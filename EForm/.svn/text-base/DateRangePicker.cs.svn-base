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
    public class DateRangePicker : FieldControl
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
        /// 开始日期
        /// </summary>
        public DateTime StartDate
        {
            get
            {
                return Attibutes.GetSafeValue<DateTime>("startDate");
            }
            set
            {
                Attibutes.SafeAdd("startDate", value);
            }
        }

        /// <summary>
        /// 开始日期
        /// </summary>
        public DateTime EndDate
        {
            get
            {
                return Attibutes.GetSafeValue<DateTime>("endDate");
            }
            set
            {
                Attibutes.SafeAdd("endDate", value);
            }
        }

        #endregion

        #region Construtor
        /// <summary>
        /// 构造函数
        /// </summary>
        public DateRangePicker()
        { ControlType = ControlType.DateRangePicker; }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public DateRangePicker(IXmlElement parent, XElement xElem)
            : base(parent, xElem)
        { ControlType = ControlType.DateRangePicker; }

        #endregion

        #region Methods

        /// <summary>
        /// 返回查询条件
        /// </summary>
        /// <param name="filterValues"></param>
        public override KeyValuePair<string, IDictionary<string, object>> GetFilterCondition(IDictionary<string, object> filterValues)
        {
            string startValue = "start" + Field.Name;
            string endValue = "end" + Field.Name;

            IDictionary<string, object> parameters = new Dictionary<string, object>();
            if (HasValue(filterValues, startValue) && HasValue(filterValues, endValue))
            {
                parameters.Add(NewParameter(startValue, filterValues));
                parameters.Add(NewParameter(endValue, filterValues));

                return new KeyValuePair<string, IDictionary<string, object>>(string.Format(" And ({0}>={3}{1} And {0}<={3}{2}) ", Field.Name, startValue, endValue, ParamChar), parameters);
            }
            else if (HasValue(filterValues, startValue))
            {
                parameters.Add(NewParameter(startValue, filterValues));

                return new KeyValuePair<string, IDictionary<string, object>>(string.Format(" And {0}>={2}{1} ", Field.Name, startValue, ParamChar), parameters);
            }
            else if (HasValue(filterValues, endValue))
            {
                parameters.Add(NewParameter(endValue, filterValues));

                return new KeyValuePair<string, IDictionary<string, object>>(string.Format(" And {0}<={2}{1} ", Field.Name, endValue, ParamChar), parameters);
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
            html.AppendFormat("<input name=\"start{0}\" type=\"text\" id=\"start{0}\" class=\"report_range_datepicker\" onfocus=\"WdatePicker({{dateFmt:'{2}'}})\" isRequired=\"{1}\"  />", Field.Name, Field.Required, this.Format);
            html.Append("&nbsp;到&nbsp;");
            html.AppendFormat("<input name=\"end{0}\" type=\"text\" id=\"end{0}\" class=\"report_range_datepicker\" onfocus=\"WdatePicker({{dateFmt:'{2}'}})\" isRequired=\"{1}\" />", Field.Name, Field.Required, this.Format);
            return html.ToString();
        }
        #endregion
    }
}
