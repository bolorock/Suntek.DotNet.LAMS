﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: Assessment
 * Module:  AnswerRecord
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
    public partial class MarkItem :DomainObject<string>
    {
        #region Fields
		
		private string _assessmentResultID = string.Empty;
		private string _subjectID = string.Empty;
		private double _score = default(Double);
		private string _scorer = string.Empty;
		private System.DateTime _scoreTime = DateTime.Now;
        private string _comment = string.Empty;
        #endregion

        #region Constructors
		public MarkItem(){}


        public MarkItem(string id, string assessmentResultID, string subjectID, double score, string scorer, System.DateTime scoreTime, string comment)
		{
		  this.ID=id;
		this._assessmentResultID=assessmentResultID;
		this._subjectID=subjectID;
		this._score=score;
		this._scorer=scorer;
		this._scoreTime=scoreTime;
        this._comment = comment;
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
			sb.Append(_assessmentResultID);
			sb.Append(_subjectID);
			
			sb.Append(_score);
			sb.Append(_scorer);
			sb.Append(_scoreTime);
			sb.Append(_comment);
		
            return sb.ToString().GetHashCode();
        }
		
		public virtual bool Validate()
        {
			return true;
        }

        #endregion

        #region Properties
		
		/// <summary>
        /// 测评结果ID
        /// </summary>
		public virtual string AssessmentResultID
        {
            get { return  _assessmentResultID; }
			set	{	_assessmentResultID =  value;}
        }
		
		/// <summary>
        /// 题目ID
        /// </summary>
		public virtual string SubjectID
        {
            get { return  _subjectID; }
			set	{	_subjectID =  value;}
        }
		
		
		/// <summary>
        /// 得分
        /// </summary>
		public virtual double Score
        {
            get { return  _score; }
			set	{	_score =  value;}
        }
		
		/// <summary>
        /// 评分人
        /// </summary>
		public virtual string Scorer
        {
            get { return  _scorer; }
			set	{	_scorer =  value;}
        }
		
		/// <summary>
        /// 评分时间
        /// </summary>
		public virtual System.DateTime ScoreTime
        {
            get { return  _scoreTime.ToSafeDateTime(); }
			set	{	_scoreTime =  value.ToSafeDateTime();}
        }


        /// <summary>
        /// 测评评语
        /// </summary>
        public virtual string Comment
        {
            get { return _comment; }
            set { _comment = value; }
        }


        #endregion
    }
}
