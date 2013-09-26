﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: AuthorizeCenter
 * Module:  Role
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
    public partial class RoleDetail : BasePage
    {
        private RoleService roleService=new RoleService();
		
		#region ---界面处理方法---

       	protected bool ShowPageDetail()
        {
			if (PageContext.Action == ActionType.Add)
			{
				dtpCreateTime.Text=DateTime.Now.ToShortDateString();
				return false;
			}

            Role entity =roleService.GetDomain(CurrentId);
			
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

        protected void btnSave_OnClick(object sender,EventArgs e)
        {
            Role role = GetDomainObject();
            roleService.SaveOrUpdate(role);
            WebUtil.PromptMsg("添加成功");
        }
		#endregion
		
		#region ---操作处理方法---
		protected Role GetDomainObject()
		{
            Role  role = roleService.GetDomain(CurrentId);

            if (role == null)
            {
                role = new Role();
				role.ID=CurrentId;
            }

			GetControlValues(ref role);	

            return role;
		}



		#endregion
    }
}