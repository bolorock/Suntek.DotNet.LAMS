﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: LAMS
 * Module:  Diploma
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
    public partial class Diploma :DomainObject<string>
    {
        #region Fields
		
		private string _employeeID = string.Empty;
		private string _fulltimeEducation = string.Empty;
		private string _fulltimeSchool = string.Empty;
		private string _fulltimeMajor = string.Empty;
		private string _inserviceEducation = string.Empty;
		private string _inserviceSchool = string.Empty;
		private string _inserviceMajor = string.Empty;
		private string _creator = string.Empty;
		private System.DateTime _createTime = DateTime.Now;
		
		
        #endregion

        #region Constructors
		public Diploma(){}
		
		
		public Diploma(string id,string employeeID,string fulltimeEducation,string fulltimeSchool,string fulltimeMajor,string inserviceEducation,string inserviceSchool,string inserviceMajor,string creator,System.DateTime createTime)
		{
		  this.ID=id;
		this._employeeID=employeeID;
		this._fulltimeEducation=fulltimeEducation;
		this._fulltimeSchool=fulltimeSchool;
		this._fulltimeMajor=fulltimeMajor;
		this._inserviceEducation=inserviceEducation;
		this._inserviceSchool=inserviceSchool;
		this._inserviceMajor=inserviceMajor;
		this._creator=creator;
		this._createTime=createTime;
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
			sb.Append(_employeeID);
			sb.Append(_fulltimeEducation);
			sb.Append(_fulltimeSchool);
			sb.Append(_fulltimeMajor);
			sb.Append(_inserviceEducation);
			sb.Append(_inserviceSchool);
			sb.Append(_inserviceMajor);
			sb.Append(_creator);
			sb.Append(_createTime);

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
        /// 全日制教育
        /// </summary>
		public virtual string FulltimeEducation
        {
            get { return  _fulltimeEducation; }
			set	{	_fulltimeEducation =  value;}
        }
		
		/// <summary>
        /// 全日制教育学校
        /// </summary>
		public virtual string FulltimeSchool
        {
            get { return  _fulltimeSchool; }
			set	{	_fulltimeSchool =  value;}
        }
		
		/// <summary>
        /// 全日制教育专业
        /// </summary>
		public virtual string FulltimeMajor
        {
            get { return  _fulltimeMajor; }
			set	{	_fulltimeMajor =  value;}
        }
		
		/// <summary>
        /// 在职教育
        /// </summary>
		public virtual string InserviceEducation
        {
            get { return  _inserviceEducation; }
			set	{	_inserviceEducation =  value;}
        }
		
		/// <summary>
        /// 在职教育学校
        /// </summary>
		public virtual string InserviceSchool
        {
            get { return  _inserviceSchool; }
			set	{	_inserviceSchool =  value;}
        }
		
		/// <summary>
        /// 在职教育专业
        /// </summary>
		public virtual string InserviceMajor
        {
            get { return  _inserviceMajor; }
			set	{	_inserviceMajor =  value;}
        }
		
		/// <summary>
        /// 创建者
        /// </summary>
		public virtual string Creator
        {
            get { return  _creator; }
			set	{	_creator =  value;}
        }
		
		/// <summary>
        /// 创建时间
        /// </summary>
		public virtual System.DateTime CreateTime
        {
            get { return  _createTime.ToSafeDateTime(); }
			set	{	_createTime =  value.ToSafeDateTime();}
        }
		
        #endregion
    }
}
