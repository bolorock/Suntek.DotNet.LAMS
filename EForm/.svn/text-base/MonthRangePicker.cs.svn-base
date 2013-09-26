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
using System.Data.SqlClient;
using System.Xml.Linq;

using EAFrame.Core.Extensions;
using EAFrame.Workflow.Enums;
using EAFrame.Workflow.Definition;

namespace EAFrame.EForm
{
    public class MonthRangePicker : FieldControl
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
        /// 默认开始值
        /// </summary>
        public string DefaultStartValue
        {
            get
            {
                return Attibutes.GetSafeValue<string>("defaultStartValue");
            }
            set
            {
                Attibutes.SafeAdd("defaultStartValue", value);
            }
        }

        /// <summary>
        /// 默认结束值
        /// </summary>
        public string DefaultEndValue
        {
            get
            {
                return Attibutes.GetSafeValue<string>("defaultEndValue");
            }
            set
            {
                Attibutes.SafeAdd("defaultEndValue", value);
            }
        }

        #endregion

        #region Construtor
        /// <summary>
        /// 构造函数
        /// </summary>
        public MonthRangePicker()
        { ControlType = ControlType.MonthRangePicker; }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="xml">字符串参数</param>
        /// <param name="isXmlFile">是否是xml文件</param>
        public MonthRangePicker(IXmlElement parent, XElement xElem)
            : base(parent, xElem)
        { ControlType = ControlType.MonthRangePicker; }

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
                parameters.Add(NewCustomParameter(startValue, filterValues));
                parameters.Add(NewCustomParameter(endValue, filterValues));

                return new KeyValuePair<string, IDictionary<string, object>>(string.Format(" And ({0}>={3}{1} And {0}<={3}{2}) ", Field.Name, startValue, endValue, ParamChar), parameters);
            }
            else if (HasValue(filterValues, startValue))
            {
                parameters.Add(NewCustomParameter(startValue, filterValues));

                return new KeyValuePair<string, IDictionary<string, object>>(string.Format(" And {0}>={2}{1} ", Field.Name, startValue, ParamChar), parameters);
            }
            else if (HasValue(filterValues, endValue))
            {
                parameters.Add(NewCustomParameter(endValue, filterValues));

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
            html.AppendFormat("<input name=\"start{0}\" type=\"text\" id=\"start{0}\" class=\"report_range_datepicker\" onfocus=\"WdatePicker({{dateFmt:'yyyy年MM月',minDate:'{1}-1',maxDate:'{2}-{3}'}})\" isRequired=\"{4}\" />", Field.Name, DateTime.Now.Year - 1, DateTime.Now.Year, DateTime.Now.Month, Field.Required);
            html.Append("&nbsp;到&nbsp;");
            html.AppendFormat("<input name=\"end{0}\" type=\"text\" id=\"end{0}\" class=\"report_range_datepicker\" onfocus=\"WdatePicker({{dateFmt:'yyyy年MM月',minDate:'{1}-1',maxDate:'{2}-{3}'}})\" isRequired=\"{4}\" />", Field.Name, DateTime.Now.Year - 1, DateTime.Now.Year, DateTime.Now.Month, Field.Required);

            return html.ToString();
        }
        #endregion
    }
}
