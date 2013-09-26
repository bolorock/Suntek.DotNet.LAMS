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
    /// 业务变量
    /// </summary>
    public class BizVariable : ConfigureElement
    {
        #region Properties
        /// <summary>
        /// 变量名
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
        /// 变量取值路径
        /// </summary>
        public string XPath
        {
            get
            {
                return Properties.GetSafeValue<string>("xpath");
            }
            set
            {
                Properties.SafeAdd("xpath", value);
            }
        }

        /// <summary>
        /// Id
        /// </summary>
        public string Id
        {
            get
            {
                return Properties.GetSafeValue<string>("id");
            }
            set
            {
                Properties.SafeAdd("id", value);
            }
        }

        /// <summary>
        /// 变量说明
        /// </summary>
        public string Description
        {
            get
            {
                return Properties.GetSafeValue<string>("description");
            }
            set
            {
                Properties.SafeAdd("description", value);
            }
        }
        #endregion

        #region Construtor
        public BizVariable()
        {
            ElementName = "bizVariable";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public BizVariable(IConfigureElement parent, XElement xElem)
            : base(parent, "bizVariable", xElem)
        { }

        #endregion
    }
}
