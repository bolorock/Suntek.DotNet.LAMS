using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EAFrame.Core;
using EAFrame.Core.Authentication;
using EAFrame.Core.Utility;

namespace EAFrame.Workflow.Engine
{
    /// <summary>
    /// 工作流上下文
    /// </summary>
    public class EngineContext
    {
        private IUser user = null;
        /// <summary>
        ///当前用户
        /// </summary>
        public IUser User
        {
            get
            {
                if (user != null) return user;

                if (System.Web.HttpContext.Current == null)
                {
                    user = new User()
                    {
                        ID = "UR1500028529",
                        LoginName = "shengp",
                        Name = "沈国萍",
                        Skin = "Default",
                        OrgID = "OR1200001684",
                        UserType = (short)EAFrame.Core.Enums.UserType.Administrator
                    };
                }
                else
                {
                    user = WebUtil.GetCurrentUser();
                }

                return user;
            }
        }

        public IList<WFException> Errors
        {
            get;
            set;
        }

        private DateTime minDate = new DateTime(2000, 1, 1);
        /// <summary>
        /// 默认最小时间
        /// </summary>
        public DateTime MinDate
        {
            get
            {
                return minDate;
            }
        }

        private DateTime maxDate = new DateTime(2099, 1, 1);
        /// <summary>
        /// 默认最大时间
        /// </summary>
        public DateTime MaxDate
        {
            get
            {
                return maxDate;
            }
        }

        private char expressionVariablePrefix = ':';
        /// <summary>
        /// 流程条件表达式变量前缀
        /// </summary>
        public char ExpressionVariablePrefix
        {
            get
            {
                return expressionVariablePrefix;
            }
        }

        public void HandleException(WFException exception)
        {
            Errors.Add(exception);
            Trace.Print(exception);
        }

        public EngineContext()
        {
            Errors = new List<WFException>();
        }
    }
}
