﻿#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: AuthorizeCenter
 * Module:  Employee
 * Descrption:
 * CreateDate: 2010/11/18 13:55:36
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
    public partial class Employee :DomainObject<string>
    {
        #region Fields
		
		private string _code = string.Empty;
		private string _loginName = string.Empty;
		private string _name = string.Empty;
		private string _operatorID = string.Empty;
		private short _gender = default(Int16);
		private System.DateTime _birthday = DateTime.Now;
		private string _nation = string.Empty;
		private string _birthplace = string.Empty;
		private string _nativeplace = string.Empty;
		private string _politicsStatus = string.Empty;
		private System.DateTime _workFromDate = DateTime.Now;
		private string _healthStatus = string.Empty;
		private string _industrialGrade = string.Empty;
		private string _speciality = string.Empty;
		private string _positionName = string.Empty;
		private string _position = string.Empty;
		private string _postGrade = string.Empty;
		private short _status = default(Int16);
		private short _cardType = default(Int16);
		private string _cardNo = string.Empty;
		private System.DateTime _inDate = DateTime.Now;
		private System.DateTime _outDate = DateTime.Now;
		private string _zipCode = string.Empty;
		private string _email = string.Empty;
		private string _fax = string.Empty;
		private string _mobile = string.Empty;
		private string _mSN = string.Empty;
		private string _officePhone = string.Empty;
		private string _address = string.Empty;
		private string _director = string.Empty;
		private string _majorOrgID = string.Empty;
		private string _photo = string.Empty;
		private string _creator = string.Empty;
		private System.DateTime _createTime = DateTime.Now;
        private string _corpID = string.Empty;
		
		
        #endregion

        #region Constructors
		public Employee(){}
		
		
		public Employee(string id,string code,string loginName,string name,string operatorID,short gender,System.DateTime birthday,string nation,string birthplace,string nativeplace,string politicsStatus,System.DateTime workFromDate,string healthStatus,string industrialGrade,string speciality,string positionName,string position,string postGrade,short status,short cardType,string cardNo,System.DateTime inDate,System.DateTime outDate,string zipCode,string email,string fax,string mobile,string mSN,string officePhone,string address,string director,string majorOrgID,string photo,string creator,System.DateTime createTime,string corpID)
		{
		  this.ID=id;
		this._code=code;
		this._loginName=loginName;
		this._name=name;
		this._operatorID=operatorID;
		this._gender=gender;
		this._birthday=birthday;
		this._nation=nation;
		this._birthplace=birthplace;
		this._nativeplace=nativeplace;
		this._politicsStatus=politicsStatus;
		this._workFromDate=workFromDate;
		this._healthStatus=healthStatus;
		this._industrialGrade=industrialGrade;
		this._speciality=speciality;
		this._positionName=positionName;
		this._position=position;
		this._postGrade=postGrade;
		this._status=status;
		this._cardType=cardType;
		this._cardNo=cardNo;
		this._inDate=inDate;
		this._outDate=outDate;
		this._zipCode=zipCode;
		this._email=email;
		this._fax=fax;
		this._mobile=mobile;
		this._mSN=mSN;
		this._officePhone=officePhone;
		this._address=address;
		this._director=director;
		this._majorOrgID=majorOrgID;
		this._photo=photo;
		this._creator=creator;
		this._createTime=createTime;
        this._corpID = corpID;
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
			sb.Append(_code);
			sb.Append(_loginName);
			sb.Append(_name);
			sb.Append(_operatorID);
			sb.Append(_gender);
			sb.Append(_birthday);
			sb.Append(_nation);
			sb.Append(_birthplace);
			sb.Append(_nativeplace);
			sb.Append(_politicsStatus);
			sb.Append(_workFromDate);
			sb.Append(_healthStatus);
			sb.Append(_industrialGrade);
			sb.Append(_speciality);
			sb.Append(_positionName);
			sb.Append(_position);
			sb.Append(_postGrade);
			sb.Append(_status);
			sb.Append(_cardType);
			sb.Append(_cardNo);
			sb.Append(_inDate);
			sb.Append(_outDate);
			sb.Append(_zipCode);
			sb.Append(_email);
			sb.Append(_fax);
			sb.Append(_mobile);
			sb.Append(_mSN);
			sb.Append(_officePhone);
			sb.Append(_address);
			sb.Append(_director);
			sb.Append(_majorOrgID);
			sb.Append(_photo);
			sb.Append(_creator);
			sb.Append(_createTime);
            sb.Append(_corpID);

            return sb.ToString().GetHashCode();
        }
		
		public virtual bool Validate()
        {
			return true;
        }

        #endregion

        #region Properties
		
		/// <summary>
        /// 人员代码
        /// </summary>
		public virtual string Code
        {
            get { return  _code; }
			set	{	_code =  value;}
        }
		
		/// <summary>
        /// 登陆名
        /// </summary>
		public virtual string LoginName
        {
            get { return  _loginName; }
			set	{	_loginName =  value;}
        }
		
		/// <summary>
        /// 人员姓名
        /// </summary>
		public virtual string Name
        {
            get { return  _name; }
			set	{	_name =  value;}
        }
		
		/// <summary>
        /// 操作员ID
        /// </summary>
		public virtual string OperatorID
        {
            get { return  _operatorID; }
			set	{	_operatorID =  value;}
        }
		
		/// <summary>
        /// 性别
        /// </summary>
		public virtual short Gender
        {
            get { return  _gender; }
			set	{	_gender =  value;}
        }
		
		/// <summary>
        /// 出生日期
        /// </summary>
		public virtual System.DateTime Birthday
        {
            get { return  _birthday.ToSafeDateTime(); }
			set	{	_birthday =  value.ToSafeDateTime();}
        }
		
		/// <summary>
        /// 民族
        /// </summary>
		public virtual string Nation
        {
            get { return  _nation; }
			set	{	_nation =  value;}
        }
		
		/// <summary>
        /// 出生地
        /// </summary>
		public virtual string Birthplace
        {
            get { return  _birthplace; }
			set	{	_birthplace =  value;}
        }
		
		/// <summary>
        /// 籍贯
        /// </summary>
		public virtual string Nativeplace
        {
            get { return  _nativeplace; }
			set	{	_nativeplace =  value;}
        }
		
		/// <summary>
        /// 政治面貌
        /// </summary>
		public virtual string PoliticsStatus
        {
            get { return  _politicsStatus; }
			set	{	_politicsStatus =  value;}
        }
		
		/// <summary>
        /// 参加工作时间
        /// </summary>
		public virtual System.DateTime WorkFromDate
        {
            get { return  _workFromDate.ToSafeDateTime(); }
			set	{	_workFromDate =  value.ToSafeDateTime();}
        }
		
		/// <summary>
        /// 健康状况
        /// </summary>
		public virtual string HealthStatus
        {
            get { return  _healthStatus; }
			set	{	_healthStatus =  value;}
        }
		
		/// <summary>
        /// 专业技术职务
        /// </summary>
		public virtual string IndustrialGrade
        {
            get { return  _industrialGrade; }
			set	{	_industrialGrade =  value;}
        }
		
		/// <summary>
        /// 特长
        /// </summary>
		public virtual string Speciality
        {
            get { return  _speciality; }
			set	{	_speciality =  value;}
        }
		
		/// <summary>
        /// 岗位名称
        /// </summary>
		public virtual string PositionName
        {
            get { return  _positionName; }
			set	{	_positionName =  value;}
        }
		
		/// <summary>
        /// 基本岗位
        /// </summary>
		public virtual string Position
        {
            get { return  _position; }
			set	{	_position =  value;}
        }
		
		/// <summary>
        /// 岗位等级
        /// </summary>
		public virtual string PostGrade
        {
            get { return  _postGrade; }
			set	{	_postGrade =  value;}
        }
		
		/// <summary>
        /// 状态
        /// </summary>
		public virtual short Status
        {
            get { return  _status; }
			set	{	_status =  value;}
        }
		
		/// <summary>
        /// 证件类型
        /// </summary>
		public virtual short CardType
        {
            get { return  _cardType; }
			set	{	_cardType =  value;}
        }
		
		/// <summary>
        /// 证件号码
        /// </summary>
		public virtual string CardNo
        {
            get { return  _cardNo; }
			set	{	_cardNo =  value;}
        }
		
		/// <summary>
        /// 入职日期
        /// </summary>
		public virtual System.DateTime InDate
        {
            get { return  _inDate.ToSafeDateTime(); }
			set	{	_inDate =  value.ToSafeDateTime();}
        }
		
		/// <summary>
        /// 离职日期
        /// </summary>
		public virtual System.DateTime OutDate
        {
            get { return  _outDate.ToSafeDateTime(); }
			set	{	_outDate =  value.ToSafeDateTime();}
        }
		
		/// <summary>
        /// 邮编
        /// </summary>
		public virtual string ZipCode
        {
            get { return  _zipCode; }
			set	{	_zipCode =  value;}
        }
		
		/// <summary>
        /// Email
        /// </summary>
		public virtual string Email
        {
            get { return  _email; }
			set	{	_email =  value;}
        }
		
		/// <summary>
        /// 传真号码
        /// </summary>
		public virtual string Fax
        {
            get { return  _fax; }
			set	{	_fax =  value;}
        }
		
		/// <summary>
        /// 手机号码
        /// </summary>
		public virtual string Mobile
        {
            get { return  _mobile; }
			set	{	_mobile =  value;}
        }
		
		/// <summary>
        /// MSN号码
        /// </summary>
		public virtual string MSN
        {
            get { return  _mSN; }
			set	{	_mSN =  value;}
        }
		
		/// <summary>
        /// 办公电话
        /// </summary>
		public virtual string OfficePhone
        {
            get { return  _officePhone; }
			set	{	_officePhone =  value;}
        }
		
		/// <summary>
        /// 住址
        /// </summary>
		public virtual string Address
        {
            get { return  _address; }
			set	{	_address =  value;}
        }
		
		/// <summary>
        /// 直接主管
        /// </summary>
		public virtual string Director
        {
            get { return  _director; }
			set	{	_director =  value;}
        }
		
		/// <summary>
        /// 主机构ID
        /// </summary>
		public virtual string MajorOrgID
        {
            get { return  _majorOrgID; }
			set	{	_majorOrgID =  value;}
        }
		
		/// <summary>
        /// 照片
        /// </summary>
		public virtual string Photo
        {
            get { return  _photo; }
			set	{	_photo =  value;}
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
        /// 公司ID
        /// </summary>
        public virtual string CorpID
        {
            get { return _corpID; }
            set { _corpID = value; }
        }

        public virtual string OwnerOrg { get; set; }
        #endregion
    }
}
