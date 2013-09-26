using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EAFrame.Core.Domain;
using EAFrame.Core.Extensions;
using Newtonsoft.Json;
using Iesi.Collections.Generic;

namespace SunTek.Register.Domain
{
    public class FieldSet : DomainObject<string>
    {
        
         #region Fields

        private string _fieldCode = string.Empty;
        private string _fieldShow = string.Empty;
        private string _description=string.Empty;
        private short _isShow = default(short);
        private int _sortOrder=default(Int32);
        private int _width = default(Int32);
       
        #endregion

        #region Constructors
		public FieldSet(){}


        public FieldSet(string fieldCode, string fieldShow, string description,short isShow,int sortOrder,int width)
		{
            this._fieldCode = fieldCode;
            this._fieldShow = fieldShow;
            this._description = description;
            this._isShow = isShow;
            this._sortOrder = sortOrder;
            this._width = width;
       
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
			sb.Append(_fieldCode);
			sb.Append(_fieldShow);
			sb.Append(_isShow);
            sb.Append(_sortOrder);
            sb.Append(_width);
           
            return sb.ToString().GetHashCode();
        }
		
		public virtual bool Validate()
        {
			return true;
        }

        #endregion

        #region Properties
	
		public virtual string FieldCode
        {
            get { return _fieldCode; }
			set	{	_fieldCode =  value;}
        }
		
		
		public virtual string FieldShow
        {
            get { return _fieldShow; }
			set	{	_fieldShow =  value;}
        }

        public virtual string Description
        {
            get { return _description; }
            set { _description = value; }
        }

        public virtual short IsShow
        {
            get { return _isShow; }
            set { _isShow = value; }
        }

		public virtual int SortOrder
        {
            get { return  _sortOrder; }
			set	{	_sortOrder =  value;}
        }

        public virtual int Width
        {
            get { return _width; }
            set { _width = value; }
        }
        #endregion
    }
}
