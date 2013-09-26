using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Threading;
using System.Configuration;
using System.IO;

using EAFrame.Core.Extensions;
using EAFrame.Core.Enums;
using EAFrame.Core.Web;
using EAFrame.Core.Utility;
using EAFrame.Core.Data;

namespace WebSite
{
    public class LAMSApplication : SunTekApplication
    {
       public void Application_BeginRequest(object sender, EventArgs e)
        {
            try
            {
                string session_param_name = "ASPSESSID";
                string session_cookie_name = "ASP.NET_SessionId";
                if (HttpContext.Current.Request.Form[session_param_name] != null)
                {
                    UpdateCookie(session_cookie_name, HttpContext.Current.Request.Form[session_param_name]);
                }
                else if (HttpContext.Current.Request.QueryString[session_param_name] != null)
                {
                    UpdateCookie(session_cookie_name, HttpContext.Current.Request.QueryString[session_param_name]);
                }
            }
            catch
            {
            }

            //此处是身份验证
            try
            {
                string auth_param_name = "AUTHID";
                string auth_cookie_name =System.Web.Security.FormsAuthentication.FormsCookieName;
                if (HttpContext.Current.Request.Form[auth_param_name] != null)
                {
                    UpdateCookie(auth_cookie_name, HttpContext.Current.Request.Form[auth_param_name]);
                }
                else if (HttpContext.Current.Request.QueryString[auth_param_name] != null)
                {
                    UpdateCookie(auth_cookie_name, HttpContext.Current.Request.QueryString[auth_param_name]);
                }
            }
            catch { }
        }

       private void UpdateCookie(string cookie_name, string cookie_value)
       {
           HttpCookie cookie = HttpContext.Current.Request.Cookies.Get(cookie_name);
           if (null == cookie)
           {
               cookie = new HttpCookie(cookie_name);
           }
           cookie.Value = cookie_value;
           HttpContext.Current.Request.Cookies.Set(cookie);//重新设定请求中的cookie值，将服务器端的session值赋值给它
       }
    }
}