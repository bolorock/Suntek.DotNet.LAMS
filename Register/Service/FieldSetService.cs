using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using log4net;

using EAFrame.Core;
using EAFrame.Core.Data;
using EAFrame.Core.Caching;
using EAFrame.Core.Service;
using EAFrame.Core.Enums;
using EAFrame.Core.DataFilter;
using SunTek.Register.Domain;
using EAFrame.Core.Extensions;

namespace SunTek.Register.Service
{
    public class FieldSetService : BaseService<string, FieldSet>
    {
        #region Fields
        private readonly ILog log = LogManager.GetLogger(typeof(FieldSetService));
        #endregion

        #region Constructors

        public FieldSetService() { }
        #endregion

        #region IDiplomaService Imp

        #endregion

        #region Internal Methods
        /// <summary>
        /// 获取字段设置显示的字段
        /// </summary>
        /// <returns></returns>
        public string GetFieldSet()
        {
            string cmdText = @"select FieldCode + ',' from Re_FieldSet where IsShow=1 order by SortOrder for xml path('')";
            return repository.ExecuteScalar<FieldSet>(cmdText).ToString();
        }

        /// <summary>
        /// 批量删除字段 
        /// </summary>
        /// <param name="ids"></param>
        public void RemoveFields(string ids)
        {
            string cmdText = string.Format(@"update Re_FieldSet set IsShow=0 where ID in ({0})", ids);
            repository.ExecuteNonQuery<FieldSet>(cmdText);
        }

        /// <summary>
        /// 清除所有字段
        /// </summary>
        public void RemoveFieldAll()
        {
            string cmdText = "update Re_FieldSet set IsShow=0,SortOrder=-1";
            repository.ExecuteNonQuery<FieldSet>(cmdText);
            
        }

        #endregion
    }
}
