using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EAFrame.Core;
using EAFrame.Core.Authentication;
using EAFrame.Core.Utility;

namespace EAFrame.Workflow.Engine
{
    public class WFUtil
    {
        public static User GetCurrentUser()
        {
            return WebUtil.GetCurrentUser();
        }
    }
}
