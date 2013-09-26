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
    /// 工作流表单
    /// </summary>
    public class Form : ConfigureElement
    {
        #region Properties 成员
        /// <summary>
        /// 表单名称
        /// </summary>
        public string Name
        {
            get
            {
                return Attibutes.GetSafeValue<string>("name");
            }
            set
            {
                Attibutes.SafeAdd("name", value);
            }
        }

        /// <summary>
        /// 表单行
        /// </summary>
        public List<FormField> Fields
        {
            get;
            set;
        }
        #endregion

        #region Construtor
        public Form()
        {
            ElementName = "form";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public Form(IConfigureElement parent, XElement xElem)
            : base(parent, "form", xElem)
        {
            Fields = xElem.Elements("field").Select(o => new FormField(this, o)).ToList();
        }

        #endregion

        #region Methods
        /// <summary>
        ///把对象转换为XElement元素
        /// </summary>
        /// <returns></returns>
        public override XElement ToXElement()
        {
            return new XElement(ElementName, Attibutes.Select(o => new XAttribute(o.Key, o.Value)),
                       Fields.Select(o => o.ToXElement()));
        }

        #endregion
    }
}
