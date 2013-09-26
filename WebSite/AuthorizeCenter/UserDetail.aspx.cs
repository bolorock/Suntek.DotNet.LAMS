using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Newtonsoft.Json;
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
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using System.IO;

namespace WebSite.AuthorizeCenter
{
    public partial class UserDetail : BasePage
    {
        private EmployeeService empService = new EmployeeService();
        private EmployeeOrgService empOrgService = new EmployeeOrgService();
        private OperatorService operatorService = new OperatorService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                dtpExpireTime.Text = DateTime.Now.ToShortDateString();
                dtpLastLogin.Text = DateTime.Now.ToShortDateString();
                dtpStartTime.Text = DateTime.Now.ToShortDateString();
                dtpEndTime.Text = DateTime.Now.ToShortDateString();
                dtpBirthday.Text = DateTime.Now.ToShortDateString();
                dtpWorkFromDate.Text = DateTime.Now.ToShortDateString();
                dtpInDate.Text = DateTime.Now.ToShortDateString();
                dtpOutDate.Text = DateTime.Now.ToShortDateString();
                
            }
        }
        public string Save(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                Operator opr = JsonConvert.DeserializeObject<Operator>(argument);
                //判断是否有相同的登录名存在
                Dictionary<string, object> param = new Dictionary<string, object>();
                param.Add("LoginName", opr.LoginName);

                var isExistsLoginName = operatorService.FindAll(param);
                if (isExistsLoginName.Count > 0 )
                {
                    ajaxResult.PromptMsg = "此登录名已存在！";
                    return JsonConvert.SerializeObject(ajaxResult);
                }

                opr.Skin = "Default";
                opr.OwnerOrg = User.OrgPath;
                opr.Creator = User.ID;
                opr.ID = IdGenerator.NewComb().ToString();

                Employee emp = JsonConvert.DeserializeObject<Employee>(argument);
                emp.ID = opr.ID;
                emp.OperatorID = emp.ID;
                emp.MajorOrgID = CurrentId;
                emp.Email = opr.Email;
                emp.Name = opr.UserName;
                emp.LoginName = opr.LoginName;
                emp.Creator = opr.Creator;

                
                EmployeeOrg empOrg = new EmployeeOrg();
                empOrg.ID = IdGenerator.NewComb().ToString();
                empOrg.OrgID = CurrentId;
                empOrg.EmployeeID = emp.ID;
                empOrg.IsMajor = 0;

                operatorService.SaveOrUpdate(opr);
                operatorService.ClearCache();

                empService.SaveOrUpdate(emp);
                empService.ClearCache();

                empOrgService.SaveOrUpdate(empOrg);
                empOrgService.ClearCache();

                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(emp, PageContext.Action, actionResult, actionMessage);
                AddActionLog(empOrg, PageContext.Action, actionResult, actionMessage);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = emp.ID;
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