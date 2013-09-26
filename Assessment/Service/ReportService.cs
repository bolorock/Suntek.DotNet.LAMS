#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Assessment
 * Module:  Report
 * Descrption:
 * CreateDate: 2010/11/18 14:00:59
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
using System.Data;
using System.Collections.Generic;
using log4net;

using EAFrame.Core;
using EAFrame.Core.Caching;
using EAFrame.Core.Service;
using EAFrame.Core.Enums;
using EAFrame.Core.DataFilter;
using SunTek.Assessment.Domain;

namespace SunTek.Assessment.Service
{
    public class ReportService :  BaseService<string,Report>
    {
		#region Fields
		private readonly ILog log = LogManager.GetLogger(typeof(ReportService));
		#endregion
		
		#region Constructors
		
		public ReportService(){ }
		#endregion

        #region IReportService Imp

        #endregion
		
		#region Internal Methods

        #endregion
    }
}