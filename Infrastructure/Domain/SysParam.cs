﻿#region Description
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
using System.Collections;
using System.Collections.Generic;

using EAFrame.Core.Domain;
using EAFrame.Core.Extensions;
using Newtonsoft.Json;
using Iesi.Collections.Generic;

namespace SunTek.EAFrame.Infrastructure.Domain
{
    public partial class SysParam :DomainObject<string>
    {
        #region Fields
		
		private string _name = string.Empty;
		private string _value = string.Empty;
		private string _description = string.Empty;
		private string _creator = string.Empty;
		private System.DateTime _createTime = DateTime.Now;
		private string _modifier = string.Empty;
		private System.DateTime _modifyTime = DateTime.Now;
		
		
        #endregion

        #region Constructors
		public SysParam(){}
		
		
		public SysParam(string id,string name,string value,string description,string creator,System.DateTime createTime,string modifier,System.DateTime modifyTime)
		{
		  this.ID=id;
		this._name=name;
		this._value=value;
		this._description=description;
		this._creator=creator;
		this._createTime=createTime;
		this._modifier=modifier;
		this._modifyTime=modifyTime;
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
			sb.Append(_name);
			sb.Append(_value);
			sb.Append(_description);
			sb.Append(_creator);
			sb.Append(_createTime);
			sb.Append(_modifier);
			sb.Append(_modifyTime);

            return sb.ToString().GetHashCode();
        }
		
		public virtual bool Validate()
        {
			return true;
        }

        #endregion

        #region Properties
		
		/// <summary>
        /// 参数名
        /// </summary>
		public virtual string Name
        {
            get { return  _name; }
			set	{	_name =  value;}
        }
		
		/// <summary>
        /// 参数值
        /// </summary>
		public virtual string Value
        {
            get { return  _value; }
			set	{	_value =  value;}
        }
		
		/// <summary>
        /// 描述
        /// </summary>
		public virtual string Description
        {
            get { return  _description; }
			set	{	_description =  value;}
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
		
		/// <summary>
        /// 修改者
        /// </summary>
		public virtual string Modifier
        {
            get { return  _modifier; }
			set	{	_modifier =  value;}
        }
		
		/// <summary>
        /// 修改时间
        /// </summary>
		public virtual System.DateTime ModifyTime
        {
            get { return  _modifyTime.ToSafeDateTime(); }
			set	{	_modifyTime =  value.ToSafeDateTime();}
        }
		
        #endregion
    }
}
