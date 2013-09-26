﻿#region Description
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
using System.Collections;
using System.Collections.Generic;

using EAFrame.Core.Domain;
using EAFrame.Core.Extensions;
using Newtonsoft.Json;
using Iesi.Collections.Generic;

namespace SunTek.Assessment.Domain
{
    public partial class Report :DomainObject<string>
    {
        #region Fields
		
		private string _employeeID = string.Empty;
		private string _name = string.Empty;
		private string _code = string.Empty;
		private string _uploadFileID = string.Empty;
		private string _ownerOrg = string.Empty;
		private string _creator = string.Empty;
		private System.DateTime _createTime = DateTime.Now;
		
		
        #endregion

        #region Constructors
		public Report(){}
		
		
		public Report(string id,string employeeID,string name,string code,string uploadFileID,string ownerOrg,string creator,System.DateTime createTime)
		{
		  this.ID=id;
		this._employeeID=employeeID;
		this._name=name;
		this._code=code;
		this._uploadFileID=uploadFileID;
		this._ownerOrg=ownerOrg;
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
			sb.Append(_name);
			sb.Append(_code);
			sb.Append(_uploadFileID);
			sb.Append(_ownerOrg);
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
        /// 名称
        /// </summary>
		public virtual string Name
        {
            get { return  _name; }
			set	{	_name =  value;}
        }
		
		/// <summary>
        /// 编号
        /// </summary>
		public virtual string Code
        {
            get { return  _code; }
			set	{	_code =  value;}
        }
		
		/// <summary>
        /// 报告文件
        /// </summary>
		public virtual string UploadFileID
        {
            get { return  _uploadFileID; }
			set	{	_uploadFileID =  value;}
        }
		
		/// <summary>
        /// 归属组织
        /// </summary>
		public virtual string OwnerOrg
        {
            get { return  _ownerOrg; }
			set	{	_ownerOrg =  value;}
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
