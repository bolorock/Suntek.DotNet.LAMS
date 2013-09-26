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
    ///一个已办或已阅节点
    /// </summary>
    [Serializable]
    public class EIACFinishedItem : BaseElement
    {
        /// <summary>
        /// 已办或已阅ID
        /// </summary>
        public string AppWorkQueueID
        {
            get;
            set;
        }

        /// <summary>
        /// 当前处理节点名称
        /// </summary>
        public string CurrActivity
        {
            get;
            set;
        }

        /// <summary>
        /// 已办/已阅页面URL
        /// </summary>
        public string FinishItemURL
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
        /// 下节点处理人部门 （UUV中部门ID）
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

        /// <summary>
        /// 把对象转换为XElement元素
        /// </summary>
        /// <returns></returns>
        public override XElement ToXElement()
        {
            return new XElement("FinishedItem",
                        NewXElement("AppWorkQueueID", AppWorkQueueID),
                        NewXElement("CurrActivity", CurrActivity),
                        NewXElement("FinishItemURL", FinishItemURL),
                        NewXElement("Executor", Executor),
                        NewXElement("ExecutorName", ExecutorName),
                        NewXElement("ExecDeptID", ExecDeptID),
                        NewXElement("ExecDeptName", ExecDeptName));

        }
    }
}
