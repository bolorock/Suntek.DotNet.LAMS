﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: ExternalInterface
 * Module:  MessagePump
 * Descrption:
 * CreateDate: 2010/11/18 13:45:01
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

using EAFrame.Core.Enums;


namespace SunTek.EAFrame.ExternalInterface.Domain
{
    public partial class MessagePump :DomainObject<string>
    {
        #region Fields
		
		private short _messageType = default(Int16);
		private string _messageContent = string.Empty;
		private short _triggerType = default(Int16);
		private System.DateTime _triggerTime = DateTime.Now;
		private int _trySendTimes = default(Int32);
		private System.DateTime _createTime = DateTime.Now;
		
		
        #endregion

        #region Constructors
		public MessagePump(){}
		
		
		public MessagePump(string id,short messageType,string messageContent,short triggerType,System.DateTime triggerTime,int trySendTimes,System.DateTime createTime)
		{
		  this.ID=id;
		this._messageType=messageType;
		this._messageContent=messageContent;
		this._triggerType=triggerType;
		this._triggerTime=triggerTime;
		this._trySendTimes=trySendTimes;
		this._createTime=createTime;
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
			sb.Append(_messageType);
			sb.Append(_messageContent);
			sb.Append(_triggerType);
			sb.Append(_triggerTime);
			sb.Append(_trySendTimes);
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
        /// 消息类型
        /// </summary>
		public virtual short MessageType
        {
            get { return  _messageType; }
			set	{	_messageType =  value;}
        }
		
		/// <summary>
        /// 消息内容
        /// </summary>
		public virtual string MessageContent
        {
            get { return  _messageContent; }
			set	{	_messageContent =  value;}
        }
		
		/// <summary>
        /// 触发类型
        /// </summary>
		public virtual short TriggerType
        {
            get { return  _triggerType; }
			set	{	_triggerType =  value;}
        }
		
		/// <summary>
        /// 触发时间
        /// </summary>
		public virtual System.DateTime TriggerTime
        {
            get { return  _triggerTime.ToSafeDateTime(); }
			set	{	_triggerTime =  value.ToSafeDateTime();}
        }
		
		/// <summary>
        /// 重发次数
        /// </summary>
		public virtual int TrySendTimes
        {
            get { return  _trySendTimes; }
			set	{	_trySendTimes =  value;}
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

    public enum MessageType
    {
        [Remark("初始化")]
        Init = 0,
        [Remark("重发")]
        ReTry = 1,
      
    }

}
