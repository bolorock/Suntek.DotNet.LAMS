using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EAFrame.Core.Enums;

namespace WebSite
{
    public enum SubjectType
    {
        [Remark("单选")]
        Radio = 1,
        [Remark("多选")]
        CheckBox = 2,
        [Remark("填空")]
        TextBox = 3,
        [Remark("问答")]
        TextArea = 4,
        [Remark("矩阵")]
        Table = 5,
        [Remark("互斥矩阵")]
        TableBoth = 6,
        [Remark("多维矩阵")]
        TableDim = 7,
    }

    public enum SubjectCategory
    {
        [Remark("360测评")]
        FullTest = 1,
        [Remark("动机测评")]
        Motive = 2,
        [Remark("团队效能测评")]
        Team = 3,
        [Remark("优势与特点测评")]
        Advantage = 4,
        [Remark("Disc测评")]
        Disc = 5,
        [Remark("情景模拟")]
        Time = 6,
        [Remark("案例分析")]
        Case = 7,
        [Remark("关键事件访谈")]
        Talk = 8,
    }

    public enum SurveyResultStatus
    {
        [Remark("初始化")]
        Init = 0,
        [Remark("测评中")]
        InTest = 1,
        [Remark("已完成")]
        Finished = 2,
        [Remark("超时")]
        OverTime = 3
    }

    public enum ExpertStatus
    {
        [Remark("初始化")]
        Init = 0,
        [Remark("评分中")]
        InTest = 1,
        [Remark("已完成")]
        Finished = 2,
        [Remark("超时")]
        OverTime = 3
    }

    /// <summary>
    /// 测评状态
    /// </summary>
    public enum SurveyStatus
    {
        [Remark("未发布")]
        Unpublished = 0,
        [Remark("已发布")]
        Published = 1,
        [Remark("已完成")]
        Finished = 2,
        [Remark("已删除")]
        Delete = 3,
        [Remark("已停用")]
        Stop=4
    }

    public enum UserStatus
    {
        [Remark("正常")]
        Normal = 1,
        [Remark("挂起")]
        Suspend = 2,
        [Remark("注销")]
        Invalid = 3,
        [Remark("锁定")]
        Lock = 4
    }

    public enum AuthMode
    {
        [Remark("本地密码认证")]
        LocalPassword = 1,
        [Remark("LDAP认证")]
        LDAP = 2
    }

    /// <summary>
    /// 后备经理入库状态
    /// </summary>
    public enum CandidateManagerStatus
    {
        [Remark("资格入库")]
        Initialization = 0,
        [Remark("后备汇总")]
        HasStorage = 1,
        [Remark("信息入库")]
        InfoStorage = 2,
        [Remark("已出库")]
        HasDelete = 3
    }

    /// <summary>
    /// 主页部件添加方式
    /// </summary>
    public enum WidgetAddType
    {
        [Remark("自动创建")]
        Auto = 0,
        [Remark("页面直接添加")]
        PageAdd = 1,
        [Remark("链接其它页面")]
        Link = 2
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
        [Remark("未审核")]
        Unaudited=0,
        [Remark("已确认")]
        Confirmed=1,
        [Remark("汇总")]
        Summary=2,
        [Remark("历史状态")]
        HistoryState=3
    }
    #endregion

}