using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SunTek.EAFrame.AuthorizeCenter.Service;

namespace WebSite
{
    public partial class CandidateMain : BasePage
    {
        EmployeeService employeeService = new EmployeeService();

        public string Grade
        {
            get
            {
                return employeeService.GetEmployeeCorpGrade(User.ID).ToString();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}