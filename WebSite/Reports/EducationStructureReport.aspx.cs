using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using SunTek.LAMS.Domain;
using SunTek.LAMS.Service;

using Microsoft.Practices.Unity;
using log4net;
using EAFrame.Core;
using EAFrame.Core.Enums;
using EAFrame.Core.Service;
using EAFrame.Core.Security;
using EAFrame.Core.Extensions;
using EAFrame.Core.Web;
using EAFrame.Core.Office;
using EAFrame.Core.Caching;
using EAFrame.Core.FastInvoker;
using EAFrame.Core.DataFilter;
using EAFrame.WebControls;
using EAFrame.Core.Utility;
using SunTek.EAFrame.Infrastructure.Service;
using SunTek.EAFrame.Infrastructure.Domain;
using Newtonsoft.Json;
using System.Data;


namespace WebSite
{
    public partial class EducationStructureReport : BasePage
    {
        private CandidateManagerService candidateManagerService = new CandidateManagerService();


        public string CorpID
        {
            get {
                return Request.QueryString["CorpID"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            PageMaster baseMaster = Master as PageMaster;
            baseMaster.IsShowNavInfo = false;
            if (!IsPostBack)
            {
                Bindcbo(filterTargetCandidate, "TargetCandidate");
                Bindcbo(filterCandidateMaturity, "CandidateMaturity");
                BindData();
            }
        }

        private void BindData()
        {
            string[] strArray = new string[] { "OR1500025055", "OR1500025056", "OR1500025057", "OR1200000535" };
            IDictionary<string, object> parameters = GetFilterParameters();
            if (CorpID != null)
            {
                if (strArray.Contains(CorpID))
                    parameters.Add("org.ParentID", CorpID);
                else
                    parameters.Add("org.ID", CorpID);
            }
            DataTable dt = candidateManagerService.GetEducationStructureReport(parameters);
            if (dt.Rows.Count == 0) return;
            ShowList(dt);
            BindChart(dt);
        }

        /// <summary>
        /// 绑定下拉列表
        /// </summary>
        /// <param name="cbo">下拉控件</param>
        /// <param name="dictName">字典名</param>
        private void Bindcbo(ComboBox cbo, string dictName)
        {
            DictService dict = new DictService();
            IList<DictItem> item = dict.GetDictItems(dictName);
            cbo.DataTextField = "Text";
            cbo.DataValueField = "Text";
            cbo.DataSource = item;
            cbo.DataBind();
            ListItem listItem = new ListItem("全部", "-1");
            listItem.Selected = true;
            cbo.Items.Add(listItem);
        }

        private void BindChart(DataTable dt)
        {
            Chart1.Series["Series1"].ChartType = SeriesChartType.Column;
            Chart1.Series["Series1"].IsValueShownAsLabel = true;
            Chart1.Titles[0].Text = "后备经理学历结构";
            // Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;
            Chart1.DataSource = dt;
            Chart1.Series["Series1"].XValueMember = "education";
            Chart1.Series["Series1"].YValueMembers = "num";
            Chart1.DataBind();
        }

        private void ShowList(DataTable dt)
        {
            DataTable dtNew = new DataTable();
            dtNew.Columns.Add(new DataColumn("学历"));
            DataRow row = dtNew.NewRow();
            row[0] = "人数";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dtNew.Columns.Add(new DataColumn(dt.Rows[i][0].ToString()));
                row[i + 1] = dt.Rows[i][1].ToInt();
            }
            dtNew.Rows.Add(row);

            GridView1.DataSource = dtNew;
            GridView1.DataBind();

        }

        /// <summary>
        /// 查询
        /// </summary>
        public void Search()
        {
            BindData();
        }

    }
}