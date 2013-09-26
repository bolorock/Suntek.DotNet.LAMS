using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite
{
    public partial class ReportsManager : BasePage
    {
        public string Type
        {
            get
            {
                return Request.QueryString["Entry"] ?? string.Empty;
            }
        }

        public string IfrMainURL
        {
            get
            {
                switch (Type)
                {
                    case "edu":
                        return "EducationStructureReport.aspx";
                    case "age":
                        return "AgeStructureReport.aspx";
                }
                return string.Empty;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}