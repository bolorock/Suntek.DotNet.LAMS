<%@ Page Language="C#"  MasterPageFile="~/Master/Page.Master" AutoEventWireup="true" CodeBehind="CandidateManagerList.aspx.cs" Inherits="WebSite.CandidateManagerList" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>

    <%-- jqgrid --%>
     <link href="../Scripts/Jqgrid/styles/themes/redmond/jquery-ui-1.8.2.custom.css" rel="stylesheet"
         type="text/css" />
    <link type="text/css" rel="stylesheet" href="../Scripts/Jqgrid/styles/ui.jqgrid.css" /> 
<%--    <link type="text/css" rel="stylesheet" href="../Scripts/Jqgrid/styles/ui.multiselect.css" /> 
    <script type="text/javascript" src="../Scripts/Jquery/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.2.custom.min.js"></script> --%>
    <script type="text/javascript" src="../Scripts/Jqgrid/Scripts/i18n/grid.locale-cn.js"></script> 
    <script type="text/javascript" src="../Scripts/Jqgrid/Scripts/jquery.jqGrid.min.js"></script> 
    <%--<script type="text/javascript" src="../Scripts/Jqgrid/Scripts/ui.multiselect.js"></script>--%>

    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            jQuery("#grid").jqGrid({
                url: 'jqgridData.ashx?type=3',
                datatype: 'json',
                colNames: ['员工编号', '目标后备', '任现职时间', '任现级时间', '任现级年限', '后备成熟度','创建时间'],
                colModel: [
                            { name: 'EmployeeID', index: 'EmployeeID' },
   		                    { name: 'TargetCandidate', index: 'TargetCandidate' },
   		                    { name: 'InPostDate', index: 'InPostDate' },
   		                    { name: 'InGradeDate', index: 'InGradeDate' },
   		                    { name: 'Tenure', index: 'Tenure' },
   		                    { name: 'CandidateMaturity', index: 'CandidateMaturity' },
                            { name: 'CreateTime',index:'CreateTime'}
   	                    ],
                 rowNum: 10,
                 rowList: [10, 20, 30],
                 pager: '#pager',
                 sortname: 'CreateTime',
                viewrecords: true,
                rownumbers: true,
                 sortorder: "desc",
                 width: '100%',
                 jsonReader: {
                    repeatitems: false,
                    id: "CreateTime"
                },
                //caption: "后备资格经理人数据列表"
            });
            jQuery("#grid").jqGrid('navGrid', '#pager', { edit: false, add: false, del: false });
        });
    </script>

    <div>
  <table id="grid"></table>
  <div id="pager"></div>
</div>
<div id="window"></div>
</asp:Content>