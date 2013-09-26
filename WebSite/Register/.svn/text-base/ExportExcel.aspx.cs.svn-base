using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

using SunTek.Register.Service;
using EAFrame.Core.Enums;

namespace WebSite.Register
{
    public partial class ExportExcel : BasePage
    {
        private RegisterService registerService = new RegisterService();
        public override bool Authorize(EAFrame.Core.Authentication.User user, string requestUrl, bool isForce)
        {
            return base.Authorize(user, requestUrl, false);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string type = Request.QueryString["type"] ?? "0";
            string yearMonth = Request.QueryString["yearMonth"];
            ManagerType managerType = (ManagerType)Enum.Parse(typeof(ManagerType), type);
            string registerType = RemarkAttribute.GetEnumRemark(managerType);

            DataTable dt = registerService.GetRegisterByCorpID(null, registerType, User.CorpID, yearMonth, null);
            if (dt == null || dt.Rows.Count == 0) return;
            string fileName = string.Format("{0}名册", registerType);
            string template = Path.Combine(Path.Combine(Server.MapPath("~"), "FileTemplate/Register"), string.Format("{0}.xml", managerType.ToString()));
            IDictionary<string, string> dicColumnName = SystemUtil.GetField(template, "RegisterInfo");//获取字段对应关系
            ExcelHelper.ExportByWeb(dt, registerType, fileName, "", dicColumnName, columnRowIndex: 0);
        }
    }
}