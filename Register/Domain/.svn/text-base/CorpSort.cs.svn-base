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
    public class CorpSort : DomainObject<string>
    {
         #region Fields

        private string _corpID = string.Empty;
        private string _corpName = string.Empty;
        private int _sortOrder=default(Int32);
       
        #endregion

        #region Constructors
		public CorpSort(){}


        public CorpSort(string corpID, string corpName, int sortOrder)
		{
            this._corpID = corpID;
            this._corpName = corpName;
            this._sortOrder = sortOrder;
       
		}
        #endregion

        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            
            sb.Append(this.GetType().FullName);
			sb.Append(_corpID);
			sb.Append(_corpName);
			sb.Append(_sortOrder);
           
            return sb.ToString().GetHashCode();
        }
		
		public virtual bool Validate()
        {
			return true;
        }

        #endregion

        #region Properties
	
		public virtual string CorpID
        {
            get { return _corpID; }
			set	{	_corpID =  value;}
        }
		
		
		public virtual string CorpName
        {
            get { return  _corpName; }
			set	{	_corpName =  value;}
        }
		
		public virtual int SortOrder
        {
            get { return  _sortOrder; }
			set	{	_sortOrder =  value;}
        }
        #endregion
    }
}
