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
    [Remark("人工活动")]
    public class ManualActivity : Activity
    {
        #region Properties 成员

        /// <summary>
        /// 是否允许代理
        /// </summary>
        public bool AllowAgent
        {
            get
            {
                return Properties.GetSafeValue<bool>("allowAgent");
            }
            set
            {
                Properties.SafeAdd("allowAgent", value);
            }
        }

        /// <summary>
        /// 重置参与者
        /// </summary>
        public string ResetParticipant
        {
            get
            {
                return Properties.GetSafeValue<string>("resetParticipant");
            }
            set
            {
                Properties.SafeAdd("resetParticipant", value);
            }
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
        /// 自定义URL
        /// </summary>
        public ActionURL CustomURL
        {
            get;
            set;
        }

        /// <summary>
        /// 重置URL
        /// </summary>
        public ActionURL ResetURL
        {
            get;
            set;
        }

        /// <summary>
        /// 参与者
        /// </summary>
        public Participant Participant
        {
            get;
            set;
        }

        /// <summary>
        /// 多工作项设置
        /// </summary>
        public MultiWorkItem MultiWorkItem
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

        /// <summary>
        /// 自由流规则
        /// </summary>
        public FreeFlowRule FreeFlowRule
        {
            get;
            set;
        }

        /// <summary>
        /// 工作流表单
        /// </summary>
        public Form Form
        {
            get;
            set;
        }

        #endregion

        #region Construtor
        /// <summary>
        /// 构造函数
        /// </summary>
        public ManualActivity()
        { }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public ManualActivity(IConfigureElement parent, XElement xElem)
            : base(parent, xElem)
        {
            ActivateRule = new ActivateRule(this, xElem.Element("activateRule"));
            Parameters = xElem.Element("parameters").Elements().Select(e => new Parameter(this, e)).ToList();
            Style = new Style(this, xElem.Element("style"));
            CustomURL = new ActionURL("customURL", this, xElem.Element("customURL"));
            ResetURL = new ActionURL("resetURL", this, xElem.Element("resetURL"));
            Participant = new Participant(this, xElem.Element("participant"));
            Form = new Form(this, xElem.Element("form"));
            TimeLimit = new TimeLimit(this, xElem.Element("timeLimit"));
            MultiWorkItem = new MultiWorkItem(this, xElem.Element("multiWorkItem"));
            TriggerEvents = xElem.Element("triggerEvents").Elements("triggerEvent").Select(o => new TriggerEvent(this, o)).ToList();
            RollBack = new CustomAction("rollBack", this, xElem.Element("rollBack"));
            FreeFlowRule = new FreeFlowRule(this, xElem.Element("freeFlowRule"));
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
                               new XElement("manualActivity",
                                   CustomURL.ToXElement(),
                                   ResetURL.ToXElement(),
                                   Participant.ToXElement(),
                                   Form.ToXElement(),
                                   TimeLimit.ToXElement(),
                                   MultiWorkItem.ToXElement(),
                                   new XElement("triggerEvents", TriggerEvents != null ? TriggerEvents.Select(o => o.ToXElement()) : null),
                                   RollBack.ToXElement(),
                                   FreeFlowRule.ToXElement()));
        }
        #endregion
    }
}
