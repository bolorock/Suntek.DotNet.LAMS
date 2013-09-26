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
    /// 标识一个待办或待阅节点
    /// </summary>
    [Serializable]
    public class EIACWorkItem : BaseElement
    {
        /// <summary>
        /// 待办/待阅GUID,标识一个待办或待阅
        /// </summary>
        public string AppWorkQueueID
        {
            get;
            set;
        }

        /// <summary>
        /// 文档类型
        /// WorkItem不空时必填 1=急办； 2=待办；3=待阅；
        /// </summary>
        public string FileType
        {
            get;
            set;
        }


        /// <summary>
        /// 当前待办节点的名称
        /// </summary>
        public string CurrActivity
        {
            get;
            set;
        }

        /// <summary>
        /// 待办/待阅页面URL
        /// </summary>
        public string PendingItemURL
        {
            get;
            set;
        }

        /// <summary>
        /// 处理人AD帐号
        /// </summary>
        public string Executor
        {
            get;
            set;
        }

        /// <summary>
        /// 处理人姓名
        /// </summary>
        public string ExecutorName
        {
            get;
            set;
        }

        /// <summary>
        /// 处理人部门ID
        /// </summary>
        public string ExecDeptID
        {
            get;
            set;
        }

        /// <summary>
        /// 处理人部门名
        /// </summary>
        public string ExecDeptName
        {
            get;
            set;
        }

        public EIACWorkItem()
        {
            FileType = "2";
        }

        /// <summary>
        /// 把对象转换为XElement元素
        /// </summary>
        /// <returns></returns>
        public override XElement ToXElement()
        {
            return new XElement("WorkItem",
                        NewXElement("AppWorkQueueID", AppWorkQueueID),
                        NewXElement("FileType", FileType),
                        NewXElement("CurrActivity", CurrActivity),
                        NewXElement("PendingItemURL", PendingItemURL),
                        NewXElement("Executor", Executor),
                        NewXElement("ExecutorName", ExecutorName),
                        NewXElement("ExecDeptID", ExecDeptID),
                        NewXElement("ExecDeptName", ExecDeptName));
        }
    }
}
