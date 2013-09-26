using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;


using Microsoft.Practices.Unity;
using Newtonsoft.Json;
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
using EAFrame.Core.Data;
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Engine;
using EAFrame.Workflow.Definition;
using EAFrame.Workflow.Enums;

namespace WebSite.Workflow
{
    public partial class StartProcessForm : BasePage
    {
        IWorkflowEngine engine = new WorkflowEngine();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string workItemID = Request.QueryString["workItemID"];
                WorkItem workItem = engine.Persistence.Repository.GetDomain<WorkItem>(workItemID);
                ActivityInst activityInst = engine.Persistence.GetActivityInst(workItem.ActivityInstID);
                ManualActivity manualActivity = engine.Persistence.GetActivity(workItem.ProcessID, activityInst.ActivityDefID) as ManualActivity;

                EAFrame.EForm.FormView formView = new EAFrame.EForm.FormView();
                formView.Form = manualActivity.Form;
                txtDataSource.Value = manualActivity.Form.DataSource;

                IDictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.SafeAdd("processInstID", Request.QueryString["processInstID"]);
                ProcessForm processForm = engine.Persistence.Repository.FindOne<ProcessForm>(parameters);
                if (processForm != null)
                {
                    parameters.Clear();
                    parameters.Add("ID", processForm.BizID);
                    DataTable dt = engine.Persistence.Repository.ExecuteDataTable<ProcessForm>(string.Format("select * from {0}", processForm.BizTable), parameters);

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        IDictionary<string, object> values = new Dictionary<string, object>();

                        foreach (DataRow row in dt.Rows)
                        {
                            foreach (DataColumn column in dt.Columns)
                            {
                                values.SafeAdd(column.ColumnName, row[column.ColumnName]);
                            }
                        }

                        formView.Values = values;
                    }
                }

                eForm.Controls.Add(formView);
            }
        }


        public string Save(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();
            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            string processInstID = Request.QueryString["processInstID"];
            ProcessForm processForm;
            try
            {
                string id = CurrentId;
                Dictionary<string, object> formValues = JsonConvert.DeserializeObject<Dictionary<string, object>>(argument);
                formValues.SafeAdd("ID", id);


                string table = txtDataSource.Value;
                StringBuilder sbFields = new StringBuilder();
                StringBuilder sbValues = new StringBuilder();
                string cmdText = string.Empty;
                StringBuilder sbUpdateValues = new StringBuilder();


                IDictionary<string, object> parameters = new Dictionary<string, object>();
                parameters.SafeAdd("ProcessInstID", processInstID);
                processForm = engine.Persistence.Repository.FindOne<ProcessForm>(parameters);
                if (processForm != null)
                {
                    formValues.Remove("ID");
                    foreach (var item in formValues)
                    {
                        if (sbUpdateValues.Length > 0)
                            sbUpdateValues.Append(",");
                        sbUpdateValues.AppendFormat("{0} = :{0}", item.Key);
                    }
                    cmdText = string.Format("update {0} set {1} where ID ='{2}'", table, sbUpdateValues.ToString(), processForm.BizID);
                }
                else
                {
                    foreach (var item in formValues)
                    {
                        sbFields.Append(item.Key).Append(",");
                        sbValues.Append(":").Append(item.Key).Append(",");
                    }

                    processForm = new ProcessForm()
                    {
                        ID = IdGenerator.NewComb().ToString(),
                        BizID = id,
                        BizTable = table,
                        CreateTime = DateTime.Now,
                        Creator = User.ID,
                        ProcessInstID = processInstID,
                        KeyWord = sbValues.ToString()
                    };
                    cmdText = string.Format("insert into {0}({1}) values({2})", table, sbFields.ToString().TrimEnd(','), sbValues.ToString().TrimEnd(','));
                }

                string workItemID = Request.QueryString["workItemID"];
                UnitOfWork.ExecuteWithTrans<WorkItem>(() =>
                {
                    engine.Persistence.Repository.ExecuteSql<WorkItem>(cmdText, formValues);
                    engine.Persistence.Repository.SaveOrUpdate(processForm);
                    engine.CompleteWorkItem(User, workItemID, formValues);
                });

                actionResult = ActionResult.Success;
                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(formValues, PageContext.Action, actionResult, actionMessage);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = CurrentId;
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