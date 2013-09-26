<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="EmployeeRegister.aspx.cs" Inherits="WebSite.Register.EmployeeRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <style type="text/css">
        table
        {
            font-size: 12px;
            border: 1px solid #DEDEDE;
            border-collapse: collapse;
            width: 100%;
            padding: 2px;
            table-layout: fixed;
        }
        table th
        {
            background-color: #3E6197;
            color: #E6FFFF;
            text-align: left;
            border: 1px solid #DEDEDE;
        }
        table td
        {
            empty-cells: show;
            border: 1px solid #DEDEDE;
            white-space: nowrap;
        }
    </style>
    <script type="text/javascript" language="javascript">

        $(function () {
            if (($.browser.msie && $.browser.version == '8.0') || (!$.browser.msie)) {
                $("#divTable").css({ "height": "100%", "overflow-x": "hidden", "overflow-y": "auto" });
                $(" html, body, form").css({ "margin": "0px", "height": "100%" });
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div id="divTable">
        <table id="tbInfo" style="background-color: White;">
            <tr>
                <td class="toptitle5" colspan="7" height="20">
                    <div class="toptitle">
                        员工情况登记表</div>
                </td>
            </tr>
            <tr>
                <td>
                    姓名
                </td>
                <td style="width: 126px;">
                    <%= sapBaseInfo.ENAME %>
                </td>
                <td>
                    性别
                </td>
                <td style="width: 126px;">
                    <%= sapBaseInfo.GESCH %>
                </td>
                <td>
                    出生年月
                    <br />
                    (岁数)
                </td>
                <td style="width: 126px;">
                    <%= sapBaseInfo.GBDAT %>
                    <br />
                    (<%= sapBaseInfo.Age %>)
                </td>
                <td width="130px" rowspan="4">
                    <img alt="图片" width="100px;" height="130px;" src="<%= PhotoPath %>" />
                </td>
            </tr>
            <tr>
                <td>
                    民族
                </td>
                <td>
                    <%= sapBaseInfo.RACKY %>
                </td>
                <td>
                    籍贯
                </td>
                <td>
                    <%= sapBaseInfo.ZJG %>
                </td>
                <td>
                    出生地
                </td>
                <td>
                    <%= sapBaseInfo.GBORT %>
                </td>
            </tr>
            <tr>
                <td>
                    政治面貌
                </td>
                <td>
                    <%= sapBaseInfo.PCODE %>
                </td>
                <td>
                    参加工作时间
                </td>
                <td>
                    <%= sapBaseInfo.WorkTime %>
                </td>
                <td>
                    健康状况
                </td>
                <td>
                    <%= sapBaseInfo.HealthState %>
                </td>
            </tr>
            <tr>
                <td>
                    专业技术职务
                </td>
                <td colspan="2">
                    <%= sapBaseInfo.ProfessionalPosition %>
                </td>
                <td>
                    熟悉专业<br />
                    有何专长
                </td>
                <td colspan="2">
                    <%= sapBaseInfo.SpecialtyHobby %>
                </td>
            </tr>
            <tr>
                <td rowspan="2">
                    学历/学位
                </td>
                <td>
                    全日制教育
                </td>
                <td colspan="2">
                    <%= sapBaseInfo.FulltimeEducation%>/<%=sapBaseInfo.FulltimeDegree%>
                </td>
                <td>
                    毕业院校<br />
                    系及专业
                </td>
                <td colspan="2">
                    <%= sapBaseInfo.FulltimeSchool%><br />
                    <%= sapBaseInfo.FulltimeProfessional%>
                </td>
            </tr>
            <tr>
                <td>
                    在职教育
                </td>
                <td colspan="2">
                    <%= sapBaseInfo.ParttimeEducation%>/<%= sapBaseInfo.ParttimeDegree%>
                </td>
                <td>
                    毕业院校<br />
                    系及专业
                </td>
                <td colspan="2">
                    <%= sapBaseInfo.ParttimeSchool%><br />
                    <%= sapBaseInfo.ParttimeProfessional%>
                </td>
            </tr>
            <tr>
                <td>
                    现任职务
                </td>
                <td colspan="6">
                    <%= sapBaseInfo.PLSTX %>
                </td>
            </tr>
            <tr>
                <td>
                    岗位名称
                </td>
                <td colspan="3">
                    <%= sapBaseInfo.PLSTX %>
                </td>
                <td>
                    岗位等级
                </td>
                <td colspan="2">
                    <%= sapBaseInfo.STLTX %>
                </td>
            </tr>
            <!----------简历------->
            <tr>
                <td rowspan="<%= sapWorkExperiences.Count+1 %>" nowrap="nowrap">
                    简历
                </td>
                <td>
                    起始时间
                </td>
                <td>
                    结束时间
                </td>
                <td colspan="3">
                    学习/工作地点
                </td>
                <td>
                    职务
                </td>
            </tr>
            <% foreach (var item in sapWorkExperiences)
               {
            %>
            <tr>
                <td id="StartDate" nowrap="nowrap">
                    <%= item.BEGDA%>
                </td>
                <td id="EndDate" nowrap="nowrap">
                    <%= item.ENDDA%>
                </td>
                <td id="Workplace" colspan="3" nowrap="nowrap">
                    <%= item.ZDW%>
                </td>
                <td id="Position" nowrap="nowrap">
                    <%= item.ZZW%>
                </td>
            </tr>
            <%
               }
            %>
            <!----------简历结束------->

            <!---------任职经历------------>
            <tr>
                <td rowspan="<%= sapAppoints.Count+1 %>" nowrap="nowrap">
                    任职经历
                </td>
                <td>
                    任职时间
                </td>
                <td colspan="3">
                    职务名称
                </td>
                <td>
                    职务岗位等级
                </td>
                <td>
                    任职文号
                </td>
            </tr>
            <% foreach (var item in sapAppoints)
               {
            %>
            <tr>
                <td nowrap="nowrap">
                    <%= item.BEGDA %>
                </td>
                <td colspan="3" nowrap="nowrap">
                    <%= item.JOBDS %>
                </td>
                <td nowrap="nowrap">
                    <%= item.JOBTY %>
                </td>
                <td nowrap="nowrap">
                    <%= item.APPRU %>
                </td>
            </tr>
            <%
               }
            %>
            <!---------任职经历结束---------------->

            <!----------家庭成员------->
            <tr>
                <td rowspan="<%= sapFamilyMembers.Count+1 %>" nowrap="nowrap">
                    家庭成员
                </td>
                <td>
                    称谓
                </td>
                <td>
                    姓名
                </td>
                <td>
                    性别
                </td>
                <td>
                    出生年月
                </td>
                <td colspan="2">
                    工作单位及职位
                </td>
            </tr>
            <% foreach (var item in sapFamilyMembers)
               {
            %>
            <tr>
                <td nowrap="nowrap">
                    <%= item.FAMSA%>
                </td>
                <td nowrap="nowrap">
                    <%= item.FCNAM  %>
                </td>
                <td nowrap="nowrap">
                    <%= item.FASEX%>
                </td>
                <td nowrap="nowrap">
                    <%= item.FGBDT%>
                </td>
                <td colspan="2" nowrap="nowrap">
                    <%= item.ZDW_ZZW %>
                </td>
            </tr>
            <%
               }
            %>
            <!----------家庭成员结束----->
        </table>
    </div>
</asp:Content>
