using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using log4net;

using SunTek.EAFrame.Core.Extensions;
using SunTek.EAFrame.Core;
using SunTek.EAFrame.Core.Data;
using SunTek.LAMS.Domain;
using SunTek.EAFrame.AuthorizeCenter.Domain;
namespace SunTek.LAMS.Repository
{
    public class EmployeeModelRepository : Repository<string, Resume>
    {
        #region Fields
        private static readonly ILog log = LogManager.GetLogger(typeof(ResumeRepository));
        #endregion

        #region Constructors
        public EmployeeModelRepository() { }
        #endregion

        #region IResumeRepository Imp

        public bool SaveEmployeeModel(EmployeeModel model)
        {
            try
            {
                Session.BeginTransaction();

                //人员基本信息
                Session.SaveOrUpdate(new Employee()
                {
                    Address = model.Address,
                    Birthday = model.Birthday,
                    Birthplace = model.Birthplace,
                    CardNo = model.CardNo,
                    CardType = model.CardType,
                    Code = model.Code,
                    CreateTime = DateTime.Now,
                    Creator = model.Creator,
                    Director = model.Director,
                    Email = model.Email,
                    Fax = model.Fax,
                    Gender = model.Gender,
                    HealthStatus = model.HealthStatus,
                    ID = model.ID,
                    InDate = model.InDate,
                    IndustrialGrade=model.IndustrialGrade,
                    LoginName=model.LoginName,
                    MajorOrgID=model.MajorOrgID,
                    Mobile=model.Mobile,
                    MSN=model.Mobile,
                    Name=model.Name,
                    Nation=model.Nation,
                    Nativeplace=model.Nativeplace,
                    OfficePhone=model.OfficePhone,
                    OperatorID=model.OperatorID,
                    OutDate=model.OutDate,
                    Photo=model.Photo,
                    PoliticsStatus=model.PoliticsStatus,
                    Position=model.Position,
                    PositionName=model.PositionName,
                    PostGrade=model.PostGrade,
                    Speciality=model.Speciality,
                    Status=model.Status,
                    WorkFromDate=model.WorkFromDate,
                    ZipCode=model.ZipCode
                });

                //学历学位
                foreach (var item in model.Diplomas)
                {
                    item.ID = IdGenerator.NewComb().ToSafeString();
                    item.Creator = model.Creator;
                    item.CreateTime = model.CreateTime;
                    item.EmployeeID = model.ID;
                    Session.SaveOrUpdate(item);
                }

                //任职经历
                foreach (var item in model.PostExperiences)
                {
                    if (item.PostDate != null && item.PostDate != string.Empty)
                    {
                        item.ID = IdGenerator.NewComb().ToSafeString();
                        item.Creator = model.Creator;
                        item.CreateTime = model.CreateTime;
                        item.EmployeeID = model.ID;
                        Session.SaveOrUpdate(item);
                    }
                }

                //家庭成员
                foreach (var item in model.FamilyMembers)
                {
                    if (item.MemberRelation != null && item.MemberRelation != string.Empty)
                    {
                        item.ID = IdGenerator.NewComb().ToSafeString();
                        item.Creator = model.Creator;
                        item.CreateTime = model.CreateTime;
                        item.EmployeeID = model.ID;
                        Session.SaveOrUpdate(item);
                    }
                }

                //简历
                foreach (var item in model.Resumes)
                {
                    if (item.StartDate != null && item.StartDate != string.Empty)
                    {
                        item.ID = IdGenerator.NewComb().ToSafeString();
                        item.Creator = model.Creator;
                        item.CreateTime = model.CreateTime;
                        item.EmployeeID = model.ID;
                        Session.SaveOrUpdate(item);
                    }
                }

                if (Session.Transaction != null && Session.Transaction.IsActive)
                    Session.Transaction.Commit();
            }
            catch (Exception ex)
            {
                if (Session.Transaction != null && Session.Transaction.IsActive)
                    Session.Transaction.Rollback();

                log.Error(string.Format("导入Excel数据,保存员工信息出错,员工Code={0}", model.Code), ex);
                return false;
                
            }
            return true;
        }
        #endregion

        #region Internal Methods

        #endregion
    }
}
