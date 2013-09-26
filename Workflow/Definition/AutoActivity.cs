using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

using log4net;
using EAFrame.Core.Extensions;
using EAFrame.Core.Enums;

namespace EAFrame.Workflow.Definition
{
    [Remark("自动活动")]
    public class AutoActivity : Activity
    {
        #region Properties 成员
        /// <summary>
        /// 调用类型:business-logic(业务逻辑),calculate-logic(运算逻辑)
        /// </summary>
        public string InvokeType
        {
            get
            {
                return Properties.GetSafeValue<string>("invokeType");
            }
            set
            {
                Properties.SafeAdd("invokeType", value);
            }
        }

        /// <summary>
        /// 自动返回结果
        /// </summary>
        public bool IsReturnBizLogicResult
        {
            get
            {
                return Properties.GetSafeValue<bool>("isReturnBizLogicResult");
            }
            set
            {
                Properties.SafeAdd("isReturnBizLogicResult", value);
            }
        }


        /// <summary>
        /// 执行动作
        /// </summary>
        public string ExecuteAction
        {
            get
            {
                return Properties.GetSafeValue<string>("executeAction");
            }
            set
            {
                Properties.SafeAdd("executeAction", value);
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
        /// 结束方式，auto（自动），manual（人工）
        /// </summary>
        public string TerminateType
        {
            get
            {
                return Properties.GetSafeValue<string>("terminateType");
            }
            set
            {
                Properties.SafeAdd("terminateType", value);
            }
        }

        /// <summary>
        /// 调用类型:business-logic(业务逻辑),calculate-logic(运算逻辑)
        /// </summary>
        public string RollbackType
        {
            get
            {
                return Properties.GetSafeValue<string>("rollbackType");
            }
            set
            {
                Properties.SafeAdd("rollbackType", value);
            }
        }

        /// <summary>
        /// 回退动作
        /// </summary>
        public string RollbackAction
        {
            get
            {
                return Properties.GetSafeValue<string>("rollbackAction");
            }
            set
            {
                Properties.SafeAdd("rollbackAction", value);
            }
        }

        /// <summary>
        /// 激活规则
        /// 有三种直接运行，待激活，由规则逻辑返回值确定
        /// </summary>
        public string ActivateRule
        {
            get
            {
                return Properties.GetSafeValue<string>("activateRule");
            }
            set
            {
                Properties.SafeAdd("activateRule", value);
            }
        }

        /// <summary>
        /// 规则逻辑
        /// 激活规则确定该活动在流程流转至此时将以何种方式激活，规则逻辑返回值为1或true
        /// 时可直接激活，否则为待激活。
        /// </summary>
        public string ActivateRuleApp
        {
            get
            {
                return Properties.GetSafeValue<string>("activateRuleApp");
            }
            set
            {
                Properties.SafeAdd("activateRuleApp", value);
            }
        }
        #endregion

        #region Construtor
        /// <summary>
        /// 构造函数
        /// </summary>
        public AutoActivity()
        {
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public AutoActivity(IConfigureElement parent, XElement xElem)
            : base(parent, xElem)
        {
            if (xElem == null) return;

            XElement elem = xElem.Element("parameters");
            if (elem != null)
            {
                Parameters = elem.Elements("parameter").Select(e => new Parameter(this, e)).ToList();
            }

            var xTriggerEvents = xElem.Element("triggerEvents");
            if (xTriggerEvents != null)
            {
                TriggerEvents = xTriggerEvents.Elements("triggerEvent").Select(o => new TriggerEvent(this, o)).ToList();
            }
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
                                new XElement("properties",
                                 Properties.Select(p => new XElement("property", new XAttribute("name", p.Key), new XAttribute("value", p.Value)))),
                                Parameters != null ? new XElement("parameters",
                                            Parameters.Select(p => p.ToXElement())) : null,
                                TriggerEvents != null ? new XElement("triggerEvents",
                                            TriggerEvents.Select(o => o.ToXElement())) : null,
                                new XElement("description", Description));
        }

        #endregion
    }
}
