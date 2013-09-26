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
    /// 流程上下文
    /// </summary>
    public class ProcessContext
    {
        public ProcessDefine ProcessDefine
        {
            get;
            set;
        }

        //public ProcessDef ProcessDef
        //{
        //    get;
        //    set;
        //}

        public ProcessInst ProcessInst
        {
            get;
            set;
        }

        public IDictionary<string, object> Parameters
        {
            get;
            set;
        }

        public EngineContext EngineContext
        {
            get;
            set;
        }

        public ProcessContext()
        { }
    }
}
