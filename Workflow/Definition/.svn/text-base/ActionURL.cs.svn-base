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
    /// 响应URL
    /// </summary>
    public class ActionURL : ConfigureElement
    {
        #region Properties
        /// <summary>
        /// 是否自定义URL
        /// </summary>
        public bool IsSpecifyURL
        {
            get
            {
                return Properties.GetSafeValue<bool>("isSpecifyURL", false);
            }
            set
            {
                Properties.SafeAdd("isSpecifyURL", value);
            }
        }

        /// <summary>
        /// URL类型,presentation-logic(展现逻辑),web-page(web页面),other(其他)
        /// </summary>
        public string URLType
        {
            get
            {
                return Properties.GetSafeValue<string>("urlType");
            }
            set
            {
                Properties.SafeAdd("urlType", value);
            }
        }

        /// <summary>
        /// 调用URL
        /// </summary>
        public string SpecifyURL
        {
            get
            {
                return Properties.GetSafeValue<string>("specifyURL");
            }
            set
            {
                Properties.SafeAdd("specifyURL", value);
            }
        }

        #endregion

        #region Construtor
        public ActionURL()
        {
            ElementName = "actionURL";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public ActionURL(IConfigureElement parent, XElement xElem)
            : base(parent, "actionURL", xElem)
        { }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="elemName">元素名</param>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public ActionURL(string elemName, IConfigureElement parent, XElement xElem)
            : base(parent, elemName, xElem)
        { }

        #endregion
    }
}
