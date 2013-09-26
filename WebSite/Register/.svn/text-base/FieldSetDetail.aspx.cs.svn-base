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
    public partial class FieldSetEdit : BasePage
    {
        private FieldSetService fieldSetService = new FieldSetService();

        public string RegisterType
        {
            get { return Request.QueryString["registerType"] ?? "CandidateManage2"; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string GetFieldSet(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                var fields=SystemUtil.GetFieldList(SystemUtil.GetTemplateFilePath(RegisterType)).Where(c=>c.IsShow==int.Parse(argument)).OrderBy(c=>c.SortOrder).ToList();
                
                if (fields == null)
                {
                    actionResult = ActionResult.Other;
                    actionMessage = "返回数据为空";
                    ajaxResult.RetValue = null;
                }
                else
                {
                    actionResult = ActionResult.Success;

                    //获取提示信息
                    actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                    ajaxResult.RetValue = fields;
                }

                ajaxResult.ActionResult = actionResult;
                ajaxResult.PromptMsg = actionMessage;

            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }
     
            return JsonConvert.SerializeObject(ajaxResult);
        }
        
        /// <summary>
        /// 保存
        /// </summary>
        /// <param name="argument"></param>
        /// <returns></returns>
        public string Save(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                fieldSetService.RemoveFieldAll();
                argument = argument.Substring(0, argument.Length - 1);
                string[] selecteds = argument.Split(',');

                SystemUtil.SaveFieldSet(SystemUtil.GetTemplateFilePath(RegisterType), selecteds);

                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                ajaxResult.RetValue = argument;


                ajaxResult.ActionResult = actionResult;
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