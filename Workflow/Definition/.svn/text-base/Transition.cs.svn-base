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
    /// 活动迁移定义类
    /// </summary>
    public class Transition : ConfigureElement
    {
        #region Properties 成员
        /// <summary>
        /// 连接Id
        /// </summary>
        public string Id
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
        ///连接显示名称
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
        ///显示皮肤
        /// </summary>
        public string Skin
        {
            get
            {
                return Properties.GetSafeValue<string>("skin");
            }
            set
            {
                Properties.SafeAdd("skin", value);
            }
        }

        /// <summary>
        /// 是否是默认连接
        /// </summary>
        public bool IsDefault
        {
            get
            {
                return Properties.GetSafeValue<bool>("isDefault");
            }
            set
            {
                Properties.SafeAdd("isDefault", value);
            }
        }

        /// <summary>
        /// 连接开始结点位置
        /// </summary>
        public string SourceOrientation
        {
            get;
            set;
        }

        public Point3D SourcePoint
        {
            get;
            set;
        }

        /// <summary>
        /// 连接结束结点位置
        /// </summary>
        public string SinkOrientation
        {
            get;
            set;
        }

        public Point3D SinkPoint
        {
            get;
            set;
        }

        /// <summary>
        /// 连接开始结点
        /// </summary>
        public Activity FromActivity
        {
            get;
            set;
        }

        /// <summary>
        /// 连接结束结点Id
        /// </summary>
        public Activity ToActivity
        {
            get;
            set;
        }

        /// <summary>
        /// 表达式类型
        /// </summary>
        public string ExpressionType
        {
            get
            {
                return Properties.GetSafeValue<string>("expressionType");
            }
            set
            {
                Properties.SafeAdd("expressionType", value);
            }
        }

        /// <summary>
        /// 复杂表达式值
        /// </summary>
        public string Expression
        {
            get
            {
                return Properties.GetSafeValue<string>("expression");
            }
            set
            {
                Properties.SafeAdd("expression", value);
            }
        }

        /// <summary>
        /// 优先级
        /// </summary>
        public string Priority
        {
            get
            {
                return Properties.GetSafeValue<string>("priority");
            }
            set
            {
                Properties.SafeAdd("priority", value);
            }
        }

        /// <summary>
        /// 描述
        /// </summary>
        public string Description
        {
            get
            {
                return Properties.GetSafeValue<string>("description");
            }
            set
            {
                Properties.SafeAdd("description", value);
            }
        }
        #endregion

        #region Construtor
        public Transition()
        {
            ElementName = "transition";
            Properties = new Dictionary<string, object>();
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public Transition(IConfigureElement parent, XElement xElem)
            : base(parent, "transition", xElem)
        {
            XElement sourceElem = xElem.Element("source");
            XElement sinkElem = xElem.Element("sink");

            SourceOrientation = sourceElem.ChildElementValue("orientation");
            SinkOrientation = sinkElem.ChildElementValue("orientation");
            SourcePoint = new Point3D() { X = sourceElem.ChildElementValue("x").ToDouble(), Y = sourceElem.ChildElementValue("y").ToDouble() };
            SinkPoint = new Point3D() { X = sinkElem.ChildElementValue("x").ToDouble(), Y = sinkElem.ChildElementValue("y").ToDouble() };

            WorkflowDefine wd = parent as WorkflowDefine;
            FromActivity = wd.Activities.FirstOrDefault(o => o != null && o.Id == sourceElem.ChildElementValue("activityId"));
            ToActivity = wd.Activities.FirstOrDefault(o => o != null && o.Id == sinkElem.ChildElementValue("activityId"));
        }

        #endregion

        #region Methods
        /// <summary>
        ///把对象转换为XElement元素
        /// </summary>
        /// <returns></returns>
        public override XElement ToXElement()
        {
            return new XElement(ElementName, Properties.Select(o => new XElement(o.Key, o.Value)),
                                new XElement("source", new XElement("orientation", SourceOrientation),
                                                       new XElement("x", SourcePoint.X), new XElement("y", SourcePoint.Y),
                                                       new XElement("activityId", FromActivity == null ? string.Empty : FromActivity.Id)),
                                new XElement("sink", new XElement("orientation", SinkOrientation),
                                                       new XElement("x", SinkPoint.X), new XElement("y", SinkPoint.Y),
                                                        new XElement("activityId", ToActivity == null ? string.Empty : ToActivity.Id))
                                );
        }

        #endregion

        public override int GetHashCode()
        {
            return string.Format("{0}.{1}", Id, Id).GetHashCode();
        }

        public override bool Equals(object obj)
        {
            if (obj == null) return false;

            if (obj.GetType() != this.GetType()) return false;

            Transition tmp = (Transition)obj;

            return Id == tmp.Id;
        }
    }

    public struct Point3D
    {
        public double X
        { get; set; }

        public double Y
        { get; set; }

        public double Z
        { get; set; }
    }
}
