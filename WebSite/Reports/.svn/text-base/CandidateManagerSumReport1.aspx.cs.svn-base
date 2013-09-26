using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SunTek.LAMS.Service;

namespace WebSite
{
    public partial class CandidateManagerSumReport1 : BasePage
    {
        CandidateManagerService candidateManagerService = new CandidateManagerService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptReport.DataSource = candidateManagerService.GetCandidateManagerGradeTwoSum();
                rptReport.DataBind();
            }

        }
    }
}