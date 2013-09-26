using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using log4net;
using EAFrame.Core;
using EAFrame.Core.Caching;
using EAFrame.Core.Utility;
using EAFrame.Core.Enums;
using EAFrame.Core.Extensions;
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Service;
using EAFrame.Workflow.Enums;
using EAFrame.Workflow.Definition;
using EAFrame.Core.Data;
using EAFrame.Core.Service;

namespace EAFrame.Workflow.Engine
{
    public class WorkflowPersistence : IWorkflowPersistence
    {
        #region Variables
        ILog log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        #endregion

        #region Properties
        /// <summary>
        /// 工作流上下文
        /// </summary>
        public EngineContext Context
        {
            get;
            set;
        }
        #endregion

        #region Contructor
        /// <summary>
        /// 构造函数
        /// </summary>
        public WorkflowPersistence()
        {
            Context = new EngineContext();
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        public WorkflowPersistence(EngineContext context)
        {
            Context = context;
        }
        #endregion

        #region IWorkflowPersistence

        #region Definition
        /// <summary>
        /// 获取工作流定义
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <returns></returns>
        public ProcessDefine GetProcessDefine(string processDefID)
        {
            string cacheKey = "all_ProcessDefine";
            IList<ProcessDefine> all = CacheManager.GetData<IList<ProcessDefine>>(cacheKey);
            if (all == null)
            {
                try
                {
                    all = repository.FindAll<ProcessDef>(null).Select(p => new ProcessDefine(p.Content, false)).ToList();
                    CacheManager.Add(cacheKey, all);
                }
                catch (Exception ex)
                {
                    log.Error("缓存流程出错", ex);
                }
            }

            ProcessDef processDef = repository.GetDomain<ProcessDef>(processDefID);

            if (all == null) return new ProcessDefine(processDef.Content, false);

            return all.FirstOrDefault(p => p.ID == processDef.Name && p.Version == processDef.Version) ?? new ProcessDefine();
        }

        /// <summary>
        /// 获取工作流某个活动
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <param name="activityID">活动定义ID</param>
        /// <returns></returns>
        public Activity GetActivity(string processDefID, string activityID)
        {
            return GetProcessDefine(processDefID).Activities.FirstOrDefault(a => string.Equals(a.ID, activityID, StringComparison.OrdinalIgnoreCase));
        }

        /// <summary>
        /// 获取流程所有定义活动
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <returns></returns>
        public IList<Activity> GetActivities(string processDefID)
        {
            return GetProcessDefine(processDefID).Activities;
        }

        /// <summary>
        /// 获取流程初始活动
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <returns></returns>
        public Activity GetStartActivity(string processDefID)
        {
            return GetProcessDefine(processDefID).StartActivity;
        }

        /// <summary>
        /// 获取活动所有的入口活动
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <param name="activityID">活动ID</param>
        /// <returns></returns>
        public IList<Definition.Activity> GetInActivities(string processDefID, string activityID)
        {
            ProcessDefine processDefine = GetProcessDefine(processDefID);

            return processDefine.Activities.Where(a => processDefine.Transitions.Exists(t => t.DestActivity.ID == activityID && t.SrcActivity.ID == a.ID)).ToList();
        }

        /// <summary>
        /// 获取活动所有的出口活动
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <param name="activityID">活动ID</param>
        /// <returns></returns>
        public IList<Definition.Activity> GetOutActivities(string processDefID, string activityID)
        {
            ProcessDefine processDefine = GetProcessDefine(processDefID);

            return processDefine.Activities.Where(a => processDefine.Transitions.Exists(t => t.SrcActivity.ID == activityID && t.DestActivity.ID == a.ID)).ToList();
        }

        #endregion

        #region Transition
        /// <summary>
        /// 获取活动之间的迁移
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <param name="srcActivityID">源活动ID</param>
        /// <param name="destActivityID">目标活动ID</param>
        /// <returns></returns>
        public Definition.Transition GetTransition(string processDefID, string srcActivityID, string destActivityID)
        {
            return GetProcessDefine(processDefID).Transitions.FirstOrDefault(t => t.SrcActivity.ID.EqualIgnoreCase(srcActivityID) && t.DestActivity.ID.EqualIgnoreCase(destActivityID));
        }

        /// <summary>
        /// 获取活动所有的入口迁移
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <param name="activityID">活动ID</param>
        /// <returns></returns>
        public IList<Definition.Transition> GetInTransitions(string processDefID, string activityID)
        {
            return GetProcessDefine(processDefID).Transitions.Where(t => t.DestActivity.ID.EqualIgnoreCase(activityID)).ToList();
        }

        /// <summary>
        /// 获取活动所有的入口迁移
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <param name="activityID">活动ID</param>
        /// <returns></returns>
        public IList<Definition.Transition> GetOutTransitions(string processDefID, string activityID)
        {
            return GetProcessDefine(processDefID).Transitions.Where(t => t.SrcActivity.ID.EqualIgnoreCase(activityID)).ToList();
        }

        #endregion

        #region Instance
        /// <summary>
        /// 创建流程实例
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <param name="parentProcessDefID">父流程ID</param>
        /// <param name="parentActivityID">父活动ID</param>
        /// <returns></returns>
        public string CreateAProcess(string processDefID, string parentProcessDefID, string parentActivityID)
        {
            ProcessDef processDef = repository.GetDomain<ProcessDef>(processDefID);
            if (processDef == null)
            {
                Context.HandleException(new MessageException()
                {
                    PromptMessage = string.Format("ID={0}的流程不存在", processDefID),
                    Source = System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.FullName,
                });

                return string.Empty;
            }

            if (processDef.CurrentState == (short)ProcessStatus.Candidate)
            {
                Context.HandleException(new MessageException()
                {
                    PromptMessage = string.Format("ID={0}的流程还未发布，不能创建流程", processDefID),
                    Source = System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.FullName,
                });

                return string.Empty;
            }

            ProcessDefine define = GetProcessDefine(processDefID);

            ProcessInst processInst = new ProcessInst()
            {
                ID = IdGenerator.NewComb().ToString(),
                ProcessDefID = processDefID,
                CreateTime = DateTime.Now,
                Creator = Context.User.ID,
                CurrentState = (short)ProcessInstStatus.NoStart,
                IsTimeOut = 0,
                Name = processDef.Text,
                Description = processDef.Description,
                ParentProcessID = parentProcessDefID,
                ParentActivityID = parentActivityID,
                StartTime = DateTime.Now,
                EndTime = Context.MaxDate,
                FinalTime = Context.MaxDate,
                LimitTime = Context.MaxDate,
                ProcessDefName = processDef.Text,
                ProcessVersion = processDef.Version,
                RemindTime = Context.MaxDate,
                TimeOutTime = Context.MaxDate
            };

            Activity ad = GetStartActivity(processDefID);
            ActivityInst activityInst = new ActivityInst()
            {
                ID = IdGenerator.NewComb().ToString(),
                ActivityDefID = ad.ID,
                CreateTime = DateTime.Now,
                CurrentState = (short)ActivityInstStatus.Compeleted,
                Description = ad.Description,
                EndTime = Context.MaxDate,
                Name = string.Format("启动{0}", processDef.Text),
                ProcessInstID = processInst.ID,
                RollbackFlag = 0,
                StartTime = DateTime.Now,
                SubProcessInstID = string.Empty,
                Type = (short)ActivityType.StartActivity
            };

            using (ITransaction trans = UnitOfWork.BeginTransaction(typeof(ProcessInst)))
            {
                repository.SaveOrUpdate(processInst);
                repository.SaveOrUpdate(activityInst);

                if (processDef.IsActive != 1)
                {
                    processDef.IsActive = 1;
                    repository.SaveOrUpdate(processDef);
                }

                trans.Commit();
            }

            return processInst.ID;
        }

        /// <summary>
        /// 创建流程实例
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <returns></returns>
        public string CreateAProcess(string processDefID)
        {
            return CreateAProcess(processDefID, null, null);
        }

        /// <summary>
        /// 获取流程实例
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <returns></returns>
        public ProcessInst GetProcessInst(string processInstID)
        {
            return repository.GetDomain<ProcessInst>(processInstID);
        }

        /// <summary>
        /// 获取某个活动实例
        /// </summary>
        /// <param name="activityInstID">活动实例ID</param>
        /// <returns></returns>
        public ActivityInst GetActivityInst(string activityInstID)
        {
            return repository.GetDomain<ActivityInst>(activityInstID);
        }

        /// <summary>
        /// 获取某个流程活动的所有活动实例
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <returns></returns>
        public IList<ActivityInst> GetActivityInsts(string processInstID, string activityDefID)
        {
            IDictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.SafeAdd("ProcessInstID", processInstID);
            parameters.SafeAdd("ActivityDefID", activityDefID);

            return repository.FindAll<ActivityInst>(parameters);
        }

        /// <summary>
        /// 获取某个流程活动的所有活动实例
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <returns></returns>
        public IList<ActivityInst> GetActivityInsts(string processInstID, string activityDefID, ActivityInstStatus actInstStatus)
        {
            return GetActivityInsts(processInstID, activityDefID).Where(a => a.CurrentState == (short)actInstStatus).ToList();
        }

        /// <summary>
        /// 获取某个工作项
        /// </summary>
        /// <param name="workItemID">工作项ID</param>
        /// <returns></returns>
        public WorkItem GetWorkItem(string workItemID)
        {
            return repository.GetDomain<WorkItem>(workItemID);
        }

        /// <summary>
        /// 获取某个流程实例的所有活动实例
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <returns></returns>
        public IList<ActivityInst> GetActivityInsts(string processInstID)
        {
            IDictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.SafeAdd("ProcessInstID", processInstID);

            return repository.FindAll<ActivityInst>(parameters);
        }

        /// <summary>
        /// 获取某个活动实例的所有工作项
        /// </summary>
        /// <param name="activityInstID">活动实例ID</param>
        /// <returns></returns>
        public IList<WorkItem> GetWorkItems(string activityInstID)
        {
            IDictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.SafeAdd("ActivityInstID", activityInstID);

            return repository.FindAll<WorkItem>(parameters);
        }

        /// <summary>
        /// 获取待办工作项列表
        /// </summary>
        /// <param name="userID">用户ID</param>
        /// <param name="parameters">参数</param>
        /// <returns></returns>
        public IList<WorkItem> GetMyWorkItems(string userID, IDictionary<string, object> parameters)
        {
            if (parameters == null) parameters = new Dictionary<string, object>();

            parameters.SafeAdd(userID, new Condition(string.Format(@"ID in
                                (select WorkItemID from WF_Participant p where p.ParticipantID='{0}' or
                                 exists(select top 1 ObjectID from OM_ObjectRole r where r.ObjectID='{0}' and r.RoleID=p.ParticipantID) or
                                 exists(select ID from OM_EmployeeOrg o where o.EmployeeID='{0}' and o.OrgID=p.ParticipantID))", userID)));

            return repository.FindAll<WorkItem>(parameters);
        }

        /// <summary>
        /// 获取待办工作项列表
        /// </summary>
        /// <param name="userID">用户ID</param>
        /// <param name="parameters">参数</param>
        /// <param name="pageInfo">分页信息</param>
        /// <returns></returns>
        public IPageOfList<WorkItem> GetMyWorkItems(string userID, IDictionary<string, object> parameters, PageInfo pageInfo)
        {
            if (parameters == null) parameters = new Dictionary<string, object>();

            parameters.SafeAdd(userID, new Condition(string.Format(@"ID in
                                (select WorkItemID from WF_Participant p where p.ParticipantID='{0}' or
                                 exists(select top 1 ObjectID from OM_ObjectRole r where r.ObjectID='{0}' and r.RoleID=p.ParticipantID) or
                                 exists(select ID from OM_EmployeeOrg o where o.EmployeeID='{0}' and o.OrgID=p.ParticipantID))", userID)));

            return repository.FindAll<WorkItem>(parameters, pageInfo);
        }

        /// <summary>
        /// 修改工作项状态
        /// </summary>
        /// <param name="workItemID">工作项ID</param>
        /// <param name="status">工作项状态</param>
        public void UpdateWorkItemStatus(string workItemID, WorkItemStatus status)
        {
            WorkItem workItem = repository.GetDomain<WorkItem>(workItemID);

            if (workItem == null)
            {
                log.Warn("UpdateWorkItemStatus error workitem is null");
                return;
            }

            workItem.CurrentState = (short)status;
            repository.Update(workItem);
        }

        /// <summary>
        /// 修改活动状态
        /// </summary>
        /// <param name="activityInstID">活动实例ID</param>
        /// <param name="status">活动状态</param>
        public void UpdateActivityInstStatus(string activityInstID, ActivityInstStatus status)
        {
            ActivityInst activityInst = repository.GetDomain<ActivityInst>(activityInstID);

            if (activityInst == null)
            {
                log.Warn("UpdateActivityInstStatus error activityInst is null");
                return;
            }

            activityInst.CurrentState = (short)status;
            repository.Update(activityInst);
        }

        /// <summary>
        ///修改流程状态 
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <param name="status">流程状态</param>
        public void UpdateProcessInstStatus(string processInstID, ProcessInstStatus status)
        {
            ProcessInst instance = repository.GetDomain<ProcessInst>(processInstID);

            if (instance == null)
            {
                log.Warn("UpdateActivityInstStatus error activityInst is null");
                return;
            }

            instance.CurrentState = (short)status;
            repository.Update(instance);
        }

        /// <summary>
        /// 获取活动参与者
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <param name="activityDefID">活动定义ID</param>
        /// <returns></returns>
        public string GetParticipant(string processDefID, string activityDefID)
        {
            return string.Empty;
            //ManualActivity ma = GetActivity(processDefID, activityDefID) as ManualActivity;

            ////if (ma.Participant.ParticipantType.Cast<ParticipantType>(ParticipantType.Person) == ParticipantType.Person)
            ////{

            ////}
            //return string.Join(",", ma.Participant.Participantors.Select(p => p.ID).ToArray());
        }
        #endregion

        #region Repository
        private IRepository<string> repository = new Repository<string>();
        public IRepository<string> Repository
        {
            get
            {
                if (repository == null)
                {
                    repository = new Repository<string>();
                }

                return repository;
            }
        }
        #endregion
        #endregion
    }
}
