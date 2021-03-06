﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Infrastructure
 * Module:  Dict
 * Descrption:
 * CreateDate: 2010/11/18 13:40:13
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

using log4net;
using Microsoft.Practices.Unity;
using EAFrame.Core;
using EAFrame.Core.Enums;
using EAFrame.Core.Service;
using EAFrame.Core.Security;
using EAFrame.Core.Extensions;
using EAFrame.Core.Web;
using EAFrame.Core.Caching;
using EAFrame.Core.Utility;
using EAFrame.Core.FastInvoker;
using EAFrame.WebControls;
using SunTek.EAFrame.Infrastructure.Domain;
using SunTek.EAFrame.Infrastructure.Service;
using Newtonsoft.Json;

namespace WebSite
{
    public partial class DictDetail : BasePage
    {
        private DictService dictService = new DictService();
        DictItemService dictItemService = new DictItemService();

        #region ---界面处理方法---

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (!IsPostBack && !IsAjaxPost)
                ShowPageDetail();
        }

        protected void ShowPageDetail()
        {
            Dict parent = null;
            if (PageContext.Action == ActionType.Add)
            {
                parent = dictService.GetDomain(Request.QueryString["ParentID"]);
                if (parent != null)
                {
                    chbParentID.Text = parent.Text;
                    chbParentID.Value = parent.ID;
                }
                return;
            }

            Dict entity = dictService.GetDomain(CurrentId);
            if (entity == null) return;

            SetControlValues(entity);

            parent = dictService.GetDomain(entity.ParentID);
            if (parent != null)
            {
                chbParentID.Text = parent.Text;
                chbParentID.Value = parent.ID;
            }

            //List<string> dictItemIDs = dictItemService.All().Where(p => p.DictID == entity.ID).Select(p => p.ID).ToList();
            this.rptDict.DataSource = dictItemService.All().Where(p => p.DictID == entity.ID).OrderBy(d=>d.SortOrder);
            this.rptDict.DataBind();

        }
        #endregion

        #region ---操作处理方法---
        protected Dict GetDomainObject()
        {
            Dict dict = dictService.GetDomain(CurrentId);

            if (dict == null)
            {
                dict = new Dict();
                dict.ID = CurrentId;
            }

            GetControlValues(ref dict);

            return dict;
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
                    this.dictItemService.Delete(argument);
                    dictItemService.ClearCache();
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
                Dict dict = JsonConvert.DeserializeObject<Dict>(argument);

                dict.ID = string.IsNullOrWhiteSpace(CurrentId)?IdGenerator.NewComb().ToString():CurrentId;
                dict.Creator = User.ID;
                
                foreach (var item in dict.DictItems)
                {
                    item.ID = string.IsNullOrWhiteSpace(item.ID) ? IdGenerator.NewComb().ToString():item.ID;
                    item.DictID = dict.ID;
                    item.Creator = User.ID;
                }

                dictService.SaveOrUpdate(dict);
                dictService.ClearCache();
                dictItemService.ClearCache();

                actionResult = ActionResult.Success;

                //获取提示信息
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);

                //记录操作日志
                AddActionLog(dict, PageContext.Action, actionResult, actionMessage);

                Dictionary<string, object> retValue = new Dictionary<string, object>();
                List<string> itemIds = dict.DictItems.Select(d => d.ID).ToList();
                retValue.Add("ID", dict.ID);
                retValue.Add("DictIds", itemIds);

                ajaxResult.ActionResult = actionResult;
                ajaxResult.RetValue = retValue;
                ajaxResult.PromptMsg = actionMessage;

            }
            catch (Exception ex)
            {
                actionMessage = RemarkAttribute.GetEnumRemark(actionResult);
                log.Error(actionMessage, ex);
            }

            return JsonConvert.SerializeObject(ajaxResult);
        }
        #endregion
    }
}
