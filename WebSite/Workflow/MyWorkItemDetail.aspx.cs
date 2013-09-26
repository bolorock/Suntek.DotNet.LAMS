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
using Newtonsoft.Json;
using EAFrame.Core.Data;
using EAFrame.Workflow.Engine;
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Enums;
using EAFrame.Workflow.Definition;
using EAFrame.Workflow.Service;

namespace WebSite
{
    public partial class MyWorkItemDetail : BasePage
    {
        public string Url = string.Empty;
        public string ProcessDefID = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IWorkflowEngine engine = new WorkflowEngine();
                WorkItem workItem = engine.Persistence.Repository.GetDomain<WorkItem>(Request.QueryString["workItemID"]);
                ActivityInst activityInst = engine.Persistence.GetActivityInst(workItem.ActivityInstID);

                ProcessDefID = workItem.ProcessID;
                ManualActivity manualActivity = engine.Persistence.GetActivity(workItem.ProcessID, activityInst.ActivityDefID) as ManualActivity;
                if (manualActivity.CustomURL.URLType == URLType.DefaultURL)
                {
                    Url = "MyEForm.aspx" + Request.Url.Query;
                }
                else
                {
                    Url = workItem.ActionURL;
                }

                gvList.DataSource = new WorkItemService().All().Where(o => o.ProcessInstID == workItem.ProcessInstID).OrderBy(o => o.ExecuteTime);
                gvList.DataBind();

            }
        }

    }
}