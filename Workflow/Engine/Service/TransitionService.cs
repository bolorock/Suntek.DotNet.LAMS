#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Workflow
 * Module:  Transition
 * Descrption:
 * CreateDate: 2010/11/18 14:21:45
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
    public class TransitionService :  BaseService<string,Transition>
    {
		#region Fields
		private readonly ILog log = LogManager.GetLogger(typeof(TransitionService));
		#endregion
		
		#region Constructors
		
		public TransitionService(){ }
		#endregion

        #region ITransitionService Imp
        public DataTable FindTransition(IDictionary<string, object> parameters, PageInfo pi)
        {
            string cmdText = "select wft.*,name from WF_Transition wft inner join WF_ProcessInst wfp on wft.ProcessInstID = wfp.ID ";

            return repository.ExecuteDataTable<Transition>(cmdText, parameters, pi);
        }

        #endregion
		
		#region Internal Methods

        #endregion
    }
}