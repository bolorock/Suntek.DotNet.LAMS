﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: EAFrame.Assessment
 * Module:  SubjectItemCore
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
using SunTek.Assessment.Domain;
using SunTek.Assessment.Service;

namespace WebSite
{
    public partial class SubjectItemCoreDetail : BasePage
    {
        private SubjectItemCoreService subjectItemCoreService=new SubjectItemCoreService();
		
		#region ---界面处理方法---

       	protected bool ShowPageDetail()
        {
			if (PageContext.Action == ActionType.Add)
			{
				return false;
			}

            SubjectItemCore entity =subjectItemCoreService.GetDomain(CurrentId);
			
            if (entity == null) return false;

			SetControlValues(entity);
			
			return true;
        }
		#endregion
		
		#region ---操作处理方法---
		protected SubjectItemCore GetDomainObject()
		{
            SubjectItemCore  subjectItemCore = subjectItemCoreService.GetDomain(CurrentId);

            if (subjectItemCore == null)
            {
                subjectItemCore = new SubjectItemCore();
				subjectItemCore.ID=CurrentId;
            }

			GetControlValues(ref subjectItemCore);	
			
            return subjectItemCore;
		}

		#endregion
    }
}