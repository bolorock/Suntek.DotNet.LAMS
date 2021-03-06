﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Infrastructure
 * Module:  Module
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
    public partial class ModuleDetail : BasePage
    {
        private ModuleService moduleService=new ModuleService();
		
		#region ---界面处理方法---

       	protected bool ShowPageDetail()
        {
			if (PageContext.Action == ActionType.Add)
			{
				dtpCreateTime.Text=DateTime.Now.ToShortDateString();
                txtCreator.Text = User.Name;
				return false;
			}

            SunTek.EAFrame.Infrastructure.Domain.Module entity = moduleService.GetDomain(CurrentId);
			
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
		protected SunTek.EAFrame.Infrastructure.Domain.Module GetDomainObject()
		{
            SunTek.EAFrame.Infrastructure.Domain.Module  module = moduleService.GetDomain(CurrentId);

            if (module == null)
            {
                module = new SunTek.EAFrame.Infrastructure.Domain.Module();
				module.ID=CurrentId;
            }

			GetControlValues(ref module);	
			
            return module;
		}

        public void Save(string argument)
        {
            try
            {
                SunTek.EAFrame.Infrastructure.Domain.Module module = GetDomainObject();

                moduleService.SaveOrUpdate(module);

                WebUtil.PromptMsg("保存操作成功");

                WebUtil.CloseRefreshParent();
            }
            catch (Exception ex)
            {
                log.Error("保存操作失败", ex);

                WebUtil.PromptMsg("保存操作失败");
            }
        }

		#endregion
    }
}
