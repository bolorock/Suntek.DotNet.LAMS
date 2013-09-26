using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EAFrame.Core.Enums;

namespace SunTek.Register.Domain
{
    public class RegisterSummary
    {
        public RegisterSummary() {
            this.IsSummitDetail = new RegisterStatus[Enum.GetNames(typeof(ManagerType)).Length];
        }
        
        /// <summary>
        /// 公司ID
        /// </summary>
        public string CorpID{get;set;}
        /// <summary>
        /// 公司名称
        /// </summary>
        public string CorpName{get;set;}
        /// <summary>
        /// 是否提交
        /// </summary>
        public bool IsSummit{get;set;}
        /// <summary>
        /// 名册人数
        /// </summary>
        public int RegisterSum{get;set;}
        /// <summary>
        /// 提交日期
        /// </summary>
        public DateTime SummitDate{get;set;}

        /// <summary>
        /// 
        /// </summary>
        public RegisterStatus[] IsSummitDetail{get;set;}

    }

    #region 名册管理
    public enum ManagerType
    {
        [Remark("二级经理")]
        RegisterManager2 = 0,
        [Remark("三级经理")]
        RegisterManager3 = 1,
        [Remark("县分公司总经理")]
        CountyManager = 2,
        [Remark("营销中心经理")]
        MarketingManager = 3,
        [Remark("资深经理")]
        SeniorManager = 4
    }

    public enum RegisterStatus
    {
        [Remark("未提交")]
        UnSummit=-1,
        [Remark("未审核")]
        Unaudited = 0,
        [Remark("已确认")]
        Confirmed = 1,
        [Remark("汇总")]
        Summary = 2,
        [Remark("历史状态")]
        HistoryState = 3
    }
    #endregion




}
