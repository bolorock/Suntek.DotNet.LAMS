<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ImportCandidateManagerQualify.aspx.cs" Inherits="WebSite.ImportCandidateManagerQualify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <%--jquery.uploadify --%>
    <link rel="Stylesheet" href="../Scripts/JQuery.uploadify/uploadify.css" />
    <script type="text/javascript" src="../Scripts/JQuery.uploadify/swfobject.js"></script>
    <script type="text/javascript" src="../Scripts/JQuery.uploadify/jquery.uploadify.min.js"></script>
    <script src="../Scripts/Json2.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript">
        dialogSetting.actionUrl = "CandidateManagerQualifyDetail.aspx?grade=<%= Grade %>&Entry=Update";

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler(sender, args) {
            if (sender._activeElement.id.indexOf('ctl00_contentPlace_rblStatus_') == 0) { //如果是RadioButtonList触发事件的
                clearValues();
            }
            SetCheckBox(); //updatepanel触发事件后
        }

        //清除查询条件
        function clearValues() {
            $("input[type='text'][name*='filter']").each(function () {
                $(this).val('');
            });
            $("select[name*='filter']").each(function () {
                $(this).val('-1');
            });
        }

        //RadioButtonList不能直接用Selected="True"，会与updatepanel冲突。
        function SetStatus(index) {
            $("#ctl00_contentPlace_rblStatus_" + index).attr("checked", "checked");
        }

        //设置GridView
        function SetCheckBox() {
            $(".gridview tbody").find("tr:eq(0) td input").attr("checked", "checked");
            $("#hidCurrentId").val($(".gridview tbody").find("tr:eq(0) td input").val()); //要重设CurrentID
        }

        $(document).ready(function () {
            SetStatus(0);
            //后备队伍入库
            $("#uploadify").uploadify({
                'uploader': '../Scripts/JQuery.uploadify/uploadify.swf',
                'script': 'ImportExcelAdd.aspx',
                'scriptData': { 'type': '3', 'grade': '<%= Grade %>' },
                'cancelImg': '../Scripts/JQuery.uploadify/cancel.png',
                //'folder': 'upload',
                'queueID': 'fileQueue',
                'fileExt': '*.xls',
                'fileDesc': 'Excel Files (.xls)',
                'auto': false,
                'multi': false,
                'buttonImg': '../Skins/Default/Images/upload.png',
                'wmode': 'transparent',
                'width': 25,
                'height': 25,
                'onError': function (event, ID, fileObj, errorObj) {
                    alert(errorObj.type + ' Error: ' + errorObj.info)
                },
                'onSelect': function (event, ID, fileObj) {
                    $("#msg").empty();
                    $("#msg").removeAttr("style");
                },
                'onComplete': function (event, ID, fileObj, response, data) {
                    $("#msg").empty();
                    if (response != "") {
                        //style="height:40px;overflow-y:auto;border:1px solid;"
                        $("#msg").css({ "overflow-y": "auto", "height": "40px", "border": "1px solid" });
                        var arr = response.split('&');
                        var code = arr[0];
                        var msg = arr[1];
                        switch (code) {
                            case "0":
                                $("#msg").append("【" + fileObj.name + "】：<br>")
                                $("#msg").append(msg + "<br>");
                                break;
                            case "1":
                                $("#msg").removeAttr("style");
                                break;
                        }
                    }
                },
                'onAllComplete': function (event, data) {
                    $("#ctl00_contentPlace_rblStatus_0").attr("checked", "checked"); //未初始化
                    $("#cmdRefresh").click();
                }
            });
        });

        function exportExcel() {
            var status = $("#ctl00_contentPlace_rblStatus").find("input[checked]").val();

            var obj = getObjectValue("filterDialog");
            var str = JSON2.stringify(obj);
            //设置cookie
            var cookiename = "search";
            setCookie(cookiename, str);
            window.open("ExportXMLExcel.aspx?type=0&grade=<%= Grade %>&status=" + status);
        }

    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <a href="../FileTemplate/<%= Grade=="grade2" ? "二级":"三级" %>经理后备人员资格库导入表.xls" style=" margin-left:20px; text-align:left">下载<%= Grade=="grade2" ? "二级":"三级" %>后备资格模版</a>
        <input type="file" name="uploadify" id="uploadify" /><label style="font-size: larger;
            color: #c0c0c0; font-weight: bold;">浏览</label>&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:$('#uploadify').uploadifyUpload()">
                导入</a>| <a href="javascript:$('#uploadify').uploadifyClearQueue();">取消导入</a>
        <div id="fileQueue">
        </div>
        <div id="msg">
        </div>
    </div>
    <hr />
   
        <div id="rblDiv" style="text-align: left; margin-left:8px; display:none;">
            <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal" AutoPostBack="true"
                OnSelectedIndexChanged="rblStatus_OnSelectedIndexChanged">
                <asp:ListItem Text="资格入库" Value="0"></asp:ListItem>
                <asp:ListItem Text="后备汇总" Value="1"></asp:ListItem>
                <asp:ListItem Text="信息入库" Value="2"></asp:ListItem>
                <asp:ListItem Text="已出库" Value="3"></asp:ListItem>
                <asp:ListItem Text="所有" Value="4"></asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div >
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
                    DataKeyNames="ID" PageSize="15">
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
                        <asp:TemplateField HeaderText="经理类别">
                            <ItemTemplate>
                                <%#Eval("CandidateManagerGrade")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="是否正职">
                            <ItemTemplate>
                                <%#Eval("IsChief").ToString()=="0" ? "否":"是"%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="状态">
                            <ItemTemplate>
                                <%#Eval("Status")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="后备岗位">
                            <ItemTemplate>
                                <%#Eval("CandidatePost")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="创建时间">
                            <ItemTemplate>
                                <%#((DateTime)Eval("CreateTime")).ToString("yyyy-MM-dd hh:mm")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </suntek:PagedGridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="cmdRefresh" />
                <asp:AsyncPostBackTrigger ControlID="rblStatus" />
                <asp:AsyncPostBackTrigger ControlID="ctl00$commandBar" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <div id="filterDialog" title="查询">
        <p id="validateTips">
        </p>
        <fieldset>
            <dl>
                <dt class="rowlable">员工编号</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterEmployeeCode" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">单位</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterOrgName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">姓名</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterEmployeeName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">后备岗位</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterCandidatePost" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="管理二岗" Value="管理二岗"></asp:ListItem>
                        <asp:ListItem Text="管理三岗" Value="管理三岗"></asp:ListItem>
                        <asp:ListItem Text="管理四岗" Value="管理四岗"></asp:ListItem>
                        <asp:ListItem Text="管理五岗" Value="管理五岗"></asp:ListItem>
                        <asp:ListItem Text="管理六岗" Value="管理六岗"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable" style="display: <%= Grade=="grade2" ? "block":"none" %>">是否正职</dt>
                <dd class="rowinput" style="display: <%= Grade=="grade2" ? "block":"none" %>">
                    <suntek:ComboBox ID="filterIsChief" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
            </dl>
        </fieldset>
    </div>
    <asp:Button ID="cmdRefresh" Style="display: none;" ClientIDMode="Static" Width="0px"
        runat="server" OnClick="cmdRefresh_Click" />
</asp:Content>
