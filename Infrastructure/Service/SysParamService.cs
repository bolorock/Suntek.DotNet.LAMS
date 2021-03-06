#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Infrastructure
 * Module:  SysParam
 * Descrption:
 * CreateDate: 2010/11/18 13:40:11
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
using System.Linq;
using System.Collections.Generic;
using log4net;

using EAFrame.Core;
using EAFrame.Core.Caching;
using EAFrame.Core.Service;
using EAFrame.Core.Enums;
using EAFrame.Core.DataFilter;
using EAFrame.Core.Extensions;
using SunTek.EAFrame.Infrastructure.Domain;

namespace SunTek.EAFrame.Infrastructure.Service
{
    public class SysParamService : BaseService<string, SysParam>
    {
        #region Fields
        private readonly ILog log = LogManager.GetLogger(typeof(SysParamService));
        #endregion

        #region Constructors

        public SysParamService() { }
        #endregion

        #region ISysParamService Imp

        /// <summary>
        /// 获取系统参数
        /// </summary>
        /// <param name="paramName"></param>
        /// <returns></returns>
        public SysParam GetSysParam(string paramName)
        {
            return All().FirstOrDefault(p => string.Equals(paramName, p.Name)) ?? new SysParam();
        }

        public TValue GetSysParamValue<TValue>(string paramName)
        {
            return GetSysParam(paramName).Value.Cast<TValue>();
        }
        #endregion

        #region Internal Methods

        #endregion
    }
}