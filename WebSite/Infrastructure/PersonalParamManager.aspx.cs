﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Infrastructure
 * Module:  PersonalParam
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

namespace WebSite
{
    public partial class PersonalParamManager : BasePage
    {
 		private PersonalParamService personalParamService=new PersonalParamService();

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
            ShowList(gvList,new PageInfo(e.PageIndex, e.PageSize, e.ItemCount));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowList(gvList,new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
            }
        }

        #endregion

        #region ---操作处理方法---
		/// <summary>
        /// 转向明细页面
        /// </summary>
        /// <param name="param"></param>
        protected  void Redirect(string param)
        {
            var currentIdParam = PageContext.Action == ActionType.Add ? string.Empty : string.Format("&CurrentId={0}", CurrentId);
            Response.Redirect(string.Format("PersonalParamDetail.aspx?LastUrl={0}&Runat=1&ActionFlag={1}{2}{3}", Request.Url.PathAndQuery, PageContext.Action, currentIdParam, string.IsNullOrEmpty(param) ? param : "&" + param));
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
        /// 查询
        /// </summary>
        public void Search()
        {
            ShowList(gvList, new PageInfo(1, gvList.PageSize, gvList.ItemCount));
        }
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
                    personalParamService.Delete(argument);
                    personalParamService.ClearCache();
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
        public string Save(string argument)
        {
            AjaxResult ajaxResult = new AjaxResult();

            string errorMsg = string.Empty;
            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                PersonalParam perParam = JsonConvert.DeserializeObject<PersonalParam>(argument);

                //判断是否有相同的参数名存在
                Dictionary<string,object> param = new Dictionary<string,object>();
                param.Add("Name",perParam.Name);
                var isParam = personalParamService.FindAll(param);

                if (isParam.Count > 0)
                {
                    ajaxResult.PromptMsg = "此参数名称已存在！";
                    return JsonConvert.SerializeObject(ajaxResult);
                }
               
                perParam.CreateTime = DateTime.Now;
                perParam.Creator = User.ID;
                if (string.IsNullOrEmpty(perParam.ID))
                {
                    perParam.ID = IdGenerator.NewComb().ToString();
                    personalParamService.SaveOrUpdate(perParam);
                }
                else
                {
                    personalParamService.Update(perParam);
                }
                personalParamService.ClearCache();
                actionResult = ActionResult.Success;
                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                
                //记录操作日志
                AddActionLog(perParam, PageContext.Action, actionResult, actionMessage);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = perParam.ID;
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
        /// 刷新
        /// </summary>
        public void Refresh()
        {
            ShowList(gvList,new PageInfo(gvList.PageIndex, gvList.PageSize, gvList.ItemCount));
        }
	
		/// <summary>
        /// 显示列表信息
        /// </summary>
        /// <param name="gvList">GridView对象</param>
        /// <param name="pageInfo">分页信息</param>
        public void ShowList(PagedGridView gvList, PageInfo pageInfo)
        {
            IPageOfList<PersonalParam> result = personalParamService.FindAll(GetFilterParameters(), pageInfo);
            gvList.ItemCount = result.PageInfo.ItemCount;
            gvList.DataSource = result;
            gvList.DataBind();
        }
        #endregion
    }
}
