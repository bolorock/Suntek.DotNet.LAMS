using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;

namespace Suntek.SAPService
{
    public class SAPServiceBll
    {
        /// <summary>
        /// 调用SAP接口提供的方法,得到某一SAPID的员工信息
        /// </summary>
        /// <param name="pernrXml"></param>
        /// <returns></returns>
        public string GetHrInfoForEss(string pernrXml)
        {
            string rets = string.Empty;
            string sapWSUrl = ConfigurationManager.AppSettings["SAPWSUrl"].ToString();

            if (ConfigurationManager.AppSettings["IsSAPLocal"] == "true")
            {
                Suntek.SAPService.ESS_GET_WS_local.ESS_GET_WS xwork_local = new Suntek.SAPService.ESS_GET_WS_local.ESS_GET_WS();
                xwork_local.Url = sapWSUrl; //global::Longtek.HR.CMMS.Utility.SqlHelper.SAPWSUrl;
                rets = xwork_local.GetHrInfoForEss(pernrXml);
            }
            else
            {
                Suntek.SAPService.ESS_GET_WS.ESS_GET_WS xwork = new Suntek.SAPService.ESS_GET_WS.ESS_GET_WS();
                xwork.Url = sapWSUrl; //global::Longtek.HR.CMMS.Utility.SqlHelper.SAPWSUrl;
                rets = xwork.GetHrInfoForEss(pernrXml);
            }

            return rets;
        }

        //public string GetPernrInfo(string sapid)
        //{
        //    string rets = string.Empty;

        //    Longtek.HR.CMMS.ServiceAgent.ESS_GET_WS.ESS_GET_WS xwork = new Longtek.HR.CMMS.ServiceAgent.ESS_GET_WS.ESS_GET_WS();
        //    xwork.Url = global::Longtek.HR.CMMS.Utility.SqlHelper.SAPWSUrl;

        //    rets = xwork.GetPernrInfo(sapid);

        //    return rets;
        //}

        /// <summary>
        /// 测试用方法
        /// </summary>
        /// <param name="pernrXml"></param>
        /// <returns></returns>
//        public string GetHrInfoForEss(string pernrXml)
//        {
//            string rets = @"<ns0:ZRFC_ESS_GET_Response xmlns:ns0='http://ESHORE_EAI_ESS.OutputXml'>
// <ZSTR_BASIC_INFOR>
//    <PERNR>44000008</PERNR>
//    <ENAME>辛 钢平</ENAME>
//    <GESCH>1</GESCH>
//    <ZJG>广东海丰</ZJG>
//    <GBORT>广东海丰</GBORT>
//    <GBDAT>19640721</GBDAT>
//    <ICNUM>440511196407210057</ICNUM>
//    <RACKY>HA</RACKY>
//    <BEGDA>19871001</BEGDA>
//    <PCODE>01</PCODE>
//    <ZHEALTH1>01</ZHEALTH1>
//    <ZFAVOR></ZFAVOR>
//  </ZSTR_BASIC_INFOR>
//  <ZSTR_POSIT_INFOR>
//    <WERKS>GD32</WERKS>
//    <STELL>10000103</STELL>
//    <PLANS>50007526</PLANS>
//    <ORGEH>50007219</ORGEH>
//    <PBTXT>省本部二级经理</PBTXT>
//    <ORGTX>部门正副职</ORGTX>
//    <PLSTX>工会副主席</PLSTX>
//    <STLTX>管理三岗</STLTX>
//    <BEGDA>20000401</BEGDA>
//    <DAT03>19880701</DAT03>
//  </ZSTR_POSIT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>19941202</BEGDA>
//    <ENDDA>19970221</ENDDA>
//    <JOBTY></JOBTY>
//    <JOBDS>省邮电管理局办公室法规科副科长</JOBDS>
//    <APPRU>粤局政字[94] 60号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>19970221</BEGDA>
//    <ENDDA>19980415</ENDDA>
//    <JOBTY></JOBTY>
//    <JOBDS>省邮电管理局办公室法规科科长</JOBDS>
//    <APPRU>粤邮人[1997]15号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>19980415</BEGDA>
//    <ENDDA>19981230</ENDDA>
//    <JOBTY></JOBTY>
//    <JOBDS>省局办公室主任助理</JOBDS>
//    <APPRU>粤邮党[1998]25号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>19981230</BEGDA>
//    <ENDDA>20000430</ENDDA>
//    <JOBTY></JOBTY>
//    <JOBDS>省局法律事务部副主任</JOBDS>
//    <APPRU>粤局党[1999]2号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>20000430</BEGDA>
//    <ENDDA>20000719</ENDDA>
//    <JOBTY></JOBTY>
//    <JOBDS>省局法律事务部主任</JOBDS>
//    <APPRU>粤局党[2000]21号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>20000719</BEGDA>
//    <ENDDA>20020415</ENDDA>
//    <JOBTY></JOBTY>
//    <JOBDS>省公司法律事务部主任</JOBDS>
//    <APPRU>广东电信人力[2000]53号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>20020415</BEGDA>
//    <ENDDA>20050624</ENDDA>
//    <JOBTY></JOBTY>
//    <JOBDS>兼任省公司综合办公室主任</JOBDS>
//    <APPRU>广东电信人力[2002]106号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>20050624</BEGDA>
//    <ENDDA>20060425</ENDDA>
//    <JOBTY>1003</JOBTY>
//    <JOBDS>珠海市分公司党组书记</JOBDS>
//    <APPRU>广东电信党组[2005]42号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>20050624</BEGDA>
//    <ENDDA>20060425</ENDDA>
//    <JOBTY>1003</JOBTY>
//    <JOBDS>珠海市分公司总经理、电信局局长</JOBDS>
//    <APPRU>广东电信人力[2005]131号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>20060425</BEGDA>
//    <ENDDA>20061119</ENDDA>
//    <JOBTY>1003</JOBTY>
//    <JOBDS>省公司综合办公室主任</JOBDS>
//    <APPRU>广东电信人力[2006]29 号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>20061120</BEGDA>
//    <ENDDA>20061226</ENDDA>
//    <JOBTY>1003</JOBTY>
//    <JOBDS>省公司综合部总经理</JOBDS>
//    <APPRU>广东电信人力[2006]94号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>20061227</BEGDA>
//    <ENDDA>20071223</ENDDA>
//    <JOBTY>1003</JOBTY>
//    <JOBDS>省公司转型业务拓展部总经理</JOBDS>
//    <APPRU>广东电信人力[2006]146号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_APPOINT_INFOR>
//    <BEGDA>20071211</BEGDA>
//    <ENDDA>99991231</ENDDA>
//    <JOBTY>1003</JOBTY>
//    <JOBDS>省电信工会副主席</JOBDS>
//    <APPRU>广东公司党组[2007]94号</APPRU>
//  </IT_APPOINT_INFOR>
//  <IT_DEGREE_INFOR>
//    <INSTI>华南理工大学管理学院</INSTI>
//    <ZSXZY>管理科学与工程</ZSXZY>
//    <ZXXFSBC>00000002</ZXXFSBC>
//    <SLART>01</SLART>
//    <SLABS>01</SLABS>
//    <BEGDA>20020901</BEGDA>
//    <ENDDA>20071228</ENDDA>
//  </IT_DEGREE_INFOR>
//  <IT_DEGREE_INFOR>
//    <INSTI>汕头大学</INSTI>
//    <ZSXZY>法学</ZSXZY>
//    <ZXXFSBC>00000001</ZXXFSBC>
//    <SLART>03</SLART>
//    <SLABS>03</SLABS>
//    <BEGDA>19840901</BEGDA>
//    <ENDDA>19880715</ENDDA>
//  </IT_DEGREE_INFOR>
//  <IT_DEGREE_INFOR>
//    <INSTI>华南理工大学</INSTI>
//    <ZSXZY>工商管理</ZSXZY>
//    <ZXXFSBC>00000002</ZXXFSBC>
//    <SLART>10</SLART>
//    <SLABS>02</SLABS>
//    <BEGDA>20000901</BEGDA>
//    <ENDDA>20030401</ENDDA>
//  </IT_DEGREE_INFOR>
//  <IT_FAMILY_INFOR>
//    <FAMSA>1</FAMSA>
//    <FCNAM>刘智连</FCNAM>
//    <FASEX>2</FASEX>
//    <FGBDT>19640907</FGBDT>
//    <ZDW>中国邮政广东公司</ZDW>
//    <ZZW></ZZW>
//    <ZDW_ZZW>中国邮政广东公司</ZDW_ZZW>
//  </IT_FAMILY_INFOR>
//  <IT_FAMILY_INFOR>
//    <FAMSA>2</FAMSA>
//    <FCNAM>辛凯颖</FCNAM>
//    <FASEX>2</FASEX>
//    <FGBDT>19920501</FGBDT>
//    <ZDW>广州市第十七中学</ZDW>
//    <ZZW>学生</ZZW>
//    <ZDW_ZZW>广州市第十七中学学生</ZDW_ZZW>
//  </IT_FAMILY_INFOR>
//  <IT_JOB_INFOR>
//    <ZYJSZWZLDM>Z7</ZYJSZWZLDM>
//    <ZYJSZWDM>Z702</ZYJSZWDM>
//    <ZYJSZWDJDM>02</ZYJSZWDJDM>
//    <ZYJSZWMC>高级经济师</ZYJSZWMC>
//  </IT_JOB_INFOR>
//  <IT_STELL_INFOR>
//    <BEGDA>20000401</BEGDA>
//    <ENDDA>99991231</ENDDA>
//    <STELL>10000103</STELL>
//  </IT_STELL_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>19880718</BEGDA>
//    <ENDDA>19941201</ENDDA>
//    <ZDW>广东省邮电管理局经营运筹办、办公室</ZDW>
//    <ZZW>干部</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>19941201</BEGDA>
//    <ENDDA>19970201</ENDDA>
//    <ZDW>广东省邮电管理局办公室法规科</ZDW>
//    <ZZW>副科长</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>19970201</BEGDA>
//    <ENDDA>19980401</ENDDA>
//    <ZDW>广东省邮电管理局办公室法规科</ZDW>
//    <ZZW>科长</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>19980401</BEGDA>
//    <ENDDA>19981201</ENDDA>
//    <ZDW>广东省邮电管理局办公室</ZDW>
//    <ZZW>主任助理</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>19981230</BEGDA>
//    <ENDDA>20000418</ENDDA>
//    <ZDW>广东省邮电管理局法律事务部</ZDW>
//    <ZZW>副主任(主持工作）</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>20000401</BEGDA>
//    <ENDDA>20000718</ENDDA>
//    <ZDW>广东省邮电管理局法律事务部</ZDW>
//    <ZZW>主任</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>20000719</BEGDA>
//    <ENDDA>20020415</ENDDA>
//    <ZDW>广东省电信公司法律事务部</ZDW>
//    <ZZW>主任</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>20020415</BEGDA>
//    <ENDDA>20050624</ENDDA>
//    <ZDW>广东省电信公司公司综合办公室、法律事务部</ZDW>
//    <ZZW>综合办主任兼法律事务部主任</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>20050624</BEGDA>
//    <ENDDA>20060425</ENDDA>
//    <ZDW>广东省电信有限公司珠海市分公司、电信局</ZDW>
//    <ZZW>总经理、局长、党组书记</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>20060425</BEGDA>
//    <ENDDA>20061119</ENDDA>
//    <ZDW>广东省电信有限公司综合办公室</ZDW>
//    <ZZW>主任</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>20061120</BEGDA>
//    <ENDDA>20061226</ENDDA>
//    <ZDW>省公司综合部</ZDW>
//    <ZZW>总经理</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>20061227</BEGDA>
//    <ENDDA>20071211</ENDDA>
//    <ZDW>省公司转型业务拓展部</ZDW>
//    <ZZW>总经理</ZZW>
//  </IT_WORK_INFOR>
//  <IT_WORK_INFOR>
//    <BEGDA>20071212</BEGDA>
//    <ENDDA>99991231</ENDDA>
//    <ZDW>省电信工会</ZDW>
//    <ZZW>副主席</ZZW>
//  </IT_WORK_INFOR>
//</ns0:ZRFC_ESS_GET_Response>";
//            return rets;
//        }

    }
}
