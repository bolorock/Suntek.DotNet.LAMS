#region Description
/*==============================================================================
 *  Copyright (c) suntektech co.,ltd. All Rights Reserved.
 * ===============================================================================
 * 描述：报表模型字段配置类
 * 作者：trh
 * 创建时间：2010-06-10
 * ===============================================================================
 * 历史记录：
 * 描述：
 * 作者：
 * 修改时间：
 * ==============================================================================*/
#endregion
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;

using EAFrame.Core.Extensions;
using EAFrame.Workflow.Enums;

namespace EAFrame.EForm
{
    /// <summary>
    /// 双文本框
    /// </summary>
    public class TextRangebox : FieldControl
    {
        #region Properties
        /// <summary>
        /// 日期格式
        /// </summary>
        public string Format
        {
            get
            {
                return Attibutes.GetSafeValue<string>("format");
            }
            set
            {
                Attibutes.SafeAdd("format", value);
            }
        }

        /// <summary>
        /// 开始值
        /// </summary>
        public string StartValue
        {
            get
            {
                return Attibutes.GetSafeValue<string>("startValue");
            }
            set
            {
                Attibutes.SafeAdd("startValue", value);
            }
        }

        /// <summary>
        /// 结束值
        /// </summary>
        public string EndValue
        {
            get
            {
                return Attibutes.GetSafeValue<string>("endValue");
            }
            set
            {
                Attibutes.SafeAdd("endValue", value);
            }
        }

        #endregion

        #region Construtor
        /// <summary>
        /// 构造函数
        /// </summary>
        public TextRangebox()
        { ControlType = ControlType.TextRangebox; }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public TextRangebox(IXmlElement parent, XElement xElem)
            : base(parent, xElem)
        { ControlType = ControlType.TextRangebox; }

        #endregion

        #region Methods

        /// <summary>
        /// 返回查询条件
        /// </summary>
        /// <param name="filterValues"></param>
        public override KeyValuePair<string, IDictionary<string, object>> GetFilterCondition(IDictionary<string, object> filterValues)
        {
            string startValue = Field.Name + "StartValue";
            string endValue = Field.Name + "EndValue";

            IDictionary<string, object> parameters = new Dictionary<string, object>();
            if (HasValue(filterValues,startValue) && HasValue(filterValues,endValue))
            {
                parameters.Add(NewParameter(startValue, filterValues));
                parameters.Add(NewParameter(endValue, filterValues));

                return new KeyValuePair<string, IDictionary<string, object>>(string.Format(" And ({0}>={1}{0}StartValue And {0}<={1}{0}EndValue) ", Field.Name, ParamChar), parameters);
            }
            else if (HasValue(filterValues,startValue))
            {
                parameters.Add(NewParameter(startValue, filterValues));

                return new KeyValuePair<string, IDictionary<string, object>>(string.Format(" And {0}>={1}{0}StartValue ", Field.Name, ParamChar), parameters);
            }
            else if (HasValue(filterValues,endValue))
            {
                parameters.Add(NewParameter(endValue, filterValues));

                return new KeyValuePair<string, IDictionary<string, object>>(string.Format(" And {0}<={1}{0}EndValue ", Field.Name, ParamChar), parameters);
            }

            return new KeyValuePair<string, IDictionary<string, object>>();
        }

        /// <summary>
        /// 转换为Html
        /// </summary>
        /// <returns></returns>
        public override string ToHtml(IDictionary<string, object> values)
        {
            StringBuilder html = new StringBuilder();
            html.AppendFormat("<input name=\"{0}StartValue\" type=\"text\" id=\"{0}StartValue\" class=\"report_range_textbox\" isRequired=\"{1}\" {2} />", Field.Name, Field.Required, NumberValidateCode);
            html.Append("&nbsp;到&nbsp;");
            html.AppendFormat("<input name=\"{0}EndValue\" type=\"text\" id=\"{0}EndValue\" class=\"report_range_textbox\" isRequired=\"{1}\" {2} />", Field.Name, Field.Required, NumberValidateCode);

            return html.ToString();
        }
        #endregion
    }
}
