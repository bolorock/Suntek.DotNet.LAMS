using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using log4net;
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
using EAFrame.Core.DataFilter;
using EAFrame.WebControls;
using SunTek.Assessment.Domain;
using SunTek.Assessment.Service;
using Newtonsoft.Json;
using EAFrame.Core.Data;

using SunTek.CMS.Domain;
using SunTek.CMS.Service;

namespace WebSite
{
    public partial class Index : BasePage
    {
        private WidgetsService widgetsService = new WidgetsService();
        private ContentManagementService contentManagementService = new ContentManagementService();
        public override bool Authorize(EAFrame.Core.Authentication.User user, string requestUrl)
        {
            return base.Authorize(user, requestUrl, false);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            BindSurveyList();
        }

        /// <summary>
        /// 获取所有发布的内容
        /// </summary>
        /// <returns></returns>
        public string GetWidgetsContent()
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                int contentNum = System.Configuration.ConfigurationManager.AppSettings["ContentNum"].ToInt();
                IList<SunTek.CMS.Domain.ContentManagement> contentManagement = contentManagementService.GetAllContent(contentNum);

                if (contentManagement != null)
                {
                    actionResult = ActionResult.Success;

                    //获取提示信息
                    actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                    ajaxResult.RetValue = contentManagement;
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
        /// 获取部件配置信息
        /// </summary>
        /// <returns></returns>
        public string GetWidgetsConfig()
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                string widgetPlaceNum = System.Configuration.ConfigurationManager.AppSettings["WidgetPlaceNum"];
                IDictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.Add("IsShow", "1");
                IList<SunTek.CMS.Domain.Widgets> widgetsList = widgetsService.FindAll(parameters).OrderBy(o=>o.AddType).ToList();

                if (widgetsList.Count>0)
                {
                    actionResult = ActionResult.Success;

                    //获取提示信息
                    actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                    var ret = new
                    {
                        widgetPlace = widgetPlaceNum,
                        rows = widgetsList
                    };
                    ajaxResult.RetValue = ret;
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


        public void BindSurveyList()
        {
            //IDictionary<string, object> para = GetFilterParameters();
            //para.SafeAdd("Status", new Condition(" Status!=3"));
            //para.SafeAdd("ID", new Condition(string.Format("ID in (select SurveyID from LA_SurveyResult r where r.Tester='{0}' and r.Status={1}) and Status=1", User.ID, (int)SurveyResultStatus.InTest)));
            //IPageOfList<Survey> result = new  SurveyService().FindAll(para, new PageInfo(0, 6, 20));
            //if (result.Count() == 0)
            //{
            //    litTips.Visible = true;
            //}
            //else
            //{
            //    rptList.DataSource = result.OrderBy(o => o.CreateTime);
            //    rptList.DataBind();
            //}
        }

    }
}