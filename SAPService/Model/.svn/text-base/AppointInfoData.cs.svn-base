using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace Suntek.SAPService.Model
{
    public class ZSTR_APPOINT_INFOR
    {
        /// <summary>
        /// 起始时间
        /// </summary>
        [XmlElement(ElementName = "BEGDA")]
        public BEGDA begda;

        /// <summary>
        /// 结束时间
        /// </summary>
        [XmlElement(ElementName="ENDDA")]
        public ENDDA endda;

        /// <summary>
        /// 职位名称
        /// </summary>
        [XmlElement(ElementName = "JOBDS")]
        public JOBDS jobds;

        /// <summary>
        /// 批准文号
        /// </summary>
        [XmlElement(ElementName="APPRU")]
        public APPRU appru;

        /// <summary>
        /// 职务类型
        /// </summary>
        [XmlElement(ElementName="JOBTY")]
        public JOBTY jobty;

        [Serializable, XmlType("JOBDS")]
        public class JOBDS
        {
            private string _jobds_value;

            [XmlText]
            public string Jobds_value
            {
                get
                {
                    return this._jobds_value;
                }
                set
                {
                    this._jobds_value = value;
                }
            }
        }

        [Serializable,XmlType("APPRU")]
        public class APPRU
        {
            private string _appru_value;

            [XmlText]
            public string _Appru_value
            {
                get
                {
                    return this._appru_value;
                }
                set
                {
                    this._appru_value = value;
                }
            }
        }

        [Serializable,XmlType("JOBTY")]
        public class JOBTY
        {
            private string _jobty;

            [XmlText]
            public string _Jobty_value
            {
                get
                {
                    return this._jobty;
                }
                set
                {
                    this._jobty = value;
                }
            }
        }
    }
}
