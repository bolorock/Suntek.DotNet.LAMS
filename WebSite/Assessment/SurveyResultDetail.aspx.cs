﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Assessment
 * Module:  SurveyResult
 * Descrption:
 * CreateDate: 2010/11/18 14:01:00
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
    public partial class SurveyResultDetail : BasePage
    {
        private SurveyResultService surveyResultService=new SurveyResultService();
		
		#region ---界面处理方法---

       	protected bool ShowPageDetail()
        {
			if (PageContext.Action == ActionType.Add)
			{
				dtpScoreTime.Text=DateTime.Now.ToShortDateString();
				dtpStartTime.Text=DateTime.Now.ToShortDateString();
				dtpEntTime.Text=DateTime.Now.ToShortDateString();
				return false;
			}

            SurveyResult entity =surveyResultService.GetDomain(CurrentId);
			
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
		protected SurveyResult GetDomainObject()
		{
            SurveyResult  surveyResult = surveyResultService.GetDomain(CurrentId);

            if (surveyResult == null)
            {
                surveyResult = new SurveyResult();
				surveyResult.ID=CurrentId;
            }

			GetControlValues(ref surveyResult);	
			
            return surveyResult;
		}

		#endregion
    }
}
