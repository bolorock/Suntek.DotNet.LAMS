using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EAFrame.Core.Extensions;
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Service;

namespace EAFrame.Workflow.Engine
{
    /// <summary>
    /// 跟踪日志
    /// </summary>
    public class Trace
    {
        static TraceLogService service = new TraceLogService();

        /// <summary>
        /// 跟踪日志
        /// </summary>
        /// <param name="message">消息</param>
        public static void Print(string message)
        {
            Print(message, null);
        }

        /// <summary>
        /// 跟踪日志
        /// </summary>
        /// <param name="message">消息</param>
        public static void Print(WFException exception)
        {
            Print(exception.ToSafeString(), null);
        }

        /// <summary>
        /// 跟踪日志
        /// </summary>
        /// <param name="message"></param>
        /// <param name="ex"></param>
        public static void Print(string message, Exception ex)
        {
            log4net.ILog log = log4net.LogManager.GetLogger("ProcessTrace");
            log.Info(message, ex);
        }

        /// <summary>
        /// 跟踪日志
        /// </summary>
        /// <param name="log">日志记录</param>
        public static void Print(TraceLog log)
        {
            service.SaveOrUpdate(log);
        }
    }
}
