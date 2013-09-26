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
    /// 表单字段
    /// </summary>
    public class FormField : ConfigureElement
    {
        #region Properties 成员
        /// <summary>
        /// 序号
        /// </summary>
        public string Index
        {
            get
            {
                return Properties.GetSafeValue<string>("index");
            }
            set
            {
                Properties.SafeAdd("index", value);
            }
        }

        /// <summary>
        /// 列名
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
        /// 类型
        /// </summary>
        public string Type
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
        /// 值
        /// </summary>
        public string Value
        {
            get
            {
                return Properties.GetSafeValue<string>("value");
            }
            set
            {
                Properties.SafeAdd("value", value);
            }
        }

        #endregion

        #region Construtor
        public FormField()
        {
            ElementName = "field";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public FormField(IConfigureElement parent, XElement xElem)
            : base(parent, "field", xElem)
        {
        }

        #endregion
    }
}