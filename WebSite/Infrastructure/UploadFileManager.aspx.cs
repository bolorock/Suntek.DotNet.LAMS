﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Infrastructure
 * Module:  UploadFile
 * Descrption:
 * CreateDate: 2010/11/18 13:40:12
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
using System.IO;

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
using Newtonsoft.Json;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;

namespace WebSite
{
    public partial class UploadFileManager : BasePage
    {
        private UploadFileService uploadFileService = new UploadFileService();
        private CatalogService catalogService = new CatalogService();

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
                ShowPageDetail();
                ShowList(gvList, new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
            }
        }
        protected void ShowPageDetail()
        {
            Catalog parent = null;
            if (PageContext.Action == ActionType.Add)
            {
                parent = catalogService.GetDomain(Request.QueryString["ParentID"]);
                if (parent != null)
                {
                    chbParentID.Text = parent.CatalogName;
                    chbParentID.Value = parent.ID;
                    txtPath.Text = parent.Path;
                    hdnPath.Value = parent.Path;
                    hdnActionType.Value = "add";
                }
                return;
            }

            Catalog entity = catalogService.GetDomain(CurrentId);
            if (entity == null) return;

            SetControlValues(entity);

            parent = catalogService.GetDomain(entity.ParentID);
            if (parent != null)
            {
                chbParentID.Text = parent.CatalogName;
                chbParentID.Value = parent.ID;
                hdnPath.Value = parent.Path;
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
            Response.Redirect(string.Format("UploadFileDetail.aspx?LastUrl={0}&Runat=1&ActionFlag={1}{2}{3}", Request.Url.PathAndQuery, PageContext.Action, currentIdParam, string.IsNullOrEmpty(param) ? param : "&" + param));
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
        /// 查询
        /// </summary>
        public void Search()
        {
            ShowList(gvList, new PageInfo(1, gvList.PageSize, gvList.ItemCount));
        }
        /// <summary>
        /// 保存目录
        /// </summary>
        public string Save(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                Catalog catalog = JsonConvert.DeserializeObject<Catalog>(argument);

                catalog.ID = string.IsNullOrWhiteSpace(CurrentId) ? IdGenerator.NewComb().ToString() : CurrentId;
                catalog.OwnerOrg = User.OrgPath;
                catalog.Creator = User.ID;

                catalogService.SaveOrUpdate(catalog);
                catalogService.ClearCache();

                string folderPath = Path.Combine(Server.MapPath("~"), catalog.Path);
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(catalog, PageContext.Action, actionResult, actionMessage);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = catalog.ID;
                ajaxResult.PromptMsg = actionMessage;

            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }

        /// <summary>
        /// 根据目录id获取目录路径
        /// </summary>
        public string GetPath(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();
            try
            {
                ActionResult actionResult = ActionResult.Failed;
                if (!string.IsNullOrWhiteSpace(argument))
                {
                    Catalog catalog = catalogService.GetDomain(argument);
                    catalogService.ClearCache();

                    actionResult = ActionResult.Success;
                    ajaxResult.ActionResult = actionResult;
                    ajaxResult.RetValue = catalog.Path;
                }
            }
            catch (Exception ex)
            {
                log.Error("获取目录路径失败！", ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }

        /// <summary>
        /// 删除目录下的文件
        /// </summary>
        public string Delete(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {

                if (!string.IsNullOrWhiteSpace(argument))
                {
                    UploadFile uploadFile = uploadFileService.GetDomain(argument);
                    string filePath = Server.MapPath("~") + uploadFile.FilePath;

                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);  //删除文件物理路径
                    }

                    uploadFileService.Delete(argument);
                    uploadFileService.ClearCache();
                    actionResult = ActionResult.Success;
                    //获取提示信息
                    actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                    ajaxResult.ActionResult = actionResult;
                    ajaxResult.RetValue = CurrentId;
                    ajaxResult.PromptMsg = actionMessage;

                }
            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }

        /// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList(PagedGridView gvList, PageInfo pageInfo)
        {
            IDictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.SafeAdd("CatalogID", CurrentId);

            IPageOfList<UploadFile> result = uploadFileService.FindAll(parameters, GetFilterString(), pageInfo);
            gvList.ItemCount = result.PageInfo.ItemCount;
            gvList.DataSource = result;
            gvList.DataBind();
        }

        public string GetUserNameByUserId(string userId)
        {
            Operator operatorInfo = new OperatorService().GetDomain(userId);
            if (operatorInfo != null)
            {
                return operatorInfo.UserName;
            }
            return "";
        }
        #endregion
    }
}
