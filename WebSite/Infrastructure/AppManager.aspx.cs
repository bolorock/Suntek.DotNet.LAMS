﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Infrastructure
 * Module:  App
 * Descrption:
 * CreateDate: 2010/11/23 10:05:34
 * Author: trenhui
 * Version:1.0
 * ===============================================================================
 * History
 *
 * Update Descrption:
 * Remark:
 * Update Time:
 * Author:generated by codesmithTemplate
 * 
 * ===============================================================================*/
#endregion
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;

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
using SunTek.EAFrame.Infrastructure.Domain;
using SunTek.EAFrame.Infrastructure.Service;
using EAFrame.Core.Utility;

using Newtonsoft.Json;

namespace WebSite
{
    public partial class AppManager : BasePage
    {
        private AppService appService = new AppService();

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
            Response.Redirect(string.Format("AppDetail.aspx?LastUrl={0}&Runat=1&ActionFlag={1}{2}{3}", Request.Url.PathAndQuery, PageContext.Action, currentIdParam, string.IsNullOrEmpty(param) ? param : "&" + param));
        }

        /// <summary>
        /// 新增
        /// </summary>
        public void Add()
        {
            this.gvList.SelectedRow.BackColor = System.Drawing.Color.Black;
            PageContext.Action = ActionType.Add;
            PageContext.PageIndex = gvList.PageIndex;
            SavePageContext(PageContext);
            //Redirect(string.Empty);
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
        /// 查询
        /// </summary>
        public void Search()
        {
            ShowList(gvList, new PageInfo(1, gvList.PageSize, gvList.ItemCount));
        }

        /// <summary>
        /// 刷新
        /// </summary>
        public void Refresh()
        {
            ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
        }

        ///// <summary>
        ///// 删除
        ///// </summary>
        //public string Delete(string argument)
        //{
        //    AjaxResult ajaxResult = new AjaxResult();
        //    string errorMsg = string.Empty;
        //    ActionResult actionResult = ActionResult.Failed;
        //    string actionMessage = string.Empty;

        //    try
        //    {
        //        if (!string.IsNullOrWhiteSpace(argument))
        //        {
        //            appService.Delete(argument);
        //            actionResult = ActionResult.Success;

        //            //获取提示信息
        //            actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

        //            ajaxResult.ActionResult = actionResult;
        //            ajaxResult.RetValue = CurrentId;
        //            ajaxResult.PromptMsg = actionMessage;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
        //        log.Error(actionMessage, ex);
        //    }
        //    return JsonConvert.SerializeObject(ajaxResult);
        //}
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
                appService.Delete(CurrentId);
                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = "删除成功！";

                ajaxResult.RetValue = CurrentId;
                ajaxResult.PromptMsg = actionMessage;

                Refresh();
                ajaxResult.ActionResult = actionResult;
            }
            catch (Exception ex)
            {
                actionMessage = "删除失败 !";
                log.Error(actionMessage, ex);
            }

            WebUtil.PromptMsg(actionMessage);
        }
        /// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList(PagedGridView gvList, PageInfo pageInfo)
        {
            IPageOfList<App> result = appService.FindAll(GetFilterParameters(), pageInfo);
            gvList.ItemCount = result.PageInfo.ItemCount;
            gvList.DataSource = result.OrderBy(o => o.SortOrder);
            gvList.DataBind();
        }
        #endregion
    }
}
