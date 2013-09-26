using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Serialization;

namespace Suntek.SAPService.Model
{
    [Serializable, XmlType("IT_JOB_INFOR")]
    public class ZSTR_JOB_INFOR
    {
        [XmlElement(ElementName = "PERNR")]
        public PERNR pernr;

        [XmlElement(ElementName = "ZYJSZWZLDM")]
        public ZYJSZWZLDM zyjszwzldm;

        [XmlElement(ElementName = "ZYJSZWDM")]
        public ZYJSZWDM zyjszwdm;

        [XmlElement(ElementName = "ZYJSZWDJDM")]
        public ZYJSZWDJDM zyjszwdjdm;

        [XmlElement(ElementName="ZYJSZWMC")]
        public ZYJSZWMC zyjszwmc;
    }

    [Serializable, XmlType("ZYJSZWZLDM")]
    public class ZYJSZWZLDM
    {
        private string _zyjszwzldm_value = "";

        [XmlText]
        public string Zyjszwzldm_value
        {
            get
            {
                return this._zyjszwzldm_value;
            }
            set
            {
                this._zyjszwzldm_value = value;
            }
        }
    }

    [Serializable, XmlType("ZYJSZWDM")]
    public class ZYJSZWDM
    {
        private string _zyjszwdm_value = "";

        [XmlText]
        public string Zyjszwdm_value
        {
            get
            {
                return this._zyjszwdm_value;
            }
            set
            {
                this._zyjszwdm_value = value;
            }
        }
    }

    [Serializable, XmlType("ZYJSZWDJDM")]
    public class ZYJSZWDJDM
    {
        private string _zyjszwdjdm_value = "";

        [XmlText]
        public string Zyjszwdjdm_value
        {
            get
            {
                return this._zyjszwdjdm_value;
            }
            set
            {
                this._zyjszwdjdm_value = value;
            }
        }
    }

    [Serializable,XmlType("ZYJSZWMC")]
    public class ZYJSZWMC
    {
        private string _zyjszwmc_value = "";

        [XmlText]
        public string Zyjszwmc_value
        {
            get
            {
                return this._zyjszwmc_value;
            }
            set
            {
                this._zyjszwmc_value = value;
            }
        }
    }
}
