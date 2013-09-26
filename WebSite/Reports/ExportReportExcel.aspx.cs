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

namespace WebSite
{
    public partial class ExportReportExcel : BasePage
    {
        private CandidateManagerService candidateManagerService = new CandidateManagerService();
        string type = string.Empty;
        string grade = string.Empty;
        string fileName = string.Empty;
        string sheetName = string.Empty;
        string gradeName = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder strXML = new StringBuilder();
            DataTable dt = null;
            type = Request.QueryString["type"] == null ? "0" : Request.QueryString["type"].ToString();
            grade = Request.QueryString["grade"] == null ? string.Empty : Request.QueryString["grade"].ToString();
            switch (type)
            {
                case "0":
                    dt = candidateManagerService.GetCandidateManagerGradeTwoSum();
                    break;
                case "1":
                    dt = candidateManagerService.GetCandidateManagerGradeThreeSum();
                    break;
                case "2":
                    break;
            }
            gradeName = grade == "grade2" ? "二级经理" : "三级经理";
            fileName = gradeName + "后备队伍统计表";
            sheetName = gradeName + "后备统计";
            CreateXML(ref strXML, dt);
            ExportXMLToExcel(this, fileName, strXML.ToString());
        }

        //导出Excel
        public void ExportXMLToExcel(System.Web.UI.Page page, string fileName, string strXML)
        {
            //这里定义下载文件的名称 
            fileName = fileName + ".xls";
            System.Web.HttpResponse httpResponse = page.Response;
            httpResponse.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
            httpResponse.ContentEncoding = System.Text.Encoding.UTF8;
            httpResponse.ContentType = "application/ms-excel";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            tw.Write(strXML);

            string filePath = page.Server.MapPath("") + fileName;
            System.IO.StreamWriter sw = System.IO.File.CreateText(filePath);
            sw.Write(tw.ToString());
            tw.Flush();
            tw.Close();
            sw.Flush();
            sw.Close();

            page.Response.ContentType = "application/vnd.ms-excel";
            page.Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8) + ";charset=utf-8");
            System.IO.FileStream fs = System.IO.File.OpenRead(filePath);
            long fLen = fs.Length;
            int size = 1024;
            //每1K同时下载数据 
            byte[] readData = new byte[size];
            //指定缓冲区的大小 
            if (size > fLen)
            {
                size = Convert.ToInt32(fLen);
            }
            long fPos = 0;
            bool isEnd = false;
            while (!isEnd)
            {
                if ((fPos + size) > fLen)
                {
                    size = Convert.ToInt32(fLen - fPos);
                    readData = new byte[size];
                    isEnd = true;
                }
                fs.Read(readData, 0, size);
                //读入一个压缩块 
                page.Response.BinaryWrite(readData);
                fPos += size;
            }
            fs.Flush();
            fs.Close();
            System.IO.File.Delete(filePath);
            httpResponse.End();
        }

        //创建xml
        public void CreateXML(ref StringBuilder strXML, DataTable dt)
        {
            CreateXMLDocuments(ref strXML, "admin");
            CreateXMLStyle(ref strXML);
            CreateWordBook(ref strXML, dt, sheetName);
        }

        //创建xml文件
        private void CreateXMLDocuments(ref StringBuilder strXML, string lastAuthor)
        {
            strXML.AppendLine("<?xml version=\"1.0\"?>");
            strXML.AppendLine("<?mso-application progid=\"Excel.Sheet\"?>");
            strXML.AppendLine("<Workbook xmlns=\"urn:schemas-microsoft-com:office:spreadsheet\"");
            strXML.AppendLine(" xmlns:o=\"urn:schemas-microsoft-com:office:office\"");
            strXML.AppendLine(" xmlns:x=\"urn:schemas-microsoft-com:office:excel\"");
            strXML.AppendLine(" xmlns:ss=\"urn:schemas-microsoft-com:office:spreadsheet\"");
            strXML.AppendLine(" xmlns:html=\"http://www.w3.org/TR/REC-html40\">");

            strXML.AppendLine(" <DocumentProperties xmlns=\"urn:schemas-microsoft-com:office:office\">");
            strXML.AppendLine("  <Author>sysdba</Author>");
            strXML.AppendLine("  <LastAuthor>" + lastAuthor + "</LastAuthor>");
            strXML.AppendLine("  <Created>" + DateTime.Now + "</Created>");
            strXML.AppendLine("  <LastSaved>" + DateTime.Now + "</LastSaved>");
            strXML.AppendLine("  <Company>Suntek</Company>");
            strXML.AppendLine("  <Version>12.00</Version>");
            strXML.AppendLine(" </DocumentProperties>");

            strXML.AppendLine(" <ExcelWorkbook xmlns=\"urn:schemas-microsoft-com:office:excel\">");
            strXML.AppendLine("  <WindowHeight>11370</WindowHeight>");
            strXML.AppendLine("  <WindowWidth>18195</WindowWidth>");
            strXML.AppendLine("  <WindowTopX>300</WindowTopX>");
            strXML.AppendLine("  <WindowTopY>2100</WindowTopY>");
            strXML.AppendLine("  <ProtectStructure>False</ProtectStructure>");
            strXML.AppendLine("  <ProtectWindows>False</ProtectWindows>");
            strXML.AppendLine(" </ExcelWorkbook>");
        }

        //创建xml样式
        private void CreateXMLStyle(ref StringBuilder strXML)
        {
            strXML.AppendLine("<Styles>");
            strXML.AppendLine("<Style ss:ID=\"Default\" ss:Name=\"Normal\">");
            strXML.AppendLine("<Alignment ss:Vertical=\"Center\"/>");
            strXML.AppendLine("<Borders/>");
            strXML.AppendLine("<Font ss:FontName=\"宋体\" x:CharSet=\"134\" ss:Size=\"11\" ss:Color=\"#000000\"/>");
            strXML.AppendLine("<Interior/>");
            strXML.AppendLine("<NumberFormat/>");
            strXML.AppendLine("<Protection/>");
            strXML.AppendLine("</Style>");
            strXML.AppendLine("<Style ss:ID=\"s16\" ss:Name=\"??\">");
            strXML.AppendLine("<Alignment ss:Vertical=\"Bottom\"/>");
            strXML.AppendLine("<Borders/>");
            strXML.AppendLine("<Font ss:FontName=\"宋体\" x:CharSet=\"134\" ss:Size=\"12\"/>");
            strXML.AppendLine("<Interior/>");
            strXML.AppendLine("<NumberFormat/>");
            strXML.AppendLine("<Protection/>");
            strXML.AppendLine("</Style>");
            strXML.AppendLine("<Style ss:ID=\"s64\" ss:Parent=\"s16\">");
            strXML.AppendLine("<Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Center\" ss:WrapText=\"1\"/>");
            strXML.AppendLine("<Borders>");
            strXML.AppendLine(" <Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>");
            strXML.AppendLine("<Border ss:Position=\"Left\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>");
            strXML.AppendLine("<Border ss:Position=\"Right\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>");
            strXML.AppendLine("<Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>");
            strXML.AppendLine(" </Borders>");
            strXML.AppendLine("<Font ss:FontName=\"宋体\" x:CharSet=\"134\" ss:Size=\"11\"/>");
            strXML.AppendLine("<Interior ss:Color=\"#99CCFF\" ss:Pattern=\"Solid\"/>");
            strXML.AppendLine(" <NumberFormat ss:Format=\"@\"/>");
            strXML.AppendLine("</Style>");
            strXML.AppendLine("<Style ss:ID=\"s82\"  ss:Parent=\"s16\">");
            strXML.AppendLine("<Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Center\"/>");
            strXML.AppendLine("<Font ss:FontName=\"宋体\" x:CharSet=\"134\" ss:Size=\"20\" ss:Bold=\"1\"/>");
            strXML.AppendLine("<Interior/>");
            strXML.AppendLine("<NumberFormat ss:Format=\"@\"/>");
            strXML.AppendLine("</Style>");
            strXML.AppendLine("<Style ss:ID=\"s66\" ss:Parent=\"s16\">");
            strXML.AppendLine("<Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Center\"/>");
            strXML.AppendLine("<Borders>");
            strXML.AppendLine("<Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>");
            strXML.AppendLine("<Border ss:Position=\"Left\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>");
            strXML.AppendLine("<Border ss:Position=\"Right\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>");
            strXML.AppendLine("<Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\"/>");
            strXML.AppendLine("</Borders>");
            strXML.AppendLine("<Font ss:FontName=\"宋体\" x:CharSet=\"134\"/>");
            strXML.AppendLine("<Interior/>");
            strXML.AppendLine("<NumberFormat ss:Format=\"@\"/>");
            strXML.AppendLine("</Style>");
            strXML.AppendLine("</Styles>");


        }

        //创建Worksheet
        private void CreateWordBook(ref StringBuilder strXML, DataTable dt, string sheetName)
        {
            //开始一个worksheet
            strXML.AppendLine(" <Worksheet ss:Name=\"" + sheetName + "\">");
            strXML.AppendLine("  <Table x:FullColumns=\"1\"");
            strXML.AppendLine("   x:FullRows=\"1\" ss:DefaultColumnWidth=\"54\"");
            strXML.AppendLine("   ss:DefaultRowHeight=\"15.9375\">");

            string title = string.Empty;
            int mergeAcross = 0;
            if (type == "0")
            {
                title = gradeName + "后备队伍统计表";
                mergeAcross = 19;
            }
            else if (type == "1")
            {
                title = gradeName + "后备队伍统计表";
                mergeAcross = 23;
            }
            


            strXML.AppendLine("<Row ss:AutoFitHeight=\"0\" ss:Height=\"33\">");
            strXML.AppendLine("<Cell ss:MergeAcross=\"" + mergeAcross + "\" ss:StyleID=\"s82\"><Data ss:Type=\"String\">" + title + "</Data></Cell>");
            strXML.AppendLine("</Row>");

            //第一行，列名行
            if (type == "0")
            {
                strXML.AppendLine("<Row ss:AutoFitHeight=\"0\" ss:Height=\"27\">");
                strXML.AppendLine("<Cell ss:MergeDown=\"1\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">序号</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeDown=\"1\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">单位名称</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeDown=\"1\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">二级经理后备合计</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeAcross=\"2\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">正职后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeAcross=\"2\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">副职后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeAcross=\"3\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">后备类型</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeAcross=\"4\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">现岗位等级</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeAcross=\"1\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">后备成熟度</Data></Cell>");
                strXML.AppendLine("</Row>");
                strXML.AppendLine("<Row ss:AutoFitHeight=\"0\" ss:Height=\"35.25\" ss:StyleID=\"s64\">");
                strXML.AppendLine("<Cell ss:Index=\"4\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">合计</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">二岗正职后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">三岗正职后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">合计</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">三岗副职后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">四岗副职后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">合计</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">综合管理</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">市场经营</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">业务技术</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">合计</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">三岗</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">四岗</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">五岗</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">其他</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">成熟</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">待培养</Data></Cell>");
                strXML.AppendLine("</Row>");

                AddGradeTwoColumns(dt);
                dt=AddSumRow(dt, 1, 18);//添加合计行
            }
            else if (type == "1")
            {
                strXML.AppendLine("<Row ss:AutoFitHeight=\"0\" ss:Height=\"27\">");
                strXML.AppendLine("<Cell ss:MergeDown=\"1\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">序号</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeDown=\"1\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">单位名称</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeAcross=\"4\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">三级经理后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeAcross=\"3\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">县分总经理后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeAcross=\"3\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">后备类型</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeAcross=\"6\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">现岗位等级</Data></Cell>");
                strXML.AppendLine("<Cell ss:MergeAcross=\"1\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">后备成熟度</Data></Cell>");
                strXML.AppendLine("</Row>");
                strXML.AppendLine("<Row ss:AutoFitHeight=\"0\" ss:Height=\"35.25\" ss:StyleID=\"s64\">");
                strXML.AppendLine("<Cell ss:Index=\"3\" ss:StyleID=\"s64\"><Data ss:Type=\"String\">合计</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">三岗后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">四岗后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">五岗后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">六岗后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">合计</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">三岗后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">四岗后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">五岗后备</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">合计</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">综合管理</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">市场经营</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">业务技术</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">合计</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">三岗</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">四岗</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">五岗</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">六岗</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">七岗</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">其它</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">成熟</Data></Cell>");
                strXML.AppendLine("<Cell ss:StyleID=\"s64\"><Data ss:Type=\"String\">待培养</Data></Cell>");
                strXML.AppendLine("</Row>");

                AddGradeThreeColumns(dt);
                dt=AddSumRow(dt, 1, 22);//添加合计行
            }

            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                strXML.AppendLine("<Row ss:AutoFitHeight=\"0\" ss:Height=\"30.75\">");
                strXML.AppendLine("<Cell ss:StyleID=\"s66\"><Data ss:Type=\"String\">" + (i + 1) + "</Data></Cell>");
                for (int j = 0; j <= mergeAcross - 1; j++)
                {
                    strXML.AppendLine("<Cell ss:StyleID=\"s66\"><Data ss:Type=\"String\">" + dt.Rows[i][j].ToString() + "</Data></Cell>");
                }
                strXML.AppendLine("</Row>");
            }

            strXML.AppendLine("  </Table>");
            strXML.AppendLine("  <WorksheetOptions xmlns=\"urn:schemas-microsoft-com:office:excel\">");
            strXML.AppendLine("   <Print>");
            strXML.AppendLine("    <ValidPrinterInfo/>");
            strXML.AppendLine("    <PaperSizeIndex>9</PaperSizeIndex>");
            strXML.AppendLine("    <HorizontalResolution>1200</HorizontalResolution>");
            strXML.AppendLine("    <VerticalResolution>1200</VerticalResolution>");
            strXML.AppendLine("   </Print>");
            strXML.AppendLine("   <Selected/>");
            strXML.AppendLine("   <Panes>");
            strXML.AppendLine("    <Pane>");
            strXML.AppendLine("     <Number>3</Number>");
            strXML.AppendLine("     <ActiveRow>1</ActiveRow>");
            strXML.AppendLine("    </Pane>");
            strXML.AppendLine("   </Panes>");
            strXML.AppendLine("   <ProtectObjects>False</ProtectObjects>");
            strXML.AppendLine("   <ProtectScenarios>False</ProtectScenarios>");
            strXML.AppendLine("  </WorksheetOptions>");
            strXML.AppendLine(" </Worksheet>");
            strXML.AppendLine("</Workbook>");
        }
        private void AddGradeTwoColumns(DataTable dt)
        {
            //添加列
            dt.Columns.Add(new DataColumn("后备类型合计"));
            dt.Columns.Add(new DataColumn("现岗位等级合计"));
            dt.Columns.Add(new DataColumn("Order"));//排序列，目的是把"全省合计"放在第一行
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                dt.Rows[i]["Order"] = i + 1;
                dt.Rows[i]["后备类型合计"] = dt.Rows[i][8].ToInt() + dt.Rows[i][9].ToInt() + dt.Rows[i][10].ToInt();
                dt.Rows[i]["现岗位等级合计"] = dt.Rows[i][11].ToInt() + dt.Rows[i][12].ToInt() + dt.Rows[i][13].ToInt() + dt.Rows[i][14].ToInt();
            }
            dt.Columns["后备类型合计"].SetOrdinal(8);
            dt.Columns["现岗位等级合计"].SetOrdinal(12);
        }

        private void AddGradeThreeColumns(DataTable dt)
        {
            //添加列
            dt.Columns.Add(new DataColumn("三级经理后备合计"));
            dt.Columns.Add(new DataColumn("县分总经理后备合计"));
            dt.Columns.Add(new DataColumn("后备类型合计"));
            dt.Columns.Add(new DataColumn("现岗位等级合计"));
            dt.Columns.Add(new DataColumn("Order"));//排序列，目的是把"全省合计"放在第一行
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                dt.Rows[i]["Order"] = i + 1;
                dt.Rows[i]["三级经理后备合计"] = dt.Rows[i][1].ToInt() + dt.Rows[i][2].ToInt() + dt.Rows[i][3].ToInt() + dt.Rows[i][4].ToInt();
                dt.Rows[i]["县分总经理后备合计"] = dt.Rows[i][5].ToInt() + dt.Rows[i][6].ToInt() + dt.Rows[i][7].ToInt();
                dt.Rows[i]["后备类型合计"] = dt.Rows[i][8].ToInt() + dt.Rows[i][9].ToInt() + dt.Rows[i][10].ToInt();
                dt.Rows[i]["现岗位等级合计"] = dt.Rows[i][11].ToInt() + dt.Rows[i][12].ToInt() + dt.Rows[i][13].ToInt() + dt.Rows[i][14].ToInt() + dt.Rows[i][15].ToInt();
            }
            dt.Columns["三级经理后备合计"].SetOrdinal(1);
            dt.Columns["县分总经理后备合计"].SetOrdinal(6);
            dt.Columns["后备类型合计"].SetOrdinal(10);
            dt.Columns["现岗位等级合计"].SetOrdinal(14);
        }

        private DataTable AddSumRow(DataTable dt,int sIndex,int eIndex)
        {
            int sum=0;
           
            //添加行
            DataRow row = dt.NewRow();
            row[0]="全省合计";
            for (int i = sIndex; i <= eIndex; i++)
            {
                for (int j = 0; j <= dt.Rows.Count - 1; j++)
                {
                    sum += dt.Rows[j][i].ToInt();
                }
                row[i] = sum;
                sum = 0;
            }
            row["Order"] = 0;
            dt.Rows.Add(row);

            //调整行和列的位置
            DataView dv = dt.DefaultView;
            dv.Sort = "Order";
            return dv.ToTable();
        }
    }
}