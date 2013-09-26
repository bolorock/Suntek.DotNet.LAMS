﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Workflow
 * Module:  TransControl
 * Descrption:
 * CreateDate: 2010/11/18 12:00:10
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
using EAFrame.Workflow.Domain;
using EAFrame.Workflow.Service;

namespace WebSite
{
    public partial class TransControlDetail : BasePage
    {
        private TransControlService transControlService=new TransControlService();
		
		#region ---界面处理方法---

       	protected bool ShowPageDetail()
        {
			if (PageContext.Action == ActionType.Add)
			{
				dtpTransTime.Text=DateTime.Now.ToShortDateString();
				return false;
			}

            TransControl entity =transControlService.GetDomain(CurrentId);
			
            if (entity == null) return false;

			SetControlValues(entity);
			
			return true;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowPageDetail();
            }
        }
		#endregion
		
		#region ---操作处理方法---
		protected TransControl GetDomainObject()
		{
            TransControl  transControl = transControlService.GetDomain(CurrentId);

            if (transControl == null)
            {
                transControl = new TransControl();
				transControl.ID=CurrentId;
            }

			GetControlValues(ref transControl);	
			
            return transControl;
		}

		#endregion
    }
}
