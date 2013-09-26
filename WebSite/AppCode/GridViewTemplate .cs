using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite
{
    public class GridViewTemplate : ITemplate
    {
        private DataControlRowType dataControlRowType;

        private string dataField;
        private string columnName;
        private string controlID;

        public GridViewTemplate(DataControlRowType rowType, string columnName)
        {
            dataControlRowType = rowType;
            switch (rowType)
            {
                case DataControlRowType.Header:
                    this.columnName = columnName;
                    break;
                case DataControlRowType.DataRow:
                    this.dataField = columnName;
                    this.controlID = string.Format("lbl{0}",dataField);
                    break;
            }
        }

        #region ITemplate 成员

        public void InstantiateIn(Control container)
        {
            switch (dataControlRowType)
            {
                case DataControlRowType.Header:
                    Literal l = new Literal();
                    l.Text = columnName;
                    container.Controls.Add(l);
                    break;
                case DataControlRowType.DataRow:
                    Label lbl = new Label();
                    lbl.ID = controlID;
                    lbl.DataBinding += new EventHandler(lbl_DataBinding);
                    container.Controls.Add(lbl);
                    break;
                default:
                    break;
            }
        }

        void lbl_DataBinding(object sender, EventArgs e)
        {
            Label lbl = sender as Label;
            GridViewRow gr = lbl.NamingContainer as GridViewRow;
            lbl.Text = (DataBinder.Eval(gr.DataItem, dataField) ?? string.Empty).ToString();
        }

        #endregion
    }
}