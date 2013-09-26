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
    [Remark("路由活动")]
    public class RouterActivity : Activity
    {
        #region Properties 成员
        #endregion

        #region Construtor
        /// <summary>
        /// 构造函数
        /// </summary>
        public RouterActivity()
        {
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public RouterActivity(IConfigureElement parent, XElement xElem)
            : base(parent, xElem)
        {
        }

        #endregion

        #region Methods

        #endregion
    }
}
