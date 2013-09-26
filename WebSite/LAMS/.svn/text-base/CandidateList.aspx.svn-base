<%@ Page Language="C#"  MasterPageFile="~/Master/Page.Master" AutoEventWireup="true" CodeBehind="CandidateList.aspx.cs" Inherits="WebSite.CandidateList" %>
 
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
    <link type="text/css" rel="stylesheet" href="../Scripts/Jqgrid/styles/ui.jqgrid.css" /> 
    <link type="text/css" rel="stylesheet" href="../Scripts/Jqgrid/styles/ui.multiselect.css" /> 
    <script type="text/javascript" src="../Scripts/Jquery/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.2.custom.min.js"></script> 
    <script type="text/javascript" src="../Scripts/Jqgrid/Scripts/i18n/grid.locale-en.js"></script> 
    <script type="text/javascript" src="../Scripts/Jqgrid/Scripts/jquery.jqGrid.min.js"></script> 
    <script type="text/javascript" src="../Scripts/Jqgrid/Scripts/ui.multiselect.js"></script>

    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
<script language="javascript" type="text/javascript">
     $(document).ready(function () {
      jQuery("#grid").jqGrid({
                url: 'jqgridData.ashx?type=2',
                datatype: 'json',
                colNames: ['编号', '姓名', '性别', '出生年月', '民族', '创建时间','操作'],
                colModel: [
   		                    { name: 'Code', index: 'Code' },
   		                    { name: 'Name', index: 'Name' },
   		                    { name: 'Gender', index: 'Gender' },
   		                    { name: 'Birthday', index: 'Birthday' },
   		                    { name: 'Nation', index: 'Nation' },
                            { name: 'CreateTime', index: 'CreateTime' },
                            { name: 'act', index: 'act', sortable: false }
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
                    root: "rows", //arry containing actual data   
                    page: "page", //current page   
                    total: "total", //total pages for the query   
                    records: "records", //total number of records   
                    repeatitems: false,
                    id: "ID" //index of the column with the PK in it    
                },
                gridComplete: function (id) {
                    var ids = jQuery("#grid").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var cl = ids[i];
                        var code;
                        var ret1 = jQuery("#grid").jqGrid('getRowData', cl);
                        code = ret1.Code; //获取所在行的Code
                        be = "<input style='height:22px;width:80px;' type='button' value='详细信息' onclick=\"openDialog('window','详细信息','EmployeeRegister.aspx?CurrentId=" + code+ "',900,800,true,0);\"  />";
                        jQuery("#grid").jqGrid('setRowData', ids[i], { act: be });
                    }
                }
               // caption: "后备经理人数据列表"
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
