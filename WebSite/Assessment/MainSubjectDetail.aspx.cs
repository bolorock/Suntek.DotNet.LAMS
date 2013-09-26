﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: EAFrame.Assessment
 * Module:  MainSubject
 * Descrption:
 * CreateDate: 2011-1-27 10:50:48
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
using SunTek.Assessment.Domain;
using SunTek.Assessment.Service;
namespace WebSite
{
    public partial class MainSubjectDetail : BasePage
    {
        private MainSubjectService mainSubjectService=new MainSubjectService();
		
		#region ---界面处理方法---

       	protected bool ShowPageDetail()
        {
			if (PageContext.Action == ActionType.Add)
			{
				return false;
			}

            MainSubject entity =mainSubjectService.GetDomain(CurrentId);
			
            if (entity == null) return false;

			SetControlValues(entity);
			
			return true;
        }
		#endregion
		
		#region ---操作处理方法---
		protected MainSubject GetDomainObject()
		{
            MainSubject  mainSubject = mainSubjectService.GetDomain(CurrentId);

            if (mainSubject == null)
            {
                mainSubject = new MainSubject();
				mainSubject.ID=CurrentId;
            }

			GetControlValues(ref mainSubject);	
			
            return mainSubject;
		}

		#endregion
    }
}