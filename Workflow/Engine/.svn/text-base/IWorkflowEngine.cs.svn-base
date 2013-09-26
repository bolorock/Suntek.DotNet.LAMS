using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;

using EAFrame.Workflow.Definition;
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Enums;
using EAFrame.Core;
using EAFrame.Core.Authentication;

namespace EAFrame.Workflow.Engine
{
    /// <summary>
    /// 工作流引擎接口
    /// </summary>
    [ServiceContract]
    public interface IWorkflowEngine
    {
        /// <summary>
        /// 流程数据接口
        /// </summary>
        IWorkflowPersistence Persistence
        {
            get;
        }

        /// <summary>
        /// 清除流程缓存
        /// </summary>
        [OperationContract]
        void ClearProcessCache();

        /// <summary>
        /// 创建工作流
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <returns></returns>
        [OperationContract]
        string CreateAProcess(string processDefID);

        /// <summary>
        /// 开始启动一个流程
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <param name="parameters">参数</param>
        [OperationContract]
        void StartAProcess(string processInstID, IDictionary<string, object> parameters);

        /// <summary>
        /// 开始启动一个流程
        /// </summary>
        /// <param name="processInstID">启动</param>
        void StartAProcess(string processInstID);

        /// <summary>
        /// 获取一个流程实例
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <returns></returns>
        [OperationContract]
        ProcessInst GetProcessInst(string processInstID);

        /// <summary>
        /// 获取流程定义
        /// </summary>
        /// <param name="processDefID">流程定义ID</param>
        /// <returns></returns>
        [OperationContract]
        ProcessDefine GetProcessDefine(string processDefID);

        /// <summary>
        /// 获取流程活动实例列表
        /// </summary>
        /// <param name="processInstID">流程实例ID</param>
        /// <returns></returns>
        [OperationContract]
        IList<ActivityInst> GetActivityInsts(string processInstID);

        /// <summary>
        /// 获取活动实例工作项列表
        /// </summary>
        /// <param name="activityInstID">活动实例ID</param>
        /// <returns></returns>
        [OperationContract]
        IList<WorkItem> GetWorkItems(string activityInstID);

        /// <summary>
        /// 获取待办工作项列表
        /// </summary>
        /// <param name="userID">用户ID</param>
        /// <param name="parameters">参数</param>
        /// <returns></returns>
        IList<WorkItem> GetMyWorkItems(string userID, IDictionary<string, object> parameters);


        /// <summary>
        /// 获取待办工作项列表
        /// </summary>
        /// <param name="userID">用户ID</param>
        /// <param name="parameters">参数</param>
        /// <param name="pageInfo">分页信息</param>
        /// <returns></returns>
        IPageOfList<WorkItem> GetMyWorkItems(string userID, IDictionary<string, object> parameters, PageInfo pageInfo);

        /// <summary>
        /// 完成一个工作项
        /// </summary>
        /// <param name="user">当前用户</param>
        /// <param name="workItemID">工作项ID</param>
        /// <param name="parameters">参数</param>
        void CompleteWorkItem(IUser user, string workItemID, IDictionary<string, object> parameters);

        /// <summary>
        /// 检查并更新工作项
        /// </summary>
        /// <param name="workItemID">工作项ID</param>
        [OperationContract]
        void CheckAndUpdateWorkItem(string workItemID);

        /// <summary>
        /// 更新工作项状态
        /// </summary>
        /// <param name="workItemID">工作项ID</param>
        /// <param name="newStatus">工作项状态</param>
        [OperationContract]
        void UpdateWorkItemStatus(string workItemID, WorkItemStatus newStatus);

        /// <summary>
        /// 是否可以处理工作项状态
        /// </summary>
        /// <param name="workItemID">工作项ID</param>
        /// <param name="newStatus">工作项状态</param>
        /// <returns></returns>
        [OperationContract]
        bool CanProcess(string workItemID, WorkItemStatus newStatus);

        /// <summary>
        /// 获取角色和组织参与者
        /// </summary>
        /// <returns></returns>
        [OperationContract]
        IList<Participantor> GetRoleAndOrgParticipantors();

        /// <summary>
        /// 获取某参与者类型下的所有参与者
        /// </summary>
        /// <param name="parentType">父参与者类型</param>
        /// <param name="parentID">父参与者ID</param>
        /// <returns></returns>
        [OperationContract]
        IList<Participantor> GetPersonParticipantors(ParticipantorType parentType, string parentID);
    }
}
