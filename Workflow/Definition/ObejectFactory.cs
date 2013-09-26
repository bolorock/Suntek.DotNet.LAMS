using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

using EAFrame.Core.Extensions;
using EAFrame.Core.Enums;
using log4net;

namespace EAFrame.Workflow.Definition
{
    /// <summary>
    /// 简单对象创建类工厂
    /// </summary>
    public sealed class ObejectFactory
    {
        private static ILog log = LogManager.GetLogger(typeof(ObejectFactory));

        /// <summary>
        /// 创建Activity对象
        /// </summary>
        /// <param name="parent"></param>
        /// <param name="xElem"></param>
        /// <returns></returns>
        public static Activity CreateActivity(IConfigureElement parent, XElement xElem)
        {
            if (xElem == null) return null;

            string typeName = xElem.Attribute("typeName").Value;// +"Activity";
            if (!typeName.StartsWith("EAFrame.Workflow.Definition"))
                typeName = string.Format("EAFrame.Workflow.Definition.{0}", typeName);

            Activity activity = null;
            try
            {
                Type type = Type.GetType(typeName);
                activity = Activator.CreateInstance(type, new object[] { parent, xElem }) as Activity;
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }

            return activity;
        }

        /// 创建Activity对象
        /// </summary>
        /// <param name="parent"></param>
        /// <param name="typeName"></param>
        /// <returns></returns>
        public static Activity CreateActivity(IConfigureElement parent, string typeName)
        {
            if (parent == null) return null;

            string activityName = typeName;
            if (!activityName.StartsWith("EAFrame.Workflow.Definition"))
                activityName = string.Format("EAFrame.Workflow.Definition.{0}", activityName);

            Activity activity = null;
            try
            {
                Type type = Type.GetType(activityName);
                activity = Activator.CreateInstance(type, new object[] { parent, null }) as Activity;
                activity.ActivityType = typeName;
                activity.Name = RemarkAttribute.GetTypeRemark(type);
                activity.Id = Guid.NewGuid().ToSafeString();
                ((WorkflowDefine)parent).Activities.SafeAdd(activity);
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }

            return activity;
        }
    }
}
