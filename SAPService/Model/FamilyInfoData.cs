using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace Suntek.SAPService.Model
{
    [Serializable, XmlType("IT_FAMILY_INFOR")]
    public class ZSTR_FAMILY_INFOR
    {
        [XmlElement(ElementName = "PERNR")]
        public PERNR pernr;

        [XmlElement(ElementName = "FAMSA")]
        public FAMSA famsa;

        [XmlElement(ElementName = "FCNAM")]
        public FCNAM cnam;

        [XmlElement(ElementName = "FASEX")]
        public FASEX fasex;

        [XmlElement(ElementName = "FGBDT")]
        public FGBDT fgbdt;

        [XmlElement(ElementName = "ZDW")]
        public ZDW zdw;

        [XmlElement(ElementName = "ZZW")]
        public ZZW zzw;

        [XmlElement(ElementName = "ZDW_ZZW")]
        public ZDW_ZZW zdw_zzw;
    }

    [Serializable, XmlType("FAMSA")]
    public class FAMSA
    {
        private string _famsa_value = "";

        [XmlText]
        public string Famsa_value
        {
            get
            {
                return this._famsa_value;
            }
            set
            {
                this._famsa_value = value;
            }
        }
    }

    [Serializable, XmlType("FCNAM")]
    public class FCNAM
    {
        private string _fcnam_value = "";

        [XmlText]
        public string Fcnam_value
        {
            get
            {
                return this._fcnam_value;
            }
            set
            {
                this._fcnam_value = value;
            }
        }
    }

    [Serializable, XmlType("FASEX")]
    public class FASEX
    {
        private string _fasex_value = "";

        [XmlText]
        public string Fasex_value
        {
            get
            {
                return this._fasex_value;
            }
            set
            {
                this._fasex_value = value;
            }
        }
    }

    [Serializable, XmlType("FGBDT")]
    public class FGBDT
    {
        private string _fgbdt_value = "";

        [XmlText]
        public string fgbdt_value
        {
            get
            {
                return this._fgbdt_value;
            }
            set
            {
                this._fgbdt_value = value;
            }
        }
    }

    [Serializable, XmlType("ZDW")]
    public class ZDW
    {
        private string _zdw_value = "";

        [XmlText]
        public string Zdw_value
        {
            get
            {
                return this._zdw_value;
            }
            set
            {
                this._zdw_value = value;
            }
        }
    }

    [Serializable, XmlType("ZZW")]
    public class ZZW
    {
        private string _zzw_value = "";

        [XmlText]
        public string Zzw_value
        {
            get
            {
                return this._zzw_value;
            }
            set
            {
                this._zzw_value = value;
            }
        }
    }

    [Serializable, XmlType("ZDW_ZZW")]
    public class ZDW_ZZW
    {
        private string _zdw_zzw_value = "";

        [XmlText]
        public string Zdw_zzw_value
        {
            get
            {
                return this._zdw_zzw_value;
            }
            set
            {
                this._zdw_zzw_value = value;
            }
        }
    }
}
