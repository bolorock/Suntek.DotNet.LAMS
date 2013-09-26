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
    public partial class CorpSort :BasePage
    {
        public int index = 0;
        private CorpSortService corpSortService = new CorpSortService();
        #region ---界面处理方法---

        protected bool ShowPageDetail()
        {
            IList<SunTek.Register.Domain.CorpSort> corps = new List<SunTek.Register.Domain.CorpSort>();
            corps = corpSortService.All().OrderBy(c=>c.SortOrder).ToList();

         
            rptSubject.DataSource = corps;
            rptSubject.DataBind();

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
     

        public string SaveSort(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                IList<SunTek.Register.Domain.CorpSort> corpSorts = JsonConvert.DeserializeObject<IList<SunTek.Register.Domain.CorpSort>>(argument);
                UnitOfWork.ExecuteWithTrans<SunTek.Register.Domain.CorpSort>(() =>
                {
                    corpSortService.DeleteAll();
                    corpSorts.ForEach(p => corpSortService.SaveOrUpdate(p));
                });

                corpSortService.DeleteAll();
                corpSorts.ForEach(p => corpSortService.SaveOrUpdate(p));
        
                actionResult = ActionResult.Success;

            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            //获取提示信息
            actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

            ajaxResult.ActionResult = actionResult;
            ajaxResult.PromptMsg = actionMessage;

            return JsonConvert.SerializeObject(ajaxResult);
        }

        /// <summary>
        /// 删除单条数据
        /// </summary>
        /// <param name="argument"></param>
        /// <returns></returns>
        public string Remove(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                SunTek.Register.Domain.CorpSort domain = corpSortService.GetDomain(argument);
                if (domain != null)
                {
                    corpSortService.Delete(domain);
                }

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

        #endregion
 
    }

}