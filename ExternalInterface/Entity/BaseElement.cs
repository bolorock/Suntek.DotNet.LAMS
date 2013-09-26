using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.IO;
using EAFrame.Core.Domain;
using EAFrame.Core.Extensions;
using log4net;

namespace SunTek.EAFrame.ExternalInterface.Entity
{
    [Serializable]
    public abstract class BaseElement
    {
        [NonSerialized]
        protected ILog log = LogManager.GetLogger(typeof(BaseElement));

        #region Methods
        /// <summary>
        /// 把对象转换为XElement元素
        /// </summary>
        /// <returns></returns>
        public abstract XElement ToXElement();


        /// <summary>
        /// 转换为xml字符串
        /// </summary>
        /// <returns></returns>
        public virtual string ToXml()
        {
            try
            {
                return ToXElement().ToSafeString();
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }

            return string.Empty;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="elemName"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        public XElement NewXElement(string elemName, string value)
        {
            return string.IsNullOrEmpty(value) || string.IsNullOrEmpty(elemName) ? null : new XElement(elemName, new XCData(value));
        }
        #endregion
    }
}
