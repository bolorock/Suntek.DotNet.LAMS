#region Description
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
using System.Data;
using System.Collections.Generic;
using log4net;

using EAFrame.Core;
using EAFrame.Core.Caching;
using EAFrame.Core.Service;
using EAFrame.Core.Enums;
using EAFrame.Core.DataFilter;
using SunTek.EAFrame.AuthorizeCenter.Domain;

namespace SunTek.EAFrame.AuthorizeCenter.Service
{
    public class EmployeeService : BaseService<string, Employee>
    {
        #region Fields
        private readonly ILog log = LogManager.GetLogger(typeof(EmployeeService));
        #endregion

        #region Constructors

        public EmployeeService() { }
        #endregion

        #region IEmployeeService Imp

        public DataTable GetEmployeeByOrg(IDictionary<string, object> parameters, PageInfo pageInfo)
        {
            string cmdText = string.Format("select T1.id,code,loginname,name,orgid from OM_Employee t1 join OM_EmployeeOrg t2 on t1.ID=t2.employeeid ");
            return repository.ExecuteDataTable<Employee>(cmdText, parameters);
        }

        public DataTable GetEmployeeByChief(int isChief, IDictionary<string, object> parameters, PageInfo pageinfo)
        {
            string cmdText = string.Format("select a.* from OM_Employee a join MM_CandidateManager b on a.Code=b.Code where b.Ischief={0} and b.CandidateManagerGrade='二级经理' and 1=1", isChief);
            return repository.ExecuteDataTable<Employee>(cmdText, parameters);
        }

        /// <summary>
        /// 获取所有后备经理
        /// </summary>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public DataTable GetEmployeeByCandidate(IDictionary<string, object> parameters, string layer, string corpID)
        {
            string cmdText = string.Empty;
            switch (layer)
            {
                case "1":
                    cmdText = "select a.* from OM_Employee a join MM_CandidateManager b on a.Code=b.Code " + (string.IsNullOrWhiteSpace(corpID) ? string.Empty : " where a.CorpID='" + corpID + "' and 1=1 ");
                    break;
                case "2":
                    cmdText = "select a.* from OM_Employee a join MM_CandidateManager b on a.Code=b.Code where CandidateManagerGrade='二级经理'" + (string.IsNullOrWhiteSpace(corpID) ? string.Empty : " and a.CorpID='" + corpID + "'") + " and 1=1 ";
                    break;
                case "3":
                    cmdText = "select a.* from OM_Employee a join MM_CandidateManager b on a.Code=b.Code where CandidateManagerGrade='三级经理'" + (string.IsNullOrWhiteSpace(corpID) ? string.Empty : " and a.CorpID='" + corpID + "'") + " and 1=1 ";
                    break;
            }
            return repository.ExecuteDataTable<Employee>(cmdText, parameters);
        }

        /// <summary>
        /// 获取专业公司，或分公司的所有后备
        /// </summary>
        /// <param name="parameters"></param>
        /// <param name="grade"></param>
        /// <param name="corpID"></param>
        /// <returns></returns>
        public DataTable GetEmployeeByParent(IDictionary<string, object> parameters, string grade, string corpID)
        {
            string cmdText = string.Format(@"select a.*,b.CandidatePostGrade from OM_Employee a join MM_CandidateManager b on a.Code=b.Code where 
                                        b.CandidateManagerGrade='{0}' and a.CorpID in
                            (select ID from OM_Organization where ParentID='{1}') and isChief=0 and  1=1", grade == "2" ? "二级经理" : "三级经理", corpID);
            return repository.ExecuteDataTable<Employee>(cmdText, parameters);
        }

        /// <summary>
        /// 获取部门下的后备
        /// </summary>
        /// <param name="parameters"></param>
        /// <param name="grade"></param>
        /// <param name="corpID"></param>
        /// <returns></returns>
        public DataTable GetEmployeeByCorpID(IDictionary<string, object> parameters, string grade, string corpID)
        {
            string cmdText = string.Format(@"select a.*,b.CandidatePostGrade from OM_Employee a join MM_CandidateManager b on a.Code=b.Code where
                                            b.CandidateManagerGrade='{0}' and a.CorpID='{1}' and isChief=0 and 1=1", grade == "2" ? "二级经理" : "三级经理", corpID);
            return repository.ExecuteDataTable<Employee>(cmdText, parameters);
        }

        /// <summary>
        /// 获取员工所属机构部门等级
        /// </summary>
        /// <param name="employeeID"></param>
        /// <returns></returns>
        public int GetEmployeeCorpGrade(string employeeID)
        {
            string cmdText = string.Format(@"select b.Grade from OM_Employee a join OM_Organization b on a.CorpID=b.ID where a.ID='{0}'", employeeID);
            object rtnValue = repository.ExecuteScalar<Employee>(cmdText);
            if (rtnValue != null)
            {
                return int.Parse(rtnValue.ToString());
            }
            else
            {
                return -1;
            }
        }

        public DataTable GetEmployeeByCodeOrName(string codes)
        {
            try
            {
                System.Text.StringBuilder cmdText = new System.Text.StringBuilder();
                cmdText.Append(string.Format(@"select ID,Code,LoginName,Name from OM_Employee"));
                if (codes.IndexOf(",")==-1)
                {
                    cmdText.Append(string.Format(" where code='{0}' or Name='{0}'", codes));
                }
                else
                {
                    cmdText.Append(string.Format(" where Code in ('{0}') or Name in ('{0}')", codes));
                }
                return repository.ExecuteDataTable<Employee>(cmdText.ToString());
            }
            catch (Exception ex)
            {
                log.Error("获取人员信息出错！", ex);
                return null;
            }
        }

        
        #endregion

        #region Internal Methods

        #endregion
    }
}