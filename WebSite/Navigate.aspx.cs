using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

using EAFrame.Core;
using EAFrame.Core.Authentication;
using EAFrame.Core.Enums;
using EAFrame.Core.Web;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using EAFrame.Core.Utility;
using EAFrame.Core.Extensions;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;




namespace WebSite
{
    public partial class NavigatePage : BasePage
    {
        public override bool Authorize(User user, string requestUrl)
        {
            return base.Authorize(user, requestUrl, false);
        }
        public string BuildNavigateBar()
        {
            string resourceId = Request.QueryString["ResourceId"];
            if (string.IsNullOrEmpty(resourceId)) return string.Empty;

            //IList<SunTek.BI.RDReport.Domain.RolePrivilege> rolePrivileges = new RolePrivilegeService().GetUserPrivileges(User.ID);
           

            #region 页面权限验证  ljz 添加
            //取得用户的角色
            List<string> privilegeIDs = new OperatorService().GetPrivilegeIDs(User.ID);

            //根据权限id取到资源id集合
            IList<string> resIDs = new PrivilegeService().All().Where(o => privilegeIDs.Contains(o.ID) && string.IsNullOrWhiteSpace(o.OperateID)).Select(o => o.ResourceID).ToList();

            ResourceService resourceService = new ResourceService();
            var resources = resourceService.All().Where(r => r.ParentID == resourceId && (User.UserType == (short)UserType.Administrator || resIDs.Contains(r.ID))).OrderBy(r => r.SortOrder);
            

            #endregion


          

            StringBuilder sb = new StringBuilder();
            foreach (var res in resources)
            {
                sb.AppendLine("<h1 class=\"type\">");
                sb.AppendLine(string.Format("<a href=\"javascript:void(0)\">{0}</a></h1>", res.Text));
                sb.AppendLine("<div class=\"content\">");
                sb.AppendLine("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
                sb.AppendLine("<tr>");
                //sb.AppendLine("<td>");
                sb.AppendLine(string.Format("<td><img src=\"{0}Skins/{1}/images/menu_topline.gif\" width=\"182px\" height=\"5px\" /></td>", RootPath, User.Skin));
                //sb.AppendLine("</td>");
                sb.AppendLine("</tr>");
                sb.AppendLine("</table>");
                sb.AppendLine("<ul class=\"MM\">");

                IList<Resource> childrenRes = resourceService.All().Where(r => r.ParentID == res.ID && (User.UserType == (short)UserType.Administrator || resIDs.Contains(r.ID))).OrderBy(r => r.SortOrder).Distinct().ToList();
                foreach (var menuItem in childrenRes)
                {
                    sb.AppendLine(string.Format("<li><a href=\"{0}{1}{2}\" target=\"ifrContentPage\" >", RootPath, menuItem.URL, string.IsNullOrEmpty(menuItem.Entry) ? string.Empty : "?Entry=" + menuItem.Entry));
                    sb.AppendLine(string.Format("{0}</a></li>", menuItem.Text));
                }
                sb.AppendLine("</ul>");
                sb.AppendLine("</div>");
            }

            return sb.ToString();
        }
    }
}
