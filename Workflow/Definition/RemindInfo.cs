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
    /// 提醒信息
    /// </summary>
    public class RemindInfo : ConfigureElement
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
        /// 提醒策略
        /// </summary>
        public string RemindStrategy
        {
            get
            {
                return Properties.GetSafeValue<string>("remindStrategy");
            }
            set
            {
                Properties.SafeAdd("remindStrategy", value);
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
        /// 提醒相关数据
        /// </summary>
        public string RemindRelevantData
        {
            get
            {
                return Properties.GetSafeValue<string>("remindRelevantData");
            }
            set
            {
                Properties.SafeAdd("remindRelevantData", value);
            }
        }

        /// <summary>
        /// 是否发送提醒信息
        /// </summary>
        public bool IsSendMessageForRemind
        {
            get
            {
                return Properties.GetSafeValue<bool>("isSendMessageForRemind");
            }
            set
            {
                Properties.SafeAdd("isSendMessageForRemind", value);
            }
        }

        #endregion

        #region Construtor
        public RemindInfo()
        {
            ElementName = "remindInfo";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public RemindInfo(IConfigureElement parent, XElement xElem)
            : base(parent, "remindInfo", xElem)
        { }

        #endregion
    }
}
