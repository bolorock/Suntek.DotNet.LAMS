using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Serialization;

namespace Suntek.SAPService.Model
{
    [Serializable, XmlType("ZRFC_ESS_GET_Response")]
    public class ZRFC_ESS_GET_Response
    {
        [XmlElement(ElementName = "Successful")]
        public Successful successful;

        [XmlElement(ElementName = "Message")]
        public Message message;

        [XmlElement(ElementName = "Source")]
        public Source source;

        [XmlElement(ElementName = "ZSTR_BASIC_INFOR")]
        public ZSTR_BASIC_INFOR base_info;

        [XmlElement(ElementName = "ZSTR_POSIT_INFOR")]
        public ZSTR_POSIT_INFOR posit_info;

        [XmlElement(ElementName = "IT_FAMILY_INFOR")]
        public ZSTR_FAMILY_INFOR[] family_info;

        [XmlElement(ElementName = "IT_DEGREE_INFOR")]
        public ZSTR_DEGREE_INFOR[] degree_info;

        [XmlElement(ElementName = "IT_JOB_INFOR")]
        public ZSTR_JOB_INFOR[] job_info;

        [XmlElement(ElementName = "IT_WORK_INFOR")]
        public ZSTR_WORK_INFOR[] work_info;

        /// <summary>
        /// 任免信息
        /// </summary>
        [XmlElement(ElementName = "IT_APPOINT_INFOR")]
        public ZSTR_APPOINT_INFOR[] appoint_info;

        /// <summary>
        /// 任现岗级时间信息
        /// </summary>
        [XmlElement(ElementName = "IT_STELL_INFOR")]
        public ZSTR_STELL_INFOR[] stell_info;
    }

    [Serializable, XmlType("Successful")]
    public class Successful
    {
        private string _successful_value = "";

        [XmlText]
        public string Successful_value
        {
            get
            {
                return this._successful_value;
            }
            set
            {
                this._successful_value = value;
            }
        }
    }

    [Serializable, XmlType("Message")]
    public class Message
    {
        private string _message_value = "";

        [XmlText]
        public string Message_value
        {
            get
            {
                return this._message_value;
            }
            set
            {
                this._message_value = value;
            }
        }
    }

    [Serializable, XmlType("Source")]
    public class Source
    {
        private string _source_value = "";

        [XmlText]
        public string Source_value
        {
            get
            {
                return this._source_value;
            }
            set
            {
                this._source_value = value;
            }
        }
    }
}
