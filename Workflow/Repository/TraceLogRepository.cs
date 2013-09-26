#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Workflow
 * Module:  TraceLog
 * Descrption:
 * CreateDate: 2010-11-2 21:41:42
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
using System.Collections;
using System.Collections.Generic;
using log4net;

using SunTek.EAFrame.Core;
using SunTek.EAFrame.Core.Data;
using SunTek.EAFrame.Workflow.Domain;

namespace SunTek.EAFrame.Workflow.Repository
{
    public class TraceLogRepository :Repository<string, TraceLog>
    {
		#region Fields
		private static readonly ILog log = LogManager.GetLogger(typeof(TraceLogRepository));
		#endregion
		
		#region Constructors
        public TraceLogRepository(){}
		#endregion

        #region ITraceLogRepository Imp
        #endregion
		
		#region Internal Methods

        #endregion
    }
}