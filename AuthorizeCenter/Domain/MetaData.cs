﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: AuthorizeCenter
 * Module:  MetaData
 * Descrption:
 * CreateDate: 2010/11/18 13:55:34
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

namespace SunTek.EAFrame.AuthorizeCenter.Domain
{
    public partial class MetaData :DomainObject<string>
    {
        #region Fields
		
		private string _name = string.Empty;
		private short _type = default(Int16);
		private string _value = string.Empty;
		private string _ownerOrg = string.Empty;
		private string _creator = string.Empty;
		private System.DateTime _createTime = DateTime.Now;
		
		
        #endregion

        #region Constructors
		public MetaData(){}
		
		
		public MetaData(string id,string name,short type,string value,string ownerOrg,string creator,System.DateTime createTime)
		{
		  this.ID=id;
		this._name=name;
		this._type=type;
		this._value=value;
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
			sb.Append(_name);
			sb.Append(_type);
			sb.Append(_value);
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
        /// 元数据名称
        /// </summary>
		public virtual string Name
        {
            get { return  _name; }
			set	{	_name =  value;}
        }
		
		/// <summary>
        /// 元数据类型
        /// </summary>
		public virtual short Type
        {
            get { return  _type; }
			set	{	_type =  value;}
        }
		
		/// <summary>
        /// 值
        /// </summary>
		public virtual string Value
        {
            get { return  _value; }
			set	{	_value =  value;}
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
