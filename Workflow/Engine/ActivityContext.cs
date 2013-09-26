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
    /// 活动上下文
    /// </summary>
    public class ActivityContext
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
        public ActivityContext(EngineContext engineContext, ProcessInst processInst, ActivityInst activityInst)
        {
            this.ProcessInst = processInst;
            this.ActivityInst = activityInst;
            this.EngineContext = engineContext;
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        public ActivityContext()
        { }
        #endregion
    }
}
