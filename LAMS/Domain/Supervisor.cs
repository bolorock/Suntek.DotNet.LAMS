﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: LAMS
 * Module:  Supervisor
 * Descrption:
 * CreateDate: 2010/11/18 14:11:16
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
using System.Collections;
using System.Collections.Generic;

using EAFrame.Core.Domain;
using EAFrame.Core.Extensions;
using Newtonsoft.Json;
using Iesi.Collections.Generic;

namespace SunTek.LAMS.Domain
{
    public partial class Supervisor :DomainObject<string>
    {
        #region Fields
		
		private string _employeeID = string.Empty;
		private short _grade = default(Int16);
		
		
        #endregion

        #region Constructors
		public Supervisor(){}
		
		
		public Supervisor(string id,string employeeID,short grade)
		{
		  this.ID=id;
		this._employeeID=employeeID;
		this._grade=grade;
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
			sb.Append(_employeeID);
			sb.Append(_grade);

            return sb.ToString().GetHashCode();
        }
		
		public virtual bool Validate()
        {
			return true;
        }

        #endregion

        #region Properties
		
		/// <summary>
        /// 员工编号
        /// </summary>
		public virtual string EmployeeID
        {
            get { return  _employeeID; }
			set	{	_employeeID =  value;}
        }
		
		/// <summary>
        /// 级别
        /// </summary>
		public virtual short Grade
        {
            get { return  _grade; }
			set	{	_grade =  value;}
        }
		
        #endregion
    }
}
