using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Text;

using Microsoft.Practices.Unity;
using log4net;
using EAFrame.Core;
using EAFrame.Core.Enums;
using EAFrame.Core.Service;
using EAFrame.Core.Security;
using EAFrame.Core.Extensions;
using EAFrame.Core.Web;
using EAFrame.Core.Office;
using EAFrame.Core.Caching;
using EAFrame.Core.FastInvoker;
using EAFrame.Core.DataFilter;
using EAFrame.WebControls;
using EAFrame.Core.Utility;
using SunTek.LAMS.Domain;
using SunTek.LAMS.Service;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using Newtonsoft.Json;

using NPOI.HSSF.UserModel;
using NPOI.HPSF;
using NPOI.POIFS.FileSystem;
using NPOI.SS.UserModel;

namespace WebSite
{
    public partial class ExportXMLExcel : BasePage
    {
        private CandidateManagerService candidateManagerService = new CandidateManagerService();

        short status = -1;
        string type = string.Empty;
        string grade = string.Empty;
        string fileName = string.Empty;
        string sheetName = string.Empty;

        public override bool Authorize(EAFrame.Core.Authentication.User user, string requestUrl, bool isForce)
        {
            return base.Authorize(user, requestUrl, false);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //获取查询条件
            IDictionary<string, object> filterParameters = new Dictionary<string, object>();
            string strCookieValue = "";
            string strCookieName = "search";
            HttpCookie cookie = Request.Cookies[strCookieName];
            if (cookie != null)
            {
                strCookieValue = HttpUtility.UrlDecode(cookie.Value.ToString());
                filterParameters = JsonConvert.DeserializeObject<IDictionary<string, object>>(strCookieValue);
                filterParameters = filterParameters.Where(p => p.Value.ToSafeString() != string.Empty && p.Value.ToSafeString() != "-1").ToDictionary(c => c.Key, c => c.Value);
                //Request.Cookies.Remove(strCookieName);
                //cookie.Expires = DateTime.Now.AddDays(-100);
                cookie.Value = "";
            }

            StringBuilder strXML = new StringBuilder();
            DataTable dt = null;
            string[] statusName = { "资格入库", "后备汇总", "信息入库", "已出库", "所有" };

            type = Request.QueryString["type"] == null ? "0" : Request.QueryString["type"].ToString();
            status = Request.QueryString["status"] == null ? (short)-1 : Request.QueryString["status"].ToShort();
            grade = Request.QueryString["grade"] == null ? string.Empty : Request.QueryString["grade"].ToString();
            sheetName = grade == "grade2" ? "二级经理" : "三级经理";

            string filterStr = string.Empty;
            string strJson = string.Empty;
            IDictionary<string, string> dicColumnName = null;
            DataTable dtClone = null;
            string filter = GetFilterString();
            filter = filter.Replace("OwnerOrg", "b.OwnerOrg").Replace("creator", "a.creator");
            switch (type)
            {
                case "1":
                    dt = candidateManagerService.GetCandidaeManager(filterParameters, filter, status, grade, null);
                    dtClone = dt.Clone();
                    dtClone.Columns["Gender"].DataType = typeof(string);//性别
                    dtClone.Columns["IsAnomalous"].DataType = typeof(string);//是否破格推荐
                    if (dtClone.Columns.Contains("IsPresident"))//是否县分总经理后备
                        dtClone.Columns["IsPresident"].DataType = typeof(string);
                    //复制数据到克隆的datatable里
                    try
                    {
                        foreach (DataRow dr in dt.Rows)
                        {
                            dtClone.ImportRow(dr);
                        }
                        foreach (DataRow row in dtClone.Rows)
                        {
                            row["Gender"] = row["Gender"].ToString() == "0" ? "男" : "女";
                            row["IsAnomalous"] = row["IsAnomalous"].ToString() == "0" ? "否" : "是";
                            if (grade == "grade3")
                                row["IsPresident"] = row["IsPresident"].ToString() == "0" ? "否" : "是";
                        }
                    }
                    catch (Exception ex)
                    {
                        log.Error("DataTable复制数据出错", ex);
                    }

                    if (grade == "grade2")
                    {
                        fileName = "二级后备汇总数据导出";
                        strJson = @"{'Code':'员工编号','OrgName':'所在单位','EmployeeName':'姓名','DeptName':'所在部门',
                                'PositionName':'现任职务','PostGrade':'现任职级','Gender':'性别','Birthday':'出生日期',
                                'Age':'年龄','InPostDate':'任现职时间','InGradeDate':'任现级时间','Tenure':'任现级年限',
                                'FulltimeEducation':'全日制学历','InserviceEducation':'最高学历','Assessment1':'"
                                    + (DateTime.Now.Year - 3) + "','Assessment2':'" + (DateTime.Now.Year - 2) + "','Assessment3':'" + (DateTime.Now.Year - 1) + @"',
                                'IsAnomalous':'是否破格推荐','DemocracyPecent':'民主推荐率','TargetCandidate':'后备类型',
                                'CandidateMaturity':'后备成熟度','CandidateOrder':'后备排名'}";
                    }
                    else
                    {
                        fileName = "三级后备汇总数据导出";
                        strJson = @"{'CandidatePost':'后备层级','Code':'员工编号','OrgName':'所在单位','EmployeeName':'姓名','DeptName':'所在部门',
                                'PositionName':'现任职务','PostGrade':'现任职级','Gender':'性别','Birthday':'出生日期',
                                'Age':'年龄','InPostDate':'任现职时间','InGradeDate':'任现级时间','Tenure':'任现级年限',
                                'FulltimeEducation':'全日制学历','InserviceEducation':'最高学历','Assessment1':'"
                                    + (DateTime.Now.Year - 3) + "','Assessment2':'" + (DateTime.Now.Year - 2) + "','Assessment3':'" + (DateTime.Now.Year - 1) + @"',
                                'IsAnomalous':'是否破格推荐','DemocracyPecent':'民主推荐率','TargetCandidate':'后备类型',
                                'CandidateMaturity':'后备成熟度','CandidateOrder':'后备排名','IsPresident':'是否县分总经理后备'}";
                    }
                    dicColumnName = JsonConvert.DeserializeObject<IDictionary<string, string>>(strJson);

                    fileName += string.Format("({0})", statusName.GetValue(status).ToSafeString());
                    ExcelHelper.ExportByWeb(dtClone, sheetName, fileName, sheetName + "后备队伍推荐人选汇总表", dicColumnName, true, 1, 2, 1);
                    break;
                case "0":
                    dt = candidateManagerService.GetCandidateManagerQualify(filterParameters, filter, status, grade, null);
                    if (dt == null || dt.Rows.Count == 0) return;
                    dtClone = dt.Clone();
                    dtClone.Columns["IsChief"].DataType = typeof(string);
                    //复制数据到克隆的datatable里
                    try
                    {
                        foreach (DataRow dr in dt.Rows)
                        {
                            dtClone.ImportRow(dr);
                        }
                        foreach (DataRow row in dtClone.Rows)
                        {
                            row["IsChief"] = row["IsChief"].ToString() == "0" ? "否" : "是";//是否正职
                        }
                    }
                    catch (Exception ex)
                    {
                        log.Error("DataTable复制数据出错", ex);
                    }
                    if (grade == "grade2")
                    {
                        fileName = "二级后备资格数据导出";
                        strJson = "{'Code':'员工编号','OrgName':'单位','EmployeeName':'姓名','CandidateManagerGrade':'经理类       别','IsChief':'是否正职','CandidatePost':'后备岗位'}";
                    }
                    else
                    {
                        fileName = "三级后备资格数据导出";
                        strJson = "{'Code':'员工编号','OrgName':'单位','EmployeeName':'姓名','CandidateManagerGrade':'经理类别','CandidatePost':'后备岗位'}";
                    }
                    dicColumnName = JsonConvert.DeserializeObject<IDictionary<string, string>>(strJson);
                    ExcelHelper.ExportByWeb(dtClone, sheetName, fileName, sheetName + "后备人员资格库", dicColumnName, true);
                    break;
                case "2":
                    string corpID = Request.QueryString["corpID"] == null ? string.Empty : Request.QueryString["corpID"].ToString();
                    string isChief = Request.QueryString["isChief"] == null ? string.Empty : Request.QueryString["isChief"].ToString();
                    string layer = Request.QueryString["layer"] == null ? string.Empty : Request.QueryString["layer"].ToString();
                    string isParent = Request.QueryString["isParent"] == null ? string.Empty : Request.QueryString["isParent"].ToString();

                    filterStr = Request.QueryString["content"] == null ? string.Empty : Request.QueryString["content"].ToString();
                    filterParameters = JsonConvert.DeserializeObject<IDictionary<string, object>>(HttpUtility.UrlDecode(filterStr));
                    filterParameters = filterParameters.Where(p => p.Value.ToSafeString() != string.Empty && p.Value.ToSafeString() != "-1").ToDictionary(c => c.Key, c => c.Value);

                    sheetName = "后备经理";
                    fileName = "后备经理信息导出";
                    strJson = @"{'Code':'员工编号','OrgName':'所在单位','EmployeeName':'姓名','DeptName':'所在部门',
                                'PositionName':'现任职务','PostGrade':'现任职级','Gender':'性别','Birthday':'出生日期',
                                'Age':'年龄','InPostDate':'任现职时间','InGradeDate':'任现级时间','Tenure':'任现级年限',
                                'FulltimeEducation':'全日制学历','InserviceEducation':'最高学历','Assessment1':'"
                                + (DateTime.Now.Year - 3) + "','Assessment2':'" + (DateTime.Now.Year - 2) + "','Assessment3':'" + (DateTime.Now.Year - 1) + @"',
                                'IsAnomalous':'是否破格推荐','DemocracyPecent':'民主推荐率','TargetCandidate':'后备类型',
                                'CandidateMaturity':'后备成熟度','CandidateOrder':'后备排名'}";
                    dt = GetDataTable(filterParameters, corpID, isChief, layer, grade, isParent);
                    if (dt == null || dt.Rows.Count == 0) return;
                    dtClone = dt.Clone();
                    dtClone.Columns["Gender"].DataType = typeof(string);//性别
                    dtClone.Columns["IsAnomalous"].DataType = typeof(string);//是否破格推荐
                    if (dtClone.Columns.Contains("IsPresident"))//是否县分总经理后备
                        dtClone.Columns["IsPresident"].DataType = typeof(string);
                    //复制数据到克隆的datatable里
                    try
                    {
                        foreach (DataRow dr in dt.Rows)
                        {
                            dtClone.ImportRow(dr);
                        }
                        foreach (DataRow row in dtClone.Rows)
                        {
                            row["Gender"] = row["Gender"].ToString() == "0" ? "男" : "女";
                            row["IsAnomalous"] = row["IsAnomalous"].ToString() == "0" ? "否" : "是";

                        }
                    }
                    catch (Exception ex)
                    {
                        log.Error("DataTable复制数据出错", ex);
                    }

                    dicColumnName = JsonConvert.DeserializeObject<IDictionary<string, string>>(strJson);
                    ExcelHelper.ExportByWeb(dtClone, sheetName, fileName, sheetName + "后备队伍推荐人选汇总表", dicColumnName, true, 1, 2, 1);
                    break;
                case "3":
                    ExportEmployeeRegister();
                    break;
                case "4":
                    filterStr = Request.QueryString["filterStr"] == null ? string.Empty : Request.QueryString["filterStr"].ToString();
                    filterParameters = JsonConvert.DeserializeObject<IDictionary<string, object>>(HttpUtility.UrlDecode(filterStr));
                    filterParameters = filterParameters.Where(p => p.Value.ToSafeString() != string.Empty && p.Value.ToSafeString() != "-1").ToDictionary(c => c.Key, c => c.Value);
                   
                    dt = GetAgeReportData(Request.QueryString["corpID"], filterParameters);
                    if (dt == null) return;
                    dicColumnName = new Dictionary<string, string>();
                    foreach (DataColumn column in dt.Columns)
                    {
                        dicColumnName.SafeAdd(column.ColumnName, column.ColumnName);
                    }
                    sheetName="年龄结构";
                    ExcelHelper.ExportByWeb(dt, sheetName, "后备经理人才队伍年龄结构报表", "后备经理年龄结构",dicColumnName);
                    break;
                case "5":
                    filterStr = Request.QueryString["filterStr"] == null ? string.Empty : Request.QueryString["filterStr"].ToString();
                    filterParameters = JsonConvert.DeserializeObject<IDictionary<string, object>>(HttpUtility.UrlDecode(filterStr));
                    filterParameters = filterParameters.Where(p => p.Value.ToSafeString() != string.Empty && p.Value.ToSafeString() != "-1").ToDictionary(c => c.Key, c => c.Value);

                    dt = GetEduReportData(Request.QueryString["corpID"], filterParameters);
                    if (dt == null) return;
                    dicColumnName = new Dictionary<string, string>();
                    foreach (DataColumn column in dt.Columns)
                    {
                        dicColumnName.SafeAdd(column.ColumnName, column.ColumnName);
                    }
                    sheetName="学历结构";
                    ExcelHelper.ExportByWeb(dt, sheetName, "后备经理人才队伍学历结构报表", "后备经理学历结构",dicColumnName);
                    break;

            }
        }

        /// <summary>
        /// 导出个人简历
        /// </summary>
        private void ExportEmployeeRegister()
        {
            string employeeID = Request.QueryString["employeeID"] == null ? string.Empty : Request.QueryString["employeeID"].ToString();
            string candidateManagerID = Request.QueryString["candidateManagerID"] == null ? string.Empty : Request.QueryString["candidateManagerID"].ToString();
            EmployeeModel employeeModel = GetEmployeeModel(employeeID, candidateManagerID);

            string path = Path.Combine(Path.Combine(Server.MapPath("~"), "FileTemplate"), "后备队伍人选推荐情况表.xls");
            string templatePath = Path.Combine(Path.Combine(Server.MapPath("~"), "FileTemplate"), "Employee.template");//Excel单位格配置xml模板
            fileName = string.Format("后备队伍人选推荐情况表_{0}", employeeModel.Name);
            HSSFWorkbook workbook;
            using (FileStream file = new FileStream(path, FileMode.Open, FileAccess.Read))
            {
                workbook = new HSSFWorkbook(file);

                HSSFSheet sheet = (HSSFSheet)workbook.GetSheetAt(0);
                workbook.SetSheetName(0, employeeModel.Name + "-" + employeeModel.Code);

                SunTek.LAMS.Uitl.ExcelUtil.InsertFromExcel<EmployeeModel>(templatePath, employeeModel, (row, column, value) =>
                {
                    try
                    {
                        string str = value.ToSafeString();
                        if (str == "0")
                            str = "男";
                        else if (str == "1")
                            str = "女";
                        sheet.GetRow(row).GetCell(column).SetCellValue(str);
                    }
                    catch (Exception ex)
                    {
                        log.Error(string.Format("导出人员简历为Excel单位格写入信息出错!【行，列，值】＝【{1],{2},{3}】", row, column, value), ex);
                    }
                });
                //设置岁数
                sheet.GetRow(2).GetCell(7).SetCellValue(DateTime.Now.Year - employeeModel.Birthday.Year);
                //插入图片
                if (employeeModel.Photo != null)
                {
                    try
                    {
                        //add picture data to this workbook.
                        string picPath = Path.Combine(SunTek.LAMS.LAMSContext.EmployeePhotoDirectory, employeeModel.Code + "." + employeeModel.Photo);
                        byte[] bytes = System.IO.File.ReadAllBytes(picPath);
                        int pictureIdx = workbook.AddPicture(bytes, PictureType.JPEG);

                        // Create the drawing patriarch.  This is the top level container for all shapes. 
                        HSSFPatriarch patriarch = sheet.CreateDrawingPatriarch() as HSSFPatriarch;

                        //add a picture
                        HSSFClientAnchor anchor = new HSSFClientAnchor(10, 10, 1023, 255, 9, 1, 9, 7);
                        anchor.AnchorType = 2;
                        HSSFPicture pict = patriarch.CreatePicture(anchor, pictureIdx) as HSSFPicture;
                    }
                    catch (Exception ex)
                    {
                        log.Error(string.Format("导出后备信息时，插入照片出错！人员编号为【{0}】", employeeModel.Code), ex);
                    }
                }

                ExportExcel(workbook, sheet);//下载
            }
        }

        /// <summary>
        /// 下载文件
        /// </summary>
        /// <param name="workbook"></param>
        /// <param name="sheet"></param>
        private void ExportExcel(HSSFWorkbook workbook, HSSFSheet sheet)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                workbook.Write(ms);
                ms.Flush();
                ms.Position = 0;

                sheet.Dispose();
                if (fileName.IndexOf(".xls") < 0)
                {
                    fileName = fileName + ".xls";
                }
                HttpContext curContext = HttpContext.Current;

                // 设置编码和附件格式  
                curContext.Response.ContentType = "application/vnd.ms-excel";
                curContext.Response.ContentEncoding = Encoding.UTF8;
                curContext.Response.Charset = "";
                curContext.Response.AppendHeader("Content-Disposition",
                    "attachment;filename=" + HttpUtility.UrlEncode(fileName, Encoding.UTF8));

                curContext.Response.BinaryWrite(ms.GetBuffer());
                curContext.Response.End();
            }
        }

        /// <summary>
        /// 获取人员简历信息
        /// </summary>
        /// <param name="employeeID"></param>
        /// <param name="candidateManagerID"></param>
        /// <returns></returns>
        private EmployeeModel GetEmployeeModel(string employeeID, string candidateManagerID)
        {
            EmployeeModel employeeModel = new EmployeeModel();
            EmployeeService employeeService = new EmployeeService();
            DiplomaService diplomaService = new DiplomaService();
            ResumeService resumeService = new ResumeService();
            CandidateManagerService candidateManagerService = new CandidateManagerService();
            CandidateDetailService candidateDetailService = new CandidateDetailService();
            try
            {
                //人员基本信息
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("ID", employeeID);

                Employee employee = employeeService.FindOne(dictionary);
                if (employee == null) return null;

                Dictionary<string, object> dicEmployeeID = new Dictionary<string, object>(); //查询字典
                dicEmployeeID.Add("EmployeeID", employee.ID);

                //学历学位
                List<Diploma> diploma = diplomaService.FindAll(dicEmployeeID).ToList<Diploma>();

                //简历信息
                List<Resume> resume = resumeService.FindAll(dicEmployeeID).OrderBy(c => c.StartDate).ToList();

                //后备信息
                CandidateManager candidateManager = candidateManagerService.GetDomain(candidateManagerID);
                List<CandidateManager> candidateManagerList = new List<CandidateManager>() { candidateManager };


                //选拔推荐情况
                Dictionary<string, object> dicDetail = new Dictionary<string, object>();
                dicDetail.Add("Code", employee.Code);
                CandidateDetail candidateDetail = candidateDetailService.FindOne(dicDetail);
                List<CandidateDetail> candidateDetailList = new List<CandidateDetail>() { candidateDetail };

                //通过反射为employeeModel赋值
                Type type = typeof(Employee);
                foreach (var p in type.GetProperties())
                {
                    if (p.PropertyType == typeof(DateTime))
                        p.SetValue(employeeModel, Convert.ToDateTime(p.GetValue(employee, null)).ToShortDateString().ToDateTime(), null);
                    else
                        p.SetValue(employeeModel, p.GetValue(employee, null), null);
                }

                employeeModel.Diplomas = diploma;
                employeeModel.Resumes = resume;
                employeeModel.CandidateManagers = candidateManagerList;
                employeeModel.CandidateDetails = candidateDetailList;
            }
            catch (Exception ex)
            {
                log.Error("导出人员简历时，获取人员信息出错！", ex);
                return null;
            }
            return employeeModel;
        }

        public DataTable GetDataTable(IDictionary<string, object> parameter, string corpID, string isChief, string layer, string grade, string isParent)
        {

            DataTable dt = null;
            if (string.IsNullOrWhiteSpace(layer))
            {
                //加载正职,副职后备经理人
                if (string.IsNullOrWhiteSpace(isChief) == false)
                {
                    dt = candidateManagerService.GetEmployee(parameter, null, isChief: int.Parse(isChief), grade: "grade2");
                }
                else //加载所有人员
                {
                    return null;
                }
            }
            else
            {
                //加载后备经理人，二级，三级节点的数据
                if (string.IsNullOrWhiteSpace(corpID) || grade == "1")
                {
                    dt = candidateManagerService.GetEmployee(parameter, null, layer: layer, corpID: corpID);
                }
                else
                {
                    if (isParent == "1") //分公司下所有后备
                    {
                        dt = candidateManagerService.GetEmployee(parameter, null, isChief: 0, grade: "grade" + layer, corpID: corpID);
                    }
                    else //部门下所有后备
                    {
                        dt = candidateManagerService.GetEmployee(parameter, null, isChief: 0, layer: layer, corpID: corpID);
                    }
                }
            }
            return dt;
        }

        /// <summary>
        /// 获取年龄结构报表
        /// </summary>
        /// <param name="corpID"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        private DataTable GetAgeReportData(string corpID, IDictionary<string, object> parameters)
        {
            string[] strArray = new string[] { "OR1500025055", "OR1500025056", "OR1500025057", "OR1200000535" };
            if (!string.IsNullOrWhiteSpace(corpID))
            {
                if (strArray.Contains(corpID))
                    parameters.Add("org.ParentID", corpID);
                else
                    parameters.Add("org.ID", corpID);
            }
            DataTable dt = candidateManagerService.GetAgeStructureReport(parameters);
            if (dt.Rows.Count == 0) return null;

            DataTable dtNew = new DataTable();
            dtNew.Columns.Add(new DataColumn("年龄段"));
            DataRow row = dtNew.NewRow();
            row[0] = "人数";
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                dtNew.Columns.Add(new DataColumn(dt.Columns[i].ColumnName));
                row[i + 1] = dt.Rows[0][i].ToInt();
            }
            dtNew.Rows.Add(row);
            return dtNew;
        }

        /// <summary>
        /// 获取学历结构报表
        /// </summary>
        /// <param name="corpID"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        private DataTable GetEduReportData(string corpID, IDictionary<string, object> parameters)
        {
            string[] strArray = new string[] { "OR1500025055", "OR1500025056", "OR1500025057", "OR1200000535" };
            if (!string.IsNullOrWhiteSpace(corpID))
            {
                if (strArray.Contains(corpID))
                    parameters.Add("org.ParentID", corpID);
                else
                    parameters.Add("org.ID", corpID);
            }
            DataTable dt = candidateManagerService.GetEducationStructureReport(parameters);
            if (dt.Rows.Count == 0) return null;

            DataTable dtNew = new DataTable();
            dtNew.Columns.Add(new DataColumn("学历"));
            DataRow row = dtNew.NewRow();
            row[0] = "人数";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dtNew.Columns.Add(new DataColumn(dt.Rows[i][0].ToString()));
                row[i + 1] = dt.Rows[i][1].ToInt();
            }
            dtNew.Rows.Add(row);
            return dtNew;
        }
    }
}