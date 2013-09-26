using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Text;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;

using EAFrame.Core;
using EAFrame.Core.Authentication;
using EAFrame.Core.Enums;
using EAFrame.Core.Web;
using EAFrame.Core.Utility;
using EAFrame.WebControls;
using EAFrame.Core.Extensions;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;

namespace WebSite
{
    public partial class _Default : BasePage
    {
        public string BuildMenuBar()
        {

            //  IList<RolePrivilege> rolePrivileges = new RolePrivilegeService().GetUserPrivileges(User.ID);
            //  List<string> privileges = new List<string>();// rolePrivileges != null ? rolePrivileges.Select(o => o.ResourceID).ToList() : new List<string>();

            #region 页面权限验证  ljz 添加
            //取得用户的角色
            List<string> privilegeIDs = new OperatorService().GetPrivilegeIDs(User.ID);
            //根据权限id取到资源id集合
            IList<string> resIDs = new PrivilegeService().All().Where(o => privilegeIDs.Contains(o.ID)).Select(o => o.ResourceID).ToList();

            ResourceService resourceService = new ResourceService();


            #endregion


            var resources = new ResourceService().All().Where(r => r.ParentID == ApplicationContext.AppID && (User.UserType == (short)UserType.Administrator || resIDs.Contains(r.ID))).OrderBy(r => r.SortOrder);

            StringBuilder sb = new StringBuilder();
            sb.Append("<ul id='mainmenuBar'>");
            string activeMenuId = ReadCookie(ApplicationContext.ActiveMenuKey);
            foreach (var resource in resources)
            {
                sb.AppendFormat("<li id='{0}' class='{1}'><a href=\"Navigate.aspx?ResourceID={0}\" target=\"ifrNavigatePage\">{3}</a></li>", resource.ID, resource.ID == activeMenuId ? "currentmenu" : "", resource.ID, resource.Text);
                sb.Append("<li style=\"color:#EEEEEE;\">|</li>");
            }
            sb.Append("</ul>");
            return sb.ToString();
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            //ComboxItem cbItem = new ComboxItem();
            //cbItem.Text = "请选择";
            //cbItem.Value = "-1";
            //orgList.Items.Add(cbItem);
            orgList.Items.Clear();
            orgList.IsSingle = true;
            //orgList.SelectedValue = "-1";


            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.SafeAdd("EmployeeID", User.ID);
            var employeeOrgs = new EmployeeOrgService().FindAll(parameters);

            foreach (var employeeOrg in employeeOrgs)
            {
                parameters.Clear();
                parameters.SafeAdd("ID", employeeOrg.OrgID);
                var org = new OrganizationService().FindOne(parameters);
                ComboxItem item = new ComboxItem();
                item.Text = org.Name;
                item.Value = org.ID;
                orgList.Items.Add(item);
                
            }
            orgList.SelectedValue = User.OrgID;
        }

        public override bool Authorize(User user, string requestUrl)
        {
            if (user == null)
            {
                if (!Request.Url.AbsolutePath.ToLower().EndsWith("Default.aspx"))
                {
                    StringBuilder script = new StringBuilder();

                    script.AppendLine("<script language='javascript'>");
                    script.AppendLine("document.close();window.parent.opener = null;window.opener = null;window.close();");
                    script.AppendFormat("window.open('{0}Login.aspx','_blank');\n", RootPath);
                    script.AppendLine("</script>");
                    Response.Write(script);
                    Response.Flush();
                    Response.End();
                    return false;
                }

                Server.Transfer(string.Format("{0}Login.aspx", WebUtil.GetRootPath()));
            }

            return true;
        }

        /// <summary>
        /// 切换用户皮肤
        /// </summary>
        /// <param name="skin"></param>
        /// <returns></returns>
        public string SwitchSkin(string skin)
        {
            OperatorService operatorService = new OperatorService();
            Operator _operator = operatorService.GetDomain(User.ID);

            _operator.Skin = skin;
            operatorService.Update(_operator);
            User.Skin = skin;

            return string.Empty;
        }

        public string SwitchOrg(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                if (!string.IsNullOrEmpty(argument)&& argument!="-1")
                {
                    User.OrgID = argument;
                    User.OrgPath = new OrganizationService().GetOrgPath(argument);
                    Session[ApplicationContext.CurrentUserKey] = User;
                    actionResult = ActionResult.Success;

                    //获取提示信息
                    actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                    //记录操作日志
                    AddActionLog(User, PageContext.Action, actionResult, actionMessage);
                    ajaxResult.ActionResult = actionResult;
                    ajaxResult.PromptMsg = actionMessage;
                }
              

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
