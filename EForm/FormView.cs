#region Description
/*==============================================================================
 *  Copyright (c) suntektech co.,ltd. All Rights Reserved.
 * ===============================================================================
 * 描述：电子表单控件
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
using System.ComponentModel;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Security.Permissions;
using System.Linq;

using EAFrame.Workflow.Definition;
using EAFrame.Workflow.Enums;

namespace EAFrame.EForm
{
    [
 AspNetHostingPermission(SecurityAction.Demand,
     Level = AspNetHostingPermissionLevel.Minimal),
 AspNetHostingPermission(SecurityAction.InheritanceDemand,
     Level = AspNetHostingPermissionLevel.Minimal),
 ToolboxData("<{0}:FormView runat=server></{0}:FormView>")]
    public class FormView : WebControl
    {
        public Form Form
        {
            get;
            set;
        }

        public IDictionary<string, object> Values
        {
            get;
            set;
        }

        private int showPerRow = 2;
        /// <summary>
        /// 一行包含的控件数
        /// </summary>
        public int ShowPerRow
        {
            get
            {
                return showPerRow;
            }
            set
            {
                showPerRow = value;
            }
        }

        private void RenderHeader(HtmlTextWriter writer)
        {
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "rp_tbHead");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "rp_thHead_Model");
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, "setTableHight();this.className=='rp_thHead_Model_Desc'?this.className='rp_thHead_Model':this.className='rp_thHead_Model_Desc';ShowAndHide('form_filter_block');");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            writer.Write(Form.Title);
            writer.RenderEndTag();// end div thHead_Model   


            writer.RenderEndTag();// end div tbHead
        }

        public string GetValidatorScript(FormField field)
        {
            string script = string.Empty;

            if (field.DataType == DataType.Integer)
            {
                return string.Format("$(\"#{0}\").formValidator().regexValidator({{ regexp: \"intege\", datatype: \"enum\", onerror: \"【{1}】必须是整数！\" }});", field.Name, field.Text);
            }
            else if (field.DataType == DataType.Float)
            {
                return string.Format("$(\"#{0}\").formValidator().regexValidator({{ regexp: \"decmal\", datatype: \"enum\", onerror: \"【{1}】必须是浮点数！\" }});", field.Name, field.Text);
            }

            return script;
        }

        private void RenderFormView(HtmlTextWriter writer)
        {
            writer.AddAttribute(HtmlTextWriterAttribute.Id, "eForm");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);

            //定位用的table
            writer.AddAttribute(HtmlTextWriterAttribute.Align, "center");
            writer.AddAttribute(HtmlTextWriterAttribute.Id, "eFormTable");
            writer.AddAttribute(HtmlTextWriterAttribute.Width, "100%");
            writer.RenderBeginTag(HtmlTextWriterTag.Table);//start

            writer.AddAttribute(HtmlTextWriterAttribute.Class, "div_row");
            writer.RenderBeginTag(HtmlTextWriterTag.Tr);
            
            //左侧
            writer.RenderBeginTag(HtmlTextWriterTag.Td);

            #region 动态生成查询条件

            writer.AddAttribute(HtmlTextWriterAttribute.Align, "center");
            writer.RenderBeginTag(HtmlTextWriterTag.Table);

            StringBuilder validatorScript = new StringBuilder();
            validatorScript.AppendLine("    <script language=\"javascript\" type=\"text/javascript\">");
            validatorScript.AppendLine("        function validator() {");

            if (Form != null && Form.Fields != null && Form.Fields.Count > 0)
            {
                for (int i = 0; i < Form.Fields.Count; i++)
                {
                    FormField field = Form.Fields[i];

                    validatorScript.AppendLine(GetValidatorScript(field));

                    if (i >= showPerRow && i % showPerRow == 0)
                    {
                        writer.RenderEndTag();
                    }
                    if (i % showPerRow == 0)
                    {
                        writer.RenderBeginTag(HtmlTextWriterTag.Tr);
                    }

                    writer.AddAttribute(HtmlTextWriterAttribute.Class, "div_row_lable");
                    writer.RenderBeginTag(HtmlTextWriterTag.Td);
                    if (field.Required)
                    {
                        writer.Write("<em>*</em>");
                    }
                    writer.Write(field.Text + (field.Text.EndsWith("：") ? string.Empty : "："));
                    writer.RenderEndTag();

                    writer.AddAttribute(HtmlTextWriterAttribute.Class, "div_row_input");
                    writer.RenderBeginTag(HtmlTextWriterTag.Td);
                    writer.Write(EAFrame.EForm.ObjectFactory.CreateControl(field).ToHtml(Values));
                    writer.RenderEndTag();
                }

                //补齐tr
                int remain = Form.Fields.Count % showPerRow;
                if (remain > 0)
                {
                    for (int i = 0; i < showPerRow - remain; i++)
                    {
                        writer.AddAttribute(HtmlTextWriterAttribute.Class, "div_row_lable");
                        writer.RenderBeginTag(HtmlTextWriterTag.Td);
                        writer.RenderEndTag();

                        writer.AddAttribute(HtmlTextWriterAttribute.Class, "div_row_input");
                        writer.RenderBeginTag(HtmlTextWriterTag.Td);
                        writer.RenderEndTag();
                    }
                }

                writer.RenderEndTag();
            }

            validatorScript.AppendLine("        }");
            validatorScript.AppendLine("    </script>");

            writer.RenderBeginTag(HtmlTextWriterTag.Tr);
            writer.AddAttribute(HtmlTextWriterAttribute.Colspan, (showPerRow * 2).ToString());
            writer.AddAttribute(HtmlTextWriterAttribute.Style, "text-align: right");
            writer.RenderBeginTag(HtmlTextWriterTag.Td);

            writer.RenderEndTag();
            writer.RenderEndTag();

            writer.RenderEndTag();//end table form_filter_block

            #endregion

            writer.RenderEndTag();

            //右侧
            writer.AddAttribute(HtmlTextWriterAttribute.Width, "120px");
            writer.AddAttribute(HtmlTextWriterAttribute.Align, "right");
            writer.AddAttribute(HtmlTextWriterAttribute.Valign, "top");
            writer.RenderBeginTag(HtmlTextWriterTag.Td);
            #region

            writer.Write("<table class=\"btnline\" align=\"center\">");
            writer.Write("<tr><td align=\"center\">");
            writer.Write("<div class=\"rpbtngp\">");

            writer.Write("</div>");
            writer.Write("</td></tr></table>");

            #endregion

            writer.RenderEndTag();

            writer.RenderEndTag();

            writer.RenderEndTag();//end



            writer.RenderEndTag();//end div form_filter_block

            writer.Write(validatorScript.ToString());
        }

        protected override void Render(HtmlTextWriter writer)
        {
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "formView");
            writer.AddAttribute(HtmlTextWriterAttribute.Id, "formView");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);

            RenderHeader(writer);

            RenderFormView(writer);

            writer.RenderEndTag();
        }
    }
}

