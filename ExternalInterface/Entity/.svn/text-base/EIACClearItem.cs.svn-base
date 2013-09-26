using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using EAFrame.Core.Domain;
using EAFrame.Core.Extensions;
using log4net;


namespace SunTek.EAFrame.ExternalInterface.Entity
{
    /// <summary>
    /// 一条待办或已办
    /// </summary>
    [Serializable]
    public class EIACClearItem : BaseElement
    {
        /// <summary>
        /// 数据类型
        /// </summary>
        public string DataType
        {
            get;
            set;
        }

        /// <summary>
        /// 需结束待办或已办ID
        /// </summary>
        public string WorkQueueID
        {
            get;
            set;
        }

        /// <summary>
        /// 需要结束待办或已办的用户AD帐号
        /// </summary>
        public string Executor
        {
            get;
            set;
        }

        /// <summary>
        /// 把对象转换为XElement元素
        /// </summary>
        /// <returns></returns>
        public override XElement ToXElement()
        {
            return new XElement("ClearItem",
                        NewXElement("DataType", DataType),
                        NewXElement("WorkQueueID", WorkQueueID),
                        NewXElement("Executor", Executor));
        }
    }
}
