using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SunTek.Register.Domain;
using SunTek.Register.Service;

namespace WebSite.Register
{
    public partial class EmployeeRegister : BasePage
    {
        RegisterService registerService = new RegisterService();
        SapBaseInfoService sapBaseInfoService = new SapBaseInfoService();
        SapWorkExperienceService sapWorkExperienceService = new SapWorkExperienceService();
        SapFamilyMemberService sapFamilyMemberService = new SapFamilyMemberService();
        SapAppointService sapApplintService = new SapAppointService();

        public SapBaseInfo sapBaseInfo;
        public string PhotoPath;

        public IList<SapWorkExperience> sapWorkExperiences; //简历信息
        public IList<SapFamilyMember> sapFamilyMembers; //家庭成员
        public IList<SapAppoint> sapAppoints;//任职经历
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetData();
            }
        }

        private void GetData()
        {

            IDictionary<string, object> para = new Dictionary<string, object>();
            para.Add("PERNR", CurrentId);
            //sap基本信息
            sapBaseInfo = sapBaseInfoService.FindOne(para) ?? new SapBaseInfo();

            //照片路径
            string imgPath = string.Format(@"{0}\{1}.jpg?{2}", SunTek.LAMS.LAMSContext.RelativePhotoDirectory, CurrentId, new Random().Next(10000));
            //if (!System.IO.File.Exists(string.Format(@"{0}\{1}.jpg", SunTek.LAMS.LAMSContext.EmployeePhotoDirectory, registerInfo.Code)))
            //{
            //        imgPath = @"..\Skin\Default\Images\men_head.gif";
            //}
            PhotoPath = imgPath;

            //简历
            sapWorkExperiences = sapWorkExperienceService.FindAll(para);

            //家庭成员
            sapFamilyMembers=sapFamilyMemberService.FindAll(para);

            //工作经历
            sapAppoints = sapApplintService.FindAll(para);
        }
    }
}