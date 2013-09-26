﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: AuthorizeCenter
 * Module:  RolePrivilege
 * Descrption:
 * CreateDate: 2010/11/18 13:55:35
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
    public partial class RolePrivilege :DomainObject<string>
    {
        #region Fields
		
		private string _roleID = string.Empty;
		private string _privilegeID = string.Empty;
		
		
        #endregion

        #region Constructors
		public RolePrivilege(){}
		
		
		public RolePrivilege(string id,string roleID,string privilegeID)
		{
		  this.ID=id;
		this._roleID=roleID;
		this._privilegeID=privilegeID;
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
			sb.Append(_roleID);
			sb.Append(_privilegeID);

            return sb.ToString().GetHashCode();
        }
		
		public virtual bool Validate()
        {
			return true;
        }

        #endregion

        #region Properties
		
		/// <summary>
        /// 角色ID
        /// </summary>
		public virtual string RoleID
        {
            get { return  _roleID; }
			set	{	_roleID =  value;}
        }
		
		/// <summary>
        /// 权限ID
        /// </summary>
		public virtual string PrivilegeID
        {
            get { return  _privilegeID; }
			set	{	_privilegeID =  value;}
        }
		
        #endregion
    }
}
