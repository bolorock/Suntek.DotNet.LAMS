using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls;

using EAFrame.Core;
using EAFrame.Core.Security;
using EAFrame.Core.Enums;
using EAFrame.Core.Web;
using EAFrame.Core.Caching;
using EAFrame.Core.Extensions;
using EAFrame.Core.Utility;
using Newtonsoft.Json;

using EAFrame.Core.Authentication;
using SunTek.EAFrame.AuthorizeCenter.Service;
using SunTek.EAFrame.AuthorizeCenter.Domain;
namespace WebSite
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //public override bool Authorize(User user, string requestUrl)
        //{
        //    return base.Authorize(user, requestUrl, false);
        //}

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtLoginName.Text))
            {
                lblMsg.Text = "用户名不能为空！";
                return;
            }

            Dictionary<string, object> parameter = new Dictionary<string, object>();
            parameter.SafeAdd("LoginName", txtLoginName.Text.Trim());
            // parameter.SafeAdd("Password", CryptographyManager.EncodePassowrd(txtPassword.Text.Trim()));

            //Response.Redirect(string.Format("{0}Default.aspx", WebUtil.GetRootPath()));
            //return;


            Employee employee = new EmployeeService().FindOne(parameter);
            Operator operatorInfo = new OperatorService().FindOne(parameter);

            if (employee != null)
            {
                parameter.Clear();
                parameter.SafeAdd("EmployeeID", employee.ID);
                string orgID = employee.MajorOrgID;

                User user = new User()
                {
                    ID = employee.ID,
                    LoginName = employee.LoginName,
                    Name = employee.Name,
                    CorpID = employee.CorpID,
                    Skin = operatorInfo.Skin ?? "Default",
                    OrgID = orgID,
                    UserType = operatorInfo.UserType,
                    OrgPath = new OrganizationService().GetOrgPath(orgID)
                };

                Session[ApplicationContext.CurrentUserKey] = user;
                //设置验证Cookie
                FormsAuthentication.SetAuthCookie(user.LoginName, false);
                //将用户重定向到访问的页面
                FormsAuthentication.RedirectFromLoginPage("../", false);

                //AddActionLog<Operator>(operatorInfo, ActionType.Login, ActionResult.Success, employee.Name+"登录成功！");
            }
            else
            {
                lblMsg.Text = "用户不存在！";
            }
        }
    }
}
