using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using EAFrame.Core.Web;
using log4net;
using Newtonsoft.Json;
using Microsoft.Practices.Unity;
using EAFrame.Core;
using EAFrame.Core.Enums;
using EAFrame.Core.Service;
using EAFrame.Core.Security;
using EAFrame.Core.Extensions;
using EAFrame.Core.Caching;
using EAFrame.Core.Utility;
using EAFrame.Core.FastInvoker;
using EAFrame.WebControls;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using SunTek.EAFrame.Infrastructure.Service;
using SunTek.EAFrame.Infrastructure.Domain;
using SunTek.Register.Domain;
using SunTek.Register.Service;
using EAFrame.Core.Data;
namespace WebSite.Register
{
    public partial class RegisterDetail:BasePage
    {
        private RegisterBaseInfoService registerBaseInfoService = new RegisterBaseInfoService();
        private RegisterService registerService = new RegisterService();

        #region ---界面处理方法---

        protected bool ShowPageDetail()
        {
            RegisterInfo registerInfo = registerService.GetDomain(CurrentId);
            if (registerInfo == null) return false;
            SetControlValues(registerInfo);
            hfCode.Value = registerInfo.Code;
            IDictionary<string, object> para = new Dictionary<string, object>();
            para.Add("Code",registerInfo.Code);
            RegisterBaseInfo registerBaseInfo = registerBaseInfoService.FindOne(para);
            if (registerBaseInfo == null) return false;
            registerBaseInfo.PostGradeExperience = registerBaseInfo.PostGradeExperience.Replace("<br />", "\r\n");
            SetControlValues(registerBaseInfo);

            picBind();

            return true;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bindcbo(cboFulltimeEducation, "Education");
                Bindcbo(cboParttimeEducation, "Education");
               
                ShowPageDetail();
            }
        }

        /// <summary>
        /// 图片路径绑定
        /// </summary>
        private void picBind()
        {
            string imgPath = string.Format(@"{0}\{1}.jpg?{2}", SunTek.LAMS.LAMSContext.RelativePhotoDirectory, hfCode.Value,new Random().Next(10000));
            if (!System.IO.File.Exists(string.Format(@"{0}\{1}.jpg", SunTek.LAMS.LAMSContext.EmployeePhotoDirectory, hfCode.Value)))
            {
                if (cboGender.Value == "男")
                    imgPath = @"~\Skin\Default\men.gif";
                else
                    imgPath = @"~\Skin\Default\women.gif";
            }
            imgRegister.ImageUrl = imgPath;
        }
        #endregion

        #region ---操作处理方法---
        protected RegisterBaseInfo GetRegisterBaseInfo()
        {
            IDictionary<string, object> para = new Dictionary<string, object>();
            para.Add("Code", hfCode.Value);
            RegisterBaseInfo registerBaseInfo = registerBaseInfoService.FindOne(para);

            if (registerBaseInfo == null)
            {
               
                registerBaseInfo = new RegisterBaseInfo();
                registerBaseInfo.ID = CurrentId;
            }
            GetControlValues(ref registerBaseInfo);
            registerBaseInfo.PostGradeExperience = registerBaseInfo.PostGradeExperience.Replace("\r\n", "<br />");
            return registerBaseInfo;
        }

        protected RegisterInfo GetRegisterInfo()
        {
            RegisterInfo registerInfo = registerService.GetDomain(CurrentId);

            if (registerInfo == null)
            {

                registerInfo = new RegisterInfo();
                registerInfo.ID = CurrentId;
            }
            GetControlValues(ref registerInfo);
            
            return registerInfo;
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

        public void Save()
        {
            string msg = string.Empty;
            try
            {

                RegisterInfo registerInfo = GetRegisterInfo();
                RegisterBaseInfo registerBaseInfo = GetRegisterBaseInfo();
                using (ITransaction trans = UnitOfWork.BeginTransaction(typeof(RegisterInfo)))
                {
                    registerService.SaveOrUpdate(registerInfo);
                    registerService.ClearCache();
                    registerBaseInfoService.SaveOrUpdate(registerBaseInfo);
                    registerBaseInfoService.ClearCache();
                    trans.Commit();
                }
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