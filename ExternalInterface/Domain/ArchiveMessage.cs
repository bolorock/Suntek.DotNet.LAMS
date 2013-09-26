﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: ExternalInterface
 * Module:  ArchiveMessage
 * Descrption:
 * CreateDate: 2010/11/18 13:45:00
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

namespace SunTek.EAFrame.ExternalInterface.Domain
{
    public partial class ArchiveMessage :DomainObject<string>
    {
        #region Fields
		
		private short _messageType = default(Int16);
		private string _messageContent = string.Empty;
		private System.DateTime _archiveTime = DateTime.Now;
		
		
        #endregion

        #region Constructors
		public ArchiveMessage(){}
		
		
		public ArchiveMessage(string id,short messageType,string messageContent,System.DateTime archiveTime)
		{
		  this.ID=id;
		this._messageType=messageType;
		this._messageContent=messageContent;
		this._archiveTime=archiveTime;
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
			sb.Append(_messageType);
			sb.Append(_messageContent);
			sb.Append(_archiveTime);

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
        /// 归档时间
        /// </summary>
		public virtual System.DateTime ArchiveTime
        {
            get { return  _archiveTime.ToSafeDateTime(); }
			set	{	_archiveTime =  value.ToSafeDateTime();}
        }
		
        #endregion
    }
}
