using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace WebSite.Assessment
{
    public partial class UploadFile :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.hfAuth.Value = Request.Cookies[FormsAuthentication.FormsCookieName] == null ?
                string.Empty : Request.Cookies[FormsAuthentication.FormsCookieName].Value;
                this.hfAspSessID.Value = Session.SessionID;

            }
        }
    }
}