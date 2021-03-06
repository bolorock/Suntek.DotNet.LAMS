﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: EAFrame.Infrastructure
 * Module:  Catalog
 * Descrption:
 * CreateDate: 2010/12/27 20:19:51
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
    public partial class Catalog :DomainObject<string>
    {
        #region Fields
		
		private string _catalogName = string.Empty;
		private short _catalogType = default(Int16);
		private string _parentID = string.Empty;
		private string _path = string.Empty;
		private string _description = string.Empty;
		private string _ownerOrg = string.Empty;
		private string _creator = string.Empty;
		private System.DateTime _createTime = DateTime.Now;
        private int _sortOrder = 0;
		
		
        #endregion

        #region Constructors
		public Catalog(){}
		
		
		public Catalog(string id,string catalogName,short catalogType,string parentID,string path,string description,string ownerOrg,string creator,System.DateTime createTime)
		{
		  this.ID=id;
		this._catalogName=catalogName;
		this._catalogType=catalogType;
		this._parentID=parentID;
		this._path=path;
		this._description=description;
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
			sb.Append(_catalogName);
			sb.Append(_catalogType);
			sb.Append(_parentID);
			sb.Append(_path);
			sb.Append(_description);
			sb.Append(_ownerOrg);
			sb.Append(_creator);
			sb.Append(_createTime);
            sb.Append(_sortOrder);

            return sb.ToString().GetHashCode();
        }
		
		public virtual bool Validate()
        {
			return true;
        }

        #endregion

        #region Properties
		
		/// <summary>
        /// 目录名称
        /// </summary>
		public virtual string CatalogName
        {
            get { return  _catalogName; }
			set	{	_catalogName =  value;}
        }
		
		/// <summary>
        /// 目录类型
        /// </summary>
		public virtual short CatalogType
        {
            get { return  _catalogType; }
			set	{	_catalogType =  value;}
        }
		
		/// <summary>
        /// 上级目录
        /// </summary>
		public virtual string ParentID
        {
            get { return  _parentID; }
			set	{	_parentID =  value;}
        }
		
		/// <summary>
        /// 目录路径
        /// </summary>
		public virtual string Path
        {
            get { return  _path; }
			set	{	_path =  value;}
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
        /// <summary>
        /// 序号
        /// </summary>
        public virtual int SortOrder
        {
            get { return  _sortOrder; }
			set	{	_sortOrder =  value;}
        }
		
        #endregion
    }
}
