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
    /// 超时设置
    /// </summary>
    public class TimeLimit : ConfigureElement
    {
        /// <summary>
        /// 是否启用超时设置
        /// </summary>
        public bool IsTimeLimitSet
        {
            get
            {
                return Properties.GetSafeValue<bool>("isTimeLimitSet");
            }
            set
            {
                Properties.SafeAdd("isTimeLimitSet", value);
            }
        }

        /// <summary>
        /// 工作日历
        /// </summary>
        public CalendarSet CalendarSet
        {
            get;
            set;
        }

        /// <summary>
        /// 超时信息
        /// </summary>
        public TimeLimitInfo TimeLimitInfo
        {
            get;
            set;
        }

        /// <summary>
        /// 提醒信息
        /// </summary>
        public RemindInfo RemindInfo
        {
            get;
            set;
        }


        #region Construtor
        public TimeLimit()
        {
            ElementName = "timeLimit";
            Properties = new Dictionary<string, object>();
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public TimeLimit(IConfigureElement parent, XElement xElem)
            : base(parent, "timeLimit", xElem)
        {
            CalendarSet = new CalendarSet(this, xElem.Element("calendarSet"));
            TimeLimitInfo = new TimeLimitInfo(this, xElem.Element("timeLimitInfo"));
            RemindInfo = new RemindInfo(this, xElem.Element("remindInfo"));
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
                                CalendarSet.ToXElement(),
                                TimeLimitInfo.ToXElement(),
                                RemindInfo.ToXElement());
        }

        #endregion
    }
}
