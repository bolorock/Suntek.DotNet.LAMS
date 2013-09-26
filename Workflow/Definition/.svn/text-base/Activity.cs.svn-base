using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

using log4net;
using EAFrame.Core.Extensions;

namespace EAFrame.Workflow.Definition
{
    /// <summary>
    /// 工作流活动基类
    /// </summary>
    public abstract class Activity : ConfigureElement
    {
        #region Properties 成员
        /// <summary>
        /// 活动Id
        /// </summary>
        public string Id
        {
            get
            {
                return Properties.GetSafeValue<string>("id");
            }
            set
            {
                Properties.SafeAdd("id", value);
            }
        }

        /// <summary>
        /// 活动名称
        /// </summary>
        public string Name
        {
            get
            {
                return Properties.GetSafeValue<string>("name");
            }
            set
            {
                Properties.SafeAdd("name", value);
            }
        }

        /// <summary>
        /// 活动类型
        /// </summary>
        public string ActivityType
        {
            get
            {
                return Properties.GetSafeValue<string>("type");
            }
            set
            {
                Properties.SafeAdd("type", value);
            }
        }

        /// <summary>
        /// 分支模式
        /// </summary>
        public string SplitType
        {
            get
            {
                return Properties.GetSafeValue<string>("splitType");
            }
            set
            {
                Properties.SafeAdd("splitType", value);
            }
        }
        /// <summary>
        /// 聚合模式
        /// </summary>
        public string JoinType
        {
            get
            {
                return Properties.GetSafeValue<string>("joinType");
            }
            set
            {
                Properties.SafeAdd("joinType", value);
            }
        }

        /// <summary>
        /// 是否分享事物
        /// </summary>
        public bool IsSplitTransaction
        {
            get
            {
                return Properties.GetSafeValue<bool>("isSplitTransaction");
            }
            set
            {
                Properties.SafeAdd("isSplitTransaction", value);
            }
        }

        /// <summary>
        /// 优先级别
        /// </summary>
        public short Priority
        {
            get
            {
                return Properties.GetSafeValue<short>("priority"); ;
            }
            set
            {
                Properties.SafeAdd("priority", value);
            }

        }

        /// <summary>
        /// 说明
        /// </summary>
        public string Description
        {
            get
            {
                return Properties.GetSafeValue<string>("description"); ;
            }
            set
            {
                Properties.SafeAdd("description", value);
            }
        }

        /// <summary>
        /// 显示样式
        /// </summary>
        public Style Style
        {
            get;
            set;
        }

        /// <summary>
        /// 超时限制
        /// </summary>
        public TimeLimit TimeLimit
        {
            get;
            set;
        }

        /// <summary>
        /// 触发事件
        /// </summary>
        public List<TriggerEvent> TriggerEvents
        {
            get;
            set;
        }

        /// <summary>
        /// 活动参数
        /// </summary>
        public List<Parameter> Parameters
        {
            get;
            set;
        }
        #endregion

        #region Construtor
        /// <summary>
        /// 构造函数
        /// </summary>
        public Activity()
        {
            ElementName = "activity";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public Activity(IConfigureElement parent, XElement xElem)
            : base(parent, "activity", xElem)
        { }

        #endregion

        #region Methods

        public override int GetHashCode()
        {
            return string.Format("{0}.{1}", Name, Id).GetHashCode();
        }

        public override bool Equals(object obj)
        {
            if (obj == null) return false;

            if (obj.GetType() != this.GetType()) return false;

            Activity tmp = (Activity)obj;

            return Id == tmp.Id && Name == tmp.Name;
        }

        #endregion

        #region Events

        public EventHandler<ActivityContextArgs> OnExecute;

        #endregion

        #region Execute Methods

        public virtual void Execute(object state)
        {
            throw new Exception("no impl");
        }

        public virtual void Execute(Action task)
        {
            if (task != null)
            {
                task();
            }
        }
        #endregion
    }
}
