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
    [Remark("结束活动")]
    public class EndActivity : Activity
    {
        #region Properties 成员

        /// <summary>
        /// 激活规则
        /// </summary>
        public ActivateRule ActivateRule
        {
            get;
            set;
        }

        #endregion

        #region Construtor
        /// <summary>
        /// 构造函数
        /// </summary>
        public EndActivity()
        {
            ActivateRule = new ActivateRule();
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public EndActivity(IConfigureElement parent, XElement xElem)
            : base(parent, xElem)
        {
            ActivateRule = new ActivateRule(this, xElem.Element("activateRule"));
            Style = new Style(this, xElem.Element("style"));
        }

        #endregion

        #region Methods
        /// <summary>
        /// 把对象转换为XElement元素
        /// </summary>
        /// <returns></returns>
        public override XElement ToXElement()
        {
            return new XElement(ElementName,
                                Attibutes.Select(o => new XAttribute(o.Key, o.Value)),
                                Properties.Select(o => new XElement(o.Key, o.Value)),
                                ActivateRule.ToXElement(),
                                Style.ToXElement());
        }
        #endregion
    }
}
