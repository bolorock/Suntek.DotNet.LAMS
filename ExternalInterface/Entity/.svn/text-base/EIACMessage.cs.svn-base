using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.Security.Cryptography;
using EAFrame.Core.Domain;
using EAFrame.Core.Extensions;
using log4net;

using System.Configuration;

namespace SunTek.EAFrame.ExternalInterface.Entity
{
    [Serializable]
    public class EIACMessage : BaseElement
    {
        static ILog log = LogManager.GetLogger(typeof(EIACMessage));

        #region Properties

        /// <summary>
        /// 消息关联ID
        /// </summary>
        public string RelatedID
        {
            get;
            set;
        }

        /// <summary>
        /// 接口版本
        /// </summary>
        public string Version
        {
            get;
            set;
        }

        /// <summary>
        /// 应用系统ID
        /// </summary>
        public string AppSystemID
        {
            get;
            set;
        }

        /// <summary>
        /// 操作类型
        /// 必填 
        /// 1-新建提交/新建保存
        /// 2-待办提交/待办保存/转他人处理/意外处理
        /// 3-转传阅
        /// 4-转已阅
        /// 5-办结
        /// </summary>
        public string RequestType
        {
            get;
            set;
        }

        /// <summary>
        /// 流程实例ID
        /// </summary>
        public string AppProcInstID
        {
            get;
            set;
        }

        /// <summary>
        /// 流程模型别名
        /// </summary>
        public string ModelAlias
        {
            get;
            set;
        }

        /// <summary>
        /// 流程模型名称
        /// </summary>
        public string ModelName
        {
            get;
            set;
        }

        /// <summary>
        /// 文档标题
        /// </summary>
        public string Title
        {
            get;
            set;
        }

        /// <summary>
        /// 密级类型
        /// 默认值1 1=一般；
        /// 2=企业密级； 
        /// 3=企业机密
        /// </summary>
        public string SecurityFlag
        {
            get;
            set;
        }

        /// <summary>
        /// 来文单位
        /// </summary>
        public string OrigDeptName
        {
            get;
            set;
        }

        /// <summary>
        /// 是否考核
        /// </summary>
        public string AssessFlag
        {
            get;
            set;
        }

        /// <summary>
        /// 处理时间
        /// 必填，格式如下： 2008-12-01 08:15:10
        /// </summary>
        public DateTime CreateTime
        {
            get;
            set;
        }

        /// <summary>
        /// 要求完成时间
        /// </summary>
        public DateTime DeadLineTime
        {
            get;
            set;
        }

        /// <summary>
        /// 拟稿人AD帐号
        /// </summary>
        public string Initiator
        {
            get;
            set;
        }

        /// <summary>
        /// 拟稿人姓名
        /// </summary>
        public string InitiatorName
        {
            get;
            set;
        }

        /// <summary>
        /// 拟稿人部门ID
        /// </summary>
        public string InitDeptID
        {
            get;
            set;
        }

        /// <summary>
        /// 拟稿人部门名
        /// </summary>
        public string InitDeptName
        {
            get;
            set;
        }

        /// <summary>
        /// 待办/待阅列表节点
        /// </summary>
        public List<EIACWorkItem> WorkItems
        {
            get;
            set;
        }

        /// <summary>
        /// 需结束的待办或已办数据节点
        /// </summary>
        public List<EIACClearItem> ClearItems
        {
            get;
            set;
        }

        /// <summary>
        /// 需产生的已办数据节点
        /// </summary>
        public List<EIACFinishedItem> FinishedItems
        {
            get;
            set;
        }

        /// <summary>
        /// 消息类型:自己增加
        /// 计划待办=0，
        /// 日志提醒待办=1，
        /// 
        /// </summary>
        public short MessageType
        {
            get;
            set;
        }

        /// <summary>
        /// 消息发送错误次数
        /// </summary>
        public int TrySendTimes
        {
            get;
            set;
        }

        /// <summary>
        /// 触发时间
        /// </summary>
        public DateTime TriggerTime
        {
            get;
            set;
        }

        /// <summary>
        /// 触发类型
        /// TriggerType=0 立即触发
        /// TriggerType=1 在指定TriggerTime点之后触发
        /// </summary>
        public short TriggerType
        {
            get;
            set;
        }
        #endregion

        public EIACMessage()
        {
            AppSystemID = "AP1500005000"; //todo:改成配置的
            Version = "V0.8";
            RequestType = "1";
            TrySendTimes = 0;
            MessageType = 0;
            ModelAlias = "经理人领导力测评流程";
            ModelName = "经理人领导力测评流程";
            AssessFlag = "0";
            SecurityFlag = "1";
            TriggerTime = new DateTime(2099, 1, 1);
            DeadLineTime = DateTime.Now.AddDays(7);
            CreateTime = DateTime.Now;

            WorkItems = new List<EIACWorkItem>();
            ClearItems = new List<EIACClearItem>();
            FinishedItems = new List<EIACFinishedItem>();
        }

        /// <summary>
        /// 将xml格式的消息转换为EIACClearItem对象
        /// </summary>
        /// <param name="xml"></param>
        /// <returns></returns>
        public static EIACMessage Parse(string xml)
        {
            XElement xelem = null;
            try
            {
                xelem = XElement.Parse(xml);
            }
            catch (Exception ex)
            {
                log.Error("Parse To Xml Error", ex);
                xelem = XDocument.Parse(xml).Root;
            }

            EIACMessage result = new EIACMessage();

            try
            {
                xelem = xelem.Element("RequestData");
                result.AppProcInstID = xelem.ChildElementValue("AppProcInstID");
                result.AppSystemID = xelem.ChildElementValue("AppSystemID");
                result.AssessFlag = xelem.ChildElementValue("AssessFlag");
                result.CreateTime = xelem.ChildElementValue("CreateTime").ToDateTime();
                result.DeadLineTime = xelem.ChildElementValue("DeadLineTime").ToDateTime();
                result.InitDeptID = xelem.ChildElementValue("InitDeptID");
                result.InitDeptName = xelem.ChildElementValue("InitDeptName");
                result.Initiator = xelem.ChildElementValue("Initiator");
                result.InitiatorName = xelem.ChildElementValue("InitiatorName");
                result.ModelAlias = xelem.ChildElementValue("ModelAlias");
                result.ModelName = xelem.ChildElementValue("ModelName");
                result.OrigDeptName = xelem.ChildElementValue("OrigDeptName");
                result.RequestType = xelem.ChildElementValue("RequestType");
                result.SecurityFlag = xelem.ChildElementValue("SecurityFlag");
                result.Title = xelem.ChildElementValue("Title");
                result.Version = xelem.ChildElementValue("Version");
                result.TriggerTime = new DateTime(2099, 1, 1);

                result.WorkItems = xelem.Descendants("WorkItem").Select(item => new EIACWorkItem()
                {
                    AppWorkQueueID = item.ChildElementValue("AppWorkQueueID"),
                    CurrActivity = item.ChildElementValue("CurrActivity"),
                    ExecDeptID = item.ChildElementValue("ExecDeptID"),
                    ExecDeptName = item.ChildElementValue("ExecDeptName"),
                    Executor = item.ChildElementValue("Executor"),
                    ExecutorName = item.ChildElementValue("ExecutorName"),
                    FileType = item.ChildElementValue("FileType"),
                    PendingItemURL = item.ChildElementValue("PendingItemURL"),
                }).ToList();

                result.ClearItems = xelem.Descendants("ClearItem").Select(item => new EIACClearItem()
                {
                    DataType = item.ChildElementValue("DataType"),
                    Executor = item.ChildElementValue("Executor"),
                    WorkQueueID = item.ChildElementValue("WorkQueueID")

                }).ToList();

                result.FinishedItems = xelem.Descendants("FinishedItem").Select(item => new EIACFinishedItem()
                {
                    AppWorkQueueID = item.ChildElementValue("AppWorkQueueID"),
                    CurrActivity = item.ChildElementValue("CurrActivity"),
                    ExecDeptID = item.ChildElementValue("ExecDeptID"),
                    ExecDeptName = item.ChildElementValue("ExecDeptName"),
                    Executor = item.ChildElementValue("Executor"),
                    ExecutorName = item.ChildElementValue("ExecutorName"),
                    FinishItemURL = item.ChildElementValue("FinishItemURL")
                }).ToList();
            }
            catch (Exception ex)
            {
                throw new FormatException(string.Format("把{0}转化为EIACMessage对象时出错！", xml), ex);
            }

            return result;
        }

        /// <summary>
        ///  把对象转换为XElement元素
        /// </summary>
        /// 
        /// <returns></returns>
        public override System.Xml.Linq.XElement ToXElement()
        {

            return new XElement("RequestMessage",
                       new XElement("RequestData",
                           NewXElement("Version", Version),
                           NewXElement("AppSystemID", AppSystemID),
                           NewXElement("RequestType", RequestType),
                           NewXElement("AppProcInstID", AppProcInstID),
                           NewXElement("ModelAlias", ModelAlias),
                           NewXElement("ModelName", ModelName),
                           NewXElement("Title", Title),
                           NewXElement("SecurityFlag", SecurityFlag),
                           NewXElement("OrigDeptName", OrigDeptName),
                           NewXElement("AssessFlag", AssessFlag),
                           NewXElement("CreateTime", CreateTime.ToSafeString()),
                           NewXElement("DeadLineTime", DeadLineTime.ToSafeString()),
                           NewXElement("Initiator", Initiator),
                           NewXElement("InitiatorName", InitiatorName),
                           NewXElement("InitDeptID", InitDeptID),
                           NewXElement("InitDeptName", InitDeptName),
                           WorkItems != null && WorkItems.Count > 0 ? new XElement("WorkItems", WorkItems.Select(o => o.ToXElement())) : null,
                           ClearItems != null && ClearItems.Count > 0 ? new XElement("ClearItems", ClearItems.Select(o => o.ToXElement())) : null,
                           FinishedItems != null && FinishedItems.Count > 0 ? new XElement("FinishedItems", FinishedItems.Select(o => o.ToXElement())) : null
                        )
                     );
        }
    }
}