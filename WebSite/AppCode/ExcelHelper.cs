using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;   
using System.IO;   
using System.Text;    
using NPOI;   
using NPOI.HPSF;   
using NPOI.HSSF;   
using NPOI.HSSF.UserModel;   
using NPOI.HSSF.Util;   
using NPOI.POIFS;   
using NPOI.Util;
using NPOI.SS.UserModel;

namespace WebSite
{
    public class ExcelHelper
    {
        /// <summary>  
        /// DataTable导出到Excel的MemoryStream  
        /// </summary>  
        /// <param name="dt">源DataTable</param>  
        /// <param name="sheetName">sheet名称</param>
        /// <param name="headerText">表头文本</param>   
        /// <param name="columnName">key:英文字段,value:中文显示</param>
        /// <param name="numCellShow">是否显示序号列</param>
        /// <param name="headerRowIndex">标题列开始行</param>
        /// <param name="columnRowIndex">列名行开始行</param>
        /// <param name="columnRowMergeDown">列名行跨越行数</param>
        public static MemoryStream Export(DataTable dt,string sheetName,string headerText,
                                          IDictionary<string,string> columnName,bool numCellShow=false,
                                          int headerRowIndex=0,int columnRowIndex=1,int columnRowMergeDown=0,IDictionary<string,int> columnWidth=null)
        {
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = (HSSFSheet)workbook.CreateSheet(sheetName);

            #region 右击文件 属性信息
            {
                DocumentSummaryInformation dsi = PropertySetFactory.CreateDocumentSummaryInformation();
                dsi.Company = "Suntek";
                workbook.DocumentSummaryInformation = dsi;

                SummaryInformation si = PropertySetFactory.CreateSummaryInformation();
                si.Author = "HGQ"; //填加xls文件作者信息  
                si.ApplicationName = "导出Excel"; //填加xls文件创建程序信息  
                si.LastAuthor = "【HGQ】"; //填加xls文件最后保存者信息  
                si.Comments = "说明信息"; //填加xls文件作者信息  
                si.Title = "领导力评估系统"; //填加xls文件标题信息  
                si.Subject = "领导里评估系统导出Excel";//填加文件主题信息  
                si.CreateDateTime = DateTime.Now;
                workbook.SummaryInformation = si;
            }
            #endregion

            HSSFCellStyle dateStyle = (HSSFCellStyle)workbook.CreateCellStyle();
            HSSFDataFormat format = (HSSFDataFormat)workbook.CreateDataFormat();
            dateStyle.DataFormat = format.GetFormat("yyyy-mm-dd");

            HSSFCellStyle stringStyle=(HSSFCellStyle)workbook.CreateCellStyle();
            stringStyle.WrapText = true;
            stringStyle.VerticalAlignment = VerticalAlignment.CENTER;

            //把不显示的列去掉
            for (int i=0; i < dt.Columns.Count; i++)
            {
                if (!columnName.Keys.Contains(dt.Columns[i].ColumnName))
                {
                    dt.Columns.Remove(dt.Columns[i]);
                    dt.AcceptChanges();
                    i--;
                }
            }

           #region 取得列宽  
           //IDictionary<string,int> arrColWidth= columnName.Select(p => 
           //                                             new { 
           //                                                 k = p.Key, 
           //                                                 v = Encoding.GetEncoding(936).GetBytes(p.Value).Length 
           //                                                 })
           //                                             .ToDictionary(c => c.k, c => c.v);

           // for (int i = 0; i < dt.Rows.Count; i++)
           // {
           //     for (int j = 0; j < dt.Columns.Count; j++)
           //     {
           //         int intTemp = Encoding.GetEncoding(936).GetBytes(dt.Rows[i][j].ToString()).Length;
           //         if (intTemp > arrColWidth[dt.Columns[j].ColumnName])
           //         {
           //             arrColWidth[dt.Columns[j].ColumnName] = intTemp;
           //         }
           //     }
           // }
            #endregion

            int rowIndex = headerRowIndex;
            // HSSFPatriarch,它负责管理一个表格里面所有的图片和图形,并且只能创建一个,
            //如果应用程序后来又创建了一个,那么将使以前创造的HSSFPatriarch所管理的图片和图形清除,
            //所以一定要保留HSSFPatriarch的引用直到最后 
            HSSFPatriarch patriarch = sheet.CreateDrawingPatriarch() as HSSFPatriarch;
            foreach (DataRow row in dt.Rows)
            {
                #region 新建表，填充表头，填充列头，样式
                if (rowIndex == 65535 || rowIndex == headerRowIndex)
                {
                    if (rowIndex != headerRowIndex)
                    {
                        sheet =(HSSFSheet)workbook.CreateSheet();
                    }
     
                    //设置表头，列头样式
                    HeadStyle(sheet, workbook, dt, columnName, headerText, rowIndex, columnRowIndex, columnRowMergeDown, numCellShow, columnWidth);

                    rowIndex = columnRowIndex+columnRowMergeDown+1;
                }
                #endregion


                #region 填充内容
                int cellIndex = 0;
                HSSFRow dataRow = (HSSFRow) sheet.CreateRow(rowIndex);
                //添加序号列
                if (numCellShow)
                {
                    HSSFCell NumCell = (HSSFCell)dataRow.CreateCell(0);
                    NumCell.SetCellValue(dt.Rows.IndexOf(row) + 1);
                    cellIndex = 1;
                }

                int columnIndex = 0;
                foreach (var item in columnName)
                {
                    //插入照片
                    if (item.Key == "Photo")
                    {
                        string picPath = Path.Combine(SunTek.LAMS.LAMSContext.EmployeePhotoDirectory,string.Format("{0}.jpg",row["Code"].ToString()));
                        //行高
                        dataRow.Height = 140 * 20;

                        InsertPhoto(picPath, workbook, patriarch, columnIndex, rowIndex);
                        columnIndex++;
                        continue;
                    }
                    HSSFCell newCell = (HSSFCell)dataRow.CreateCell(columnIndex + cellIndex);

                    string drValue = row[item.Key].ToString();

                    switch (dt.Columns[item.Key].DataType.ToString())
                    {
                        case "System.String"://字符串类型  
                            newCell.SetCellValue(drValue);
                            newCell.CellStyle = stringStyle;
                            break;
                        case "System.DateTime"://日期类型  
                            DateTime dateV;
                            DateTime.TryParse(drValue, out dateV);
                            newCell.SetCellValue(dateV);

                            newCell.CellStyle = dateStyle;//格式化显示  
                            break;
                        case "System.Boolean"://布尔型  
                            bool boolV = false;
                            bool.TryParse(drValue, out boolV);
                            newCell.SetCellValue(boolV);
                            break;
                        case "System.Int16"://整型  
                        case "System.Int32":
                        case "System.Int64":
                        case "System.Byte":
                            int intV = 0;
                            int.TryParse(drValue, out intV);
                            newCell.SetCellValue(intV);
                            newCell.CellStyle = stringStyle;
                            break;
                        case "System.Decimal"://浮点型  
                        case "System.Double":
                            double doubV = 0;
                            double.TryParse(drValue, out doubV);
                            newCell.SetCellValue(doubV);
                            break;
                        case "System.DBNull"://空值处理  
                            newCell.SetCellValue("");
                            break;
                        default:
                            newCell.SetCellValue("");
                            break;
                    }
                    columnIndex++;
                }
                #endregion

                rowIndex++;
            }


            using (MemoryStream ms = new MemoryStream())
            {
                workbook.Write(ms);
                ms.Flush();
                ms.Position = 0;

                sheet.Dispose();
                //workbook.Dispose();//一般只用写这一个就OK了，他会遍历并释放所有资源，但当前版本有问题所以只释放sheet  
                return ms;
            }

        }

        /// <summary>
        /// 表头及样式
        /// </summary>
        /// <param name="sheet"></param>
        /// <param name="workbook"></param>
        /// <param name="dt"></param>
        /// <param name="headerText"></param>
        /// <param name="rowIndex"></param>
        /// <param name="numCellShow"></param>
        private static void HeadStyle(HSSFSheet sheet, HSSFWorkbook workbook, DataTable dt, IDictionary<string, string> columnName, string headerText, int rowIndex, int columnRowIndex, int columnRowMergeDown, bool numCellShow, IDictionary<string, int> columnWidth)
        {
            #region 表头及样式
            if (!string.IsNullOrWhiteSpace(headerText))
            {
                HSSFRow headerRow = (HSSFRow)sheet.CreateRow(rowIndex);
                headerRow.HeightInPoints = 25;
                headerRow.CreateCell(0).SetCellValue(headerText);

                HSSFCellStyle headStyle = (HSSFCellStyle)workbook.CreateCellStyle();
                headStyle.Alignment = HorizontalAlignment.CENTER; // CellHorizontalAlignment.CENTER;
                HSSFFont font = (HSSFFont)workbook.CreateFont();
                font.FontHeightInPoints = 20;
                font.Boldweight = 700;
                headStyle.SetFont(font);

                headerRow.GetCell(0).CellStyle = headStyle;

                int lastCol = dt.Columns.Count - 1;
                if (numCellShow)
                    lastCol = lastCol + 1;

                sheet.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowIndex, rowIndex, 0, lastCol));

                //sheet.AddMergedRegion(new Region(0, 0, 0, dt.Columns.Count - 1));
                //headerRow.Dispose();
            }
            #endregion

            #region 列头及样式
            {
                HSSFRow columnHeaderRow = (HSSFRow)sheet.CreateRow(columnRowIndex);
                if (columnWidth != null)
                {
                    columnHeaderRow.Height = 1000; //列头高度
                }

                HSSFCellStyle headStyle = (HSSFCellStyle)workbook.CreateCellStyle();
                headStyle.Alignment = HorizontalAlignment.CENTER;// CellHorizontalAlignment.CENTER;
                headStyle.VerticalAlignment = VerticalAlignment.CENTER; //垂直居中
                HSSFFont font = (HSSFFont)workbook.CreateFont();
                font.FontHeightInPoints = 12;
                // font.Boldweight = 350;
                headStyle.SetFont(font);

                headStyle.FillForegroundColor = NPOI.HSSF.Util.HSSFColor.SKY_BLUE.index;   //图案颜色
                headStyle.FillPattern = NPOI.SS.UserModel.FillPatternType.SPARSE_DOTS;                    //图案样式
                headStyle.FillBackgroundColor = NPOI.HSSF.Util.HSSFColor.SKY_BLUE.index;   //背景颜色
                headStyle.WrapText = true;


                //序号列
                int cellHeadIndex = 0;
                if (numCellShow)
                {
                    columnHeaderRow.CreateCell(0).SetCellValue("序号");
                    columnHeaderRow.GetCell(0).CellStyle = headStyle;

                    if (columnRowMergeDown > 0)
                        sheet.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(columnRowIndex, columnRowIndex + columnRowMergeDown, 0, 0));

                    cellHeadIndex = 1;
                }

                int itemIndex = 0;
                int temp = 0;
                foreach (var item in columnName)
                {
                    //列宽 
                    if (columnWidth != null)
                    {
                        if (item.Key == "Photo")
                        {
                            sheet.SetColumnWidth(itemIndex, columnWidth[item.Key] / 6 * 256);
                        }
                        else
                        {
                            sheet.SetColumnWidth(itemIndex, columnWidth[item.Key] / 5 * 256);
                        }
                    }
                    temp = itemIndex + cellHeadIndex;
                    columnHeaderRow.CreateCell(temp).SetCellValue(item.Value);
                    columnHeaderRow.GetCell(temp).CellStyle = headStyle;
                    sheet.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(columnRowIndex, columnRowIndex + columnRowMergeDown, temp, temp));
                    itemIndex++;
                }

                //foreach (DataColumn column in dt.Columns)
                //{
                //    columnHeaderRow.CreateCell(column.Ordinal + cellHeadIndex).SetCellValue(columnName[column.ColumnName]);
                //    columnHeaderRow.GetCell(column.Ordinal + cellHeadIndex).CellStyle = headStyle;
                //    //设置列宽  
                //   // sheet.SetColumnWidth(column.Ordinal, (arrColWidth[column.ColumnName] + 1) * 256);
                //   // sheet.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(1, 2, column.Ordinal+cellHeadIndex,column.Ordinal+cellHeadIndex));
                //}

                // sheet.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(5, 6, 0, 0));


            }
            #endregion
        }



        /// <summary>
        /// 插入照片
        /// </summary>
        /// <param name="picPath"></param>
        /// <param name="workbook"></param>
        /// <param name="sheet"></param>
        /// <param name="col"></param>
        /// <param name="row"></param>
        private static void InsertPhoto(string picPath, HSSFWorkbook workbook, HSSFPatriarch patriarch, int col, int row)
        {
            try
            { 
                //add picture data to this workbook.
                if (!System.IO.File.Exists(picPath)) return;
                byte[] bytes = System.IO.File.ReadAllBytes(picPath);
                int pictureIdx = workbook.AddPicture(bytes, PictureType.JPEG);
                //add a picture
                HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0, 1023, 255, col, row, col,row);
                anchor.AnchorType = 2;
                HSSFPicture pict = patriarch.CreatePicture(anchor, pictureIdx) as HSSFPicture;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        /// <summary>  
        /// 用于Web导出  
        /// </summary>  
        /// <param name="dt">源DataTable</param>  
        /// <param name="sheetName">sheet名称</param>
        /// <param name="headerText">表头文本</param>   
        /// <param name="columnName">key:英文字段,value:中文显示</param>
        /// <param name="numCellShow">是否显示序号列</param>
        /// <param name="headerRowIndex">标题列开始行</param>
        /// <param name="columnRowIndex">列名行开始行</param>
        /// <param name="columnRowMergeDown">列名行跨越行数</param> 
        /// <param name="isOpen">Excel是否直接打开：如果设置为 attachment 就下载,设置为 inline 就直接打开</param>
        /// <param name="columnWidth">列的宽度</param>
        public static void ExportByWeb(DataTable dt,string sheetName, string fileName, string headerText,
                                      IDictionary<string, string> columnName,bool numCellShow=false,
                                      int headerRowIndex = 0, int columnRowIndex = 1, int columnRowMergeDown = 0,bool isOpen=false,
                                      IDictionary<string,int> columnWidth=null)
        {
            if (fileName.IndexOf(".xls") < 0)
            {
                fileName = fileName + ".xls";
            }
            HttpContext curContext = HttpContext.Current;

            // 设置编码和附件格式  
            curContext.Response.ContentType = "application/vnd.ms-excel";
            curContext.Response.ContentEncoding = Encoding.UTF8;
            curContext.Response.Charset = "";
            curContext.Response.AppendHeader("Content-Disposition", (isOpen ? "inline" : "attachment") + ";filename=" + HttpUtility.UrlEncode(fileName, Encoding.UTF8));
            //如果设置为 attachment 就下载,设置为 inline 就直接打开
            curContext.Response.BinaryWrite(Export(dt, sheetName, headerText, columnName, numCellShow, headerRowIndex, columnRowIndex, columnRowMergeDown,columnWidth).GetBuffer());
            curContext.Response.End();

        }


        /// <summary>读取excel  
        /// 默认第一行为标头  
        /// </summary>  
        /// <param name="strFileName">excel文档路径</param>  
        /// <returns></returns>  
        public static DataTable Import(string strFileName)
        {
            DataTable dt = new DataTable();

            HSSFWorkbook hssfworkbook;
            using (FileStream file = new FileStream(strFileName, FileMode.Open, FileAccess.Read))
            {
                hssfworkbook = new HSSFWorkbook(file);
            }
            HSSFSheet sheet =(HSSFSheet) hssfworkbook.GetSheetAt(0);
            System.Collections.IEnumerator rows = sheet.GetRowEnumerator();

            HSSFRow headerRow = (HSSFRow) sheet.GetRow(0);
            int cellCount = headerRow.LastCellNum;

            for (int j = 0; j < cellCount; j++)
            {
                HSSFCell cell = (HSSFCell) headerRow.GetCell(j);
                dt.Columns.Add(cell.ToString());
            }

            for (int i = (sheet.FirstRowNum + 1); i <= sheet.LastRowNum; i++)
            {
                HSSFRow row = (HSSFRow) sheet.GetRow(i);
                DataRow dataRow = dt.NewRow();

                for (int j = row.FirstCellNum; j < cellCount; j++)
                {
                    if (row.GetCell(j) != null)
                        dataRow[j] = row.GetCell(j).ToString();
                }

                dt.Rows.Add(dataRow);
            }
            return dt;
        }  
    }
}