using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Data;
using System.Collections;

using log4net;
using Microsoft.Practices.Unity;
using EAFrame.Core;
using EAFrame.Core.Enums;
using EAFrame.Core.Service;
using EAFrame.Core.Security;
using EAFrame.Core.Extensions;
using EAFrame.Core.Web;
using EAFrame.Core.Data;
using EAFrame.Core.Caching;
using EAFrame.Core.Utility;
using EAFrame.Core.FastInvoker;
using EAFrame.WebControls;

using NPOI.HSSF.UserModel;
using NPOI.HPSF;
using NPOI.POIFS.FileSystem;
using NPOI.SS.UserModel;

using SunTek.Assessment.Domain;
using SunTek.Assessment.Service;
using SunTek.EAFrame.AuthorizeCenter.Service;
using SunTek.EAFrame.AuthorizeCenter.Domain;

namespace WebSite
{
    public partial class UploadifyExpert : BasePage
    {
        SurveyService surveyService = new SurveyService();
        public string SurveyID
        {
            get
            {
                return Request["surveyID"];
            }
        }

        public override bool Authorize(EAFrame.Core.Authentication.User user, string requestUrl, bool isForce)
        {
            return base.Authorize(user, requestUrl, false);
        }



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //绑定角色

            }
            if (Request["type"] != null)
            {
                HttpPostedFile file = Request.Files["FileData"];
                HSSFWorkbook workbook = new HSSFWorkbook(file.InputStream);
                HSSFSheet sheet = (HSSFSheet)workbook.GetSheetAt(0);
                ImportSurveyResultTester(sheet, workbook);
            }
        }

        /// <summary>
        /// 导入Excel数据： 返回客户端信息:0:出错；1：成功；2：提示;
        /// </summary>
        private void ImportSurveyResultTester(HSSFSheet sheet, HSSFWorkbook workbook)
        {
            string surveyID = Request["surveyID"];
            string template = Path.Combine(Path.Combine(Server.MapPath("~"), "FileTemplate"), "SurveyResult.template");//Excel单位格配置xml模板

            int rowNum = sheet.PhysicalNumberOfRows - 1;

            for (int i = 1; i < rowNum; i++)
            {
                if (string.IsNullOrWhiteSpace(sheet.GetRow(i).GetCell(0).ToSafeString()))
                {
                    rowNum = i - 1;
                    break;
                }
            }

            if (SaveSurveyResult(sheet, template, rowNum, surveyID))
            {
                Response.Write("1&保存成功！");
            }

       
        }

        private bool SaveSurveyResult(HSSFSheet sheet, string templatePath, int rowCount, string surveyID)
        {
            string strError = string.Empty;
            //读取Excel数据
            SurveyResultModel model = SunTek.LAMS.Uitl.ExcelUtil.CreateFromExcel<SurveyResultModel>(templatePath, (row, column) =>
            {
                try
                {
                    return sheet.GetRow(row).GetCell(column).ToString();
                }
                catch (Exception ex)
                {
                    log.Error(string.Format("获取导入评分人excel单位格信息出错!【行，列】＝【{1],{2}】", row, column), ex);
                    return string.Empty;
                }
            }, rowCount);
            if (model.SurveyResults == null)
            {
                Response.Write("0&获取Excel单位格信息出错，请检查Excel数据格式是否正确!");
                return false;
            }
            IDictionary<string, object> dic = new Dictionary<string, object>();
            model.SurveyID = surveyID;
            model.OwnerOrg = User.OrgPath;
            Survey survey = surveyService.GetDomain(surveyID);
            model.EntTime = survey.EndTime;
            model.RemainTime = survey.LimitTime;
           
            Type type = typeof(SurveyResult);
            foreach (var p in type.GetProperties())//通过反射为属性为空的赋值
            {
                if (string.IsNullOrWhiteSpace(p.GetValue(model, null).ToSafeString()) || (p.PropertyType == typeof(DateTime) && p.GetValue(model, null).ToSafeString() == "1800/1/1 0:00:00"))
                {
                    p.SetValue(model, null, null);
                }
            }
  
            EmployeeService employeeService = new EmployeeService();
            List<Employee> emp = new List<Employee>();


            
            //获取ID
            foreach (var item in model.SurveyResults)
            {
                dic.Add("Code", item.Tester);
                emp = employeeService.FindAll(dic).ToList();
                if (emp.Count > 0)
                    item.Comment = emp[0].ID;
                dic.Clear();
                item.SurveyID = surveyID;
            }

           new ExpertService().SaveImportExpert(model, out strError);
            if (!string.IsNullOrWhiteSpace(strError))
            {
                Response.Write("0&" + strError+"<ErrorEnd>");
                return false;
            }
            else
            {
                return true;
            }
        }
    }
}