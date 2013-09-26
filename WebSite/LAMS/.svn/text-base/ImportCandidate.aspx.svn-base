<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true" CodeBehind="ImportCandidate.aspx.cs" Inherits="WebSite.ImportExcel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>

     <%--jquery.uploadify --%>
    <link rel="Stylesheet" href="../Scripts/JQuery.uploadify/uploadify.css" />
    <script type="text/javascript" src="../Scripts/JQuery.uploadify/swfobject.js"></script>
    <script type="text/javascript" src="../Scripts/JQuery.uploadify/jquery.uploadify.min.js"></script>

    <style type="text/css">
    .ui-jqgrid-btable {float:left;}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">

    <script type="text/javascript">
        var createTime="";
        var flag=false
        $(document).ready(function () {
            //后备经理人入库
            $("#uploadify").uploadify({
                'uploader': '../Scripts/JQuery.uploadify/uploadify.swf',
                'script': 'ImportExcelAdd.aspx?type=1',
                'cancelImg': '../Scripts/JQuery.uploadify/cancel.png',
                //'folder': 'upload',
                'queueID': 'fileQueue',
                'fileExt': '*.xls',
                'fileDesc': 'Excel Files (.xls)',
                'auto': false,
                'multi': true,
                'buttonImg': '../Skins/Default/Images/upload.png',
                'wmode': 'transparent',
                'width': 70,
                'height': 32,
                'onError': function (event, ID, fileObj, errorObj) {
                    alert(errorObj.type + ' Error: ' + errorObj.info)
                },
                'onSelect': function (event, ID, fileObj) {
                    createTime = new Date().toLocaleString().replace("年", "-").replace("月", "-").replace("日", "");
                },
                'onComplete': function (event, ID, fileObj, response, data) {
                    //返回客户端信息:0:出错；1：成功；2:提示信息；3：保存信息成功，但不存在照片;4：保存人员信息成功，但保存照片出错
                    if (response != "") {
                        var arr = response.split('&');
                        var code = arr[0];
                        var msg = arr[1];
                        switch (code) {
                            case "0":
                                $("#msg").append("【" + fileObj.name + "】：" + msg + "<br>");
                                break;
                            case "1":
                                // employeeCodes = employeeCodes + msg + ",";
                                break;
                            case "2":
                                $("#msg").append("【" + fileObj.name + "】：" + msg + "<br>");
                                break;
                            case "3":
                                // employeeCodes = employeeCodes + msg + ",";
                                $("#msg").append("【" + fileObj.name + "】：保存人员信息成功，但不存在人员照片<br>");
                                break;
                            case "4":
                                // employeeCodes = employeeCodes + msg + ",";
                                $("#msg").append("【" + fileObj.name + "】：保存人员信息成功，但保存人员照片出错 + <br>");
                                break;
                        }
                    }
                },
                'onAllComplete': function (event, data) {
                    if (!flag) {
                        flag = true;
                        BindGrid(); //绑定jqgrid
                    }
                    else {
                        $("#grid").trigger("reloadGrid");
                    }
                }
            });

        });
        function BindGrid() {
            jQuery("#grid").jqGrid({
                url: 'jqgridData.ashx?type=0&createTime='+createTime, //440652234320,44065290,44065294320
                datatype: 'json',
                colNames: ['ID','编号', '姓名', '性别', '出生年月', '民族', '操作'],
                colModel: [
                            { name: 'ID',index:'ID' },
   		                    { name: 'Code', index: 'Code' },
   		                    { name: 'Name', index: 'Name' },
   		                    { name: 'Gender', index: 'Gender' },
   		                    { name: 'Birthday', index: 'Birthday', formatter: DateTimeFmatter},
   		                    { name: 'Nation', index: 'Nation' },
                            { name: 'act', index: 'act', width: 75, sortable: false }

   	                    ],
                rowNum: 10,
                autowidth: true,
                 rowList: [10, 20, 30],
                 pager: '#pager',
                 sortname: 'Code',
                viewrecords: true,
                rownumbers: true,
                 sortorder: "desc",
                jsonReader: {
                    root: "rows", //arry containing actual data   
                    page: "page", //current page   
                    total: "total", //total pages for the query   
                    records: "records", //total number of records   
                    repeatitems: false,
                    id: "Code" //index of the column with the PK in it    
                },
                gridComplete: function (id) {
                    var ids = jQuery("#grid").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var cl = ids[i];
                        var employeeID;
                        var ret1 = jQuery("#grid").jqGrid('getRowData', cl);
                        employeeID = ret1.ID; //获取所在行的Code
                        be = "<input style='height:22px;width:80px;' type='button' value='详细信息' onclick=\"openDialog('window','详细信息','EmployeeRegister.aspx?CurrentId=" + employeeID + "',900,800,true,1);\"  />";
                        jQuery("#grid").jqGrid('setRowData', ids[i], { act: be });
                    }
                },
                caption: "导入的后备经理数据列表"
            });
            jQuery("#grid").jqGrid('navGrid', '#pager', { edit: false, add: false, del: false, search: false });
        }
    </script>


    <div>
        <table border="1" width="100%" bordercolor="#82A9DF" style="margin-bottom: 0px; border-collapse: collapse;">
            <tr>
                <td width="100%" class="toptitle5" colspan="2">
                    <div class="toptitle">
                        后备经理人入库</div>
                </td>
            </tr>
            <tr>
                <td>
                    <a href="../FileTemplate/员工情况登记表--模版.xls">下载模版</a>
                </td>
                <td>
                    <div>
                        <input type="file" name="uploadify" id="uploadify" />
                        <a href="javascript:$('#uploadify').uploadifyUpload()">导入</a>| <a href="javascript:$('#uploadify').uploadifyClearQueue()">
                            取消导入</a>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="fileQueue">
                    </div>
                    <div id="msg">
                    </div>
                </td>
            </tr>
              <tr>
                <td colspan="2" align="center">
                    <div id="divContent" class="div_content">
                        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
                            DataKeyNames="ID">
                            <Columns>
                                <asp:TemplateField HeaderText="选择">
                                    <ItemTemplate>
                                        <input id="radioId" type="radio" value='<%#Eval("ID") %>' name="radioId" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="员工编号">
                                    <ItemTemplate>
                                        <%#Eval("Code")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="单位">
                                    <ItemTemplate>
                                        <%#Eval("OrgName")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="姓名">
                                    <ItemTemplate>
                                        <%#Eval("EmployeeName")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="性别">
                                    <ItemTemplate>
                                        <%#Eval("Gender")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="出生年月">
                                    <ItemTemplate>
                                        <%#Eval("Birthday")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="民族">
                                    <ItemTemplate>
                                        <%#Eval("Nation")%>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="入库员">
                                    <ItemTemplate>
                                        <%#Eval("InitorName")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="入库时间">
                                    <ItemTemplate>
                                        <%#((DateTime)Eval("InitTime")).ToShortDateString()%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </suntek:PagedGridView>
                    </div>
                </td>
            </tr>
        </table>
    </div>


</asp:Content>
