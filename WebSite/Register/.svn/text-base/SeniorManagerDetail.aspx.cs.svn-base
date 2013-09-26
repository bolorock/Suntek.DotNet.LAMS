using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using log4net;
using Newtonsoft.Json;
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
using SunTek.Register.Domain;
using SunTek.Register.Service;
using EAFrame.Core.Data;

namespace WebSite.Register
{
    public partial class SeniorManagerDetail : BasePage
    {
        private RegisterBaseInfoService registerBaseInfoService = new RegisterBaseInfoService();
        private RegisterService registerService = new RegisterService();

        #region ---界面处理方法---

        protected bool ShowPageDetail()
        {
            RegisterInfo registerInfo = registerService.GetDomain(CurrentId);
            if (registerInfo == null) return false;
            SetControlValues(registerInfo);

            return true;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowPageDetail();
            }
        }
        #endregion

        #region ---操作处理方法---
        public void Save()
        {
            string msg = string.Empty;
            try
            {
                RegisterInfo registerInfo = registerService.GetDomain(CurrentId);
                if (registerInfo == null)
                {

                    registerInfo = new RegisterInfo();
                    registerInfo.ID = CurrentId;
                }
                GetControlValues(ref registerInfo);

                registerService.SaveOrUpdate(registerInfo);
                registerService.ClearCache();
                msg = "保存成功";
            }
            catch (Exception ex)
            {
                log.Error("保存名册明细失败", ex);
                msg = "保存失败";
            }
            WebUtil.PromptMsg(msg);
        }

        #endregion
    }
}