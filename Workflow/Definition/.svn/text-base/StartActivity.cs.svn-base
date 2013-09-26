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
    [Remark("开始活动")]
    public class StartActivity : Activity
    {
        #region Properties 成员

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
        public StartActivity()
        {
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public StartActivity(IConfigureElement parent, XElement xElem)
            : base(parent, xElem)
        {
            Parameters = xElem.Element("parameters").Elements("parameter").Select(e => new Parameter(this, e)).ToList();
            Style = new Style(this, xElem.Element("style"));
            Form = new Form(this, xElem.Element("startActivity").Element("form"));
        }

        #endregion

        #region Methods

        public override XElement ToXElement()
        {
            return new XElement(ElementName,
                                Attibutes.Select(o => new XAttribute(o.Key, o.Value)),
                                Properties.Select(p => new XElement(p.Key, p.Value)),
                                new XElement("parameters", Parameters != null ? Parameters.Select(p => p.ToXElement()) : null),
                                Style.ToXElement(),
                                new XElement("startActivity", Form != null ? Form.ToXElement() : null)
                               );

        }

        #endregion
    }
}
