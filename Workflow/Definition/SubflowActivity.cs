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
    [Remark("子流程")]
    public class SubflowActivity : Activity
    {
        #region Properties 成员

        /// <summary>
        /// 调用方式，synchronous同步，asynchronous异步
        /// </summary>
        public string SyncType
        {
            get;
            set;
        }

        /// <summary>
        /// 子流程
        /// </summary>
        public string SubProcess
        {
            get;
            set;
        }

        /// <summary>
        /// 是否多子流程
        /// </summary>
        public bool IsMultiSubProcess
        {
            get;
            set;
        }

        /// <summary>
        /// 关联数据
        /// </summary>
        public string IterationRelevantData
        {
            get;
            set;
        }

        /// <summary>
        /// 关联变量名
        /// </summary>
        public string IterationVariableName
        {
            get;
            set;
        }


        /// <summary>
        /// 激动规则
        /// </summary>
        public ActivateRule ActivateRule
        {
            get;
            set;
        }

        /// <summary>
        /// 回滚操作
        /// </summary>
        public CustomAction RollBack
        {
            get;
            set;
        }

        #endregion

        #region Construtor
        /// <summary>
        /// 构造函数
        /// </summary>
        public SubflowActivity()
        {
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public SubflowActivity(IConfigureElement parent, XElement xElem)
            : base(parent, xElem)
        {
            XElement subElem = xElem.Element("subActivity");
            SubProcess = subElem.Element("subProcess").Value;
            SyncType = subElem.Element("syncType").Value;
            IsMultiSubProcess = subElem.Element("isMultiSubProcess").Value.Cast<bool>(false);
            IterationRelevantData = subElem.Element("iterationRelevantData").Value;
            IterationVariableName = subElem.Element("iterationVariableName").Value;

            Parameters = xElem.Element("parameters").Elements("parameter").Select(e => new Parameter(this, e)).ToList();
            TriggerEvents = subElem.Element("triggerEvents").Elements("triggerEvent")
                           .Select(e => new TriggerEvent(this, e)).ToList();
            RollBack = new CustomAction("rollBack", this, xElem.Element("rollBack"));
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
                                Properties.Select(p => new XElement(p.Key, p.Value)),
                                ActivateRule.ToXElement(),
                                new XElement("parameters", Parameters != null ? Parameters.Select(p => p.ToXElement()) : null),
                                Style.ToXElement(),
                                new XElement("subActivity",
                                    new XElement("subProcess", SubProcess),
                                    new XElement("syncType", SyncType),
                                    new XElement("isMultiSubProcess", IsMultiSubProcess),
                                    new XElement("iterationRelevantData", IterationRelevantData),
                                    new XElement("iterationVariableName", IterationVariableName),
                                    new XElement("triggerEvents", TriggerEvents != null ? TriggerEvents.Select(o => o.ToXElement()) : null),
                                    RollBack.ToXElement()));
        }
        #endregion
    }
}
