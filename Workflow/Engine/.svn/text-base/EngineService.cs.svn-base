using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EAFrame.Workflow.Engine
{
    /// <summary>
    /// 工作流服务类
    /// </summary>
    public class EngineService : IEngineService
    {
        public EngineService()
        {
            Persistence = new WorkflowPersistence();
            Notification = new Notification();
        }
        #region IEngineService

        public IWorkflowPersistence Persistence
        {
            get;
            set;
        }

        public INotification Notification
        {
            get;
            set;
        }

        public IWorkAssign WorkAssign
        {
            get;
            set;
        }
        #endregion
    }
}
