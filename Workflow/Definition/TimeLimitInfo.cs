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
    /// 超时信息
    /// </summary>
    public class TimeLimitInfo : ConfigureElement
    {
        #region Properties
        /// <summary>
        /// 提醒类型
        /// </summary>
        public string RemindType
        {
            get
            {
                return Properties.GetSafeValue<string>("remindType");
            }
            set
            {
                Properties.SafeAdd("remindType", value);
            }
        }

        /// <summary>
        /// 超时提醒策略
        /// </summary>
        public string TimeLimitStrategy
        {
            get
            {
                return Properties.GetSafeValue<string>("timeLimitStrategy");
            }
            set
            {
                Properties.SafeAdd("timeLimitStrategy", value);
            }
        }


        /// <summary>
        /// 天
        /// </summary>
        public int Day
        {
            get
            {
                return Properties.GetSafeValue<int>("day");
            }
            set
            {
                Properties.SafeAdd("day", value);
            }
        }

        /// <summary>
        /// 小时
        /// </summary>
        public int Hour
        {
            get
            {
                return Properties.GetSafeValue<int>("hour");
            }
            set
            {
                Properties.SafeAdd("hour", value);
            }
        }

        /// <summary>
        /// 分钟
        /// </summary>
        public int Minute
        {
            get
            {
                return Properties.GetSafeValue<int>("minute");
            }
            set
            {
                Properties.SafeAdd("minute", value);
            }
        }

        /// <summary>
        /// 相关数据
        /// </summary>
        public string RelevantData
        {
            get
            {
                return Properties.GetSafeValue<string>("relevantData");
            }
            set
            {
                Properties.SafeAdd("relevantData", value);
            }
        }

        /// <summary>
        /// 是否发送超时信息
        /// </summary>
        public bool IsSendMessageForOvertime
        {
            get
            {
                return Properties.GetSafeValue<bool>("isSendMessageForOvertime");
            }
            set
            {
                Properties.SafeAdd("isSendMessageForOvertime", value);
            }
        }

        #endregion

        #region Construtor
        public TimeLimitInfo()
        {
            ElementName = "timeLimitInfo";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public TimeLimitInfo(IConfigureElement parent, XElement xElem)
            : base(parent, "timeLimitInfo", xElem)
        { }

        #endregion
    }
}
