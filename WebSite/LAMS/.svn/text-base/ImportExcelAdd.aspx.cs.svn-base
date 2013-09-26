using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Collections;

using NPOI.HSSF.UserModel;
using NPOI.HPSF;
using NPOI.POIFS.FileSystem;
using NPOI.SS.UserModel;


using log4net;
using Microsoft.Practices.Unity;
using EAFrame.Core;
using EAFrame.Core.Enums;
using EAFrame.Core.Service;
using EAFrame.Core.Security;
using EAFrame.Core.Extensions;
using EAFrame.Core.Web;
using EAFrame.Core.Data;
using EAFrame.Core.Caching;
using EAFrame.Core.Utility;
using EAFrame.Core.FastInvoker;
using EAFrame.WebControls;
using SunTek.EAFrame.AuthorizeCenter.Domain;
using SunTek.EAFrame.AuthorizeCenter.Service;
using SunTek.LAMS.Domain;
using SunTek.LAMS.Service;

namespace WebSite
{
    public partial class ImportExcelAdd : BasePage
    {
        EmployeeService employeeService = new EmployeeService();

        /// <summary>
        /// 区分经理等级
        /// </summary>
        private string Grade
        {
            get
            {
                return Request["grade"] ?? "grade2";
            }
        }
        CandidateManagerService candidateManagerService = new CandidateManagerService();
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpPostedFile file = Request.Files["FileData"];
            HSSFWorkbook workbook = new HSSFWorkbook(file.InputStream);
            HSSFSheet sheet = (HSSFSheet)workbook.GetSheetAt(0);

            string type = string.IsNullOrEmpty(Request["type"]) ? string.Empty : Request["type"].ToString();

            switch (type)
            {
                case "1"://信息入库
                    ImportEmployeeModel(sheet, workbook);
                    break;
                case "2": //后备入库
                    ImportCandidateManager(sheet);
                    break;
                case "3"://后备资格
                    ImportCandidateManagerQualify(sheet);
                    break;
                case "4"://导入批量查询人员的SapID
                    ImportSapID(sheet);
                    break;
            }

        }

        #region CandidateManagerQualify
        /// <summary>
        /// 后备资格
        /// </summary>
        /// <param name="sheet"></param>
        private void ImportCandidateManagerQualify(HSSFSheet sheet)
        {
            string templateName = Grade == "grade2" ? "CandidateManagerQualify2.template" : "CandidateManagerQualify3.template";
            string sheetGrade = (sheet.SheetName == "二级经理" ? "grade2" : "grade3");
            if (Grade != sheetGrade)
            {
                Response.Write(string.Format("0&你导入的模版是{0}模版,不能在这导入，请选择对应的入口！", sheet.SheetName));
                return;
            }
            string template = Path.Combine(Path.Combine(Server.MapPath("~"), "FileTemplate"), templateName);
            int rowNum = sheet.PhysicalNumberOfRows - 2;

            for (int i = 1; i < rowNum; i++)
            {
                if (string.IsNullOrWhiteSpace(sheet.GetRow(i).GetCell(1).ToSafeString()))
                {
                    rowNum = i - 2;
                    break;
                }
            }
            if (SaveCandidatemanagerQualify(sheet, template, rowNum))
                Response.Write("1&保存成功！");
        }

        private bool SaveCandidatemanagerQualify(HSSFSheet sheet, string templatePath, int rowCount)
        {
            string strError = string.Empty;
            CandidateManagerModel model = SunTek.LAMS.Uitl.ExcelUtil.CreateFromExcel<CandidateManagerModel>(templatePath, (row, column) =>
            {
                try
                {
                    string value = sheet.GetRow(row).GetCell(column).ToString();
                    if (value.Trim() == "是") //是否破格推荐
                        return 1;
                    else if (value.Trim() == "否")
                        return 0;
                    return value;
                }
                catch (Exception ex)
                {
                    log.Error(string.Format("获取excel单位格信息出错!【行，列】＝【{1],{2}】", row, column), ex);
                    return string.Empty;
                }
            }, rowCount);
            if (model.CandidateManagers == null)
            {
                Response.Write("0&获取Excel单位格信息出错，请检查Excel数据格式是否正确!");
                return false;
            }

            model.CandidateManagerGrade = sheet.SheetName;
            model.Creator = User.ID;
            model.CreateTime = DateTime.Now;

            candidateManagerService.SaveCandidateManagerQualify(model, out strError);
            if (!string.IsNullOrWhiteSpace(strError))
            {
                Response.Write("0&" + strError);
                return false;
            }
            else
            {
                return true;
            }
        }
        #endregion

        #region CandidateManagers

        /// <summary>
        /// 导入二级经理后备队伍推荐人选汇总表
        /// </summary>
        private void ImportCandidateManager(HSSFSheet sheet)
        {
            string templateName = Grade == "grade2" ? "CandidateManage2.template" : "CandidateManage3.template";
            string sheetGrade = (sheet.SheetName == "二级经理" ? "grade2" : "grade3");
            if (Grade != sheetGrade)
            {
                Response.Write(string.Format("0&你导入的模版是{0}模版,不能在这导入，请选择对应的入口！", sheet.SheetName));
                return;
            }

            string template = Path.Combine(Path.Combine(Server.MapPath("~"), "FileTemplate"), templateName);//Excel单位格配置xml模板
            int rowNum = sheet.PhysicalNumberOfRows - 5;

            for (int i = 5; i < rowNum; i++)
            {
                if (string.IsNullOrWhiteSpace(sheet.GetRow(i).GetCell(1).ToSafeString()))
                {
                    rowNum = i - 5;
                    break;
                }
            }

            if (SaveCandidatemanager(sheet, template, rowNum))
            {
                Response.Write("1&保存成功！");
            }
        }

        /// <summary>
        /// 保存二级经理后备队伍推荐人选汇总信息
        /// </summary>
        /// <param name="sheet"></param>
        /// <param name="rowCount">行数</param>
        private bool SaveCandidatemanager(HSSFSheet sheet, string templatePath, int rowCount)
        {
            string strError = string.Empty;
            CandidateManagerModel model = SunTek.LAMS.Uitl.ExcelUtil.CreateFromExcel<CandidateManagerModel>(templatePath, (row, column) =>
            {
                try
                {
                    string value = sheet.GetRow(row).GetCell(column).ToString();
                    if (value.Trim() == "是") //是否破格推荐
                        return 1;
                    else if (value.Trim() == "否")
                        return 0;
                    else if (string.IsNullOrWhiteSpace(value.Trim()))
                        return null;
                    return value;
                }
                catch (Exception ex)
                {
                    log.Error(string.Format("获取excel单位格信息出错!【行，列】＝【{1],{2}】", row, column), ex);
                    return string.Empty;
                }
            }, rowCount);
            if (model.CandidateManagers == null)
            {
                Response.Write("0&获取Excel单位格信息出错，请检查Excel数据格式是否正确!");
                return false;
            }

            Type type = typeof(CandidateManager);
            foreach (var p in type.GetProperties())//通过反射为属性为空的赋值
            {
                if (string.IsNullOrWhiteSpace(p.GetValue(model, null).ToSafeString()) || (p.PropertyType == typeof(DateTime) && p.GetValue(model, null).ToString() == "1800/1/1 0:00:00"))
                {
                    p.SetValue(model, null, null);
                }
            }

            model.Creator = User.ID;
            model.CreateTime = DateTime.Now;

            CandidateManagerService candidateManagerService = new CandidateManagerService();
            candidateManagerService.SaveCandidateManager(model, Grade, out strError);
            if (!string.IsNullOrWhiteSpace(strError))
            {
                Response.Write("0&" + strError);
                return false;
            }
            else
            {
                return true;
            }
        }
        #endregion

        #region EmployeeModel

        /// <summary>
        /// 导入Excel数据： 返回客户端信息:0:出错；1：成功；2：提示;
        /// </summary>
        private void ImportEmployeeModel(HSSFSheet sheet, HSSFWorkbook workbook)
        {
            string template = Path.Combine(Path.Combine(Server.MapPath("~"), "FileTemplate"), "Employee.template");//Excel单位格配置xml模板
            string employeeCode;
            string sheetName;
            Employee employee = null;

            sheetName = sheet.SheetName;
            if (sheetName.IndexOf('-') > 0)
            {
                employeeCode = sheet.SheetName.Split('-')[1].ToString().Trim(); //人员代码
                Dictionary<string, object> dic = new Dictionary<string, object>();
                dic.Add("Code", employeeCode);
                employee = employeeService.FindOne(dic);
                if (employee == null)
                {
                    Response.Write("2&不存在编号为【{0}】的人员！");
                    return;
                }
            }
            else
            {
                Response.Write("2&不能导入该Excel,Sheet的名称要如下格式：【员工姓名-员工编号】");
                return;
            }

            string tempID = string.Empty;
            if (!IsEmployeeExist(employeeCode))
            {
                Response.Write("2&该员工不具备后备资格或已经导入后备信息,不能导入!");
                return;
            }

            //获取照片后缀名
            string picExt = string.Empty;
            IList lst = workbook.GetAllPictures(); //获取所有图片
            if (lst.Count > 0)
            {
                HSSFPictureData pic = (HSSFPictureData)lst[0];
                employee.Photo = pic.SuggestFileExtension();
            }

            //保存员工信息
            if (SaveEmployee(sheet, template, employee))
            {
                //获取照片，并保存
                if (!SavePic(workbook, employeeCode))
                    return;
            }
            else
            {
                //Response.Write("0&保存员工信息出错！");
                return;
            }

            Response.Write(string.Format("1&{0}", employeeCode));
        }

        /// <summary>
        /// 判断员工是否已经入库
        /// </summary>
        /// <param name="employeeCode"></param>
        /// <returns></returns>
        private bool IsEmployeeExist(string code)
        {
            Dictionary<string, object> dic = new Dictionary<string, object>();
            dic.Add("Code", code);
            dic.Add("Status", new Condition(" Status<3 "));
            return candidateManagerService.FindAll(dic).Count > 0;
        }

        /// <summary>
        /// 保存员工信息
        /// </summary>
        /// <param name="sheet"></param>
        /// <param name="employeeCode"></param>
        private bool SaveEmployee(HSSFSheet sheet, string templatePath, Employee employee)
        {
            try
            {
                //读取Excel数据
                EmployeeModel model = SunTek.LAMS.Uitl.ExcelUtil.CreateFromExcel<EmployeeModel>(templatePath, (row, column) =>
                {
                    try
                    {
                        Cell cell = sheet.GetRow(row).GetCell(column);
                        string value = cell.CellType == CellType.BLANK ? null : cell.ToSafeString();

                        if (value != null)
                        {
                            if (value.Trim() == "男")
                                return 0;
                            else if (value.Trim() == "女")
                                return 1;

                            if (value.EndsWith("%"))
                                return value.ToString().Replace("%", "");
                        }

                        return value;
                    }
                    catch (Exception ex)
                    {
                        log.Error(string.Format("获取Excel单元格信息出错，人员Code={0},【行，列】＝【{1],{2}】", employee.Code, row, column), ex);
                        Response.Write("0&获取Excel单元格信息出错!");
                    }
                    return string.Empty;
                });

                CandidateManager candidateManager = model.CandidateManagers[0];
                if (string.IsNullOrWhiteSpace(candidateManager.TargetCandidate) || string.IsNullOrWhiteSpace(candidateManager.CandidateMaturity))
                {
                    Response.Write("0&【后备方向】和【人才成熟度】都不能为空！");
                    return false;
                }
                Type type = typeof(Employee);
                foreach (var p in type.GetProperties())//通过反射为属性为空的赋值
                {
                    if (string.IsNullOrWhiteSpace(p.GetValue(model, null).ToSafeString()) || (p.PropertyType == typeof(DateTime) && p.GetValue(model, null).ToString() == "1800/1/1 0:00:00"))
                    {
                        p.SetValue(model, p.GetValue(employee, null), null);
                    }
                }
                //这时间字段在excel中不存在，系统会默认给它当前时间
                model.InDate = employee.InDate;
                model.OutDate = employee.OutDate;
                model.WorkFromDate = employee.WorkFromDate;

                model.CreateTime = DateTime.Now;
                model.Creator = User.ID;



                //保存数据
                EmployeeModelService employeeModelService = new EmployeeModelService();
                employeeModelService.SaveEmployeeModel(model);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                Response.Write("0&保存人员信息出错：" + ex.Message);
                return false;
            }

            return true;
        }

        /// <summary>
        /// 保存人员照片
        /// </summary>
        private bool SavePic(HSSFWorkbook workbook, string employeeCode)
        {
            try
            {
                IList lst = workbook.GetAllPictures(); //获取所有图片
                if (lst.Count == 0)
                {
                    Response.Write(string.Format("3&{0}", employeeCode));
                    return false;
                }
                HSSFPictureData pic = (HSSFPictureData)lst[0];

                String ext = pic.SuggestFileExtension();
                byte[] data = pic.Data;

                File.WriteAllBytes(Path.Combine(SunTek.LAMS.LAMSContext.EmployeePhotoDirectory, employeeCode + "." + ext), data);
            }
            catch (Exception ex)
            {
                log.Error(string.Format("保存Excel中的人员照片出错，人员Code={0}", employeeCode), ex);
                Response.Write(string.Format("4&{0}", employeeCode));
                return false;
            }
            return true;
        }
        #endregion

        #region "ImportSapID"

        private void ImportSapID(HSSFSheet sheet)
        {
            int rowNum = sheet.PhysicalNumberOfRows;
            System.Text.StringBuilder sapIDs=new System.Text.StringBuilder();
            for (int i = 1; i < rowNum; i++)
            {
                sapIDs.AppendFormat("{0},",sheet.GetRow(i).GetCell(0).ToSafeString());
            }
            Response.Write(sapIDs);
        }

        #endregion

    }
}