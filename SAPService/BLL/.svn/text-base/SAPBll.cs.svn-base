using System;
using System.Collections.Generic;
using System.Text;
using Suntek.SAPService.Model;
using System.Xml.Serialization;
using System.IO;
using SunTek.Register.Domain;
using SunTek.Register.Service;
using System.Linq;
using log4net;

using EAFrame.Core;

namespace Suntek.SAPService.BLL
{
    public class SAPBll
    {
        private readonly ILog log = LogManager.GetLogger(typeof(SAPBll));
        private SAPServiceBll bll;
        private RegisterBaseInfoService registerBaseInfoService = new RegisterBaseInfoService();
        private SapBaseInfoService sapBaseInfoService = new SapBaseInfoService();
        /// <summary>
        /// 构造函数
        /// </summary>
        public SAPBll()
        {
            bll = new SAPServiceBll();
        }

        //public string GetSAPAsycInfo(string sapid)
        //{
        //    return bll.GetPernrInfo(sapid);
        //}


        /// <summary>
        /// 根据提供的SAPID值获取该员工的详细信息
        /// </summary>
        /// <param name="sapid">sapid</param>
        /// <param name="state">调用的状态:0解析返回结果失败 1调用失败 2无此员工信息 3调用成功</param>
        /// <returns></returns>
        public Results GetSAPAsycInfo(string sapid, out int state)
        {
            state = 0;
            string paras = GetParametersXML(sapid);
            string rets = bll.GetHrInfoForEss(paras);
            rets = rets.Replace("ns0:", "");

            XmlSerializer xs = new XmlSerializer(typeof(ZRFC_ESS_GET_Response));
            StringReader sr = new StringReader(rets);

            ZRFC_ESS_GET_Response response = xs.Deserialize(sr) as ZRFC_ESS_GET_Response;
            if (response != null)//解析成功
            {
                if (response.successful != null)//调用失败
                {
                    state = 1;
                    return null;
                }
                else//调用成功
                {
                    Results results = new Results();

                    #region base
                    if (response.base_info != null)
                    {
                        ZSTR_BASIC_INFOR baseinfo = response.base_info;//员工基本信息

                        results.SapID = baseinfo.pernr.Pernr_value;
                        if (results.SapID == "00000000")//查找不到相应的员工信息
                        {
                            state = 2;
                            return null;
                        }
                        if (baseinfo.ename != null)
                        {
                            results.Ename = baseinfo.ename.Ename_value.Replace(" ", "");
                        }
                        if (baseinfo.gesch != null)
                        {
                            results.Esex = baseinfo.gesch.Gesch_value == "1" ? "男" : "女";
                        }
                        if (baseinfo.zjg != null)
                        {
                            results.Zjg = baseinfo.zjg.Zjg_value;
                        }
                        if (baseinfo.gbort != null)
                        {
                            results.Gbort = baseinfo.gbort.Gbort_value;
                        }

                        if (baseinfo.gbdat != null)
                        {
                            results.Gbdat = FormatDateTime(baseinfo.gbdat.Gbdat_value);
                            if (results.Gbdat.Length > 0)//算出年龄
                            {
                                int ages = DateTime.Now.Year - Convert.ToDateTime(results.Gbdat).Year;
                                results.Ages = ages.ToString();
                            }
                        }
                        if (baseinfo.icnum != null)
                        {
                            results.Icnum = baseinfo.icnum.Icnum_value;
                        }
                        if (baseinfo.racky != null)
                        {
                            results.Packy = GetPacky(baseinfo.racky.Racky_value);
                        }
                        if (baseinfo.pcode != null)
                        {
                            results.Pcode = GetPcode(baseinfo.pcode.Pcode_value);
                        }
                    }
                    #endregion

                    #region position
                    if (response.posit_info != null)//员工现在的职位
                    {
                        ZSTR_POSIT_INFOR posit = response.posit_info;

                        if (posit.stell != null)
                        {
                            results.Stell = posit.stell.Stell_value;
                        }
                        if (posit.stltx != null)
                        {
                            results.Stltx = posit.stltx.Stltx_value;
                        }
                        if (posit.plans != null)
                        {
                            results.Plans = posit.plans.Plans_value;
                        }
                        if (posit.plstx != null)
                        {
                            results.Plstx = posit.plstx.Plstx_value;
                        }
                        if (posit.orgeh != null)
                        {
                            results.Orgeh = posit.orgeh.Orgeh_value;
                        }

                        if (posit.pbtxt != null)
                        {
                            results.Pbtxt = posit.pbtxt.Pbtxt_value;
                        }
                        if (posit.orgtx != null)
                        {
                            results.Orgtx = posit.orgtx.Orgtx_value;
                        }
                        results.Pbtxt_Plstx = posit.pbtxt.Pbtxt_value + "~" + posit.plstx.Plstx_value;
                        results.Begda = FormatDateTime(posit.begda.Begda_value);
                    }
                    #endregion

                    #region family
                    if (response.family_info != null && response.family_info.Length > 0)//员工家庭人员信息
                    {
                        ZSTR_FAMILY_INFOR[] family = response.family_info;
                        IList<FamilyInfo> family_list = new List<FamilyInfo>();
                        foreach (ZSTR_FAMILY_INFOR familyinfo in family)
                        {
                            FamilyInfo info = new FamilyInfo();
                            if (familyinfo.famsa != null)
                            {
                                info.Famsa = GetFamsa(familyinfo.famsa.Famsa_value);
                            }
                            if (familyinfo.fasex != null)
                            {
                                info.Fasex = familyinfo.fasex.Fasex_value == "1" ? "男" : "女";
                            }
                            if (familyinfo.cnam != null)
                            {
                                info.Fcnam = familyinfo.cnam.Fcnam_value;
                            }
                            if (familyinfo.fgbdt != null)
                            {
                                info.Fgbdt = FormatDateTime(familyinfo.fgbdt.fgbdt_value);
                            }
                            if (familyinfo.zdw != null)
                            {
                                info.Zdw = familyinfo.zdw.Zdw_value;
                            }

                            if (familyinfo.zdw_zzw != null)
                            {
                                info.Zdw_Zzw = familyinfo.zdw_zzw.Zdw_zzw_value;
                            }
                            if (familyinfo.zzw != null)
                            {
                                info.Zzw = familyinfo.zzw.Zzw_value;
                            }

                            family_list.Add(info);
                        }
                        results.Family_List = family_list;
                    }
                    #endregion

                    #region degree
                    if (response.degree_info != null && response.degree_info.Length > 0)//员工的教育经历
                    {
                        ZSTR_DEGREE_INFOR[] degree = response.degree_info;
                        IList<DegreeInfo> degree_list = new List<DegreeInfo>();

                        DateTime startda1 = DateTime.MinValue;//全日制
                        DateTime startda2 = DateTime.MinValue;//在岗

                        int index1 = -1;//全日制
                        int index2 = -1;//在岗

                        for (int i = 0; i < degree.Length; i++)
                        {
                            DegreeInfo info = new DegreeInfo();
                            if (degree[i].begda != null)//入学时间
                            {
                                info.Begda = FormatDateTime(degree[i].begda.Begda_value);
                            }
                            if (degree[i].endda != null)//毕业时间
                            {
                                info.Endda = FormatDateTime(degree[i].endda.Endda_value);
                                string str = info.Endda;
                                if (str.Length > 0 && str != "0000-00-00")
                                {
                                    DateTime endda = Convert.ToDateTime(str);
                                    if (endda > startda1)
                                    {
                                        if (degree[i].zxxfsbc.Zxxfsbc_value == "00000001")//全日制
                                        {
                                            startda1 = endda;
                                            index1 = i;
                                        }
                                    }
                                    if (endda > startda2)
                                    {
                                        if (degree[i].zxxfsbc.Zxxfsbc_value == "00000002")//在岗
                                        {
                                            startda2 = endda;
                                            index2 = i;
                                        }
                                    }
                                }
                            }


                            if (degree[i].insti != null)
                            {
                                info.Insti = degree[i].insti.Insti_value;
                            }
                            if (degree[i].slabs != null)
                            {
                                info.Slabs = GetSlabs(degree[i].slabs.Slabs_value);
                            }
                            if (degree[i].slart != null)
                            {
                                info.Slart = GetSlart(degree[i].slart.Slart_value);
                            }

                            if (degree[i].zsxzy != null)
                            {
                                info.Zsxzy = degree[i].zsxzy.Zsxzy_value;
                            }
                            if (degree[i].zxxfsbc != null)
                            {
                                info.Zxxfsbc = GetZxxfsbc(degree[i].zxxfsbc.Zxxfsbc_value);
                            }

                            degree_list.Add(info);
                        }

                        results.Degree_List = degree_list;

                        if (index1 > -1)//全日制最高学历
                        {
                            results.Slart = GetSlart(degree[index1].slart.Slart_value);
                            results.Slabs = GetSlabs(degree[index1].slabs.Slabs_value);
                            results.Insti = degree[index1].insti.Insti_value;
                            results.zsxzy = degree[index1].zsxzy.Zsxzy_value;
                            results.GraduateTime = degree[index1].endda.Endda_value;
                        }
                        if (index2 > -1)//在岗教育最高学历
                        {
                            results.Slart1 = GetSlart(degree[index2].slart.Slart_value);
                            results.Slabs1 = GetSlabs(degree[index2].slabs.Slabs_value);
                            results.Insti1 = degree[index2].insti.Insti_value;
                            results.zsxzy1 = degree[index2].zsxzy.Zsxzy_value;
                            results.GraduateTime1 = degree[index2].endda.Endda_value;
                        }
                    }
                    #endregion

                    #region job
                    if (response.job_info != null && response.job_info.Length > 0)//员工的培训经历
                    {
                        ZSTR_JOB_INFOR[] job = response.job_info;
                        IList<JobInfo> job_list = new List<JobInfo>();

                        foreach (ZSTR_JOB_INFOR jobinfo in job)
                        {
                            JobInfo info = new JobInfo();
                            if (jobinfo.zyjszwdjdm != null)
                            {
                                info.Zyjszwdjdm = jobinfo.zyjszwdjdm.Zyjszwdjdm_value;
                                info.Zyjszwdjdm_Value = GetZyjszwdjdm(jobinfo.zyjszwdjdm.Zyjszwdjdm_value);
                            }
                            if (jobinfo.zyjszwdm != null)
                            {
                                info.Zyjszwdm = jobinfo.zyjszwdm.Zyjszwdm_value;
                                info.Zyjszwdm_Value = GetZyjszwdm(jobinfo.zyjszwdm.Zyjszwdm_value);
                            }

                            if (jobinfo.zyjszwzldm != null)
                            {
                                info.Zyjszwzldm = jobinfo.zyjszwzldm.Zyjszwzldm_value;
                                info.Zyjszwzldm_Value = GetZyjszwzldm(jobinfo.zyjszwzldm.Zyjszwzldm_value);
                            }

                            job_list.Add(info);
                        }

                        results.Job_List = job_list;
                    }
                    #endregion job

                    #region work
                    if (response.work_info != null && response.work_info.Length > 0)//员工的工作经历
                    {
                        ZSTR_WORK_INFOR[] workinfo = response.work_info;
                        IList<WorkInfo> work_list = new List<WorkInfo>();

                        DateTime minDate = DateTime.MaxValue;
                        int index = 0;
                        StringBuilder sb = new StringBuilder();

                        for (int i = 0; i < workinfo.Length; i++)
                        {
                            WorkInfo info = new WorkInfo();
                            if (workinfo[i].begda != null)
                            {
                                info.Begda = FormatDateTime(workinfo[i].begda.Begda_value);
                                string str = info.Begda;
                                if (str.Length > 0 && str != "0000-00-00")
                                {
                                    DateTime startDate = Convert.ToDateTime(str);
                                    if (startDate < minDate && workinfo[i].zzw.Zzw_value != null && workinfo[i].zzw.Zzw_value != "学生")
                                    {
                                        minDate = startDate;
                                        index = i;
                                    }
                                }
                            }
                            if (workinfo[i].endda != null)
                            {
                                info.Endda = FormatDateTime(workinfo[i].endda.Endda_value);
                            }
                            if (workinfo[i].zdw != null)
                            {
                                info.Zdw = workinfo[i].zdw.Zdw_value;
                            }
                            if (workinfo[i].zzw != null)
                            {
                                info.Zzw = workinfo[i].zzw.Zzw_value;
                            }

                            int k = i + 1;
                            sb.Append(k + ".(" + FormatDateTime(workinfo[i].begda.Begda_value) + " - " + FormatDateTime(workinfo[i].endda.Endda_value) + ")" + workinfo[i].zdw.Zdw_value + "  " + workinfo[i].zzw.Zzw_value + "\n");

                            work_list.Add(info);
                        }

                        results.Work_List = work_list;

                        results.WorkTime = FormatDateTime(workinfo[index].begda.Begda_value);
                        results.WorkInfo = sb.ToString();
                    }
                    #endregion

                    state = 3;
                    return results;
                }
            }
            else//解析失败
            {
                state = 0;
                return null;
            }
        }

        public SapResult GetSAPInfo(string sapid, out int state)
        {
            state = 0;
            string paras = GetParametersXML(sapid);
            string rets = bll.GetHrInfoForEss(paras);

            rets = rets.Replace("ns0:", "");
            //log.Error(rets);
            XmlSerializer xs = new XmlSerializer(typeof(ZRFC_ESS_GET_Response));
            StringReader sr = new StringReader(rets);

            ZRFC_ESS_GET_Response response = xs.Deserialize(sr) as ZRFC_ESS_GET_Response;
            if (response != null)//解析成功
            {
                if (response.successful != null)//调用失败
                {
                    state = 1;
                    return null;
                }
                else//调用成功
                {
                    SapResult sapResult = new SapResult();
                    SapBaseInfo sapBaseInfo = new SapBaseInfo();

                    #region base
                    if (response.base_info != null)
                    {
                        ZSTR_BASIC_INFOR baseinfo = response.base_info;//员工基本信息

                        sapBaseInfo.PERNR = baseinfo.pernr.Pernr_value;
                        if (sapBaseInfo.PERNR == "00000000")//查找不到相应的员工信息
                        {
                            state = 2;
                            return null;
                        }
                        if (baseinfo.ename != null)
                        {
                            sapBaseInfo.ENAME = baseinfo.ename.Ename_value.Replace(" ", "");
                        }
                        if (baseinfo.gesch != null)
                        {
                            sapBaseInfo.GESCH = baseinfo.gesch.Gesch_value == "1" ? "男" : "女";
                        }
                        if (baseinfo.zjg != null)
                        {
                            sapBaseInfo.ZJG = baseinfo.zjg.Zjg_value;
                        }
                        if (baseinfo.gbort != null)
                        {
                            sapBaseInfo.GBORT = baseinfo.gbort.Gbort_value;
                        }

                        if (baseinfo.gbdat != null)
                        {
                            sapBaseInfo.GBDAT = FormatDateTime(baseinfo.gbdat.Gbdat_value);
                            if (sapBaseInfo.GBDAT.Length > 0)//算出年龄
                            {
                                int ages = DateTime.Now.Year - Convert.ToDateTime(sapBaseInfo.GBDAT).Year;
                                sapBaseInfo.Age = ages.ToString();
                            }
                        }
                        if (baseinfo.icnum != null)
                        {
                            sapBaseInfo.ICNUM = baseinfo.icnum.Icnum_value;
                        }
                        if (baseinfo.racky != null)
                        {
                            sapBaseInfo.RACKY = GetPacky(baseinfo.racky.Racky_value);
                        }
                        if (baseinfo.pcode != null)
                        {
                            sapBaseInfo.PCODE = GetPcode(baseinfo.pcode.Pcode_value);
                        }

                        if (baseinfo.begda != null)
                        {
                            sapBaseInfo.PartyTime = FormatDateTime(baseinfo.begda.Begda_value);
                        }

                        if (baseinfo.Zhealth1 != null)
                        {
                            sapBaseInfo.HealthState = GetHealthState(baseinfo.Zhealth1.Zhealth1_value);
                        }

                        if (baseinfo.Zfavor != null)
                        {
                            sapBaseInfo.SpecialtyHobby = baseinfo.Zfavor.Zfavor_value;
                        }
                    }
                    #endregion

                    #region position
                    if (response.posit_info != null)//员工现在的职位
                    {
                        ZSTR_POSIT_INFOR posit = response.posit_info;
                        if (posit.stell != null)
                        {
                            sapBaseInfo.STELL = posit.stell.Stell_value;
                        }
                        if (posit.stltx != null)
                        {
                            sapBaseInfo.STLTX = posit.stltx.Stltx_value;
                        }
                        if (posit.plans != null)
                        {
                            sapBaseInfo.PLANS = posit.plans.Plans_value;
                        }
                        if (posit.plstx != null)
                        {
                            sapBaseInfo.PLSTX = posit.plstx.Plstx_value;
                        }
                        if (posit.orgeh != null)
                        {
                            sapBaseInfo.ORGEH = posit.orgeh.Orgeh_value;
                        }

                        if (posit.pbtxt != null)
                        {
                            sapBaseInfo.PBTXT = posit.pbtxt.Pbtxt_value;
                        }
                        if (posit.orgtx != null)
                        {
                            sapBaseInfo.ORGTX = posit.orgtx.Orgtx_value;
                        }
                        if (posit.begda != null)
                        {
                            sapBaseInfo.BEGDA = FormatDateTime(posit.begda.Begda_value);
                        }
                        if (posit.dat03 != null)
                        {
                            sapBaseInfo.SystemTime = FormatDateTime(posit.dat03.Dat03_value);
                        }
                        //results.Pbtxt_Plstx = posit.pbtxt.Pbtxt_value + "~" + posit.plstx.Plstx_value;
                    }
                    #endregion

                    #region family
                    if (response.family_info != null && response.family_info.Length > 0)//员工家庭人员信息
                    {
                        ZSTR_FAMILY_INFOR[] family = response.family_info;
                        IList<SapFamilyMember> familyList = new List<SapFamilyMember>();

                        foreach (ZSTR_FAMILY_INFOR familyinfo in family)
                        {
                            SapFamilyMember sapFamilyMember = new SapFamilyMember();
                            if (familyinfo.famsa != null)
                            {
                                sapFamilyMember.FAMSA = GetFamsa(familyinfo.famsa.Famsa_value);
                            }
                            if (familyinfo.fasex != null)
                            {
                                sapFamilyMember.FASEX = familyinfo.fasex.Fasex_value == "1" ? "男" : "女";
                            }
                            if (familyinfo.cnam != null)
                            {
                                sapFamilyMember.FCNAM = familyinfo.cnam.Fcnam_value;
                            }
                            if (familyinfo.fgbdt != null)
                            {
                                sapFamilyMember.FGBDT = FormatDateTime(familyinfo.fgbdt.fgbdt_value);
                            }
                            if (familyinfo.zdw != null)
                            {
                                sapFamilyMember.ZDW = familyinfo.zdw.Zdw_value;
                            }

                            if (familyinfo.zdw_zzw != null)
                            {
                                sapFamilyMember.ZDW_ZZW = familyinfo.zdw_zzw.Zdw_zzw_value;
                            }
                            if (familyinfo.zzw != null)
                            {
                                sapFamilyMember.ZZW = familyinfo.zzw.Zzw_value;
                            }
                            familyList.Add(sapFamilyMember);
                        }
                        sapResult.FamilyMembers = familyList;
                    }
                    #endregion

                    #region degree
                    if (response.degree_info != null && response.degree_info.Length > 0)//员工的教育经历
                    {
                        ZSTR_DEGREE_INFOR[] degree = response.degree_info;
                        IList<SapDiploma> DiplomaList = new List<SapDiploma>();

                        DateTime startda1 = DateTime.MinValue;//全日制
                        DateTime startda2 = DateTime.MinValue;//在岗

                        int index1 = -1;//全日制
                        int index2 = -1;//在岗

                        for (int i = 0; i < degree.Length; i++)
                        {
                            SapDiploma sapDiploma = new SapDiploma();
                            if (degree[i].begda != null)//入学时间
                            {
                                sapDiploma.BEGDA = FormatDateTime(degree[i].begda.Begda_value);
                            }
                            if (degree[i].endda != null)//毕业时间
                            {
                                sapDiploma.ENDDA = FormatDateTime(degree[i].endda.Endda_value);
                                string str = sapDiploma.ENDDA;
                                if (str.Length > 0 && str != "0000-00-00")
                                {
                                    DateTime endda = Convert.ToDateTime(str);
                                    if (endda > startda1)
                                    {
                                        if (degree[i].zxxfsbc.Zxxfsbc_value == "00000001")//全日制
                                        {
                                            startda1 = endda;
                                            index1 = i;
                                        }
                                    }
                                    if (endda > startda2)
                                    {
                                        if (degree[i].zxxfsbc.Zxxfsbc_value == "00000002")//在岗
                                        {
                                            startda2 = endda;
                                            index2 = i;
                                        }
                                    }
                                }
                            }


                            if (degree[i].insti != null)
                            {
                                sapDiploma.INSTI = degree[i].insti.Insti_value;
                            }
                            if (degree[i].slabs != null)
                            {
                                sapDiploma.SLABS = GetSlabs(degree[i].slabs.Slabs_value);
                            }
                            if (degree[i].slart != null)
                            {
                                sapDiploma.SLART = GetSlart(degree[i].slart.Slart_value);
                            }

                            if (degree[i].zsxzy != null)
                            {
                                sapDiploma.ZSXZY = degree[i].zsxzy.Zsxzy_value;
                            }
                            if (degree[i].zxxfsbc != null)
                            {
                                sapDiploma.ZXXFSBC = GetZxxfsbc(degree[i].zxxfsbc.Zxxfsbc_value);
                            }

                            DiplomaList.Add(sapDiploma);
                        }
                        sapResult.Diplomas = DiplomaList;

                        if (index1 > -1)//全日制最高学历
                        {
                            sapBaseInfo.FulltimeEducation = GetSlart(degree[index1].slart.Slart_value);
                            sapBaseInfo.FulltimeDegree = GetSlabs(degree[index1].slabs.Slabs_value);
                            sapBaseInfo.FulltimeSchool = degree[index1].insti.Insti_value;
                            sapBaseInfo.FulltimeProfessional = degree[index1].zsxzy.Zsxzy_value;
                            sapBaseInfo.FulltimeGraduationTime = degree[index1].endda.Endda_value;
                        }
                        if (index2 > -1)//在岗教育最高学历
                        {
                            sapBaseInfo.ParttimeEducation = GetSlart(degree[index2].slart.Slart_value);
                            sapBaseInfo.ParttimeDegree = GetSlabs(degree[index2].slabs.Slabs_value);
                            sapBaseInfo.ParttimeSchool = degree[index2].insti.Insti_value;
                            sapBaseInfo.ParttimeProfessional = degree[index2].zsxzy.Zsxzy_value;
                            sapBaseInfo.ParttimeGraduationTime = degree[index2].endda.Endda_value;
                        }
                    }
                    #endregion

                    #region job
                    if (response.job_info != null && response.job_info.Length > 0)//员工的培训经历
                    {
                        ZSTR_JOB_INFOR[] job = response.job_info;
                       // IList<JobInfo> job_list = new List<JobInfo>();
                        
                        StringBuilder strRet = new StringBuilder();
                        foreach (ZSTR_JOB_INFOR jobinfo in job)
                        {
                            //ZYJSZWMC
                            if (jobinfo.zyjszwmc != null)
                            {
                                strRet.Append(jobinfo.zyjszwmc.Zyjszwmc_value);
                                strRet.Append(",");
                            }
                            //JobInfo info = new JobInfo();
                            //if (jobinfo.zyjszwdjdm != null)
                            //{
                            //    info.Zyjszwdjdm = jobinfo.zyjszwdjdm.Zyjszwdjdm_value;
                            //    info.Zyjszwdjdm_Value = GetZyjszwdjdm(jobinfo.zyjszwdjdm.Zyjszwdjdm_value);
                            //}
                            //if (jobinfo.zyjszwdm != null)
                            //{
                            //    info.Zyjszwdm = jobinfo.zyjszwdm.Zyjszwdm_value;
                            //    info.Zyjszwdm_Value = GetZyjszwdm(jobinfo.zyjszwdm.Zyjszwdm_value);
                            //}

                            //if (jobinfo.zyjszwzldm != null)
                            //{
                            //    info.Zyjszwzldm = jobinfo.zyjszwzldm.Zyjszwzldm_value;
                            //    info.Zyjszwzldm_Value = GetZyjszwzldm(jobinfo.zyjszwzldm.Zyjszwzldm_value);
                            //}

                            //job_list.Add(info);
                        }
                        sapBaseInfo.ProfessionalPosition = strRet.ToString().Substring(0, strRet.Length - 1);
                    }
                    #endregion job

                    #region work
                    if (response.work_info != null && response.work_info.Length > 0)//员工的工作经历
                    {
                        ZSTR_WORK_INFOR[] workinfo = response.work_info;
                        IList<SapWorkExperience> workList = new List<SapWorkExperience>();

                        DateTime minDate = DateTime.MaxValue;
                        int index = 0;
                        StringBuilder sb = new StringBuilder();

                        for (int i = 0; i < workinfo.Length; i++)
                        {
                            SapWorkExperience work = new SapWorkExperience();
                            if (workinfo[i].begda != null)
                            {
                                work.BEGDA = FormatDateTime(workinfo[i].begda.Begda_value);
                                string str = work.BEGDA;
                                if (str.Length > 0 && str != "0000-00-00")
                                {
                                    DateTime startDate = Convert.ToDateTime(str);
                                    if (startDate < minDate && workinfo[i].zzw.Zzw_value != null && workinfo[i].zzw.Zzw_value != "学生")
                                    {
                                        minDate = startDate;
                                        index = i;
                                    }
                                }
                            }
                            if (workinfo[i].endda != null)
                            {
                                work.ENDDA = FormatDateTime(workinfo[i].endda.Endda_value);
                            }
                            if (workinfo[i].zdw != null)
                            {
                                work.ZDW = workinfo[i].zdw.Zdw_value;
                            }
                            if (workinfo[i].zzw != null)
                            {
                                work.ZZW = workinfo[i].zzw.Zzw_value;
                            }

                            int k = i + 1;
                            sb.Append(k + ".(" + FormatDateTime(workinfo[i].begda.Begda_value) + " - " + FormatDateTime(workinfo[i].endda.Endda_value) + ")" + workinfo[i].zdw.Zdw_value + "  " + workinfo[i].zzw.Zzw_value + "\n");

                            workList.Add(work);
                        }
                        sapResult.WorkExperiences = workList;

                        sapBaseInfo.WorkTime = FormatDateTime(workinfo[index].begda.Begda_value);
                        // results.WorkInfo = sb.ToString();
                    }
                    #endregion

                    #region Appoint
                    if (response.appoint_info != null && response.appoint_info.Length > 0)//任职经历
                    {
                        ZSTR_APPOINT_INFOR[] appointInfos = response.appoint_info;
                        IList<SapAppoint> sapAppoints = new List<SapAppoint>();

                        foreach (ZSTR_APPOINT_INFOR appointInfo in appointInfos)
                        {
                            SapAppoint sapAppoint = new SapAppoint();
                            if (appointInfo.begda != null)
                            {
                                sapAppoint.BEGDA = FormatDateTime(appointInfo.begda.Begda_value);
                            }
                            if (appointInfo.endda != null)
                            {
                                sapAppoint.ENDDA = FormatDateTime(appointInfo.endda.Endda_value);
                            }
                            if (appointInfo.jobds != null)
                            {
                                sapAppoint.JOBDS = appointInfo.jobds.Jobds_value;
                            }
                            if (appointInfo.appru != null)
                            {
                                sapAppoint.APPRU = appointInfo.appru._Appru_value;
                            }
                            if (appointInfo.jobty != null)
                            {
                                sapAppoint.JOBTY = GetPostGrade(appointInfo.jobty._Jobty_value);
                            }
                            sapAppoints.Add(sapAppoint);
                        }
                        sapResult.Appoints = sapAppoints;
                    }

                    #endregion

                    #region stell
                    //if (response.appoint_info != null && response.appoint_info.Length > 0)//任现岗级时间信息
                    //{
                    //    ZSTR_APPOINT_INFOR[] appointInfos = response.appoint_info;
                    //    IList<SapAppoint> sapAppoints = new List<SapAppoint>();

                    //    ZSTR_STELL_INFOR[] stellInfos = response.stell_info;

                    //    DateTime tempDate = DateTime.MinValue;
                    //    foreach (ZSTR_STELL_INFOR stellInfo in stellInfos)
                    //    {
                    //        if (stellInfo.begda != null)
                    //        {
                    //            if (Convert.ToDateTime(stellInfo.begda.Begda_value) > tempDate)
                    //            {
                    //                tempDate = Convert.ToDateTime(stellInfo.begda.Begda_value);

                    //                sapBaseInfo.CurrentPosition = GetStell(stellInfo.stell.Stell_value); ;
                    //                sapBaseInfo.PositionTime = FormatDateTime(stellInfo.begda.Begda_value);
                    //            }
                    //        }
                    //    }
                    //}
                    #endregion

                    state = 3;
                    sapResult.SapBaseInfo = sapBaseInfo;
                    return sapResult;
                }
            }
            else//解析失败
            {
                state = 0;
                return null;
            }
        }

        /// <summary>
        /// 获取员工信息
        /// </summary>
        /// <param name="sapid"></param>
        /// <param name="state"></param>
        /// <returns></returns>
        public RegisterBaseInfo GetRegisterBaseInfo(SapResult sapResult)
        {
            SapBaseInfo sapBaseInfo = sapResult.SapBaseInfo;
            if (sapBaseInfo == null) return null;
            RegisterBaseInfo baseInfo = new RegisterBaseInfo();
            baseInfo.Code = sapBaseInfo.PERNR;
            baseInfo.Gender = sapBaseInfo.GESCH;
            baseInfo.Birthday = this.DateFormate(sapBaseInfo.GBDAT);
            baseInfo.Birthplace = sapBaseInfo.ZJG;
            //baseInfo.CurrentPostTime = this.DateFormate(result.Begda);

            baseInfo.GradeExperience = "";
            baseInfo.WorkTime = this.DateFormate(sapBaseInfo.WorkTime);
            baseInfo.PoliticalFace = sapBaseInfo.PCODE;
            baseInfo.PostGradeExperience = "";
            baseInfo.PartyTime = sapBaseInfo.PartyTime;
            baseInfo.SystemTime = sapBaseInfo.SystemTime;
            baseInfo.CurrentGradeTime = sapBaseInfo.BEGDA;
            

            //baseInfo.Age = (DateTime.Now.Year - Convert.ToDateTime(result.Gbdat).Year).ToString();
            //baseInfo.Nation = result.Packy;
            //baseInfo.HealthState = ""; //未确定
            //baseInfo.TechnicalPositions = "";
            //baseInfo.ProfessionalExpertise = "";
            //baseInfo.CurrentPosition = "";
            //baseInfo.PostName = "";
            //baseInfo.PostGrade = "";

            //全日制学历
            baseInfo.FulltimeEducation = sapBaseInfo.FulltimeEducation;
            baseInfo.FulltimeDegree = sapBaseInfo.FulltimeDegree;
            baseInfo.FulltimeProfessional = sapBaseInfo.FulltimeProfessional;
            baseInfo.FulltimeSchool = sapBaseInfo.FulltimeSchool;
            baseInfo.FulltimeGraduationTime = this.DateFormate(sapBaseInfo.FulltimeGraduationTime);
            //在岗学历
            baseInfo.ParttimeEducation = sapBaseInfo.ParttimeEducation;
            baseInfo.ParttimeDegree = sapBaseInfo.ParttimeDegree;
            baseInfo.ParttimeProfessional = sapBaseInfo.ParttimeProfessional;
            baseInfo.ParttimeSchool = sapBaseInfo.ParttimeSchool;
            baseInfo.ParttimeGraduationTime = this.DateFormate(sapBaseInfo.ParttimeGraduationTime);

            //工作经历
            if (sapResult.WorkExperiences != null)
            {
                foreach (SapWorkExperience workinfo in sapResult.WorkExperiences)
                {
                    baseInfo.PostGradeExperience += string.Format(@"{0} {1}{2} <br />", DateFormat(workinfo.BEGDA), workinfo.ZDW, workinfo.ZZW);
                }
                baseInfo.PostGradeExperience = baseInfo.PostGradeExperience.Replace("\"", "");
            }
            return baseInfo;
        }

        public string DateFormate(string date)
        {
            string yy, mm;
            try
            {
                yy = date.Substring(2, 2);
                mm = date.Substring(5, 2);
            }
            catch (Exception e)
            {
                return string.Empty;
            }
            return string.Format("{0}.{1}", yy, mm);
        }

        private string DateFormat(string date)
        {
            try
            {
                return string.Format("{0}.{1}", date.Substring(0, 4), date.Substring(5, 2));
            }
            catch (Exception e)
            {
                return date;
            }
        }

        /// <summary>
        /// SAP同步方法
        /// </summary>
        /// <param name="registerCodes">员工编号列表</param>
        public string SapSynchronize(string registerCodes, bool isComplete)
        {
            SapWorkExperienceService workExperienceService = new SapWorkExperienceService();
            SapFamilyMemberService familyMemberService = new SapFamilyMemberService();
            SapAppointService appointService = new SapAppointService();
            string rtnStr = string.Empty;
            int state;
            string[] codes = registerCodes.Split(',');
            IDictionary<string, object> para = new Dictionary<string, object>();
            foreach (string code in codes)
            {
                try
                {
                    SapResult sapResult = null;

                    using (ITransaction trans = UnitOfWork.BeginTransaction(typeof(RegisterBaseInfo)))
                    {
                        if (!isComplete)
                        {
                            //名册基本信息
                            para.Clear();
                            para.Add("Code", code);
                            if (registerBaseInfoService.FindOne(para) == null)
                            {
                                sapResult = this.GetSAPInfo(code, out state);
                                if (state != 3)
                                {
                                    rtnStr += string.Format("员工编号为{0}同步失败！", code) + "<br>";
                                    continue;
                                }
                                RegisterBaseInfo registerBaseInfo = this.GetRegisterBaseInfo(sapResult);
                                if (registerBaseInfo != null)
                                {
                                    registerBaseInfo.ID = IdGenerator.NewComb().ToString();
                                    registerBaseInfoService.SaveOrUpdate(registerBaseInfo);
                                }
                            }
                        }
                        para.Clear();
                        para.Add("PERNR", code);
                        if (sapBaseInfoService.FindOne(para) == null)
                        {
                            if (sapResult == null)
                            {
                                sapResult = this.GetSAPInfo(code, out state);
                                if (state != 3)
                                {
                                    rtnStr += string.Format("员工编号为{0}同步失败！", code) + "<br>";
                                    continue;
                                }
                            }
                            //sap基本信息
                            SapBaseInfo sapBaseInfo = sapResult.SapBaseInfo;
                            if (sapBaseInfo != null)
                            {
                                sapBaseInfo.ID = IdGenerator.NewComb().ToString();
                                sapBaseInfo.Creator = "";
                                sapBaseInfo.CreateTime = DateTime.Now;
                                sapBaseInfoService.SaveOrUpdate(sapBaseInfo);
                            }
                            //简历
                            if (sapResult.WorkExperiences != null)
                            {
                                foreach (var item in sapResult.WorkExperiences)
                                {
                                    item.ID = IdGenerator.NewComb().ToString();
                                    item.PERNR = code;
                                    workExperienceService.SaveOrUpdate(item);
                                }
                            }
                            //家庭成员
                            if (sapResult.FamilyMembers != null)
                            {
                                foreach (var item in sapResult.FamilyMembers)
                                {
                                    item.ID = IdGenerator.NewComb().ToString();
                                    item.PERNR = code;
                                    familyMemberService.SaveOrUpdate(item);
                                }
                            }
                            //任职经历
                            if (sapResult.Appoints != null)
                            {
                                foreach (var item in sapResult.Appoints)
                                {
                                    item.ID = IdGenerator.NewComb().ToString();
                                    item.PERNR = code;
                                    appointService.SaveOrUpdate(item);
                                }
                            }
                        }

                        trans.Commit();
                    }
                }
                catch (Exception ex)
                {
                    log.Error(string.Format("员工编号为{0}同步失败！", code), ex);
                    rtnStr += string.Format("员工编号为{0}同步失败！", code) + "<br>";
                    continue;
                }
            }
            return rtnStr;
        }

        /// <summary>
        /// 获取职位等级
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public string GetPostGrade(string code)
        {
            string rets = "";
            switch (code)
            {
                case "1001":
                    rets = "管理一岗";
                    break;
                case "1002":
                    rets = "管理二岗";
                    break;
                case "1021":
                    rets = "管理二岗副";
                    break;
                case "1003":
                    rets = "管理三岗";
                    break;
                case "1004":
                    rets = "管理四岗";
                    break;
                case "1005":
                    rets = "管理五岗";
                    break;
                case "1006":
                    rets = "管理六岗";
                    break;
                case "1007":
                    rets = "管理七岗";
                    break;
                case "1008":
                    rets = "管理八岗";
                    break;
                case "1009":
                    rets = "管理九岗";
                    break;
                case "1010":
                    rets = "管理十岗";
                    break;
                case "1031":
                    rets = "专业一岗";
                    break;
                case "1032":
                    rets = "专业二岗";
                    break;
                case "1033":
                    rets = "专业三岗";
                    break;
                case "1034":
                    rets = "专业四岗";
                    break;
                case "1035":
                    rets = "专业五岗";
                    break;
                case "1036":
                    rets = "专业六岗";
                    break;
                case "1037":
                    rets = "专业七岗";
                    break;
                case "1038":
                    rets = "专业八岗";
                    break;
                case "1039":
                    rets = "专业九岗";
                    break;
                case "1040":
                    rets = "专业十岗";
                    break;
                case "2010":
                    rets = "技术一岗";
                    break;
                case "2020":
                    rets = "技术二岗";
                    break;
                case "2021":
                    rets = "技术二岗副";
                    break;
                case "2030":
                    rets = "技术三岗";
                    break;
                case "2040":
                    rets = "技术四岗";
                    break;
                case "2050":
                    rets = "技术五岗";
                    break;
                case "2060":
                    rets = "技术六岗";
                    break;
                case "2070":
                    rets = "技术七岗";
                    break;
                case "2080":
                    rets = "技术八岗";
                    break;
                case "2090":
                    rets = "技术九岗";
                    break;
                case "2100":
                    rets = "技术十岗";
                    break;
                case "3010":
                    rets = "业务一岗";
                    break;
                case "3020":
                    rets = "业务二岗";
                    break;
                case "3021":
                    rets = "业务二岗副";
                    break;
                case "3030":
                    rets = "业务三岗";
                    break;
                case "3040":
                    rets = "业务四岗";
                    break;
                case "3050":
                    rets = "业务五岗";
                    break;
                case "3060":
                    rets = "业务六岗";
                    break;
                case "3070":
                    rets = "业务七岗";
                    break;
                case "3080":
                    rets = "业务八岗";
                    break;
                case "3090":
                    rets = "业务九岗";
                    break;
                case "3100":
                    rets = "业务十岗";
                    break;
                default:
                    break;
            }
            return rets;
        }

        /// <summary>
        /// 健康状况
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public string GetHealthState(string code)
        {
            string rets = "";
            switch (code)
            {
                case "01":
                    rets = "良好";
                    break;
                case "02":
                    rets = "一般";
                    break;
                case "03":
                    rets = "残疾";
                    break;
                case "04":
                    rets = "有慢性病";
                    break;
                case "05":
                    rets = "有生理缺陷";
                    break;
                case "06":
                    rets = "较弱";
                    break;
                default:
                    rets = "良好";
                    break;
            }
            return rets;
        }

        /// <summary>
        /// 专业技术职务等级
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        private string GetZyjszwdjdm(string type)
        {
            string rets = "";
            switch (type)
            {
                case "01":
                    rets = "正高级专业技术职务";
                    break;

                case "02":
                    rets = "副高级专业技术职务";
                    break;

                case "03":
                    rets = "中级专业技术职务";
                    break;

                case "04":
                    rets = "助级专业技术职务";
                    break;

                case "05":
                    rets = "员级专业技术职务";
                    break;
            }
            return rets;
        }

        /// <summary>
        /// 专业技术职务代码
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        private string GetZyjszwdm(string type)
        {
            string rets = "";
            switch (type)
            {
                case "Z101":
                    rets = "教授级高级工程师";
                    break;

                case "Z102":
                    rets = "高级工程师";
                    break;

                case "Z103":
                    rets = "工程师";
                    break;

                case "Z104":
                    rets = "助理工程师";
                    break;

                case "Z105":
                    rets = "技术员";
                    break;

                case "Z201":
                    rets = "主任医（药、护、技）师";
                    break;

                case "Z202":
                    rets = "副主任医（药、护、技）师";
                    break;

                case "Z203":
                    rets = "主治医（药、护、技）师";
                    break;

                case "Z204":
                    rets = "医（药、护、技）师";
                    break;

                case "Z205":
                    rets = "医（药、护、技）士";
                    break;

                case "Z206":
                    rets = "医务员";
                    break;

                case "Z301":
                    rets = "教授";
                    break;

                case "Z302":
                    rets = "副教授";
                    break;

                case "Z303":
                    rets = "高级讲师";
                    break;

                case "Z304":
                    rets = "讲师";
                    break;

                case "Z305":
                    rets = "助讲、助教";
                    break;

                case "Z306":
                    rets = "教员";
                    break;

                case "Z401":
                    rets = "高级会计师";
                    break;

                case "Z402":
                    rets = "会计师";
                    break;

                case "Z403":
                    rets = "助理会计师";
                    break;

                case "Z404":
                    rets = "会计员";
                    break;

                case "Z501":
                    rets = "高级审计师";
                    break;

                case "Z502":
                    rets = "审计师";
                    break;

                case "Z503":
                    rets = "助理审计师";
                    break;

                case "Z504":
                    rets = "审计员";
                    break;

                case "Z601":
                    rets = "高级统计师";
                    break;

                case "Z602":
                    rets = "统计师";
                    break;

                case "Z603":
                    rets = "助理统计师";
                    break;

                case "Z604":
                    rets = "统计员";
                    break;

                case "Z701":
                    rets = "教授级高级经济师";
                    break;

                case "Z702":
                    rets = "高级经济师";
                    break;

                case "Z703":
                    rets = "经济师";
                    break;

                case "Z704":
                    rets = "国际商务师";
                    break;

                case "Z705":
                    rets = "助理经济师";
                    break;

                case "Z706":
                    rets = "助理商务师";
                    break;

                case "Z707":
                    rets = "经济员";
                    break;

                case "Z801":
                    rets = "译审";
                    break;

                case "Z802":
                    rets = "副译审";
                    break;

                case "Z803":
                    rets = "翻译";
                    break;

                case "Z804":
                    rets = "助理翻译";
                    break;

                case "Z901":
                    rets = "编审、高记";
                    break;

                case "Z902":
                    rets = "副编审、主任记者";
                    break;

                case "Z903":
                    rets = "编辑、记者、一级校对、技术编辑";
                    break;

                case "Z904":
                    rets = "助理编辑、助理记者、助理技术编辑、二级校对";
                    break;

                case "Z905":
                    rets = "技术设计员、三级校对";
                    break;

                case "ZA01":
                    rets = "高级政工师";
                    break;

                case "ZA02":
                    rets = "政工师";
                    break;

                case "ZA03":
                    rets = "助理政工师";
                    break;

                case "ZA04":
                    rets = "政工员";
                    break;

                case "ZB01":
                    rets = "小教高级";
                    break;

                case "ZB02":
                    rets = "小教一级";
                    break;

                case "ZB03":
                    rets = "小教二级";
                    break;

                case "ZB04":
                    rets = "小教三级";
                    break;

                case "ZC01":
                    rets = "研究员";
                    break;

                case "ZC02":
                    rets = "副研究员";
                    break;

                case "ZC03":
                    rets = "助理研究员";
                    break;

                case "ZC04":
                    rets = "研究实习员";
                    break;

                case "ZD01":
                    rets = "其他正高级";
                    break;

                case "ZD02":
                    rets = "其他副高级";
                    break;

                case "ZD03":
                    rets = "其他中级";
                    break;

                case "ZD04":
                    rets = "其他助级";
                    break;

                case "ZD05":
                    rets = "其他员级";
                    break;
            }
            return rets;
        }

        /// <summary>
        /// 专业技术职务种类
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        private string GetZyjszwzldm(string type)
        {
            string rets = "";
            type = type.ToUpper();

            switch (type)
            {
                case "Z1":
                    rets = "工程技术人员";
                    break;

                case "Z2":
                    rets = "卫生技术人员";
                    break;

                case "Z3":
                    rets = "大中专教师";
                    break;

                case "Z4":
                    rets = "会计人员";
                    break;

                case "Z5":
                    rets = "审计人员";
                    break;

                case "Z6":
                    rets = "统计人员";
                    break;

                case "Z7":
                    rets = "经济商务人员";
                    break;

                case "Z8":
                    rets = "翻译人员";
                    break;

                case "Z9":
                    rets = "新闻出版人员";
                    break;

                case "ZA":
                    rets = "政工人员";
                    break;

                case "ZB":
                    rets = "小学、幼儿园教师";
                    break;

                case "ZC":
                    rets = "科学研究人员";
                    break;

                case "ZD":
                    rets = "其他人员";
                    break;
            }
            return rets;
        }

        /// <summary>
        /// 学习方式补充
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        private string GetZxxfsbc(string type)
        {
            string rets = "";
            switch (type)
            {
                case "00000001":
                    rets = "全日制教育";
                    break;

                case "00000002":
                    rets = "在岗教育";
                    break;
            }
            return rets;
        }

        /// <summary>
        /// 获取称谓类型
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        private string GetFamsa(string type)
        {
            string rets = "";
            switch (type)
            {
                case "1":
                    rets = "配偶";
                    break;

                case "2":
                    rets = "子女";
                    break;

                case "3":
                    rets = "兄弟姐妹";
                    break;

                case "4":
                    rets = "父亲";
                    break;

                case "5":
                    rets = "母亲";
                    break;

                case "6":
                    rets = "其它亲属关系";
                    break;
            }
            return rets;
        }
        /// <summary>
        /// 将格式为yyyyMMdd的时间格式转换成yyyy-MM-dd的格式
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        private string FormatDateTime(string str)
        {
            str = str.Trim();
            if (str.Length == 0 || str == "00000000")
            {
                return "";
            }
            else
            {
                str = str.Insert(4, "-");
                str = str.Insert(7, "-");
                return str;
            }
        }

        /// <summary>
        /// 构造符合协议的XML格式的参数
        /// </summary>
        /// <param name="sapid"></param>
        /// <returns></returns>
        private string GetParametersXML(string sapid)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<ns0:ZRFC_ESS_GET_Request xmlns:ns0=\"http://schemas.microsoft.com/BizTalk/2003\">\n");
            sb.Append("<PERNR>" + sapid + "</PERNR>\n");
            sb.Append("</ns0:ZRFC_ESS_GET_Request>\n");

            return sb.ToString();
        }

        /// <summary>
        /// 获取民族信息
        /// </summary>
        /// <param name="racky"></param>
        /// <returns></returns>
        private string GetPacky(string racky)
        {
            string rets = "";
            switch (racky)
            {
                case "AC":
                    rets = "阿昌族";
                    break;

                case "BA":
                    rets = "白族";
                    break;

                case "BL":
                    rets = "布朗族";
                    break;

                case "BN":
                    rets = "保安族";
                    break;

                case "BY":
                    rets = "布依族";
                    break;

                case "CS":
                    rets = "朝鲜族";
                    break;

                case "DA":
                    rets = "傣族";
                    break;

                case "DE":
                    rets = "德族";
                    break;

                case "DO":
                    rets = "侗族";
                    break;

                case "DR":
                    rets = "独龙族";
                    break;

                case "DU":
                    rets = "达翰尔族";
                    break;

                case "DX":
                    rets = "东乡族 ";
                    break;

                case "EW":
                    rets = "鄂温克族";
                    break;

                case "GI":
                    rets = "京族";
                    break;

                case "GL":
                    rets = "仡佬族";
                    break;

                case "GS":
                    rets = "高山族";
                    break;

                case "HA":
                    rets = "汉族";
                    break;

                case "HU":
                    rets = "回族";
                    break;

                case "HZ":
                    rets = "赫哲族";
                    break;

                case "JN":
                    rets = "基诺族";
                    break;

                case "JP":
                    rets = "景颇族";
                    break;

                case "KG":
                    rets = "柯尔克孜族";
                    break;

                case "KZ":
                    rets = "哈萨克族";
                    break;

                case "LB":
                    rets = "珞巴族";
                    break;

                case "LH":
                    rets = "拉祜族";
                    break;

                case "LI":
                    rets = "黎族";
                    break;

                case "LS":
                    rets = "傈僳族";
                    break;

                case "MA":
                    rets = "满族";
                    break;

                case "MB":
                    rets = "门巴族";
                    break;

                case "MG":
                    rets = "蒙古族";
                    break;

                case "MH":
                    rets = "苗族";
                    break;

                case "ML":
                    rets = "仫佬族";
                    break;

                case "MN":
                    rets = "毛南族";
                    break;

                case "NU":
                    rets = "怒族";
                    break;

                case "NX":
                    rets = "纳西族";
                    break;

                case "OR":
                    rets = "鄂伦春族";
                    break;

                case "PM":
                    rets = "普米族";
                    break;

                case "QI":
                    rets = "羌族";
                    break;

                case "RS":
                    rets = "俄罗斯族";
                    break;

                case "SH":
                    rets = "畲族";
                    break;

                case "SL":
                    rets = "萨拉族";
                    break;

                case "SU":
                    rets = "水族";
                    break;

                case "TA":
                    rets = "塔吉克族";
                    break;

                case "TJ":
                    rets = "土家族";
                    break;

                case "TT":
                    rets = "塔塔尔族";
                    break;

                case "TU":
                    rets = "土族";
                    break;

                case "UG":
                    rets = "维吾尔族";
                    break;

                case "UZ":
                    rets = "乌孜别克族";
                    break;

                case "VA":
                    rets = "佤族";
                    break;

                case "XB":
                    rets = "锡伯族";
                    break;

                case "YA":
                    rets = "瑶族";
                    break;

                case "YG":
                    rets = "裕固族";
                    break;

                case "YI":
                    rets = "彝族";
                    break;

                case "ZA":
                    rets = "藏族";
                    break;

                case "ZH":
                    rets = "壮族";
                    break;

                default:
                    rets = "汉族";
                    break;
            }
            return rets;
        }

        /// <summary>
        /// 获取政治面貌
        /// </summary>
        /// <param name="racky"></param>
        /// <returns></returns>
        private string GetPcode(string pcode)
        {
            string rets = "";
            switch (pcode)
            {
                case "01":
                    rets = "中共党员";
                    break;

                case "02":
                    rets = "中共预备党员";
                    break;

                case "03":
                    rets = "共青团员";
                    break;

                case "04":
                    rets = "中国国民党革命委员会会员";
                    break;

                case "05":
                    rets = "中国民主同盟盟员";
                    break;

                case "06":
                    rets = "中国民主建国会会员";
                    break;

                case "07":
                    rets = "中国民主促进会会员";
                    break;

                case "08":
                    rets = "中国农工民主党党员";
                    break;

                case "09":
                    rets = "中国致公党党员";
                    break;

                case "10":
                    rets = "九三学社社员";
                    break;

                case "11":
                    rets = "台湾民主自治同盟盟员";
                    break;

                case "12":
                    rets = "无党派民主人士";
                    break;

                case "13":
                    rets = "群众";
                    break;

                default:
                    rets = "群众";
                    break;
            }
            return rets;
        }

        /// <summary>
        /// 学历
        /// </summary>
        /// <param name="slart"></param>
        /// <returns></returns>
        private string GetSlart(string slart)
        {
            string rets = "";
            switch (slart)
            {
                case "01":
                    rets = "博士研究生";
                    break;

                case "02":
                    rets = "硕士研究生";
                    break;

                case "03":
                    rets = "大学本科";
                    break;

                case "04":
                    rets = "大专";
                    break;

                case "05":
                    rets = "高中";
                    break;

                case "06":
                    rets = "中专";
                    break;

                case "07":
                    rets = "技工学校";
                    break;

                case "08":
                    rets = "初中";
                    break;

                case "09":
                    rets = "小学";
                    break;

                case "10":
                    rets = "未取得学历";
                    break;

                default:
                    rets = "未取得学历";
                    break;
            }
            return rets;
        }

        /// <summary>
        /// 学位名称
        /// </summary>
        /// <param name="slabs"></param>
        /// <returns></returns>
        private string GetSlabs(string slabs)
        {
            string rets = "";
            switch (slabs)
            {
                case "01":
                    rets = "博士";
                    break;

                case "02":
                    rets = "硕士";
                    break;

                case "03":
                    rets = "学士";
                    break;

                case "04":
                    rets = "无学位证书";
                    break;

                default:
                    rets = "无学位证书";
                    break;
            }
            return rets;
        }
    }
}
