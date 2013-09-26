using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;

using EAFrame.Workflow.Domain;

namespace EAFrame.Workflow.Engine
{
    [ServiceContract]
    public interface IWorkflowService
    {
        [OperationContract]
        string GetProcessDefine(string processDefID);
    }

    public class WorkflowService : IWorkflowService
    {
        IWorkflowEngine engine = new WorkflowEngine();

        public string GetProcessDefine(string processDefID)
        {
            return (engine.Persistence.Repository.GetDomain<ProcessDef>(processDefID) ?? new ProcessDef()).Content;
        }
    }
}
