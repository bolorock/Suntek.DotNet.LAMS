#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: AuthorizeCenter
 * Module:  Operator
 * Descrption:
 * CreateDate: 2010/11/18 13:55:34
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
using System.Data;
using System.Collections.Generic;
using System.Linq;
using log4net;

using EAFrame.Core;
using EAFrame.Core.Data;
using EAFrame.Core.Caching;
using EAFrame.Core.Service;
using EAFrame.Core.Enums;
using EAFrame.Core.DataFilter;
using EAFrame.Core.Extensions;
using SunTek.EAFrame.AuthorizeCenter.Domain;

namespace SunTek.EAFrame.AuthorizeCenter.Service
{
    public class OperatorService : BaseService<string, Operator>
    {
        #region Fields
        private readonly ILog log = LogManager.GetLogger(typeof(OperatorService));
        #endregion

        #region Constructors

        public OperatorService() { }
        #endregion

        public DataTable GetOperatorByOrg(IDictionary<string, object> parameters, PageInfo pageInfo,string filter1="",string filter2="")
        {
            string filter = " where 1=1 ";
            if (!string.IsNullOrEmpty(filter1))
            {
                filter += filter1;
            }
            if (!string.IsNullOrEmpty(filter2))
            {
                filter += @" and t1.ID in (select distinct ObjectID from OM_ObjectRole a join AC_Role b on a.RoleID=b.ID where 1=1 ";
                filter += filter2;
                filter += ")";
            }
            filter += " and 1=1";

                string cmdText = string.Format(@"
select  T1.id,UserName,loginname,t2.OrgID,t3.Name as Department,t4.Name as CorpName,
stuff((select ','+b.Name from OM_ObjectRole a  left join AC_Role b on a.RoleID=b.ID
where ObjectID=t1.ID  for xml path('')),1,1,'') as RoleName
from AC_Operator t1 
left join OM_EmployeeOrg t2 on t1.ID=t2.employeeid
left join OM_Organization t3 on t3.ID=t2.OrgID  
left join OM_Organization t4 on t4.ID=t3.CorpID {0}", filter);
                return repository.ExecuteDataTable<Operator>(cmdText, parameters, pageInfo);
            
          
            
            
        }

        /// <summary>
        /// 根据用户取得相应的页面权限（已经处理特殊权限）
        /// </summary>
        /// <param name="userID">用户ID</param>
        /// <returns></returns>
        public List<string> GetPrivilegeIDs(string userID)
        {
            List<string> privilegeIDs = GetAllPrivilegeIDs(userID);
            //特殊权限添加
            List<SpecialPrivilege> specialPrivileges = new SpecialPrivilegeService().All().Where(o => o.OperatorID.Equals(userID, StringComparison.OrdinalIgnoreCase)).ToList();

            foreach (SpecialPrivilege item in specialPrivileges.ToList())
            {
                if (item.AuthFlag == 1)
                {
                    if (!privilegeIDs.Contains(item.PrivilegeID))
                        privilegeIDs.Add(item.PrivilegeID);
                }
                else if (item.AuthFlag == 2)
                {
                    privilegeIDs.Remove(item.PrivilegeID);
                }
            }

            return privilegeIDs;
        }

        /// <summary>
        /// 根据用户取得相应的页面权限（未处理特殊权限）
        /// </summary>
        /// <param name="userID">用户ID</param>
        /// <returns></returns>
        public List<string> GetAllPrivilegeIDs(string userID)
        {
            DataTable dt = repository.ExecuteDataTable<Operator>(string.Format(@"select c.PrivilegeID from AC_RolePrivilege c where c.RoleID in
                                                                        (select d.RoleID from OM_ObjectRole d where d.ObjectID='{0}')", userID)) ?? new DataTable();
            return dt.AsEnumerable().Select(dr => dr["PrivilegeID"].ToSafeString()).ToList();

        }


        /// <summary>
        /// 获取用户数据权限
        /// </summary>
        /// <param name="userID">用户ID</param>
        /// <returns></returns>
        public List<string> GetDataPriveleges(string userID)
        {
            DataTable dt = repository.ExecuteDataTable<Operator>(string.Format(@"select  Value from AC_MetaData a where a.ID in
                                                                        (select b.MetaDataID from AC_Privilege b where b.ID in 
                                                                        (select c.PrivilegeID from AC_RolePrivilege c where c.RoleID in
                                                                        (select d.RoleID from OM_ObjectRole d where d.ObjectID='{0}')))", userID)) ?? new DataTable();
            return dt.AsEnumerable().Select(dr => dr["Value"].ToSafeString()).ToList();
        }


        #region IOperatorService Imp


        #endregion

        #region Internal Methods

        #endregion
    }
}