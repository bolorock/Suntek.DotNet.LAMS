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
    /// 参与者信息
    /// </summary>
    public class Participantor : ConfigureElement
    {
        #region Properties 成员

        /// <summary>
        /// 编号
        /// </summary>
        public string ID
        {
            get
            {
                return Properties.GetSafeValue<string>("id");
            }
            set
            {
                Properties.SafeAdd("id", value);
            }
        }


        /// <summary>
        /// 参与者名称
        /// </summary>
        public string Name
        {
            get
            {
                return Properties.GetSafeValue<string>("name");
            }
            set
            {
                Properties.SafeAdd("name", value);
            }
        }

        /// <summary>
        /// 参与者类别:person,role,org三类
        /// </summary>
        public string ParticipantorType
        {
            get
            {
                return Properties.GetSafeValue<string>("participantorType");
            }
            set
            {
                Properties.SafeAdd("participantorType", value);
            }
        }

        /// <summary>
        /// 参与者值
        /// </summary>
        public string Value
        {
            get
            {
                return Properties.GetSafeValue<string>("value");
            }
            set
            {
                Properties.SafeAdd("value", value);
            }
        }

        /// <summary>
        /// 序号
        /// </summary>
        public string SortOrder
        {
            get
            {
                return Properties.GetSafeValue<string>("sortOrder");
            }
            set
            {
                Properties.SafeAdd("sortOrder", value);
            }
        }

        #endregion

        #region Construtor
        public Participantor()
        {
            ElementName = "participantor";
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public Participantor(IConfigureElement parent, XElement xElem)
            : base(parent, "participantor", xElem)
        { }

        #endregion
    }
}
