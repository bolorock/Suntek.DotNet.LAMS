using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;

using EAFrame.Core;
using EAFrame.Core.Data;
using EAFrame.Core.Authentication;
using EAFrame.Core.Utility;
using EAFrame.Core.Enums;
using EAFrame.Core.Extensions;
using EAFrame.Core.Caching;
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Service;
using EAFrame.Workflow.Enums;
using EAFrame.Workflow.Definition;
using SunTek.EAFrame.AuthorizeCenter.Domain;

namespace EAFrame.Workflow.Engine
{
    /// <summary>
    /// 工作流引擎
    /// </summary>
    public class WorkflowEngine : IWorkflowEngine
    {
        #region Variables
        log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodInfo.GetCurrentMethod().DeclaringType);
        IEngineService engineService = null;
        private IDictionary<string, ProcessInst> runtimeProcessInsts = new Dictionary<string, ProcessInst>();
        private EngineContext context = new EngineContext();
        #endregion

        #region Properties

        /// <summary>
        /// 流程引擎上下文
        /// </summary>
        public EngineContext Context
        {
            get
            {
                return context;
            }
            set
            {
                context = value;
            }
        }

        /// <summary>
        /// 运行中的流程实例
        /// </summary>
        public IDictionary<string, ProcessInst> RuntimeProcessInsts
        {
            get
            {
                return runtimeProcessInsts;
            }
            set
            {
                runtimeProcessInsts = value;
            }
        }
        #endregion

        #region Constructor

        public WorkflowEngine()
        {
            engineService = new EngineService();
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        public WorkflowEngine(IEngineService engineService)
        {
            this.engineService = engineService;
        }
        #endregion

        #region Properties
        /// <summary>
        /// 流程数据接口
        /// </summary>
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
        #endregion

        #region IWorkflowEngine

        /// <summary>
        /// 清除流程缓存
        /// </summary>
        public void ClearProcessCache()
        {
            CacheManager.Remove("all_ProcessDefine");
        }

        /// <summary>
        /// 创建工作流
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <returns></returns>
        public string CreateAProcess(string processDefID)
        {
            return Persistence.CreateAProcess(processDefID);
        }

        /// <summary>
        /// 开始启动一个流程
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        ///<param name="parameters">启动参数</param>
        public void StartAProcess(string processInstID, IDictionary<string, object> parameters)
        {
            ProcessInst processInst = GetToRunProcessInst(processInstID, Context.User);
            ProcessDefine processDefine = Persistence.GetProcessDefine(processInst.ProcessDefID);
            ProcessContext processContext = new ProcessContext()
            {
                EngineContext = Context,
                ProcessDefine = processDefine,
                ProcessInst = processInst,
                Parameters = parameters
            };

            ProcessRuntime runtime = new ProcessRuntime(engineService, processContext);
            runtime.Run();
        }

        /// <summary>
        /// 开始启动一个流程
        /// </summary>
        /// <param name="processInstID">启动</param>
        public void StartAProcess(string processInstID)
        {
            StartAProcess(processInstID, null);
        }

        /// <summary>
        /// 获取一个流程实例
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <returns></returns>
        public ProcessInst GetProcessInst(string processInstID)
        {
            ProcessInst processInst = Persistence.GetProcessInst(processInstID);

            if (processInst == null)
            {
                Context.HandleException(new MessageException()
                {
                    PromptMessage = string.Format("不存在ID={0}的流程实例", processInstID),
                    Source = System.Reflection.MethodInfo.GetCurrentMethod().DeclaringType.FullName
                });
            }

            return processInst;
        }

        /// <summary>
        /// 获取一个流程实例
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <returns></returns>
        public ProcessInst GetToRunProcessInst(string processInstID, IUser user)
        {
            ProcessInst processInst = GetProcessInst(processInstID);
            ProcessDefine processDefine = GetProcessDefine(processInst.ProcessDefID);
            string processDefID = processInst.ProcessDefID;

            //如果流程还未启动，产生一个活动实例
            if (processInst.CurrentState == (short)ProcessInstStatus.NoStart)
            {
                DateTime createTime = DateTime.Now;
                Activity srcActivity = processDefine.StartActivity;
                ActivityInst srcActInst = Persistence.GetActivityInsts(processInstID, srcActivity.ID, ActivityInstStatus.Compeleted)[0];
                IList<Activity> destActivities = Persistence.GetOutActivities(processDefID, srcActivity.ID);

                using (ITransaction transaction = UnitOfWork.BeginTransaction(typeof(ProcessDef)))
                {
                    foreach (var destActivity in destActivities)
                    {
                        ActivityInst destActInst = new ActivityInst()
                        {
                            ActivityDefID = destActivity.ID,
                            CurrentState = (short)ActivityInstStatus.NoStart,
                            ID = IdGenerator.NewComb().ToString(),
                            CreateTime = createTime,
                            Description = destActivity.Description,
                            EndTime = Context.MaxDate,
                            Name = destActivity.Name,
                            ProcessInstID = processInstID,
                            RollbackFlag = 0,
                            StartTime = createTime,
                            SubProcessInstID = string.Empty,
                            Type = (short)destActivity.ActivityType.Cast<ActivityType>(ActivityType.ManualActivity)
                        };

                        Domain.Transition transition = new Domain.Transition()
                        {
                            ID = IdGenerator.NewComb().ToString(),
                            DestActID = destActivity.ID,
                            DestActInstID = destActInst.ID,
                            DestActInstName = destActInst.Name,
                            DestActName = destActivity.Name,
                            ProcessInstID = processInstID,
                            SrcActID = srcActivity.ID,
                            SrcActInstID = srcActInst.ID,
                            SrcActInstName = srcActInst.Name,
                            SrcActName = srcActivity.Name,
                            TransTime = createTime
                        };

                        TransControl transControl = new TransControl()
                        {
                            ID = IdGenerator.NewComb().ToString(),
                            DestActID = destActivity.ID,
                            DestActName = destActivity.Name,
                            ProcessInstID = processInst.ID,
                            SrcActID = srcActivity.ID,
                            SrcActName = srcActivity.Name,
                            TransTime = createTime,
                            TransWeight = 100
                        };


                        if (destActivity is ManualActivity)
                        {
                            ManualActivity ma = destActivity as ManualActivity;
                            WorkItem wi = new WorkItem()
                            {
                                ID = IdGenerator.NewComb().ToString(),
                                ActionMask = string.Empty,
                                ActionURL = ma.CustomURL.SpecifyURL,
                                ActivityInstID = destActInst.ID,
                                ActivityInstName = destActInst.Name,
                                AllowAgent = (short)(ma.AllowAgent ? 1 : 0),
                                BizState = (short)WorkItemBizStatus.Common,
                                CreateTime = createTime,
                                Creator = user.ID,
                                CreatorName = user.Name,
                                CurrentState = (short)WorkItemStatus.WaitExecute,
                                Description = destActInst.Description,
                                EndTime = Context.MaxDate,
                                Executor = string.Empty,
                                ExecutorName = string.Empty,
                                IsTimeOut = 0,
                                Name = destActInst.Name,
                                Participant = string.Empty,
                                ProcessID = processDefID,
                                ProcessInstID = processInst.ID,
                                ProcessInstName = processInst.Name,
                                ProcessName = processDefine.Name,
                                RemindTime = Context.MaxDate,
                                RootProcessInstID = string.Empty,
                                StartTime = createTime,
                                TimeOutTime = Context.MaxDate,
                                Type = destActInst.Type
                            };

                            foreach (var participantor in ma.Participant.Participantors)
                            {
                                Domain.Participant participant = new Domain.Participant()
                                {
                                    ID = IdGenerator.NewComb().ToString(),
                                    CreateTime = createTime,
                                    DelegateType = (short)DelegateType.Sponsor,
                                    Name = participantor.Name,
                                    ParticipantID = participantor.ID,
                                    ParticipantIndex = participantor.SortOrder,
                                    ParticipantType = (short)participantor.ParticipantorType.Cast<ParticipantorType>(ParticipantorType.Person),
                                    PartiInType = (short)PartiInType.Exe,
                                    WorkItemID = wi.ID,
                                    WorkItemState = (short)wi.CurrentState
                                };

                                Persistence.Repository.SaveOrUpdate(participant);
                            }

                            Persistence.Repository.SaveOrUpdate(wi);
                        }

                        srcActInst.CurrentState = (short)ActivityInstStatus.Compeleted;
                        Persistence.Repository.SaveOrUpdate(srcActInst);
                        Persistence.Repository.SaveOrUpdate(destActInst);
                        Persistence.Repository.SaveOrUpdate(transition);
                        Persistence.Repository.SaveOrUpdate(transControl);
                        transaction.Commit();
                    }
                }
            }

            return processInst;
        }

        /// <summary>
        /// 获取流程定义
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <returns></returns>
        public ProcessDefine GetProcessDefine(string processDefID)
        {
            return Persistence.GetProcessDefine(processDefID);
        }

        /// <summary>
        /// 获取流程活动实例列表
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <returns></returns>
        public IList<ActivityInst> GetActivityInsts(string processInstID)
        {
            return Persistence.GetActivityInsts(processInstID);
        }

        /// <summary>
        /// 获取活动实例工作项列表
        /// </summary>
        /// <param name="activityInstID">活动实例ID</param>
        /// <returns></returns>
        public IList<WorkItem> GetWorkItems(string activityInstID)
        {
            return Persistence.GetWorkItems(activityInstID);
        }

        /// <summary>
        /// 获取待办工作项列表
        /// </summary>
        /// <param name="userID">用户ID</param>
        /// <param name="parameters">参数</param>
        /// <returns></returns>
        public IList<WorkItem> GetMyWorkItems(string userID, IDictionary<string, object> parameters)
        {
            return Persistence.GetMyWorkItems(userID, parameters);
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
            return Persistence.GetMyWorkItems(userID, parameters, pageInfo);
        }

        /// <summary>
        /// 完成一个工作项
        /// </summary>
        /// <param name="user">当前用户</param>
        /// <param name="workItemID">工作项ID</param>
        /// <param name="parameters">参数</param>
        public void CompleteWorkItem(IUser user, string workItemID, IDictionary<string, object> parameters)
        {
            WorkItem wi = Persistence.GetWorkItem(workItemID);
            if (wi.CurrentState != (short)WorkItemStatus.WaitExecute)
            {
                Context.HandleException(new MessageException()
                {
                    PromptMessage = string.Format("ID={0}的工作项{1}当前状态={2},不能被执行", wi.ID, wi.Name, wi.CurrentState.ToString().Cast<WorkItemStatus>(WorkItemStatus.Executing).GetRemark()),
                    Source = System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.FullName
                });

                return;
            }

            wi.CurrentState = (short)WorkItemStatus.Executing;

            using (ITransaction trans = UnitOfWork.BeginTransaction(typeof(ProcessDef)))
            {
                Persistence.Repository.SaveOrUpdate(wi);
                Persistence.UpdateActivityInstStatus(wi.ActivityInstID, ActivityInstStatus.Running);

                trans.Commit();
            }

            ProcessInst processInst = Persistence.GetProcessInst(wi.ProcessInstID);
            ProcessDefine processDefine = Persistence.GetProcessDefine(processInst.ProcessDefID);
            ProcessContext processContext = new ProcessContext()
            {
                EngineContext = Context,
                ProcessDefine = processDefine,
                ProcessInst = processInst,
                Parameters = parameters
            };

            ProcessRuntime runtime = new ProcessRuntime(engineService, processContext);
            runtime.Run();
        }

        /// <summary>
        /// 检查并更新工作项
        /// </summary>
        /// <param name="workItemID">工作项ID</param>
        public void CheckAndUpdateWorkItem(string workItemID)
        {

        }

        /// <summary>
        /// 更新工作项状态
        /// </summary>
        /// <param name="workItemID">工作项ID</param>
        /// <param name="newStatus">工作项状态</param>
        public void UpdateWorkItemStatus(string workItemID, WorkItemStatus newStatus)
        {
        }

        /// <summary>
        /// 是否可以处理工作项状态
        /// </summary>
        /// <param name="workItemID">工作项ID</param>
        /// <param name="newStatus">工作项状态</param>
        /// <returns></returns>
        public bool CanProcess(string workItemID, WorkItemStatus newStatus)
        {
            return false;
        }

        /// <summary>
        /// 获取角色和组织参与者
        /// </summary>
        /// <returns></returns>
        public IList<Participantor> GetRoleAndOrgParticipantors()
        {
            string cacheKey = "All_RoleAndOrgParticipantors";
            IList<Participantor> result = CacheManager.GetData<IList<Participantor>>(cacheKey);
            if (result == null)
            {
                int index = 0;
                result = Persistence.Repository.All<Role>().Select(r =>
                   new Participantor()
                   {
                       ID = r.ID,
                       ParticipantorType = ParticipantorType.Role,
                       SortOrder = ++index,
                       Name = r.Name,
                       ParentID = r.AppID
                   }).ToList();

                index = 0;
                foreach (var o in Persistence.Repository.All<Organization>())
                {
                    result.Add(new Participantor()
                    {
                        ID = o.ID,
                        Name = o.Name,
                        ParticipantorType = ParticipantorType.Org,
                        SortOrder = ++index,
                        ParentID = o.ParentID
                    });
                }

                CacheManager.Add(cacheKey, result);
            }

            return result;
        }

        /// <summary>
        /// 获取某参与者类型下的所有参与者
        /// </summary>
        /// <param name="parentType">父参与者类型</param>
        /// <param name="parentID">父参与者ID</param>
        /// <returns></returns>
        public IList<Participantor> GetPersonParticipantors(ParticipantorType parentType, string parentID)
        {
            IDictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.SafeAdd("ID", "none");
            if (parentType == ParticipantorType.Role)
            {
                parameters.SafeAdd("ID", new EAFrame.Core.Data.Condition(string.Format("ID in (select b.ObjectID from OM_ObjectRole b where b.RoleID='{0}')", parentID)));
            }
            else if (parentType == ParticipantorType.Org)
            {
                parameters.SafeAdd("ID", new EAFrame.Core.Data.Condition(string.Format("ID in (select b.EmployeeID from OM_EmployeeOrg b where b.OrgID='{0}')", parentID)));
            }

            int index = 0;
            return Persistence.Repository.FindAll<Employee>(parameters).Select(o => new Participantor()
            {
                ID = o.ID,
                Name = o.Name,
                ParticipantorType = ParticipantorType.Person,
                SortOrder = ++index,
                ParentID = parentID
            }).ToList();
        }

        #endregion
    }
}
