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
    /// 参数
    /// </summary>
    public class Parameter : ConfigureElement
    {
        #region Properties
        /// <summary>
        /// 参数名称
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
        /// 参数方向
        /// </summary>
        public string Direction
        {
            get
            {
                return Properties.GetSafeValue<string>("direction");
            }
            set
            {
                Properties.SafeAdd("direction", value);
            }
        }


        /// <summary>
        /// 参数值
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
        public Parameter()
        {
            ElementName = "parameter";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public Parameter(IConfigureElement parent, XElement xElem)
            : base(parent, "parameter", xElem)
        { }

        #endregion
    }
}
