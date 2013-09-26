using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Serialization;

namespace Suntek.SAPService.Model
{
    [Serializable, XmlType("ZSTR_BASIC_INFOR")]
    public class ZSTR_BASIC_INFOR
    {
        [XmlElement(ElementName = "PERNR")]
        public PERNR pernr;

        [XmlElement(ElementName = "ENAME")]
        public ENAME ename;

        [XmlElement(ElementName = "GESCH")]
        public GESCH gesch;

        [XmlElement(ElementName = "ZJG")]
        public ZJG zjg;

        [XmlElement(ElementName = "GBORT")]
        public GBORT gbort;

        [XmlElement(ElementName = "GBDAT")]
        public GBDAT gbdat;

        [XmlElement(ElementName = "ICNUM")]
        public ICNUM icnum;

        [XmlElement(ElementName = "RACKY")]
        public RACKY racky;

        [XmlElement(ElementName = "PCODE")]
        public PCODE pcode;

        /// <summary>
        /// 入党时间
        /// </summary>
        [XmlElement(ElementName="BEGDA")]
        public BEGDA begda;

        /// <summary>
        /// 健康状况
        /// </summary>
        [XmlElement(ElementName = "ZHEALTH1")]
        public ZHEALTH1 Zhealth1;

        /// <summary>
        /// 特长爱好
        /// </summary>
        [XmlElement(ElementName = "ZFAVOR")]
        public ZFAVOR Zfavor;

    }

    [Serializable, XmlType("PERNR")]
    public class PERNR
    {
        private string _pernr_value = "";

        [XmlText]
        public string Pernr_value
        {
            get
            {
                return this._pernr_value;
            }
            set
            {
                this._pernr_value = value;
            }
        }
    }

    [Serializable, XmlType("ENAME")]
    public class ENAME
    {
        private string _ename_value = "";

        [XmlText]
        public string Ename_value
        {
            get
            {
                return this._ename_value;
            }
            set
            {
                this._ename_value = value;
            }
        }
    }

    [Serializable, XmlType("GESCH")]
    public class GESCH
    {
        private string _gesch_value = "";

        [XmlText]
        public string Gesch_value
        {
            get
            {
                return this._gesch_value;
            }
            set
            {
                this._gesch_value = value;
            }
        }
    }

    [Serializable, XmlType("ZJG")]
    public class ZJG
    {
        private string _zjg_value = "";

        [XmlText]
        public string Zjg_value
        {
            get
            {
                return this._zjg_value;
            }
            set
            {
                this._zjg_value = value;
            }
        }
    }

    [Serializable, XmlType("GBORT")]
    public class GBORT
    {
        private string _gbort_value = "";

        [XmlText]
        public string Gbort_value
        {
            get
            {
                return this._gbort_value;
            }
            set
            {
                this._gbort_value = value;
            }
        }
    }

    [Serializable, XmlType("GBDAT")]
    public class GBDAT
    {
        private string _gbdat_value = "";

        [XmlText]
        public string Gbdat_value
        {
            get
            {
                return this._gbdat_value;
            }
            set
            {
                this._gbdat_value = value;
            }
        }
    }

    [Serializable, XmlType("ICNUM")]
    public class ICNUM
    {
        private string _icnum_value = "";

        [XmlText]
        public string Icnum_value
        {
            get
            {
                return this._icnum_value;
            }
            set
            {
                this._icnum_value = value;
            }
        }
    }

    [Serializable, XmlType("RACKY")]
    public class RACKY
    {
        private string _racky_value = "";

        [XmlText]
        public string Racky_value
        {
            get
            {
                return this._racky_value;
            }
            set
            {
                this._racky_value = value;
            }
        }
    }

    [Serializable, XmlType("PCODE")]
    public class PCODE
    {
        private string _pcode_value = "";

        [XmlText]
        public string Pcode_value
        {
            get
            {
                return this._pcode_value;
            }
            set
            {
                this._pcode_value = value;
            }
        }
    }

    [Serializable, XmlType("ZHEALTH1")]
    public class ZHEALTH1
    {
        private string _zhealth1_value = "";

        [XmlText]
        public string Zhealth1_value
        {
            get
            {
                return this._zhealth1_value;
            }
            set
            {
                this._zhealth1_value = value;
            }
        }
    }

    [Serializable, XmlType("ZFAVOR")]
    public class ZFAVOR
    {
        private string _zfavor_value = "";

        [XmlText]
        public string Zfavor_value
        {
            get
            {
                return this._zfavor_value;
            }
            set
            {
                this._zfavor_value = value;
            }
        }
    }

}
