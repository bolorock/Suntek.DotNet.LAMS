using System;
using System.Data;
using System.Collections.Generic;
using log4net;
using System.Linq;

using EAFrame.Core;
using EAFrame.Core.Extensions;
using EAFrame.Core.Data;
using EAFrame.Core.Caching;
using EAFrame.Core.Service;
using EAFrame.Core.Enums;
using EAFrame.Core.DataFilter;
using SunTek.LAMS.Domain;
using SunTek.EAFrame.AuthorizeCenter.Domain;

namespace SunTek.LAMS.Service
{
    public class EmployeeModelService : BaseService<string, EmployeeModel>
    {
        #region Fields
        private static readonly ILog log = LogManager.GetLogger(typeof(EmployeeModelService));
        #endregion

        #region Constructors
        public EmployeeModelService() { }
        #endregion

        #region IEmployeeModelService Imp
        /// <summary>
        /// 删除人员基本信息
        /// </summary>
        /// <param name="employeeID"></param>
        public void DeleteEmployeeModel(string employeeID,string id)
        {
            using (ITransaction trans = UnitOfWork.BeginTransaction(typeof(Employee)))
            {
                Dictionary<string, object> dic=new Dictionary<string,object>();
                dic.Add("EmployeeID", employeeID);
                repository.Delete<CandidateManager>(id);
                repository.Delete<Diploma>(dic);
                //repository.Delete<PostExperience>(dic);
                //repository.Delete<FamilyMember>(dic);
                repository.Delete<Resume>(dic);
                repository.Delete<CandidateDetail>(dic);
                repository.Delete<Employee>(employeeID);
                trans.Commit();
            }
        }

        /// <summary>
        ///  保存人员基本信息
        /// </summary>
        /// <param name="model"></param>
        public void SaveEmployeeModel(EmployeeModel model)
        {
            string errMsg = string.Empty;
            Dictionary<string,object> dic=new Dictionary<string,object>();
            dic.Add("EmployeeID",model.ID);

            using (ITransaction trans = UnitOfWork.BeginTransaction(typeof(Employee)))
            {
                //人员基本信息
                repository.SaveOrUpdate(new Employee()
                 {
                     Address = model.Address,
                     Birthday = model.Birthday,
                     Birthplace = model.Birthplace,
                     CardNo = model.CardNo,
                     CardType = model.CardType,
                     Code = model.Code,
                     CorpID=model.CorpID,
                     CreateTime = DateTime.Now,
                     Creator = model.Creator,
                     Director = model.Director,
                     Email = model.Email,
                     Fax = model.Fax,
                     Gender = model.Gender,
                     HealthStatus = model.HealthStatus,
                     ID = model.ID,
                     InDate = model.InDate,
                     IndustrialGrade = model.IndustrialGrade,
                     LoginName = model.LoginName,
                     MajorOrgID = model.MajorOrgID,
                     Mobile = model.Mobile,
                     MSN = model.Mobile,
                     Name = model.Name,
                     Nation = model.Nation,
                     Nativeplace = model.Nativeplace,
                     OfficePhone = model.OfficePhone,
                     OperatorID = model.OperatorID,
                     OutDate = model.OutDate,
                     Photo = model.Photo,
                     PoliticsStatus = model.PoliticsStatus,
                     Position = model.Position,
                     PositionName = model.PositionName,
                     PostGrade = model.PostGrade,
                     Speciality = model.Speciality,
                     Status = model.Status,
                     WorkFromDate = model.WorkFromDate,
                     ZipCode = model.ZipCode
                 });

                //学历学位
                DiplomaService dip = new DiplomaService();
                IList<Diploma> diplomas=dip.FindAll(dic);
                if (diplomas.Count > 0)
                    diplomas.ForEach(o => dip.Delete(o));//存在的先删除
                    
                foreach (var item in model.Diplomas)
                {
                    item.ID = IdGenerator.NewComb().ToString();
                    item.Creator = model.Creator;
                    item.CreateTime = model.CreateTime;
                    item.EmployeeID = model.ID;
                    repository.SaveOrUpdate(item);
                }

                //简历
                ResumeService resume = new ResumeService();
                if (resume.FindAll(dic).Count > 0)
                    resume.Delete(dic);
                foreach (var item in model.Resumes)
                {
                    if (item.StartDate != null && item.StartDate != string.Empty)
                    {
                        item.ID = IdGenerator.NewComb().ToSafeString();
                        item.Creator = model.Creator;
                        item.CreateTime = model.CreateTime;
                        item.EmployeeID = model.ID;
                        repository.SaveOrUpdate(item);
                    }
                }

                //选拔推荐情况
                CandidateDetailService candidateDetail = new CandidateDetailService();
                Dictionary<string, object> dicDetail = new Dictionary<string, object>();
                dicDetail.Add("Code", model.Code);
                if (candidateDetail.FindAll(dicDetail).Count > 0)
                    candidateDetail.Delete(dicDetail);
                foreach (var item in model.CandidateDetails)
                {
                    item.ID = IdGenerator.NewComb().ToSafeString();
                    item.CreateTime = model.CreateTime;
                    item.Creator = model.Creator;
                    item.Code = model.Code;
                    repository.SaveOrUpdate(item);
                }

                //update后备资格表的状态
                CandidateManagerService candidate = new CandidateManagerService();
                CandidateManager candidateManager=new CandidateManager();
                CandidateManager entity=model.CandidateManagers[0];
                Dictionary<string,object> parameters=new Dictionary<string,object>();
                parameters.Add("Code",model.Code);
                parameters.Add("Status", new Condition(" Status<3 "));
                IList<CandidateManager> list=candidate.FindAll(parameters);
                if (list.Count == 1)
                {
                    candidateManager = list[0];
                    candidateManager.InPostDate = (Convert.ToDateTime(entity.InPostDate)).ToString("yyyy-MM-dd");
                    candidateManager.InGradeDate = (Convert.ToDateTime(entity.InGradeDate)).ToString("yyyy-MM-dd");
                    candidateManager.TargetCandidate=entity.TargetCandidate;
                    candidateManager.CandidateMaturity=entity.CandidateMaturity;
                    candidateManager.Status = 2;
                    candidate.Update(candidateManager);
                }
                else //存在同一人多条后备信息情况
                {
                    var p = from q in list
                            where q.TargetCandidate == entity.TargetCandidate && q.CandidateMaturity == entity.CandidateMaturity
                            select q;
                   
                    if (p.Count() == 0)
                    {
                        errMsg = string.Format("不存在({0})【后备方向】为\"{1}\",【后备成熟度】为\"{2}\"的后备经历人！", model.Name, entity.TargetCandidate,entity.CandidateMaturity);
                        throw new Exception(errMsg);
                    }
                    foreach (var m in p)
                    {
                        candidateManager = m.Cast<CandidateManager>(null);
                        candidateManager.InPostDate = (Convert.ToDateTime(entity.InPostDate)).ToString("yyyy-MM-dd");
                        candidateManager.InGradeDate = (Convert.ToDateTime(entity.InGradeDate)).ToString("yyyy-MM-dd");
                        candidateManager.Status = 2;
                        candidate.Update(candidateManager);
                    }
                }
                trans.Commit();
            }
        }
        #endregion

        #region Internal Methods

        #endregion
    }
}
