using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EAFrame.Workflow.Definition
{
    public interface IExecute
    {
        void Execute(object state);
    }
}
