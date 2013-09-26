using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Collections;
using Newtonsoft.Json;

using NPOI.HSSF.UserModel;
using NPOI.HPSF;
using NPOI.POIFS.FileSystem;
using NPOI.SS.UserModel;

using EAFrame.Core.Web;
using EAFrame.Core.Enums;
using EAFrame.Core.Extensions;

using SunTek.Register.Domain;
using SunTek.Register.Service;

namespace WebSite.Register
{
    public partial class ImportRegisterExcel : BasePage
    {
        private RegisterService registerService = new RegisterService();
        private string type = string.Empty;
        private string complete = string.Empty;
        private ManagerType managerType;
        private string registerType = string.Empty;
        private string yearMonth = string.Empty;
        private HSSFWorkbook workbook;
        private HSSFSheet sheet;

        public override bool Authorize(EAFrame.Core.Authentication.User user, string requestUrl, bool isForce)
        {
            return base.Authorize(user, requestUrl, false);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpPostedFile file = Request.Files["FileData"];
            workbook = new HSSFWorkbook(file.InputStream);
            sheet = (HSSFSheet)workbook.GetSheetAt(0);

            type = string.IsNullOrEmpty(Request["type"]) ? string.Empty : Request["type"].ToString();
            complete = Request["complete"] ?? string.Empty;
            yearMonth = Request["yearMonth"].ToString();
            managerType = (ManagerType)Enum.Parse(typeof(ManagerType), type);
            registerType = RemarkAttribute.GetEnumRemark(managerType);

            string filePath = complete == "1" ? "FileTemplate\\Register\\Complete" : "FileTemplate\\Register"; ;
            string fileName = complete == "1" ? string.Format("Complete{0}.xml", managerType.ToString()) : string.Format("{0}.xml", managerType.ToString());
            string template = Path.Combine(Path.Combine(Server.MapPath("~"), filePath), fileName);//Excel单位格配置xml模板
            ImportRegister(template);
        }

        /// <summary>
        /// 导入读取Excel数据 
        /// </summary>
        /// <param name="sheet"></param>
        /// <param name="workbook"></param>
        private void ImportRegister(string template)
        {
            string sheetName;

            AjaxResult ajaxResult = new AjaxResult();

            ActionResult actionResult = ActionResult.Failed;
            string actionMessage = string.Empty;
            try
            {
                int rowNum = sheet.PhysicalNumberOfRows - 1;
                if (rowNum == 0)
                {
                    actionResult = ActionResult.Other;
                    actionMessage = "该Excel数据为空，不能导入！";
                }
                else
                {

                    for (int i = 1; i < rowNum; i++)
                    {
                        if (string.IsNullOrWhiteSpace(sheet.GetRow(i).GetCell(1).ToSafeString()))
                        {
                            rowNum = i - 1;
                            break;
                        }
                    }
                    sheetName = sheet.SheetName;
                    string temp = complete == "1" ? string.Format("{0}(完整)", registerType) : registerType;
                    if (sheetName == temp)
                    {
                        //保存员工信息
                        if (SaveRegister(template, rowNum))
                        {
                            actionResult = ActionResult.Success;
                            actionMessage = "导入数据成功！";
                        }
                        else
                        {
                            actionMessage = "保存名册信息出错！";
                        }
                    }
                    else
                    {
                        actionResult = ActionResult.Other;
                        actionMessage = "不能导入该Excel,请导入正确的模板！";
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(string.Format("导入{0}名册出错!", registerType), ex);
                actionMessage = "导入名册信息出错";
            }

            ajaxResult.PromptMsg = actionMessage;
            ajaxResult.ActionResult = actionResult;
            Response.Write(JsonConvert.SerializeObject(ajaxResult));
        }

        /// <summary>
        /// 保存数据
        /// </summary>
        /// <param name="templatePath"></param>
        /// <param name="rowCount"></param>
        /// <returns></returns>
        private bool SaveRegister(string templatePath, int rowCount)
        {
            try
            {
                //读取Excel数据
                RegisterModel model = SunTek.LAMS.Uitl.ExcelUtil.CreateFromExcel<RegisterModel>(templatePath, (row, column) =>
                {
                    try
                    {
                        Cell cell = sheet.GetRow(row).GetCell(column);
                        if (cell == null) return null;
                        string value = cell.CellType == CellType.BLANK ? null : cell.ToSafeString();

                        return value;
                    }
                    catch (Exception ex)
                    {
                        log.Error(string.Format("获取名册Excel单元格信息出错，【行，列】＝【{0],{1}】", row, column), ex);
                        Response.Write("0&获取Excel单元格信息出错!");
                    }
                    return string.Empty;
                }, rowCount);
                //保存数据
                if (complete == "1")
                {
                    registerService.SaveCompleteRegister(model, registerType, User.ID, User.CorpID, yearMonth);
                    //SavePic(model); //保存照片
                }

                else
                {
                    registerService.SaveRegisterModel(model, registerType, User.ID, User.CorpID, yearMonth);
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return false;
            }
            return true;
        }

        /// <summary>
        /// 保存人员照片
        /// </summary>
        private void SavePic(RegisterModel model)
        {
            string code = string.Empty;
            try
            {
                IList lst = workbook.GetAllPictures(); //获取所有图片
                if (lst.Count == 0) return;
                HSSFPictureData pic;
                int i = 0;
                foreach (var item in model.RegisterInfos)
                {
                    code = item.Code;
                    pic = (HSSFPictureData)lst[i];
                    byte[] data = pic.Data;
                    File.WriteAllBytes(Path.Combine(SunTek.LAMS.LAMSContext.EmployeePhotoDirectory, code + ".jpg"), data);
                    i++;
                }
            }
            catch (Exception ex)
            {
                log.Error(string.Format("保存Excel中的人员照片出错，人员Code={0}", code), ex);
            }
        }
    }
}