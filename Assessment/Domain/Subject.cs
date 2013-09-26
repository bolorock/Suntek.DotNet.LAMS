﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Assessment
 * Module:  Subject
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
    public partial class Subject : DomainObject<string>
    {
        #region Fields

        private string _subjectTitle = string.Empty;
        private short _subjectType = default(Int16);
        private short _category = default(Int16);
        private string _answer = string.Empty;
        private int _sortOrder = default(Int32);
        private int _defaultScore = default(Int32);
        private string _ownerOrg = string.Empty;
        private string _creator = string.Empty;

        private System.DateTime _createTime = DateTime.Now;
        private string _parentID = string.Empty;
        private string _mainSubjectID = string.Empty;

        private int _group = default(Int32);
        #endregion

        #region Constructors
        public Subject() { }


        public Subject(string id, string subjectTitle, short subjectType, short category, int sortOrder, string answer, int defaultScore, string ownerOrg, string creator, System.DateTime createTime, string mainSubjectID, string parentID,int group)
        {
            this.ID = id;
            this._subjectTitle = subjectTitle;
            this._subjectType = subjectType;
            this._category = category;
            this._answer = answer;
            this._defaultScore = defaultScore;
            this._ownerOrg = ownerOrg;
            this._creator = creator;
            this._createTime = createTime;
            this._parentID = parentID;
            this._sortOrder = sortOrder;
            this._mainSubjectID = mainSubjectID;
            this._group = group;
        }
        #endregion

        #region Methods



        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            sb.Append(this.GetType().FullName);
            sb.Append(_subjectTitle);
            sb.Append(_subjectType);
            sb.Append(_category);
            sb.Append(_answer);
            sb.Append(_defaultScore);
            sb.Append(_ownerOrg);
            sb.Append(_creator);
            sb.Append(_createTime);
            sb.Append(_parentID);
            sb.Append(_sortOrder);
            sb.Append(_mainSubjectID);
            sb.Append(_group);
            return sb.ToString().GetHashCode();
        }

        public virtual bool Validate()
        {
            return true;
        }

        #endregion

        #region Properties

        /// <summary>
        /// 题目标题
        /// </summary>
        public virtual string SubjectTitle
        {
            get { return _subjectTitle; }
            set { _subjectTitle = value; }
        }
        /// <summary>
        /// 题目标题
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
        /// 单选=1;
        ///多选=2;
        ///填空=3;
        /// 问答=4;
        /// </summary>
        public virtual short SubjectType
        {
            get { return _subjectType; }
            set { _subjectType = value; }
        }

        /// <summary>
        /// 360测评=1;
        ///动机测评=2;
        ///团队效能测评=3;
        /// 优势与特点测评=4;
        /// Disc测评=5;
        /// 情景模拟=21;
        /// 案例分析=22;
        /// 关键事件访谈=23;
        /// </summary>
        public virtual short Category
        {
            get { return _category; }
            set { _category = value; }
        }

        /// <summary>
        /// 参考答案
        /// </summary>
        public virtual string Answer
        {
            get { return _answer; }
            set { _answer = value; }
        }

        /// <summary>
        /// 默认分值
        /// </summary>
        public virtual int DefaultScore
        {
            get { return _defaultScore; }
            set { _defaultScore = value; }
        }

        /// <summary>
        /// 归属组织
        /// </summary>
        public virtual string OwnerOrg
        {
            get { return _ownerOrg; }
            set { _ownerOrg = value; }
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

        public virtual List<SubjectItem> SubjectItems
        {
            get;
            set;
        }

        public virtual List<Subject> SubSubjects
        {
            get;
            set;
        }

        /// <summary>
        /// 大题
        /// </summary>
        public virtual string MainSubjectID
        {
            get;
            set;
        }


        /// <summary>
        /// 分组
        /// </summary>
        public virtual int GroupNumber
        {
            get { return _group; }
            set { _group = value; }
        }

		
    }
}
