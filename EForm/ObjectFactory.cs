#region Description
/*==============================================================================
 *  Copyright (c) suntektech co.,ltd. All Rights Reserved.
 * ===============================================================================
 * 描述：对象工厂类
 * 作者：trh
 * 创建时间：2010-06-10
 * ===============================================================================
 * 历史记录：
 * 描述：
 * 作者：
 * 修改时间：
 * ==============================================================================*/
#endregion
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.Configuration;

using log4net;
using EAFrame.EForm;
using EAFrame.Core.Extensions;
using EAFrame.Workflow.Definition;

namespace EAFrame.EForm
{
    /// <summary>
    /// 对象工厂类
    /// </summary>
    public static class ObjectFactory
    {
        private static ILog log = LogManager.GetLogger(typeof(ObjectFactory));

        public static FieldControl CreateControl(IXmlElement parent, XElement xElem)
        {
            if (xElem == null)
            {
                log.Debug("xElem is null! parent=" + parent.ToXml());
                return null;
            }

            string typeName = xElem.Attribute("type").Value;
            if (!typeName.StartsWith("EAFrame.EForm"))
                typeName = string.Format("EAFrame.EForm.{0}", typeName);

            FieldControl control = null;
            try
            {
                control = Activator.CreateInstance(Type.GetType(typeName), new object[] { parent, xElem }) as FieldControl;
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }

            return control;
        }

        public static FieldControl CreateControl(FormField field)
        {
            string typeName = string.Format("EAFrame.EForm.{0}", field.ControlType);

            FieldControl control = null;
            try
            {
                control = Activator.CreateInstance(Type.GetType(typeName), new object[] { field }) as FieldControl;
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }

            return control;
        }
    }
}
