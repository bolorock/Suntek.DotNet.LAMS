using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Text;
using System.Configuration;

using System.Xml.Linq;
using SunTek.Register.Domain;
using System.IO;
using EAFrame.Core.Utility;

namespace WebSite
{
    public class SystemUtil
    {

        #region 字段设置有关

        /// <summary>
        /// 初始化
        /// </summary>
        /// <param name="templatePath"></param>
        public static void SetFieldInit(string templatePath)
        {
            XElement xElem = XElement.Load(templatePath);
            XElement reg = xElem.Descendants("RegisterInfo").First();
            var i = 1;
            foreach (var item in reg.Elements())
            {
                if (item.Name.ToString().Equals("registerBaseInfo"))
                {
                    XElement elements = reg.Descendants("registerBaseInfo").First();
                    foreach (var element in elements.Elements())
                    {
                        AddAttributeValue(element, i);
                        i++;
                    }
                    continue;
                }
                AddAttributeValue(item, i);
                i++;
            }
            xElem.Save(templatePath);
        }

        /// <summary>
        /// 设置宽度
        /// </summary>
        /// <param name="templatePath"></param>
        /// <param name="dict"></param>
        public static void SetFieldWidth(string templatePath, IDictionary<int, int> dict)
        {
            XElement xElem = XElement.Load(templatePath);
            XElement reg = xElem.Descendants("RegisterInfo").First();
            foreach (var item in reg.Elements())
            {
                if (item.Name.ToString().Equals("registerBaseInfo"))
                {
                    XElement elements = reg.Descendants("registerBaseInfo").First();
                    foreach (var element in elements.Elements())
                    {
                        if (element.Attribute("IsShow").Value == "0") continue;
                        AddWidth(element, dict[Convert.ToInt32(element.Attribute("SortOrder").Value)]);
                    }
                    continue;
                }
                if (item.Attribute("IsShow").Value == "0") continue;
                AddWidth(item, dict[Convert.ToInt32(item.Attribute("SortOrder").Value)]);
            }
            xElem.Save(templatePath);
        }

        /// <summary>
        /// 获取xml模板里的字段中文显示
        /// </summary>
        /// <param name="templatePath"></param>
        /// <param name="tableName"></param>
        /// <returns></returns>
        public static IList<FieldSet> GetFieldList(string templatePath)
        {
            IDictionary<string, string> dict = new Dictionary<string, string>();

            XElement xElem = XElement.Load(templatePath);
            XElement reg = xElem.Descendants("RegisterInfo").First();
            IList<FieldSet> fieldSets = new List<FieldSet>();
            foreach (var item in reg.Elements())
            {
                if (item.Name.ToString().Equals("registerBaseInfo"))
                {
                    XElement elements = reg.Descendants("registerBaseInfo").First();
                    foreach (var element in elements.Elements())
                    {
                        fieldSets.Add(CreateFieldSet(element));
                    }
                    continue;
                }
                fieldSets.Add(CreateFieldSet(item));
            }
            return fieldSets;
        }

        /// <summary>
        /// 保存字段设置
        /// </summary>
        /// <param name="templatePath"></param>
        /// <param name="fields"></param>
        public static void SaveFieldSet(string templatePath, string[] fields)
        {
            //清空所有字段
            ClearFieldSet(templatePath);

            XElement xElem = XElement.Load(templatePath);
            XElement reg = xElem.Descendants("RegisterInfo").First();
            IEnumerable<XElement> xElements = reg.Elements();
            IDictionary<string, string> dic = new Dictionary<string, string>();
            for (int i = 0; i < fields.Length; i++)
            {
                dic.Clear();
                dic.Add("IsShow", "1");
                dic.Add("SortOrder", (i + 1).ToString());
                SetFieldAttribute(xElements, fields[i], dic);
            }
            xElem.Save(templatePath);
        }

        /// <summary>
        /// 删除单个或批量删除字段
        /// </summary>
        /// <param name="templatePath"></param>
        /// <param name="field">批量就以逗号隔开</param>
        public static void RemoveFieldSet(string templatePath, string field)
        {
            XElement xElem = XElement.Load(templatePath);
            XElement reg = xElem.Descendants("RegisterInfo").First();
            IEnumerable<XElement> xElements = reg.Elements();
            if (field.Contains(","))
            {
                string[] fields = field.Split(',');
                foreach (var item in fields)
                {
                    RemoveField(xElements, item);
                }
            }
            else
            {
                RemoveField(xElements, field);
            }
            xElem.Save(templatePath);
        }

        /// <summary>
        /// 清除所有字段
        /// </summary>
        /// <param name="templatePath"></param>
        public static void ClearFieldSet(string templatePath)
        {
            XElement xElem = XElement.Load(templatePath);
            XElement reg = xElem.Descendants("RegisterInfo").First();
            IEnumerable<XElement> xElements = reg.Elements().Where(p => p.Name != "registerBaseInfo");
            foreach (XElement xElement in xElements)
            {
                xElement.SetAttributeValue("IsShow", "0");
                xElement.SetAttributeValue("SortOrder", "-1");
            }
            IEnumerable<XElement> baseInfo = reg.Elements().Where(p => p.Name == "registerBaseInfo");
            if (baseInfo.Count()!=0)
            {
                foreach (XElement xElement in baseInfo.ToArray()[0].Elements())
                {
                    xElement.SetAttributeValue("IsShow", "0");
                    xElement.SetAttributeValue("SortOrder", "-1");
                }
            }

            xElem.Save(templatePath);
        }

        /// <summary>
        /// 修改单个字段的值
        /// </summary>
        /// <param name="templatePath"></param>
        /// <param name="fieldName"></param>
        /// <param name="attrValue"></param>
        public static void UpdateField(string templatePath, string fieldName, IDictionary<string, string> attrValue)
        {
            XElement xElem = XElement.Load(templatePath);
            XElement reg = xElem.Descendants("RegisterInfo").First();
            IEnumerable<XElement> xElements = reg.Elements();
            SetFieldAttribute(xElements, fieldName, attrValue);
            xElem.Save(templatePath);
        }


        /// <summary>
        /// 设置字段属性的值
        /// </summary>
        /// <param name="xElements"></param>
        /// <param name="fieldName"></param>
        /// <param name="attrValue"></param>
        public static void SetFieldAttribute(IEnumerable<XElement> xElements, string fieldName, IDictionary<string, string> attrValue)
        {
            XElement field = null;
            if (xElements.Where(p => p.Name == fieldName).Count() == 0)
            {
                XElement xele = xElements.Single(p => p.Name == "registerBaseInfo");
                if (xele.Elements().Where(p => p.Name == fieldName).Count() == 0) return;
                field = xele.Elements().Single(p => p.Name == fieldName);
            }
            else
            {
                field = xElements.Single(p => p.Name == fieldName);
            }
            foreach (var item in attrValue)
            {
                field.SetAttributeValue(item.Key, item.Value);
            }
        }

        private static void AddWidth(XElement item, int iWidth)
        {
            if (item.Attribute("Width") == null)
            {
                item.Add(new XAttribute("Width", iWidth));
            }
            else
            {
                item.SetAttributeValue("Width", iWidth);
            }
        }

        /// <summary>
        /// 增加属性
        /// </summary>
        /// <param name="item"></param>
        /// <param name="index"></param>
        private static void AddAttributeValue(XElement item, int index)
        {
            if (item.Attribute("IsShow") == null)
            {
                item.Add(new XAttribute("IsShow", "1"));
            }
            else
            {
                item.SetAttributeValue("IsShow", "1");
            }

            if (item.Attribute("SortOrder") == null)
            {
                item.Add(new XAttribute("SortOrder", index));
            }
            else
            {
                item.SetAttributeValue("SortOrder", index);
            }

            if (item.Attribute("Description") == null)
            {
                item.Add(new XAttribute("Description", item.Attribute("text").Value));
            }
            else
            {
                item.SetAttributeValue("Description", item.Attribute("text").Value);
            }
        }

        /// <summary>
        /// 删除单个字段
        /// </summary>
        /// <param name="xElements"></param>
        /// <param name="fieldName"></param>
        private static void RemoveField(IEnumerable<XElement> xElements, string fieldName)
        {
            XElement field = null;
            if (xElements.Where(p => p.Name == fieldName).Count() == 0)
            {
                XElement xele = xElements.Single(p => p.Name == "registerBaseInfo");
                if (xele.Elements().Where(p => p.Name == fieldName).Count() == 0) return;
                field = xele.Elements().Single(p => p.Name == fieldName);
            }
            else
            {
                field = xElements.Single(p => p.Name == fieldName);
            }

            field.SetAttributeValue("IsShow", "0");
            field.SetAttributeValue("SortOrder", "-1");
        }

        private static FieldSet CreateFieldSet(XElement item)
        {
            FieldSet fieldSet = new FieldSet();
            fieldSet.FieldCode = item.Name.ToString();
            fieldSet.FieldShow = item.Attribute("text").Value;
            fieldSet.SortOrder = Convert.ToInt32(item.Attribute("SortOrder").Value);
            fieldSet.IsShow = Convert.ToInt16(item.Attribute("IsShow").Value);
            fieldSet.Description = item.Attribute("Description").Value;
            fieldSet.Width = item.Attribute("Width") == null ? 0 : (int)item.Attribute("Width");
            return fieldSet;
        }

        #endregion

        /// <summary>
        /// 获取xml模板里的字段中文显示
        /// </summary>
        /// <param name="templatePath"></param>
        /// <param name="tableName"></param>
        /// <returns></returns>
        public static IDictionary<string, string> GetField(string templatePath, string tableName)
        {
            IDictionary<string, string> dict = new Dictionary<string, string>();

            XElement xElem = XElement.Load(templatePath);
            XElement reg = xElem.Descendants(tableName).First();
            foreach (var item in reg.Elements())
            {
                dict.Add(item.Name.ToString(), item.Attribute("text").Value);
            }
            return dict;
        }

        /// <summary>
        /// 获取字段以逗号隔开
        /// </summary>
        /// <param name="templatePath"></param>
        /// <param name="tableName"></param>
        /// <returns></returns>
        public static string GetFields(string templatePath, string tableName)
        {
            StringBuilder str = new StringBuilder();
            XElement xElem = XElement.Load(templatePath);
            XElement reg = xElem.Descendants(tableName).First();
            foreach (var item in reg.Elements())
            {
                if (item.Attribute("IsShow").Value == "1")
                {
                    str.Append(item.Name.ToString());
                    str.Append(",");
                }
            }
            return str.ToString().Substring(0, str.Length - 1);
        }

        /// <summary>
        /// 动态增加列
        /// </summary>
        /// <param name="gvList"></param>
        /// <param name="dict"></param>
        public static void AddTemplateField(GridView gvList, IDictionary<string, string> dict)
        {
            gvList.AutoGenerateColumns = false;
            TemplateField tf;
            tf = new TemplateField();
            tf.ShowHeader = true;
            tf.HeaderText = "选择";
            tf.HeaderStyle.Wrap = false;
            tf.ItemTemplate = new GridViewTemplate(DataControlRowType.DataRow, "SortOrder");
            gvList.Columns.Add(tf);
            foreach (var item in dict)
            {
                tf = new TemplateField();
                tf.ShowHeader = true;
                tf.HeaderText = item.Value;
                tf.HeaderStyle.Wrap = false;
                //if (item.Key == "PostGradeExperience")
                //{
                //    tf.HeaderStyle.Width = Unit.Pixel(200);
                //    tf.ItemStyle.Width = Unit.Pixel(200);
                //}
                //tf.HeaderTemplate = new GridViewTemplate(DataControlRowType.Header, item.Value);
                tf.ItemTemplate = new GridViewTemplate(DataControlRowType.DataRow, item.Key);
                gvList.Columns.Add(tf);
            }
        }

        /// <summary>
        /// 获取xml路径
        /// </summary>
        /// <returns></returns>
        public static string GetTemplateFilePath(string type)
        {
            string templatePath = Path.Combine(WebUtil.GetSiteDirectory(), ConfigurationManager.AppSettings["FileTemplateDirectory"]);
            if (type == "SeniorManager")
            {
                templatePath = string.Format(@"{0}\Register\{1}.xml", templatePath, type);
            }
            else
            {
                templatePath = string.Format(@"{0}\Register\Complete\{1}.xml", templatePath, type);
            }
            return templatePath;
        }
    }
}