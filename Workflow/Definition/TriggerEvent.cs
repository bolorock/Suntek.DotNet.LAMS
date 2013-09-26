using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

using log4net;
using EAFrame.Core.Extensions;

namespace EAFrame.Workflow.Definition
{
    public class TriggerEvent : ConfigureElement
    {
        #region Properties 成员
        /// <summary>
        /// ID
        /// </summary>
        public string ID
        {
            get
            {
                return Attibutes.GetSafeValue<string>("id");
            }
            set
            {
                Attibutes.SafeAdd("id", value);
            }
        }

        /// <summary>
        /// 触发时机,创建（create）,启动（start）,结束（terminate）,超时（overtime）,提醒（remind）
        /// </summary>
        public string TriggerTime
        {
            get
            {
                return Properties.GetSafeValue<string>("triggerTime");
            }
            set
            {
                Properties.SafeAdd("triggerTime", value);
            }
        }

        /// <summary>
        /// 事件类型，业务逻辑(business-logic)，计算逻辑(calculate-logic)
        /// </summary>
        public string EventType
        {
            get
            {
                return Properties.GetSafeValue<string>("eventType");
            }
            set
            {
                Properties.SafeAdd("eventType", value);
            }
        }
        /// <summary>
        /// 调用方式，synchronous同步，asynchronous异步
        /// </summary>
        public string SyncType
        {
            get
            {
                return Properties.GetSafeValue<string>("syncType");
            }
            set
            {
                Properties.SafeAdd("syncType", value);
            }
        }

        /// <summary>
        /// 事件动作
        /// </summary>
        public string EventAction
        {
            get
            {
                return Properties.GetSafeValue<string>("eventAction");
            }
            set
            {
                Properties.SafeAdd("eventAction", value);
            }
        }


        #endregion

        #region Construtor
        public TriggerEvent()
        {
            ElementName = "triggerEvent";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public TriggerEvent(IConfigureElement parent, XElement xElem)
            : base(parent, "triggerEvent", xElem)
        {
        }

        #endregion

        #region Methods
        /// <summary>
        ///把对象转换为XElement元素
        /// </summary>
        /// <returns></returns>
        public override XElement ToXElement()
        {
            return new XElement(ElementName,
                                Attibutes.Select(o => new XAttribute(o.Key, o.Value)),
                                Properties.Select(p => new XElement(p.Key, p.Value)));
        }

        #endregion
    }
}
