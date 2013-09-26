using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EAFrame.Core;
using EAFrame.Core.Authentication;
using EAFrame.Core.Utility;
using EAFrame.Core.Enums;
using EAFrame.Core.Extensions;
using EAFrame.Core.Caching;
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Service;
using EAFrame.Workflow.Enums;
using EAFrame.Workflow.Definition;
using EAFrame.Core.Data;

namespace EAFrame.Workflow.Engine
{
    public class WorkItemRuntime
    {
        #region Variables
        private IEngineService engineService;
        #endregion

        #region Properties
        public IWorkflowPersistence Persistence
        {
            get { return engineService.Persistence; }
        }
        public INotification Notification
        {
            get { return engineService.Notification; }
        }
        public IWorkAssign WorkAssign
        {
            get { return engineService.WorkAssign; }
        }

        public IUser User
        {
            get;
            set;
        }

        public WorkItemContext Context
        {
            get;
            set;
        }

        #endregion

        public WorkItemRuntime(IEngineService services, WorkItemContext context)
        {
            this.engineService = services;
            Context = context;
        }

        public void Run(object state)
        {
            //string command = "command";// = (String)workItem.getParameter("Command");
            Command command = null;// CommandLine.parse(command);
            DefaultExecutor executor = new DefaultExecutor();
            try
            {
                executor.Execute(command, state);
                CompleteWorkItem(Context.EngineContext.User);
            }
            catch (Exception ex)
            {
                Context.EngineContext.HandleException(new WFException(GetType().FullName, string.Format("完成工作项{0}出错,WorkItemID={1}", Context.WorkItem.Name, Context.WorkItem.ID), ex));

                TraceLog traceLog = new TraceLog()
                {
                    ActionType = (short)Operation.Complete,
                    ActivityID = Context.ActivityInst.ActivityDefID,
                    ActivityInstID = Context.ActivityInst.ID,
                    ClientIP = WebUtil.GetClientIP(),
                    ID = IdGenerator.NewComb().ToSafeString(),
                    Operator = Context.EngineContext.User.ID,
                    ProcessID = Context.ProcessInst.ProcessDefID,
                    ProcessInstID = Context.ProcessInst.ID,
                    WorkItemID = Context.WorkItem.ID,
                    Message = string.Format("完成工作项{0}出错,WorkItemID={1}", Context.WorkItem.Name, Context.WorkItem.ID)
                };
                Persistence.Repository.SaveOrUpdate(traceLog);
                AbortWorkItem();
            }
        }

        /// <summary>
        /// 获取待执行活动
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <returns></returns>
        public IList<ActivityInst> GetToRunActivityInsts(string processInstID)
        {
            return Persistence.GetActivityInsts(processInstID).Where(a => a.CurrentState == (short)ActivityInstStatus.NoStart
                    || a.CurrentState == (short)ActivityInstStatus.WaitActivate).ToList();
        }

        /// <summary>
        /// 完成工作项
        /// </summary>
        public void CompleteWorkItem(IUser user)
        {
            using (ITransaction trans = UnitOfWork.BeginTransaction(typeof(WorkItem)))
            {
                Context.WorkItem.CurrentState = (short)WorkItemStatus.Compeleted;
                Context.WorkItem.Executor = Context.EngineContext.User.ID;
                Context.WorkItem.ExecutorName = Context.EngineContext.User.Name;
                Context.WorkItem.ExecuteTime = DateTime.Now;
                Persistence.Repository.SaveOrUpdate(Context.WorkItem);

                TraceLog traceLog = new TraceLog()
                {
                    ActionType = (short)Operation.Complete,
                    ActivityID = Context.ActivityInst.ActivityDefID,
                    ActivityInstID = Context.ActivityInst.ID,
                    ClientIP = WebUtil.GetClientIP(),
                    ID = IdGenerator.NewComb().ToSafeString(),
                    Operator = Context.EngineContext.User.ID,
                    ProcessID = Context.ProcessInst.ProcessDefID,
                    ProcessInstID = Context.ProcessInst.ID,
                    WorkItemID = Context.WorkItem.ID,
                    Message = string.Format("完成工作项{0}", Context.WorkItem.Name)
                };
                Persistence.Repository.SaveOrUpdate(traceLog);
             
                trans.Commit();
            }
        }

        public void AbortWorkItem()
        {
            Context.WorkItem.CurrentState = (short)WorkItemStatus.Error;
            Persistence.Repository.SaveOrUpdate(Context.WorkItem);
        }
    }
}
