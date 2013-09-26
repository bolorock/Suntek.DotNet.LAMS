﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: EAFrame.Assessment
 * Module:  MainSubject
 * Descrption:
 * CreateDate: 2011-1-27 10:50:45
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
    public partial class MainSubject :DomainObject<string>
    {
        #region Fields

        private string _title = string.Empty;
		private string _examPaperID = string.Empty;
		private int _score = default(Int32);
		private int _sortOrder = default(Int32);
		
		
        #endregion

        #region Constructors
		public MainSubject(){}


        public MainSubject(string id, string title, string examPaperID, int score, int sortOrder)
		{
		  this.ID=id;
          this._title = title;
		this._examPaperID=examPaperID;
		this._score=score;
		this._sortOrder=sortOrder;
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
            sb.Append(_title);
			sb.Append(_examPaperID);
			sb.Append(_score);
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
        /// 标题
        /// </summary>
		public virtual string Title
        {
            get { return   _title; }
            set { _title = value; }
        }
		
		/// <summary>
        /// 试卷ID
        /// </summary>
		public virtual string ExamPaperID
        {
            get { return  _examPaperID; }
			set	{	_examPaperID =  value;}
        }
		
		/// <summary>
        /// 大题分值
        /// </summary>
		public virtual int Score
        {
            get { return  _score; }
			set	{	_score =  value;}
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

        public virtual List<ExamPaperSubject> ExamPaperSubjects
        {
            get;
            set;
        }
    }
}
