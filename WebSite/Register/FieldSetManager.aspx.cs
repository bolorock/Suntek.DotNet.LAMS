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
    public partial class FieldSetManage : BasePage
    {
        private FieldSetService fieldSetService = new FieldSetService();
        private string RegisterType
        {
            get
            {
                return Request.Form["registerType"] ?? drpGrade.SelectedValue;
            }
        }
        #region ---界面处理方法---

        protected bool ShowPageDetail()
        {
            IDictionary<string, object> para = new Dictionary<string, object>();
            para.Add("IsShow", "1");
            IList<FieldSet> fieldSets = SystemUtil.GetFieldList(SystemUtil.GetTemplateFilePath(RegisterType)).Where(c => c.IsShow == 1).OrderBy(c => c.SortOrder).ToList();
            rptFieldSet.DataSource = fieldSets;
            rptFieldSet.DataBind();
            return true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !IsAjaxPost)
            {
                ShowPageDetail();
            }
        }
        #endregion

        #region ---操作处理方法---
        
        public string SaveAll(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                argument = argument.Substring(0, argument.Length - 1);
                string[] ids = argument.Split(',');
                SystemUtil.SaveFieldSet(SystemUtil.GetTemplateFilePath(RegisterType), ids);

                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = argument;
                ajaxResult.PromptMsg = actionMessage;
            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }

       
        public string SaveRow(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                FieldSet entity = JsonConvert.DeserializeObject<FieldSet>(argument);
                IDictionary<string,string> dict=new Dictionary<string,string>();
                dict.Add("text",entity.FieldShow);
                dict.Add("Description",entity.Description);
                SystemUtil.UpdateField(SystemUtil.GetTemplateFilePath(RegisterType), entity.FieldCode, dict);

                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = argument;
                ajaxResult.PromptMsg = actionMessage;
            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }

        protected void cmdInit_Click(Object sender, EventArgs e)
        {
            SystemUtil.SetFieldInit(SystemUtil.GetTemplateFilePath(RegisterType));
            WebUtil.PromptMsg("操作成功！");
            ShowPageDetail();
        }

        protected void drpGrade_SelectedIndexChanged(Object sender, EventArgs e)
        {
            ShowPageDetail();

        }

        #endregion
    }
}