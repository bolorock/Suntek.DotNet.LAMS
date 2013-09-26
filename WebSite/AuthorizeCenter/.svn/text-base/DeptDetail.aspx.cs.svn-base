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

namespace WebSite.AuthorizeCenter
{
    public partial class DeptDetail : BasePage
    {
        private OrganizationService orgService = new OrganizationService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            ShowPageDetail();
        }
        protected void ShowPageDetail()
        {
            Organization org = orgService.GetDomain(CurrentId);
            if (org == null) return;

            SetControlValues(org);
        }
        public string Save(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                Organization org = JsonConvert.DeserializeObject<Organization>(argument);
                if (PageContext.Action == ActionType.Add)
                {
                    org.ID = string.IsNullOrWhiteSpace(CurrentId) ? IdGenerator.NewComb().ToString() : CurrentId;
                    org.Code = org.ID;
                    org.ParentID = Request.QueryString["ParentId"];
                    org.CorpID = "";
                    org.GovernPosition = "";
                    org.Governor = "";
                    org.Manager = "";
                    org.ContactMan = "";
                    org.Area = "0";
                    org.Creator = "";
                    org.SapID = "";
                }
                else if (PageContext.Action == ActionType.Update)
                {
                    Organization orgDetail = orgService.GetDomain(CurrentId);
                    orgDetail.Name = org.Name;
                    orgDetail.SortOrder = org.SortOrder;
                    org = orgDetail;
                }

                orgService.SaveOrUpdate(org);
                orgService.ClearCache();
                
                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(org, PageContext.Action, actionResult, actionMessage);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = org.ID;
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