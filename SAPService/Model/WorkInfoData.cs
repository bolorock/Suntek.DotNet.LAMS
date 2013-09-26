using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Serialization;

namespace Suntek.SAPService.Model
{
    [Serializable, XmlType("IT_WORK_INFOR")]
    public class ZSTR_WORK_INFOR
    {
        [XmlElement(ElementName = "PERNR")]
        public PERNR pernr;

        [XmlElement(ElementName = "BEGDA")]
        public BEGDA begda;

        [XmlElement(ElementName = "ENDDA")]
        public ENDDA endda;

        [XmlElement(ElementName = "ZDW")]
        public ZDW zdw;

        [XmlElement(ElementName = "ZZW")]
        public ZZW zzw;
    }
}
