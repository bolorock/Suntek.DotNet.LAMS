using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Data;

using EAFrame.Core;
using EAFrame.WebControls;
using SunTek.LAMS.Domain;
using SunTek.LAMS.Service;
using SunTek.Register.Domain;
using SunTek.Register.Service;

using System.Xml.Linq;
using EAFrame.Core.Web;
using EAFrame.Core.Enums;
using EAFrame.Core.Extensions;
using EAFrame.Core.Utility;

namespace WebSite.Register
{
    public partial class ShowRegister : BasePage
    {
        private FieldSetService fieldSetService = new FieldSetService();
        RegisterService registerService = new RegisterService();

        public ManagerType managerType
        {
            get { return (ManagerType)Enum.Parse(typeof(ManagerType), Request.QueryString["Entry"] ?? "0"); }
        }

        //public string RegisterType
        //{
        //    get { return RemarkAttribute.GetEnumRemark(managerType); }
        //}

        #region ---界面处理方法---


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //PageMaster baseMaster = Master as PageMaster;
                //baseMaster.IsShowNavInfo = false;
                drpYear.SelectedValue = DateTime.Now.Year.ToString();
                drpMonth.SelectedValue = DateTime.Now.Month.ToString();
                
                if (User.CorpID == "OR1000000001")
                {
                    IList<SunTek.Register.Domain.CorpSort> corpSorts = new CorpSortService().All().OrderBy(p => p.SortOrder).ToList();
                    drpCompany.DataSource = corpSorts;
                    drpCompany.DataBind();

                    //drpCompany.Items.Insert(0, new ListItem("全省", "all"));

                    drpCompany.SelectedValue = User.CorpID;
                }
                else
                {
                    drpCompany.Visible = false;
                    cmdProvince.Visible = false;
                }
            }
        }

        #endregion

        /// <summary>
        /// 设置字段宽度
        /// </summary>
        /// <param name="argument"></param>
        /// <returns></returns>
        public string SetFieldWidth(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                string templatePath =SystemUtil.GetTemplateFilePath(Request.Form["registerType"]);

                // IDictionary<int,int> dict = JsonConvert.DeserializeObject<Dictionary<int,int>>(argument);
                var js = new System.Runtime.Serialization.Json.DataContractJsonSerializer(typeof(Dictionary<int, int>));
                using (var ms = new System.IO.MemoryStream(System.Text.Encoding.UTF8.GetBytes(argument)))
                {
                    var obj = js.ReadObject(ms) as Dictionary<int, int>;
                    SystemUtil.SetFieldWidth(templatePath, obj);
                }

                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                ajaxResult.ActionResult = actionResult;

                ajaxResult.PromptMsg = actionMessage;
            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }
    }
}