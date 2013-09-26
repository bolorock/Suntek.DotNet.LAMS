﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: EAFrame.Assessment
 * Module:  AssessmentRole
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
    public partial class AssessmentRoleDetail : BasePage
    {
        private AssessmentRoleService assessmentRoleService=new AssessmentRoleService();
		
		#region ---界面处理方法---

       	protected bool ShowPageDetail()
        {
			if (PageContext.Action == ActionType.Add)
			{
				return false;
			}

            AssessmentRole entity =assessmentRoleService.GetDomain(CurrentId);
			
            if (entity == null) return false;

			SetControlValues(entity);
			
			return true;
        }
		#endregion
		
		#region ---操作处理方法---
		protected AssessmentRole GetDomainObject()
		{
            AssessmentRole  assessmentRole = assessmentRoleService.GetDomain(CurrentId);

            if (assessmentRole == null)
            {
                assessmentRole = new AssessmentRole();
				assessmentRole.ID=CurrentId;
            }

			GetControlValues(ref assessmentRole);	
			
            return assessmentRole;
		}

		#endregion
    }
}
