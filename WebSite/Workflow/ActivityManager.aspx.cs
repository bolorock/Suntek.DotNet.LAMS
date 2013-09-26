using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Service;
using EAFrame.Workflow.Engine;
using EAFrame.Workflow.Definition;
using EAFrame.Workflow.Enums;
using EAFrame.Core.Utility;
using Newtonsoft.Json;

namespace WebSite.Workflow
{
    public partial class ActivityManager : BasePage
    {
        WorkflowEngine wfEngine = new WorkflowEngine();
        public string ProcessDefID
        {
            get
            {
                return Request.QueryString["ProcessDefID"];
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(ProcessDefID))
                {
                    ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
                }
            }
        }
        /// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList(PagedGridView gvList, PageInfo pageInfo)
        {
            WorkflowEngine wfEngine = new WorkflowEngine();
            IList<Activity> result = wfEngine.GetProcessDefine(ProcessDefID).Activities.OrderBy(a => a.ActivityType).ToList();

            gvList.ItemCount = result.Count;
            gvList.DataSource = result;
            gvList.DataBind();
        }

        public void Delete()
        {
            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;

            try
            {
                ProcessDefine processDefine = wfEngine.GetProcessDefine(ProcessDefID);
                Activity activity = processDefine.Activities.FirstOrDefault(a => a.ID == CurrentId);
                processDefine.Activities.Remove(activity);

                foreach (var transition in processDefine.Transitions.Where(t => t.DestActivity.ID == CurrentId || t.SrcActivity.ID == CurrentId).ToList())
                {
                    processDefine.Transitions.Remove(transition);
                }

                ProcessDefService processDefService = new ProcessDefService();
                IDictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.SafeAdd("Name", processDefine.ID);
                parameters.SafeAdd("Version", processDefine.Version);
                ProcessDef processDef = processDefService.FindOne(parameters);
                processDef.Content = processDefine.ToXml();

                processDefService.SaveOrUpdate(processDef);

                wfEngine.ClearProcessCache();

                actionResult = ActionResult.Success;
                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //显示提示信息
                WebUtil.PromptMsg(actionMessage);

                //刷新页面
                Refresh();

            }
            catch (Exception ex)
            {
                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(ex);
            }

        }


        private bool IsRelate()
        {
            bool isTrue = false;
            List<EAFrame.Workflow.Definition.Transition> transitions = wfEngine.GetProcessDefine(ProcessDefID).Transitions;
            foreach (var transition in transitions)
            {
                if (transition.SrcActivity.ID == CurrentId || transition.DestActivity.ID == CurrentId)
                {
                    isTrue = true;
                    break;
                }
            }
            return isTrue;
        }
        /// <summary>
        /// 修改
        /// </summary>
        public void Update()
        {
            PageContext.Action = ActionType.Update;
            PageContext.PageIndex = gvList.PageIndex;
            SavePageContext(PageContext);

            Redirect(string.Empty);
        }
        /// <summary>
        /// 转向明细页面
        /// </summary>
        /// <param name="param"></param>
        protected void Redirect(string param)
        {
            var currentIdParam = PageContext.Action == ActionType.Add ? string.Empty : string.Format("&CurrentId={0}", CurrentId);
            Response.Redirect(string.Format("ActivityDetail.aspx?LastUrl={0}&Runat=1&ActionFlag={1}{2}{3}", Request.Url.PathAndQuery, PageContext.Action, currentIdParam, string.IsNullOrEmpty(param) ? param : "&" + param));
        }
        /// <summary>
        /// 刷新
        /// </summary>
        public void Refresh()
        {
            ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
        }
    }
}