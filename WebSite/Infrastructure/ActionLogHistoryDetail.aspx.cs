﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Infrastructure
 * Module:  ActionLogHistory
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

namespace WebSite
{
    public partial class ActionLogHistoryDetail : BasePage
    {
        private ActionLogHistoryService actionLogHistoryService = new ActionLogHistoryService();

        #region ---界面处理方法---

        protected bool ShowPageDetail()
        {
            if (PageContext.Action == ActionType.Add)
            {
                dtpCreateTime.Text = DateTime.Now.ToShortDateString();
                dtpArchiveTime.Text = DateTime.Now.ToShortDateString();
                return false;
            }

            ActionLogHistory entity = actionLogHistoryService.GetDomain(CurrentId);

            if (entity == null) return false;

            SetControlValues(entity);

            return true;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !IsAjaxPost)
            {
                ShowPageDetail();
            }
        }

        #endregion

        #region ---操作处理方法---
        protected ActionLogHistory GetDomainObject()
        {
            ActionLogHistory actionLogHistory = actionLogHistoryService.GetDomain(CurrentId);

            if (actionLogHistory == null)
            {
                actionLogHistory = new ActionLogHistory();
                actionLogHistory.ID = CurrentId;
            }

            GetControlValues(ref actionLogHistory);

            return actionLogHistory;
        }

        #endregion
    }
}
