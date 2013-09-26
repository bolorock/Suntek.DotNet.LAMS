using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

using SunTek.Register.Service;
using EAFrame.Core.Enums;
using EAFrame.Core.Extensions;
using SunTek.Register.Domain;
using Newtonsoft.Json;

namespace WebSite.Register
{
    public partial class ExportRegister : BasePage
    {
        private RegisterService registerService = new RegisterService();
        public override bool Authorize(EAFrame.Core.Authentication.User user, string requestUrl, bool isForce)
        {
            return base.Authorize(user, requestUrl, false);
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            string type = Request.QueryString["type"];
            string yearMonth = Request.QueryString["yearMonth"];
            string registerType = Request.QueryString["registerType"];
            string corpID = type == "all" ? type : Request.QueryString["corpID"];
            string corpName = Server.UrlDecode(Request.QueryString["corpName"]);
            string filterStr =Server.UrlDecode(Request.QueryString["filterStr"]);
            bool isOpen = (type == "all" ? true : false);
            string managerType = RemarkAttribute.GetEnumRemark((ManagerType)Enum.Parse(typeof(ManagerType), registerType.Replace("Complete", "")));
            try
            {
                //查询条件
                IDictionary<string, object> para = new Dictionary<string, object>();
                if (!string.IsNullOrEmpty(filterStr))
                {
                    para = JsonConvert.DeserializeObject<IDictionary<string, object>>(filterStr)
                        //  .Where(p => !string.IsNullOrEmpty(p.Value.ToString()) && p.Value.ToString() != "-1")
                        .ToDictionary(p => p.Key, p => p.Value);
                }

                if (!para.Keys.Contains("Department") && !string.IsNullOrEmpty(corpName))
                {
                    if (corpName != "中国电信广东公司")
                    {
                        para.Add("Department", corpName);
                    }
                }

                DataTable dt = registerService.GetRegistersForExport(para, corpID, managerType, yearMonth);
                if (dt == null)
                {
                    EAFrame.Core.Utility.WebUtil.ExecuteJs("alert('导出数据出错！');window.close();");
                    log.Error("导出展示名册出错！corpName:" + corpName + "&filterStr:" + filterStr);
                    return;
                }
                string fileName = string.Format("{0}{1}{2}名册", corpName, yearMonth, managerType); //文件名



                string template = SystemUtil.GetTemplateFilePath(registerType); //xml文件
                IList<FieldSet> fields = SystemUtil.GetFieldList(template).Where(p => p.IsShow == 1).OrderBy(f => f.SortOrder).ToList();
                if (fields == null)
                {
                    return;
                }
                IDictionary<string, string> dicColumnName = new Dictionary<string, string>();
                IDictionary<string, int> dictWidth = new Dictionary<string, int>();

                foreach (var field in fields)
                {
                    if (field.FieldCode == "PostGradeExperience")
                    {
                        field.FieldCode = "pGradeExperience";
                    }

                    if (managerType != "资深经理")
                    {
                        if (field.FieldCode == "Gender")
                        {
                            field.FieldCode = "Gender1";
                        }
                        if (field.FieldCode == "Birthday")
                        {
                            field.FieldCode = "Birthday1";
                        }
                    }

                    dicColumnName.Add(field.FieldCode == "SortOrder" ? "rowNum" : field.FieldCode, field.FieldShow);
                    dictWidth.Add(field.FieldCode == "SortOrder" ? "rowNum" : field.FieldCode, field.Width);
                }

                ExcelHelper.ExportByWeb(dt, managerType, fileName, "", dicColumnName, columnRowIndex: 0, isOpen: isOpen, columnWidth: dictWidth);
            }
            catch (Exception ex)
            {
                log.Error("导出展示名册出错！corpName:" + corpName + "&filterStr:" + filterStr, ex);
                EAFrame.Core.Utility.WebUtil.ExecuteJs("alert('导出数据出错！');window.close();");
            }
        }
    }
}