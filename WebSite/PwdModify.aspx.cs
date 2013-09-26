using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;

using Microsoft.Practices.Unity;
using log4net;
using EAFrame.Core;
using EAFrame.Core.Enums;
using EAFrame.Core.Service;
using EAFrame.Core.Security;
using EAFrame.Core.Extensions;
using EAFrame.Core.Web;
using EAFrame.Core.Caching;
using EAFrame.Core.FastInvoker;
using EAFrame.Core.DataFilter;
using EAFrame.WebControls;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using EAFrame.Core.Utility;

namespace WebSite
{
    public partial class PwdModify : BasePage
    {
        private OperatorService operatorService = new OperatorService();

        private Operator result;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region ---界面处理方法---

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);       
        }

        #endregion

        #region ---操作处理方法---

        protected void btnSubmit_OnClick(object sender, EventArgs e)
        {
            result = operatorService.GetDomain(User.ID);

            if (result != null)
            {
                try
                {
                    result.Password = CryptographyManager.EncodePassowrd(txtNewPwd.Text.Trim());

                    operatorService.SaveOrUpdate(result);

                    WebUtil.PromptMsg("修改成功！");
                }
                catch (Exception ex)
                {
                    log.ErrorFormat("user={0}修改密码出错,Error={1}", result.ID, ex);
                    WebUtil.PromptMsg("修改密码出错！");
                }
            }
        }

        #endregion
    }
}