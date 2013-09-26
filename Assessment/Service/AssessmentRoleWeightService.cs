#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: EAFrame.Assessment
 * Module:  AssessmentRole
 * Descrption:
 * CreateDate: 2011-1-27 10:50:43
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
using SunTek.Assessment.Domain;
using EAFrame.Core.Data;

namespace SunTek.Assessment.Service
{
    public class AssessmentRoleWeightService :  BaseService<string,AssessmentRoleWeight>
    {
		#region Fields
		private readonly ILog log = LogManager.GetLogger(typeof(AssessmentRoleWeightService));
		#endregion
		
		#region Constructors

        public AssessmentRoleWeightService() { }
		#endregion

        #region IAssessmentRoleWeightService Imp

        /// <summary>
        /// ȡ�ò������صĽ�ɫ
        /// </summary>
        /// <param name="surveyID"></param>
        /// <returns></returns>
        public DataTable GetRoleBySurveyID(string surveyID)
        {
            if (string.IsNullOrWhiteSpace(surveyID)) return new DataTable();
            DataTable dt = repository.ExecuteDataTable<AssessmentRoleWeight>(string.Format(@"select t1.ID,t1.RoleID,t1.SurveyID,t1.[Weight],t3.Value  
from LA_AssessmentRoleWeight t1,AB_Dict t4,AB_DictItem t3 where t4.Name='AssessRole' and t4.ID=t3.DictID and t1.RoleID=t3.ID and t1.SurveyID='{0}'
", surveyID)) ?? new DataTable();
            return dt;
        }

        /// <summary>
        /// ȡ��ɫ�б���˳�����Ѿ���Ȩ����ϢҲ��ȡ����
        /// </summary>
        /// <param name="surveyID"></param>
        /// <returns></returns>
        public DataTable GetRoleList(string surveyID)
        {
            if (string.IsNullOrWhiteSpace(surveyID)) return new DataTable();
            DataTable dt = repository.ExecuteDataTable<AssessmentRoleWeight>(string.Format(@"select t1.ID,t1.Value as name,ISNULL(t2.[Weight],0) [Weight],t2.surveyID from
(
select t3.ID,t3.Value  
from AB_Dict t4,AB_DictItem t3 where t4.Name='AssessRole' and t4.ID=t3.DictID
) as t1
left join LA_AssessmentRoleWeight t2
on t1.ID=t2.RoleID and t2.SurveyID='{0}'
", surveyID)) ?? new DataTable();
            return dt;
        }

        public void SaveRoleWeight(IList<AssessmentRoleWeight> roleWeights,string surveyID)
        {

            using (ITransaction trans = UnitOfWork.BeginTransaction(typeof(AssessmentRoleWeight)))
            {
                //ɾ���Ѿ����ڵ�
                repository.ExecuteSql<AssessmentRoleWeight>(string.Format("delete from LA_AssessmentRoleWeight where SurveyID='{0}'", surveyID));

                foreach (var p in roleWeights)
                {
                    repository.SaveOrUpdate(p);
                }
                trans.Commit();
            }
            ClearCache(typeof(AssessmentRoleWeight));
        }




        #endregion
		
		#region Internal Methods

        #endregion
    }
}