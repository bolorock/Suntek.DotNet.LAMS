using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

using log4net;
using EAFrame.Core.Extensions;

namespace EAFrame.Workflow.Definition
{
    /// <summary>
    /// 活动参与者
    /// </summary>
    public class Participant : ConfigureElement
    {
        #region Properties
        /// <summary>
        /// 参与者方式
        /// </summary>
        public string ParticipantType
        {
            get
            {
                return Properties.GetSafeValue<string>("participantType");
            }
            set
            {
                Properties.SafeAdd("participantType", value);
            }
        }

        /// <summary>
        /// 是否允许前驱活动根据如上参与者列表指派该活动的参与者
        /// </summary>
        public bool AllowAppointParticipants
        {
            get
            {
                return Properties.GetSafeValue<bool>("allowAppointParticipants");
            }
            set
            {
                Properties.SafeAdd("allowAppointParticipants", value);
            }
        }

        /// <summary>
        /// 参与者
        /// </summary>
        public List<Participantor> Participantors
        {
            get;
            set;
        }

        /// <summary>
        /// 从活动中获取
        /// </summary>
        public string SpecialActivityId
        {
            get
            {
                return Properties.GetSafeValue<string>("specialActivityId");
            }
            set
            {
                Properties.SafeAdd("specialActivityId", value);
            }
        }

        /// <summary>
        /// 从相关数据获取
        /// </summary>
        public string SpecialPath
        {
            get
            {
                return Properties.GetSafeValue<string>("specialPath");
            }
            set
            {
                Properties.SafeAdd("specialPath", value);
            }
        }

        #endregion

        #region Construtor
        public Participant()
        {
            ElementName = "participant";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public Participant(IConfigureElement parent, XElement xElem)
            : base(parent, "participant", xElem)
        {
            Participantors = xElem.Element("participantors").Elements().Select(e => new Participantor(this, e)).ToList();
        }

        #endregion

        #region Methods
        /// <summary>
        ///把对象转换为XElement元素
        /// </summary>
        /// <returns></returns>
        public override XElement ToXElement()
        {
            return new XElement(ElementName,
                               Properties.Select(p => new XElement(p.Key, p.Value)),
                               new XElement("participantors",
                                   Participantors.Select(p => p.ToXElement()))
                              );
        }
        #endregion
    }
}
