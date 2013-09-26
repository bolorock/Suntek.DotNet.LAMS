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
using EAFrame.Core.Caching;
using EAFrame.Core.FastInvoker;
using EAFrame.Core.DataFilter;
using EAFrame.Core.Office;
using EAFrame.WebControls;
using EAFrame.Core.Utility;
using SunTek.LAMS.Domain;
using SunTek.LAMS.Service;
using Newtonsoft.Json;

namespace WebSite
{
    public partial class ImportCandidateManagerQualify : BasePage
    {
        private CandidateManagerService candidateManagerService = new CandidateManagerService();

        public short Status
        {
            get
            {
                return rblStatus.SelectedValue.ToShort();
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
            if (!IsPostBack && !IsAjaxPost)
            {
                ShowList(gvList, Status, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
                gvList.Columns[5].Visible = Grade == "grade2" ? true : false;//是否正职列只在二级经理显示
            }
        }

        #endregion

        /// <summary>
        /// 转向明细页面
        /// </summary>
        /// <param name="param"></param>
        protected void Redirect(string param)
        {
            var currentIdParam = PageContext.Action == ActionType.Add ? string.Empty : string.Format("&CurrentId={0}", CurrentId);
            Response.Redirect(string.Format("CandidateManagerQualifyDetail.aspx?LastUrl={0}&Runat=1&ActionFlag={1}{2}{3}", Request.Url.PathAndQuery, PageContext.Action, currentIdParam, string.IsNullOrEmpty(param) ? param : "&" + param));
        }

        /// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList(PagedGridView gvList, short status, PageInfo pageInfo,short flag=0)
        {
            //IPageOfList<SunTek.LAMS.Domain.CandidateManager> result = candidateManagerService.FindAll(GetFilterParameters(), pageInfo);
            IDictionary<string, object> parameters = GetFilterParameters();
            string filter = GetFilterString();
            filter = filter.Replace("OwnerOrg", "b.OwnerOrg").Replace("creator", "a.creator");
            if (flag == 1)//刷新时删除所有查询条件
            {
                parameters.Clear();
            }
            DataTable dt = candidateManagerService.GetCandidateManagerQualify(parameters,filter, status,Grade, pageInfo);
            //gvList.IncludeRowDoubleClick = false;
            gvList.ItemCount = pageInfo.ItemCount;
            gvList.DataSource = dt;
            gvList.DataBind();

        }

        protected void cmdRefresh_Click(object sender, EventArgs e)
        {
            ShowList(gvList, Status, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount),1);
        }

        protected void rblStatus_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            gvList.PageIndex = 1;
            gvList.ItemCount = 0;
            ShowList(gvList, Status, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount),1);
        }

        /// <summary>
        /// 修改
        /// </summary>
        public void Update()
        {
            PageContext.Action = ActionType.Update;
            PageContext.PageIndex = gvList.PageIndex;
            SavePageContext(PageContext);

            Redirect(string.Empty);
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
            ShowList(gvList,Status, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="argument"></param>
        /// <returns></returns>
        public void Delete()
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                CandidateManager candidateManager=candidateManagerService.GetDomain(CurrentId);
                if (candidateManager.Status == 3)
                {
                    actionMessage = "该记录已经出库！";
                    actionResult=ActionResult.Other;
                }
                else
                {
                    candidateManager.Status=3;
                    candidateManagerService.Update(candidateManager);
                    actionResult = ActionResult.Success;
                    actionMessage = "删除成功！";
                }

                ajaxResult.RetValue = CurrentId;
                ajaxResult.PromptMsg = actionMessage;

                AddActionLog(candidateManager, PageContext.Action, actionResult, actionMessage);//添加操作日志

                Refresh();
                ajaxResult.ActionResult = actionResult;
            }
            catch (Exception ex)
            {
                actionMessage = "删除失败!";
                log.Error(actionMessage, ex);
            }

           // WebUtil.PromptMsg(actionMessage);UpdatePanel下要用下面的方法
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, typeof(UpdatePanel), "CandidateManager", "alert('"+actionMessage+"');", true);


        }


        public void Export()
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                string errMsg = string.Empty;
                ExcelUtil excel = new ExcelUtil();
                string fileName = string.Empty;
                string filter = GetFilterString();
                filter = filter.Replace("OwnerOrg", "b.OwnerOrg").Replace("creator", "a.creator");
                DataTable dt = candidateManagerService.GetCandidateManagerQualify(GetFilterParameters(),filter, Status, Grade, null);
                string[] strName;// =new string[dt.Columns.Count];
                
                if (Grade == "grade2")
                {
                    fileName="二级后备资格";
                    strName=new string[]{"员工编号","单位","姓名","经理类别","是否正职","后备岗位","创建时间"};
                    dt.Columns.Remove("ID");
                    dt.Columns.Remove("Status");
                    dt.Columns.Remove("Creator");
                }
                else
                {
                   fileName="三级后备资格";
                   strName = new string[] { "员工编号", "单位", "姓名", "经理类别", "后备岗位", "创建时间" };
                   dt.Columns.Remove("ID");
                   dt.Columns.Remove("Status");
                   dt.Columns.Remove("IsChief");
                   dt.Columns.Remove("Creator");
                }
                if (excel.ResponseToExcelFile(strName, dt, fileName, out errMsg))
                {
                    // actionResult = ActionResult.Success;
                    return;
                }
                else
                {
                    actionMessage = "导出失败：" + errMsg;
                    actionResult = ActionResult.Failed;
                }

                ajaxResult.PromptMsg = actionMessage;

                ajaxResult.ActionResult = actionResult;
            }
            catch (Exception ex)
            {
                actionMessage = "导出失败!";
                log.Error(actionMessage, ex);
            }

            WebUtil.PromptMsg(actionMessage);

        }

        
    }
}