<%@ Page Language="C#"  MasterPageFile="~/Master/Page.Master" AutoEventWireup="true" CodeBehind="CandidateManagerSumReport2.aspx.cs" 
Inherits="WebSite.CandidateManagerSumReport2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <style type="text/css">
        #tblData thead tr th
        {
            font-weight: normal;
            font-size: 12px;
            font-weight: bold;
            color: #2C59AA;
            text-indent: 4px;
            text-align: center;
            background:url(../Skins/Default/Images/th2.gif);
            height: 22px;
            padding: 0;
            border-color: #B5D6E6;
            border: 1px solid #8DB2E3;
        }
        #tblData tr td
        {
        	margin:4px 5px 4px 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
        var str = "<tr><td>1</td><td>全省合计</td>";
        for (var i = 2; i < 24; i++) {
            str += "<td>" + columnAdd(i) + "</td>";
        }
        $("#tblData tbody").find("tr:eq(0)").before(str);
    });

    //所有列相加
    function columnAdd(col) {
        var num = 0;
        $("#tblData tbody tr").find("td:eq(" + col + ")").each(function () {
            num += Number($(this).text());
        });
        return num.toString();
    }

    //导出Excel
    function exportExcel() {
        window.open("ExportReportExcel.aspx?type=1&grade=grade3");
    }
</script>
    <div style="width: 1040px; overflow: auto; height: 100%;">
        <table id="tblData" class="gridview" rules="all" border="1" style="border-collapse: collapse;
            width: 100%; display: inline-table;">
            <thead>
                <tr>
                    <th rowspan="2" nowrap="nowrap">
                        序号
                    </th>
                    <th rowspan="2" nowrap="nowrap">
                        单位名称
                    </th>
                    <th colspan="5" nowrap="nowrap">
                        三级经理后备
                    </th>
                    <th colspan="4" nowrap="nowrap">
                        县分总经理后备
                    </th>
                    <th colspan="4" nowrap="nowrap">
                        后备类型
                    </th>
                    <th colspan="7" nowrap="nowrap">
                        现岗位等级
                    </th>
                    <th colspan="2" nowrap="nowrap">
                        后备成熟度
                    </th>
                </tr>
                <tr>
                    <th nowrap="nowrap">
                        合计
                    </th>
                    <th nowrap="nowrap">
                        三岗后备
                    </th>
                    <th nowrap="nowrap">
                        四岗后备
                    </th>
                    <th nowrap="nowrap">
                        五岗后备
                    </th>
                    <th nowrap="nowrap">
                        六岗后备
                    </th>
                    <th nowrap="nowrap">
                        合计
                    </th>
                    <th nowrap="nowrap">
                        三岗后备
                    </th>
                    <th nowrap="nowrap">
                        四岗后备
                    </th>
                    <th nowrap="nowrap">
                        五岗后备
                    </th>
                    <th nowrap="nowrap">
                        合计
                    </th>
                    <th nowrap="nowrap">
                        综合管理
                    </th>
                    <th nowrap="nowrap">
                        市场经营
                    </th>
                    <th nowrap="nowrap">
                        业务技术
                    </th>
                    <th nowrap="nowrap">
                        合计
                    </th>
                    <th nowrap="nowrap">
                        三岗
                    </th>
                    <th nowrap="nowrap">
                        四岗
                    </th>
                    <th nowrap="nowrap">
                        五岗
                    </th>
                    <th nowrap="nowrap">
                        六岗
                    </th>
                    <th nowrap="nowrap">
                        七岗
                    </th>
                    <th nowrap="nowrap">
                        其他
                    </th>
                    <th nowrap="nowrap">
                        成熟
                    </th>
                    <th nowrap="nowrap">
                        待培养
                    </th>
                </tr>
            </thead>
            <asp:Repeater ID="rptReport" runat="server">
                <ItemTemplate>
                    <tr>
                        <td>
                            <%# 2+Container.ItemIndex %>
                        </td>
                        <td nowrap="nowrap">
                            <%#Eval("CorpName")%>
                        </td>
                        <td>
                            <%#Eval("PostThreeSum").ToInt() + Eval("PostFourSum").ToInt() + Eval("PostFiveSum").ToInt() + Eval("PostSixSum").ToInt() %>
                        </td>
                        <td>
                            <%#Eval("PostThreeSum")%>
                        </td>
                        <td>
                            <%#Eval("PostFourSum")%>
                        </td>
                        <td>
                            <%#Eval("PostFiveSum")%>
                        </td>
                        <td>
                            <%#Eval("PostSixSum")%>
                        </td>
                        <td>
                            <%#Eval("PostThreePresident").ToInt() + Eval("PostFourPresident").ToInt() + Eval("PostFivePresident").ToInt()%>
                        </td>
                        <td>
                            <%#Eval("PostThreePresident")%>
                        </td>
                        <td>
                            <%#Eval("PostFourPresident") %>
                        </td>
                        <td>
                            <%#Eval("PostFivePresident") %>
                        </td>
                        <td>
                            <%#Eval("Integrated").ToInt()+Eval("Market").ToInt()+Eval("Business").ToInt() %>
                        </td>
                        <td>
                            <%#Eval("Integrated")%>
                        </td>
                        <td>
                            <%#Eval("Market") %>
                        </td>
                        <td>
                            <%#Eval("Business") %>
                        </td>
                        <td>
                            <%#Eval("PostThree").ToInt() + Eval("PostFour").ToInt() + Eval("PostFive").ToInt() + Eval("PostSix").ToInt() + Eval("PostSeven").ToInt() + Eval("PostOther").ToInt()%>
                        </td>
                        <td>
                            <%#Eval("PostThree")%>
                        </td>
                        <td>
                            <%#Eval("PostFour") %>
                        </td>
                        <td>
                            <%#Eval("PostFive") %>
                        </td>
                        <td>
                            <%#Eval("PostSix")%>
                        </td>
                        <td>
                            <%#Eval("PostSeven")%>
                        </td>
                        <td>
                            <%#Eval("PostOther") %>
                        </td>
                        <td>
                            <%#Eval("Mature") %>
                        </td>
                        <td>
                            <%#Eval("Cultured") %>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
</asp:Content>
