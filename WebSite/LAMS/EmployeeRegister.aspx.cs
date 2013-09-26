using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using log4net;
using Microsoft.Practices.Unity;
using EAFrame.Core;
using EAFrame.Core.Enums;
using EAFrame.Core.Service;
using EAFrame.Core.Security;
using EAFrame.Core.Extensions;
using EAFrame.Core.Web;
using EAFrame.Core.Caching;
using EAFrame.Core.Utility;
using EAFrame.Core.FastInvoker;
using EAFrame.WebControls;

using SunTek.EAFrame.Infrastructure.Service;
using SunTek.EAFrame.Infrastructure.Domain;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using SunTek.LAMS.Domain;
using SunTek.LAMS.Service;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace WebSite
{
    public partial class EmployeeRegister : BasePage
    {
        EmployeeService employeeService = new EmployeeService();
        EmployeeModelService employeeModelService = new EmployeeModelService();
        DiplomaService diplomaService = new DiplomaService();
        CandidateManagerService candidateManagerService = new CandidateManagerService();
        CandidateDetailService candidateDetailService = new CandidateDetailService();
        ResumeService resumeService = new ResumeService();


        public IList<Resume> resume; //简历信息

        public string CandidateManagerID
        {
            get
            {
                return Request.QueryString["CandidateManagerID"] ?? string.Empty;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bindcbo(cboFulltimeEducation, "Education");
                Bindcbo(cboInserviceEducation,"Education");
                Bindcbo(cboTargetCandidate, "TargetCandidate");
                Bindcbo(cboCandidateMaturity, "CandidateMaturity");
                ShowPageDetail();
            }
        }

        /// <summary>
        /// 绑定下拉列表
        /// </summary>
        /// <param name="cbo">下拉控件</param>
        /// <param name="dictName">字典名</param>
        private void Bindcbo(ComboBox cbo, string dictName)
        {
            DictService dict = new DictService();
            IList<DictItem> item = dict.GetDictItems(dictName);
            cbo.DataTextField = "Text";
            cbo.DataValueField = "Text";
            cbo.DataSource = item;
            cbo.DataBind();
            ListItem listItem = new ListItem("", "");
            listItem.Selected = true;
            cbo.Items.Add(listItem);
        }

        protected void ShowPageDetail()
        {

            //人员基本信息
            Dictionary<string, object> dictionary = new Dictionary<string, object>();
            dictionary.Add("ID", CurrentId);

            Employee employee = employeeService.FindOne(dictionary);
            if (employee == null) return;
            SetControlValues(employee);

            //照片
            imgEmployee.ImageUrl =string.Format( "~/FileEmployeePic/{0}.{1}", employee.Code,employee.Photo);

            Dictionary<string, object> dicEmployeeID = new Dictionary<string, object>(); //查询字典
            dicEmployeeID.Add("EmployeeID", employee.ID);

            //学历学位
            Diploma diploma = diplomaService.FindOne(dicEmployeeID);
            SetControlValues(diploma);

            //显示简历信息
            resume = resumeService.FindAll(dicEmployeeID).OrderBy(c => c.StartDate).ToList();

            //显示选拔推荐情况
            Dictionary<string, object> dicDetail = new Dictionary<string, object>();
            dicDetail.Add("Code", employee.Code);
            ShowCandidateDetail(dicDetail);

            ShowCandidateMananger();
        }


        //显示选拔推荐情况
        private void ShowCandidateDetail(Dictionary<string, object> dic)
        {
            CandidateDetailService candidateDetailService = new CandidateDetailService();
            CandidateDetail entity = candidateDetailService.FindOne(dic);
            SetControlValues(entity);
        }

        private void ShowCandidateMananger()
        {
            CandidateManagerService candidateManagerService = new CandidateManagerService();
            CandidateManager entity = candidateManagerService.GetDomain(CandidateManagerID);
            SetControlValues(entity);
        }

        //保存员工基本信息
        private void SaveEmployeeInfo(Employee employee,JObject jobj)
        {
            IDictionary<string, object> dic = new Dictionary<string, object>();
            dic.Add("EmployeeID", employee.ID);
            Diploma diploma = diplomaService.FindOne(dic);
            CandidateManager candidateManager = candidateManagerService.GetDomain(CandidateManagerID);

            employee.Name = jobj["Name"].Value<string>();
            employee.Gender = jobj["Gender"].Value<string>().ToShort();
            employee.Birthday = jobj["Birthday"].Value<string>().Cast<DateTime>();
            employee.Nation = jobj["Nation"].Value<string>();
            employee.Nativeplace = jobj["Nativeplace"].Value<string>();
            employee.Birthplace = jobj["Birthplace"].Value<string>();
            employee.PoliticsStatus = jobj["PoliticsStatus"].Value<string>();
            employee.WorkFromDate = jobj["WorkFromDate"].Value<string>().Cast<DateTime>();
            employee.HealthStatus = jobj["HealthStatus"].Value<string>();
            employee.IndustrialGrade = jobj["IndustrialGrade"].Value<string>();
            employee.Speciality = jobj["Speciality"].Value<string>();
            employee.PositionName = jobj["PositionName"].Value<string>();
            employee.PostGrade = jobj["PostGrade"].Value<string>();
            employeeService.Update(employee);

            if (diploma == null)
            {
                diploma = new Diploma();
                diploma.ID = IdGenerator.NewComb().ToSafeString();
                diploma.EmployeeID = employee.ID;
            }
            diploma.FulltimeEducation = jobj["FulltimeEducation"].Value<string>();
            diploma.FulltimeSchool = jobj["FulltimeSchool"].Value<string>();
            diploma.FulltimeMajor = jobj["FulltimeMajor"].Value<string>();
            diploma.InserviceEducation = jobj["InserviceEducation"].Value<string>();
            diploma.InserviceSchool = jobj["InserviceSchool"].Value<string>();
            diploma.InserviceMajor = jobj["InserviceMajor"].Value<string>();
            diploma.Creator = User.ID;
            diploma.CreateTime = DateTime.Now;
            diplomaService.SaveOrUpdate(diploma);

            if (candidateManager == null)
            {
                candidateManager = new CandidateManager();
                candidateManager.ID = IdGenerator.NewComb().ToSafeString();
                candidateManager.Code = employee.Code;
            }
            candidateManager.InPostDate = jobj["InPostDate"].Value<string>();
            candidateManager.InGradeDate = jobj["InGradeDate"].Value<string>();
            candidateManager.TargetCandidate = jobj["TargetCandidate"].Value<string>();
            candidateManager.CandidateMaturity = jobj["CandidateMaturity"].Value<string>();
            candidateManager.Creator = User.ID;
            candidateManager.CreateTime = DateTime.Now;
            candidateManagerService.SaveOrUpdate(candidateManager);
        }

        //保存选拔推荐情况
        private void SaveCandidateDetail(JObject jobj,string employeeCode)
        {
            IDictionary<string, object> dic = new Dictionary<string, object>();
            dic.Add("Code", employeeCode);
            CandidateDetail candidateDetail = candidateDetailService.FindOne(dic);
            candidateDetail.ApproveCount = jobj["ApproveCount"].Value<int>();
            candidateDetail.ApprovePercent = jobj["ApprovePercent"].Value<double>();
            candidateDetail.AttendCount = jobj["AttendCount"].Value<int>();
            candidateDetail.Deficiency = jobj["Deficiency"].Value<string>();
            candidateDetail.EmployeeCount = jobj["EmployeeCount"].Value<int>();
            candidateDetail.MajorKPI = jobj["MajorKPI"].Value<string>();
            candidateDetail.Recommendation = jobj["Recommendation"].Value<string>();
            candidateDetail.ShouldCount = jobj["ShouldCount"].Value<int>();
            candidateDetail.TrainingPlan=jobj["TrainingPlan"].Value<string>();
            candidateDetailService.Update(candidateDetail);
        }

        public string SaveOneRow(string argument)
        {
             AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                Resume model = JsonConvert.DeserializeObject<Resume>(argument);
                model.EmployeeID = CurrentId;
                model.CreateTime = DateTime.Now;
                model.Creator = User.ID;
                resumeService.Update(model);

                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(model, PageContext.Action, actionResult, actionMessage);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.PromptMsg = actionMessage;
            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }
            return JsonConvert.SerializeObject(ajaxResult);
        }

        public string Save(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                JObject jobj = JObject.Parse(argument);//转化为JObject
                Employee employee = employeeService.GetDomain(CurrentId);
                string type = jobj["Type"].Value<string>().ToSafeString();

                if (type == "0") //保存员工基本信息
                {
                    SaveEmployeeInfo(employee,jobj);
                }
                else //保存选拔推荐情况
                {
                    SaveCandidateDetail(jobj, employee.Code);
                }
              
                 
                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(employee, PageContext.Action, actionResult, actionMessage);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = employee.ID;
                ajaxResult.PromptMsg = actionMessage;
            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }
    }
}