#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Workflow
 * Module:  ActivityInst
 * Descrption:
 * CreateDate: 2010/11/18 14:21:44
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
using EAFrame.Workflow.Domain;

namespace EAFrame.Workflow.Service
{
    public class ActivityInstService :  BaseService<string,ActivityInst>
    {
		#region Fields
		private readonly ILog log = LogManager.GetLogger(typeof(ActivityInstService));
		#endregion
		
		#region Constructors
		
		public ActivityInstService(){ }
		#endregion

        #region IActivityInstService Imp

        #endregion
		
		#region Internal Methods

        #endregion
    }
}