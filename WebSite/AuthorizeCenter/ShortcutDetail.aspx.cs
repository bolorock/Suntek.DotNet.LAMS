﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: AuthorizeCenter
 * Module:  Shortcut
 * Descrption:
 * CreateDate: 2010/11/18 13:55:37
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
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;

namespace WebSite
{
    public partial class ShortcutDetail : BasePage
    {
        private ShortcutService shortcutService=new ShortcutService();
		
		#region ---界面处理方法---

       	protected bool ShowPageDetail()
        {
			if (PageContext.Action == ActionType.Add)
			{
				return false;
			}

            Shortcut entity =shortcutService.GetDomain(CurrentId);
			
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
		protected Shortcut GetDomainObject()
		{
            Shortcut  shortcut = shortcutService.GetDomain(CurrentId);

            if (shortcut == null)
            {
                shortcut = new Shortcut();
				shortcut.ID=CurrentId;
            }

			GetControlValues(ref shortcut);	
			
            return shortcut;
		}

		#endregion
    }
}
