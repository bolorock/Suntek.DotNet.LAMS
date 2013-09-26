﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Workflow
 * Module:  TransControl
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
using System.Collections;
using System.Collections.Generic;

using EAFrame.Core.Domain;
using EAFrame.Core.Extensions;
using Newtonsoft.Json;
using Iesi.Collections.Generic;

namespace EAFrame.Workflow.Domain
{
    [Serializable]
    public partial class TransControl :DomainObject<string>
    {
        #region Fields
		
		private string _srcActID = string.Empty;
		private string _srcActName = string.Empty;
		private string _destActID = string.Empty;
		private string _destActName = string.Empty;
		private string _processInstID = string.Empty;
		private System.DateTime _transTime = DateTime.Now;
		private double _transWeight = default(Double);
		
		
        #endregion

        #region Constructors
		public TransControl(){}
		
		
		public TransControl(string id,string srcActID,string srcActName,string destActID,string destActName,string processInstID,System.DateTime transTime,double transWeight)
		{
		  this.ID=id;
		this._srcActID=srcActID;
		this._srcActName=srcActName;
		this._destActID=destActID;
		this._destActName=destActName;
		this._processInstID=processInstID;
		this._transTime=transTime;
		this._transWeight=transWeight;
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
			sb.Append(_srcActID);
			sb.Append(_srcActName);
			sb.Append(_destActID);
			sb.Append(_destActName);
			sb.Append(_processInstID);
			sb.Append(_transTime);
			sb.Append(_transWeight);

            return sb.ToString().GetHashCode();
        }
		
		public virtual bool Validate()
        {
			return true;
        }

        #endregion

        #region Properties
		
		/// <summary>
        /// 源活动定义ID
        /// </summary>
		public virtual string SrcActID
        {
            get { return  _srcActID; }
			set	{	_srcActID =  value;}
        }
		
		/// <summary>
        /// 源活动定义名称
        /// </summary>
		public virtual string SrcActName
        {
            get { return  _srcActName; }
			set	{	_srcActName =  value;}
        }
		
		/// <summary>
        /// 目标活动定义ID
        /// </summary>
		public virtual string DestActID
        {
            get { return  _destActID; }
			set	{	_destActID =  value;}
        }
		
		/// <summary>
        /// 目标活动定义名称
        /// </summary>
		public virtual string DestActName
        {
            get { return  _destActName; }
			set	{	_destActName =  value;}
        }
		
		/// <summary>
        /// 流程实例ID
        /// </summary>
		public virtual string ProcessInstID
        {
            get { return  _processInstID; }
			set	{	_processInstID =  value;}
        }
		
		/// <summary>
        /// 迁移时间
        /// </summary>
		public virtual System.DateTime TransTime
        {
            get { return  _transTime.ToSafeDateTime(); }
			set	{	_transTime =  value.ToSafeDateTime();}
        }
		
		/// <summary>
        /// 迁移权重
        /// </summary>
		public virtual double TransWeight
        {
            get { return  _transWeight; }
			set	{	_transWeight =  value;}
        }
		
        #endregion
    }
}
