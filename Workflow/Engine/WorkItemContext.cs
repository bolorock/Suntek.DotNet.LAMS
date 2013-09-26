using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EAFrame.Core.Utility;
using EAFrame.Core.Enums;
using EAFrame.Core.Extensions;
using EAFrame.Core.Caching;
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Service;
using EAFrame.Workflow.Enums;
using EAFrame.Workflow.Definition;

namespace EAFrame.Workflow.Engine
{
    /// <summary>
    /// 工作项上下文
    /// </summary>
    public class WorkItemContext
    {
        #region Properties

        /// <summary>
        /// 流程上下文
        /// </summary>
        public EngineContext EngineContext
        {
            get;
            set;
        }

        /// <summary>
        /// 流程实例
        /// </summary>
        public ProcessInst ProcessInst
        {
            get;
            set;
        }

        /// <summary>
        /// 活动实例
        /// </summary>
        public ActivityInst ActivityInst
        {
            get;
            set;
        }

        /// <summary>
        /// 当前工作项
        /// </summary>
        public WorkItem WorkItem
        {
            get;
            set;
        }

        /// <summary>
        /// 参数
        /// </summary>
        public IDictionary<string, object> Parameters
        {
            get;
            set;
        }
        #endregion

        #region Contructor
        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="engineContext">流程引擎上下文</param>
        /// <param name="processInst">流程实例</param>
        /// <param name="activityInst">活动实例</param>
        /// <param name="workItem">工作项</param>
        public WorkItemContext(EngineContext engineContext, ProcessInst processInst, ActivityInst activityInst, WorkItem workItem)
        {
            this.ProcessInst = processInst;
            this.ActivityInst = activityInst;
            this.EngineContext = engineContext;
            this.WorkItem = workItem;
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        public WorkItemContext()
        { }
        #endregion
    }
}
