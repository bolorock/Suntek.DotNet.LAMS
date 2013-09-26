using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

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
using EAFrame.WebControls;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;

using Newtonsoft.Json;


namespace WebSite
{
    public partial class OrgUserList : BasePage
    {
        private OperatorService operatorService = new OperatorService();

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
            ShowList(gvList, new PageInfo(e.PageIndex, e.PageSize, e.ItemCount));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            PageMaster baseMaster = Master as PageMaster;
            baseMaster.IsShowNavInfo = false;
            if (!IsPostBack)
            {

                ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
            }
        }

        #endregion

        #region ---操作处理方法---
        /// <summary>
        /// 转向明细页面
        /// </summary>
        /// <param name="param"></param>
        protected void Redirect(string param)
        {
            var currentIdParam = PageContext.Action == ActionType.Add ? string.Empty : string.Format("&CurrentId={0}", CurrentId);
            Response.Redirect(string.Format("EmployeeDetail.aspx?LastUrl={0}&Runat=1&ActionFlag={1}{2}{3}", Request.Url.PathAndQuery, PageContext.Action, currentIdParam, string.IsNullOrEmpty(param) ? param : "&" + param));
        }

        /// <summary>
        /// 新增
        /// </summary>
        public void Add()
        {
            PageContext.Action = ActionType.Add;
            PageContext.PageIndex = gvList.PageIndex;
            SavePageContext(PageContext);

            Redirect(string.Empty);
        }

        /// <summary>
        /// 查看
        /// </summary>
        public void View()
        {
            PageContext.Action = ActionType.View;
            PageContext.PageIndex = gvList.PageIndex;
            SavePageContext(PageContext);

            Redirect(string.Empty);
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
        /// 刷新
        /// </summary>
        public void Refresh()
        {
            ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
        }

        /// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList(PagedGridView gvList, PageInfo pageInfo)
        {
            string orgId = string.IsNullOrEmpty(Request.QueryString["orgid"]) ? "" : Request.QueryString["orgid"].ToSafeString();
            if (!string.IsNullOrWhiteSpace(orgId))
            {
                string filter = string.Empty;
                filter += string.Format(@" and OrgID='{0}' ", orgId);

                DataTable dt = operatorService.GetOperatorByOrg(null, pageInfo,filter);
                gvList.ItemCount = pageInfo.ItemCount;
                gvList.DataSource = dt;
                gvList.DataBind();
            }
        }



        public string IsExist(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            try
            {
                string dataID = Request.Form["DataID"].Trim();
                IDictionary<string, object> para = new Dictionary<string, object>();
                para.SafeAdd("ID", dataID);
                Operator operatorInfo = new OperatorService().FindOne(para);
                if (operatorInfo != null)
                {
                    ajaxResult.PromptMsg = "该用户已经存在！";
                }

                ajaxResult.RetValue = string.Empty;
                ajaxResult.ActionResult = ActionResult.Success;


            }
            catch (Exception ex)
            {
                ajaxResult.ActionResult = ActionResult.Failed;
                ajaxResult.PromptMsg = "获取信息出错，请联系管理员！";
                log.Error(ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }

        protected void btnSearch_OnClick(object sender, EventArgs e)
        {
            string loginName = txtLoginName.Text;
            string userName = txtUserName.Text; 

            IDictionary<string, object> para = new Dictionary<string, object>();
            //if (!string.IsNullOrWhiteSpace(loginName))
            //    para.SafeAdd("LoginName", loginName);
            //if (!string.IsNullOrWhiteSpace(userName)) 
            //    para.SafeAdd("UserName", userName);
            string filter1, filter2;
            GetFilterParameters(out filter1,out filter2);
            PageInfo pageInfo=new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount);
            DataTable dt = operatorService.GetOperatorByOrg(para, pageInfo,filter1,filter2);
            gvList.ItemCount = pageInfo.ItemCount;
            gvList.DataSource = dt;
            gvList.DataBind();
        }

    


        #endregion

        /// <summary>
        /// 获取搜索条件
        /// </summary>
        /// <returns></returns>
        private void GetFilterParameters(out string filter1,out string filter2)
        {
            filter1 = string.Empty;
            filter2=string.Empty;
            string loginName = txtLoginName.Text;
            string roleNames=chbRole.Text;
            string userName = txtUserName.Text;
            if (!string.IsNullOrWhiteSpace(loginName))
                filter1 += string.Format(@" and LoginName='{0}' ", loginName);
            if (!string.IsNullOrWhiteSpace(userName))
                filter1 += string.Format(@" and UserName='{0}' ", userName);

            if (!string.IsNullOrWhiteSpace(roleNames))
            {
                string[] roleNameList = roleNames.Split(',');
                foreach (string name in roleNameList)
                {
                    if(!string.IsNullOrEmpty(name))
                    filter2 += string.Format(@" and Name ='{0}' ", name);
                }
            }
        }



    }
}