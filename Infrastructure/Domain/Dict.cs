﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Infrastructure
 * Module:  Dict
 * Descrption:
 * CreateDate: 2010/11/18 13:40:10
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
    public partial class Dict : DomainObject<string>
    {
        #region Fields

        private string _name = string.Empty;
        private string _text = string.Empty;
        private string _parentID = string.Empty;
        private int _sortOrder = default(Int32);
        private string _description = string.Empty;
        private string _creator = string.Empty;
        private System.DateTime _createTime = DateTime.Now;


        #endregion

        #region Constructors
        public Dict() { }


        public Dict(string id, string name, string text, string parentID, int sortOrder, string description, string creator, System.DateTime createTime)
        {
            this.ID = id;
            this._name = name;
            this._text = text;
            this._parentID = parentID;
            this._sortOrder = sortOrder;
            this._description = description;
            this._creator = creator;
            this._createTime = createTime;
        }
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            sb.Append(this.GetType().FullName);
            sb.Append(_name);
            sb.Append(_text);
            sb.Append(_parentID);
            sb.Append(_sortOrder);
            sb.Append(_description);
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
        /// 字典名
        /// </summary>
        public virtual string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        /// <summary>
        /// 字典显示名
        /// </summary>
        public virtual string Text
        {
            get { return _text; }
            set { _text = value; }
        }

        /// <summary>
        /// 父字典
        /// </summary>
        public virtual string ParentID
        {
            get { return _parentID; }
            set { _parentID = value; }
        }

        /// <summary>
        /// 序号
        /// </summary>
        public virtual int SortOrder
        {
            get { return _sortOrder; }
            set { _sortOrder = value; }
        }

        /// <summary>
        /// 描述
        /// </summary>
        public virtual string Description
        {
            get { return _description; }
            set { _description = value; }
        }

        /// <summary>
        /// 创建者
        /// </summary>
        public virtual string Creator
        {
            get { return _creator; }
            set { _creator = value; }
        }

        /// <summary>
        /// 创建时间
        /// </summary>
        public virtual System.DateTime CreateTime
        {
            get { return _createTime.ToSafeDateTime(); }
            set { _createTime = value.ToSafeDateTime(); }
        }

        #endregion

        public virtual List<DictItem> DictItems
        {
            get;
            set;
        }
    }
}
