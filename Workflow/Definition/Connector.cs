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
    /// 活动连接类
    /// </summary>
    public class Connector : ConfigureElement
    {
        #region Properties 成员
        /// <summary>
        /// 连接Id
        /// </summary>
        public string Id
        {
            get
            {
                return Attibutes.GetSafeValue<string>("id");
            }
            set
            {
                Attibutes.SafeAdd("id", value);
            }
        }

        ///// <summary>
        ///// 连接开始结点Id
        ///// </summary>
        //public string From
        //{
        //    get;
        //    set;
        //}

        ///// <summary>
        ///// 连接结束结点Id
        ///// </summary>
        //public string To
        //{
        //    get;
        //    set;
        //}

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
        /// 连接类型
        /// </summary>
        public string Type
        {
            get
            {
                return Attibutes.GetSafeValue<string>("type");
            }
            set
            {
                Attibutes.SafeAdd("type", value);
            }
        }

        public string Style
        {
            get
            {
                return Attibutes.GetSafeValue<string>("style");
            }
            set
            {
                Attibutes.SafeAdd("style", value);
            }
        }

        public string Description
        {
            get
            {
                return Attibutes.GetSafeValue<string>("description");
            }
            set
            {
                Attibutes.SafeAdd("description", value);
            }
        }

        /// <summary>
        ///连接显示名称
        /// </summary>
        public string Text
        {
            get
            {
                return Attibutes.GetSafeValue<string>("text");
            }
            set
            {
                Attibutes.SafeAdd("text", value);
            }
        }

        /// <summary>
        ///活动显示皮肤
        /// </summary>
        public string Skin
        {
            get
            {
                return Attibutes.GetSafeValue<string>("skin");
            }
            set
            {
                Attibutes.SafeAdd("skin", value);
            }
        }

        /// <summary>
        /// 工作流属性
        /// </summary>
        public Dictionary<string, object> Properties
        {
            get;
            set;
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
        /// 是否简单表达式，如不是简单表达式则是复杂表达式
        /// </summary>
        public bool IsSimpleExpression
        {
            get
            {
                return Properties.GetSafeValue<bool>("isSimpleExpression");
            }
            set
            {
                Properties.SafeAdd("isSimpleExpression", value);
            }
        }

        /// <summary>
        ///连接右值
        /// </summary>
        public string RightValue
        {
            get
            {
                return Properties.GetSafeValue<string>("rightValue");
            }
            set
            {
                Properties.SafeAdd("rightValue", value);
            }
        }

        /// <summary>
        /// 复杂表达式值
        /// </summary>
        public string ComplexExpressionValue
        {
            get
            {
                return Properties.GetSafeValue<string>("complexExpressionValue");
            }
            set
            {
                Properties.SafeAdd("complexExpressionValue", value);
            }
        }

        /// <summary>
        /// 连接右值类型
        /// </summary>
        public string RightValueType
        {
            get
            {
                return Properties.GetSafeValue<string>("rightValueType");
            }
            set
            {
                Properties.SafeAdd("rightValueType", value);
            }
        }

        /// <summary>
        /// 连接左值
        /// </summary>
        public string LeftValue
        {
            get
            {
                return Properties.GetSafeValue<string>("leftValue");
            }
            set
            {
                Properties.SafeAdd("leftValue", value);
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
        /// 比较类型
        /// </summary>
        public string CompType
        {
            get
            {
                return Properties.GetSafeValue<string>("compType");
            }
            set
            {
                Properties.SafeAdd("compType", value);
            }
        }

        #endregion

        #region Construtor
        public Connector()
        {
            ElementName = "connector";

            Properties = new Dictionary<string, object>();
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public Connector(IConfigureElement parent, XElement xElem)
            : base(parent, "connector", xElem)
        {
            if (xElem == null)
            {
                Properties = new Dictionary<string, object>();
                return;
            }

            string from = xElem.ChildElementValue("from");
            string to = xElem.ChildElementValue("to");

            WorkflowDefine wf = parent as WorkflowDefine;

            if (wf == null) throw new Exception("parent 对象为空！");

            FromActivity = wf.Activities.FirstOrDefault(o => o != null && o.Id == from);
            ToActivity = wf.Activities.FirstOrDefault(o => o != null && o.Id == to);

            Properties = InitProperties(xElem);
        }

        #endregion

        #region Methods
        /// <summary>
        ///把对象转换为XElement元素
        /// </summary>
        /// <returns></returns>
        public override XElement ToXElement()
        {
            return new XElement(ElementName, Attibutes.Select(o => new XAttribute(o.Key, o.Value)),
                                new XElement("from", FromActivity == null ? string.Empty : FromActivity.Id),
                                new XElement("to", FromActivity == null ? string.Empty : ToActivity.Id),
                                new XElement("properties",
                                Properties.Select(p => new XElement("property", new XAttribute("name", p.Key), new XAttribute("value", p.Value))))
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

            Connector tmp = (Connector)obj;

            return Id == tmp.Id;
        }

    }
}
