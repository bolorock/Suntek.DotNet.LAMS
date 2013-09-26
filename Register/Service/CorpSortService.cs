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
    public class CorpSortService : BaseService<string, CorpSort>
    {
        #region Fields
        private readonly ILog log = LogManager.GetLogger(typeof(CorpSortService));
        #endregion

        #region Constructors

        public CorpSortService() { }
        #endregion

        #region IDiplomaService Imp

        #endregion

        #region Internal Methods
        public void DeleteAll()
        {
            string cmdText = "truncate table Re_CorpSort";
            try
            {
                repository.ExecuteSql<CorpSort>(cmdText);
            }
            catch (Exception ex)
            {
                log.Error("删除所有数据出错.", ex);
                throw ex;
            }
        }
        
        /// <summary>
        /// 删除一条记录并对后面记录重新编号
        /// </summary>
        /// <param name="domain"></param>
        public void Delete(CorpSort domain)
        {
            UnitOfWork.ExecuteWithTrans<SunTek.Register.Domain.CorpSort>(() =>
            {
                base.Delete(domain);
                string cmdText = string.Format(@"update Re_CorpSort set SortOrder=SortOrder-1 where SortOrder>{0}", domain.SortOrder);
                repository.ExecuteSql<CorpSort>(cmdText);
            });
        }
        #endregion
    }
}
