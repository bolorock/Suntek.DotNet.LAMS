using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

using log4net;
using EAFrame.Core.Extensions;
using EAFrame.Workflow.Enums;

namespace EAFrame.Workflow.Definition
{
    /// <summary>
    /// 工作日历
    /// </summary>
    public class CalendarSet : ConfigureElement
    {
        #region Properties
        /// <summary>
        /// 初始类型
        /// </summary>
        public string InitType
        {
            get
            {
                return Properties.GetSafeValue<string>("initType");
            }
            set
            {
                Properties.SafeAdd("initType", value);
            }
        }

        /// <summary>
        /// 日历类型
        /// </summary>
        public string CalendarType
        {
            get
            {
                return Properties.GetSafeValue<string>("calendarType");
            }
            set
            {
                Properties.SafeAdd("calendarType", value);
            }
        }


        /// <summary>
        /// 日历标记
        /// </summary>
        public string CalendarId
        {
            get
            {
                return Properties.GetSafeValue<string>("calendarId");
            }
            set
            {
                Properties.SafeAdd("calendarId", value);
            }
        }

        /// <summary>
        /// 日历名称
        /// </summary>
        public string CalendarName
        {
            get
            {
                return Properties.GetSafeValue<string>("calendarName");
            }
            set
            {
                Properties.SafeAdd("calendarName", value);
            }
        }
        #endregion

        #region Construtor
        public CalendarSet()
        {
            ElementName = "calendarSet";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public CalendarSet(IConfigureElement parent, XElement xElem)
            : base(parent, "calendarSet", xElem)
        { }

        #endregion
    }
}
