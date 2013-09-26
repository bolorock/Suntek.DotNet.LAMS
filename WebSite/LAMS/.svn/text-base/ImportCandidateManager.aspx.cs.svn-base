using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

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
using SunTek.LAMS.Domain;
using SunTek.LAMS.Service;
using SunTek.EAFrame.Infrastructure.Service;
using SunTek.EAFrame.Infrastructure.Domain;
using Newtonsoft.Json;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;

namespace WebSite
{
    public partial class ImportCandidateManager : BasePage
    {
        private CandidateManagerService candidateManagerService = new CandidateManagerService();
        private ObjectRoleService objectRoleSerivce = new ObjectRoleService();

        public short Status
        {
            get
            {
                return string.IsNullOrWhiteSpace(rblStatus.SelectedValue) ? (short)4 : rblStatus.SelectedValue.ToShort();
            }
        }

        public string Grade
        {
            get
            {
                return Request.QueryString["entry"] ?? "grade2";
            }
        }

        #region ---界面处理方法---

        /// <summary>
        /// 初始化页面
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            gvList.PageChanged += new PagedGridView.PagintEventHandler(gvList_PageChanged);
        }

        void gvList_PageChanged(object sender, PagingArgs e)
        {
            ShowList(gvList,Status, new PageInfo(e.PageIndex, e.PageSize, e.ItemCount));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bindcbo(filterTargetCandidate, "TargetCandidate");
                Bindcbo(filterCandidateMaturity, "CandidateMaturity");
                Bindcbo(filterFulltimeEducation, "Education");
                Bindcbo(filterInserviceEducation, "Education");
                ShowList(gvList,Status, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
            }
        }

        /// <summary>
        /// 绑定下拉列表
        /// </summary>
        /// <param name="cbo">下拉控件</param>
        /// <param name="dictName">字典名</param>
        private void Bindcbo(ComboBox cbo,string dictName)
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

        #endregion

        /// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList(PagedGridView gvList, short status, PageInfo pageInfo, short flag = 0)
        {
            IDictionary<string, object> parameters = GetFilterParameters();
            if (flag == 1)//刷新时删除所有查询条件
            {
                parameters.Clear();
            }
            string filter = GetFilterString();
            filter = filter.Replace("OwnerOrg", "b.OwnerOrg").Replace("creator", "a.creator");
            DataTable dt = candidateManagerService.GetCandidaeManager(parameters,filter, status,Grade,pageInfo);
            gvList.ItemCount = pageInfo.ItemCount;
            gvList.DataSource = dt;
            gvList.Columns[25].Visible = (Grade == "grade3");
            gvList.DataBind();
        }

        protected void cmdRefresh_Click(object sender, EventArgs e)
        {
            ShowList(gvList,Status, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount),1);
        }

        protected void rblStatus_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            gvList.PageIndex = 1;
            gvList.ItemCount = 0;
            ShowList(gvList, Status, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount),1);
        }

        /// <summary>
        /// 查询
        /// </summary>
        public void Search()
        {
            ShowList(gvList, Status, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
        }

        /// <summary>
        /// 刷新
        /// </summary>
        public void Refresh()
        {
            ShowList(gvList, Status, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="argument"></param>
        /// <returns></returns>
        public string Delete(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                CandidateManager candidateManager = candidateManagerService.GetDomain(argument);
                if (candidateManager.Status == 3)
                {
                    actionMessage = "该记录已经出库！";
                    actionResult = ActionResult.Other;
                }
                else
                {
                    candidateManager.Status = 3;
                    candidateManagerService.Update(candidateManager);

                    //删除后备经理人的角色配置
                    string roleID = System.Configuration.ConfigurationManager.AppSettings["CandidateManagerRoleID"].ToString();
                    IDictionary<string, object> dict = new Dictionary<string, object>();
                    dict.Add("Code", candidateManager.Code);
                    Employee employee = new EmployeeService().FindOne(dict);
                    dict.Clear();
                    dict.Add("RoleID", roleID);
                    dict.Add("ObjectID", employee.ID);
                    ObjectRole objectRole = objectRoleSerivce.FindOne(dict);
                    objectRoleSerivce.Delete(objectRole);
                    actionResult = ActionResult.Success;
                    actionMessage = "出库成功！";
                }

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = CurrentId;
                ajaxResult.PromptMsg = actionMessage;

                AddActionLog(candidateManager, PageContext.Action, actionResult, actionMessage);//添加操作日志

            }
            catch (Exception ex)
            {
                actionMessage = "出库失败 !";
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);

        }


    }
}