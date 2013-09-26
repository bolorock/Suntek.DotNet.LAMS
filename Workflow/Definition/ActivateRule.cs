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
    /// <summary>
    /// 激活规则
    /// </summary>
    public class ActivateRule : ConfigureElement
    {
        #region Properties
        /// <summary>
        /// 激活类型
        /// </summary>
        public string ActivateRuleType
        {
            get
            {
                return Properties.GetSafeValue<string>("activateRuleType");
            }
            set
            {
                Properties.SafeAdd("activateRuleType", value);
            }
        }

        /// <summary>
        /// 响应类型
        /// </summary>
        public string ActionType
        {
            get
            {
                return Properties.GetSafeValue<string>("actionType");
            }
            set
            {
                Properties.SafeAdd("actionType", value);
            }
        }

        /// <summary>
        /// 事物失败
        /// </summary>
        public string SuppressJoinFailure
        {
            get
            {
                return Properties.GetSafeValue<string>("suppressJoinFailure");
            }
            set
            {
                Properties.SafeAdd("suppressJoinFailure", value);
            }
        }

        /// <summary>
        /// 应用Uri
        /// </summary>
        public string ApplicationUri
        {
            get
            {
                return Properties.GetSafeValue<string>("applicationUri");
            }
            set
            {
                Properties.SafeAdd("applicationUri", value);
            }
        }

        /// <summary>
        ///事物类型
        /// </summary>
        public string TransactionType
        {
            get
            {
                return Properties.GetSafeValue<string>("transactionType");
            }
            set
            {
                Properties.SafeAdd("transactionType", value);
            }
        }

        /// <summary>
        /// 异常处理策略
        /// </summary>
        public string ExceptionStrategy
        {
            get
            {
                return Properties.GetSafeValue<string>("exceptionStrategy");
            }
            set
            {
                Properties.SafeAdd("exceptionStrategy", value);
            }
        }

        /// <summary>
        /// 调用模式
        /// </summary>
        public string InvokePattern
        {
            get
            {
                return Properties.GetSafeValue<string>("invokePattern");
            }
            set
            {
                Properties.SafeAdd("invokePattern", value);
            }
        }


        /// <summary>
        /// 参数
        /// </summary>
        public List<Parameter> Parameters
        {
            get;
            set;
        }

        #endregion

        #region Construtor
        public ActivateRule()
        {
            ElementName = "activateRule";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public ActivateRule(IConfigureElement parent, XElement xElem)
            : base(parent, "activateRule", xElem)
        {
            ActivateRuleType = xElem.ChildElementValue("activateRuleType");

            XElement elem = xElem.Element("customAction");
            elem.Elements().Where(e => e.Elements().Count() == 0)
                    .ForEach(e => Properties.SafeAdd(e.Name.LocalName, e.Value));
            Parameters = elem.Element("parameters").Elements().Select(e => new Parameter(this, e)).ToList();
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
                               new XElement("activateRuleType", ActivateRuleType),
                               new XElement("customAction",
                                           new XElement("actionType", ActionType),
                                           new XElement("suppressJoinFailure", SuppressJoinFailure),
                                           new XElement("applicationUri", ApplicationUri),
                                           new XElement("transactionType", TransactionType),
                                           new XElement("exceptionStrategy", ExceptionStrategy),
                                           new XElement("invokePattern", InvokePattern),
                                           new XElement("parameters",
                                           Parameters != null ? Parameters.Select(p => p.ToXElement()) : null))
                              );
        }
        #endregion
    }
}
