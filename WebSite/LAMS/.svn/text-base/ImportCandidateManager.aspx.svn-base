<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ImportCandidateManager.aspx.cs" Inherits="WebSite.ImportCandidateManager" %>

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
    <style type="text/css">
        /*==  内容列表(table)头部==*/
        .gridview th
        {
            font-weight: normal;
            font-size: 12px;
            font-weight: bold;
            color: #2C59AA;
            text-indent: 4px;
            text-align: center;
            background: url(../Skins/Default/Images/th1.gif);
            height: 22px;
            padding: 0;
            border-color: #B5D6E6;
            border: 1px solid #8DB2E3;
        }
        
        .download:link
        {
            color: #03C;
        }
        .download:visited
        {
            color: #0000ff;
        }
        .download:hover
        {
            color: red;
            text-decoration: underline;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript">
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler(sender, args) {
            if (sender._activeElement.id.indexOf('ctl00_contentPlace_rblStatus_') == 0) { //如果是RadioButtonList触发事件的
                clearValues();
            }
            SetGridViewHead(); //updatepanel触发事件后
            SetCheckBox();
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

        //设置GridView的checkbox
        function SetCheckBox() {
            var currentRow = $(".gridview tbody").find("tr:eq(0)");
            $(currentRow).find("td input").attr("checked", "checked");
            $("#hidCurrentId").val($(currentRow).find("td input").val()); //要重设CurrentID
            candidateManagerID = $("#hidCurrentId").val();
        }

        //为gridview设置表头多行
        function SetGridViewHead() {
            var str = "";
            var head = "";
            var year = new Date().getFullYear();
            head = $(".gridview").find("thead").html() == null ? "tbody" : "thead"; //当没有数据时，gridview会没有thread.
            $(".gridview").find(head).empty();
            str = "<tr><th nowrap=\"nowrap\"  rowspan=\"2\">选择</th><th nowrap=\"nowrap\"  rowspan=\"2\">员工编号</th>"
                + "<th nowrap=\"nowrap\"  rowspan=\"2\">单位</th><th nowrap=\"nowrap\"  rowspan=\"2\">姓名</th>"
                + "<th nowrap=\"nowrap\"  rowspan=\"2\">经理类别</th><th nowrap=\"nowrap\"  rowspan=\"2\">所在部门</th>"
                + "<th nowrap=\"nowrap\"  rowspan=\"2\">现任职务</th><th nowrap=\"nowrap\"  rowspan=\"2\">现任职级</th>"
                + "<th nowrap=\"nowrap\"  rowspan=\"2\">性别</th><th nowrap=\"nowrap\"  rowspan=\"2\">出生日期</th>"
                + "<th nowrap=\"nowrap\"  rowspan=\"2\">年龄</th><th nowrap=\"nowrap\"  rowspan=\"2\">任现职时间</th>"
                + "<th nowrap=\"nowrap\"  rowspan=\"2\">任现级时间</th><th nowrap=\"nowrap\"  rowspan=\"2\">任现级年限</th>"
                + "<th nowrap=\"nowrap\" rowspan=\"2\">全日制学历</th><th nowrap=\"nowrap\" rowspan=\"2\">最高学历</th>"
                + "<th nowrap=\"nowrap\" nowrap colspan=\"3\">近三年年度考核结果</th><th nowrap=\"nowrap\" rowspan=\"2\">是否破格推荐</th>"
                + "<th nowrap=\"nowrap\"  rowspan=\"2\">民主推荐率</th><th nowrap=\"nowrap\"  rowspan=\"2\">后备类型</th>"
                + "<th nowrap=\"nowrap\"  rowspan=\"2\">后备成熟度</th><th nowrap=\"nowrap\"  rowspan=\"2\">后备排名</th>"
                + "<th nowrap=\"nowrap\"  rowspan=\"2\">状态</th>";
            if ("<%= Grade %>" == "grade3") {
                str = str + "<th nowrap=\"nowrap\" rowspan=\"2\">是否县分总经理后备</th>";
            }
            str = str + "<th nowrap=\"nowrap\"  rowspan=\"2\">入库员</th><th nowrap=\"nowrap\"  rowspan=\"2\">入库时间</th>"
                      + "</tr><tr><th nowrap=\"nowrap\">" + (year - 3) + "</th><th nowrap=\"nowrap\">" + (year - 2) + "</th>"
                      + "<th nowrap=\"nowrap\">" + (year - 1) + "</th></tr>";
            $(".gridview").find(head).append(str);
        }

        //RadioButtonList不能直接用Selected="True"，会与updatepanel冲突。
        function SetStatus(index) {
            $("#ctl00_contentPlace_rblStatus_" + index).attr("checked", "checked");
        }

        $(document).ready(function () {
            //radiobuttonlist选择项
            SetStatus(2);
            //为gridview设置表头多行
            SetGridViewHead();

            //后备队伍入库
            $("#uploadify").uploadify({
                'uploader': '../Scripts/JQuery.uploadify/uploadify.swf',
                'script': 'ImportExcelAdd.aspx',
                'scriptData': { 'type': 2, 'grade': '<%= Grade %>' },
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
                    $("#ctl00_contentPlace_rblStatus_0").attr("checked", "checked"); //选择信息入库
                    $("#cmdRefresh").click();
                }
            });

            //后备信息入库
            $("#uploadify1").uploadify({
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
                    //返回客户端信息:0:出错；1：成功；2:提示信息；3：保存信息成功，但不存在照片;4：保存人员信息成功，但保存照片出错
                    if (response != "") {
                        $("#msg").css({ "overflow-y": "auto", "height": "40px", "border": "1px solid" });
                        var arr = response.split('&');
                        var code = arr[0];
                        var msg = arr[1];
                        switch (code) {
                            case "0":
                                $("#msg").append("【" + fileObj.name + "】：" + msg + "<br>");
                                break;
                            case "1":
                                $("#msg").removeAttr("style");
                                break;
                            case "2":
                                $("#msg").append("【" + fileObj.name + "】：" + msg + "<br>");
                                break;
                            case "3":
                                $("#msg").append("【" + fileObj.name + "】：保存人员信息成功，但不存在人员照片<br>");
                                break;
                            case "4":
                                $("#msg").append("【" + fileObj.name + "】：保存人员信息成功，但保存人员照片出错 + <br>");
                                break;
                        }
                    }
                },
                'onAllComplete': function (event, data) {
                    $("#ctl00_contentPlace_rblStatus_1").attr("checked", "checked"); //选择信息入库
                    $("#cmdRefresh").click();
                }
            });
            //导入SapID 
            uploadSapID();
            $("#uploadSapIDUploader").attr("title", "批量导入SapID");
            $("#uploadSapIDUploader").css("margin-left", "5px");

        });

        function uploadSapID() {
            $("#uploadSapID").uploadify({
                'uploader': '../Scripts/JQuery.uploadify/uploadify.swf',
                'script': 'ImportExcelAdd.aspx?type=4',
                'cancelImg': '../Scripts/JQuery.uploadify/cancel.png',
                //'folder': 'upload',
                'queueID': 'fileQueue2',
                'fileExt': '*.xls',
                'fileDesc': 'Excel Files (.xls)',
                'auto': true,
                'multi': true,
                'buttonImg': '../Skins/Default/Images/upload2.png',
                'wmode': 'transparent',
                'width': 20,
                'height': 20,
                'onError': function (event, ID, fileObj, errorObj) {
                    alert(errorObj.type + ' Error: ' + errorObj.info)
                },
                'onSelect': function (event, ID, fileObj) {
                    $("#loading").show();
                    $("#<%=filterEmployeeCode.ClientID %>").val("");
                },
                'onComplete': function (event, ID, fileObj, response, data) {
                    if (response != "") {
                        var txt = $("#<%=filterEmployeeCode.ClientID %>");
                        txt.val(txt.val() + response);
                    }
                },
                'onAllComplete': function (event, data) {
                    $("#loading").hide();
                }
            });
        }

        var employeeid = '';
        var candidateManagerID = '';
        function rowClick(me, id, remember) {
            if (currentRow) {
                currentRow.className = "gridview_row";
            }

            me.className = "rowcurrent";

            currentRow = me;

            $("input:radio", me).attr("checked", true);
            if (id == '') {
                id = $("input:radio", me).attr("employeeid");
            }
            if (contextStore == "cookie") {
                if (remember)
                    setCookie("CurrentId", id);
            } else {
                if (remember)
                    $("#hidCurrentId").val(id);
            }
            employeeid = id;
            candidateManagerID = $("input:radio", me).attr("value");
            return id;

        }

        function deleteItem() {
            if (!confirm("是否确定删除记录？")) {
                return false;
            }
            $.post(getCurrentUrl(), { AjaxAction: "Delete", AjaxArgument: candidateManagerID }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        $(".gridview tbody").find("input[checked]").parent().parent().remove(); //删除一行
                        SetCheckBox();
                        if (message == "")
                            message = "操作成功！";
                    }
                }

                alert(message);
            });
        }

        //导出Excel
        function exportExcel() {
            var status = $("#ctl00_contentPlace_rblStatus").find("input[checked]").val();
            var obj = getObjectValue("filterDialog");
            var str = JSON2.stringify(obj);
            //设置cookie
            var cookiename = "search";
            setCookie(cookiename, str);
            window.open("ExportXMLExcel.aspx?type=1&grade=<%= Grade %>&status=" + status);
        }

        function openActionDialog(container, cmdName, argument, actionName, showModal, style, refreshParent) {
            var dialogShowModal = showModal || false;
            var dialogStyle = 1; //0表示弹出div,1表示弹出窗体
            var refresh = refreshParent || 1; //1刷新
            var currentID = "&CurrentId="
            currentID += cmdName == "Update" ? candidateManagerID : employeeid;
            currentID += "&CandidateManagerID=" + candidateManagerID;
            var url = "";
            switch (cmdName) {
                case "Update":
                    url = "CandidateManagerDetail.aspx?grade=<%= Grade %>&Entry=Update";
                    dialogSetting.detailWidth = 650;
                    dialogSetting.detailHeight = 370;
                    dialogStyle = 0;
                    break;
                case "View":
                    url = "EmployeeRegister.aspx?Entry=View";
                    dialogSetting.detailWidth = 900;
                    dialogSetting.detailHeight = 780;
                    break;
            }

            if (url.indexOf('?') > 0)
                url += "&Runat=3&ActionFlag=" + cmdName + currentID + "&radom=" + Math.random();
            else
                url += "?Runat=3&ActionFlag=" + cmdName + currentID + "&radom=" + Math.random();

            if (dialogStyle == 1) {
                if (showModal) {
                    var cssDialog = "dialogHeight:" + dialogSetting.detailHeight + "px; dialogWidth:" + dialogSetting.detailWidth + "px; edge: Raised; center: Yes; resizable: Yes; status: No;scrollbars=no,";
                    return window.showModalDialog(url, cmdName, cssDialog);
                }
                else {
                    var cssDialog = 'center: Yes,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=' + dialogSetting.detailWidth + ',height=' + dialogSetting.detailHeight;
                    window.open(url, cmdName, cssDialog);
                }
            }
            else {
                container = "#" + container;
                if ($(container).html() != "")
                    $(container).dialog("destroy");
                $(container).html('<iframe id="bg_div_iframe" scrolling="no"  width="100%" height="98%" allowTransparency="true" frameborder="0"></iframe>');
                $('#bg_div_iframe').attr('src', url);

                $(container).dialog({
                    bgiframe: true,
                    autoOpen: false,
                    width: dialogSetting.detailWidth,
                    height: dialogSetting.detailHeight,
                    maxWidth: dialogSetting.detailWidth,
                    maxHeight: dialogSetting.detailHeight,
                    minWidth: dialogSetting.detailWidth,
                    minHeight: dialogSetting.detailHeight,
                    modal: true,
                    close: function () {
                        if (cmdName != "View" && refresh == 1)
                            __doPostBack('ctl00$commandBar', 'Search$Search');
                    }
                });
                $(container).dialog("option", "title", actionName);
                $(container).dialog("open");
            }
        }


    </script>
    <div>
        <a href="../FileTemplate/<%= Grade=="grade2" ? "二级":"三级" %>经理后备队伍推荐人选汇总表.xls">下载<%= Grade=="grade2" ? "二级":"三级" %>经理后备队伍推荐人选汇总表模板</a>
        <input type="file" name="uploadify" id="uploadify" /><label style="font-size: larger;
            color: #c0c0c0; font-weight: bold;">浏览</label>&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:$('#uploadify').uploadifyUpload()">
                导入</a>| <a href="javascript:$('#uploadify').uploadifyClearQueue();">取消导入</a>
    </div>
    <div>
        <a href="../FileTemplate/后备队伍人选推荐情况表.xls">下载<%= Grade=="grade2" ? "二级":"三级" %>经理后备队伍人选推荐情况表模板</a>
        <input type="file" name="uploadify1" id="uploadify1" /><label style="font-size: larger;
            color: #c0c0c0; font-weight: bold;">浏览</label>&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:$('#uploadify1').uploadifyUpload()">
                导入</a>| <a href="javascript:$('#uploadify1').uploadifyClearQueue();">取消导入</a>
        <div id="fileQueue">
        </div>
        <div id="msg">
        </div>
    </div>
    <hr />
    <div style="text-align: left;">
        <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal" AutoPostBack="true"
            OnSelectedIndexChanged="rblStatus_OnSelectedIndexChanged">
            <asp:ListItem Text="后备汇总" Value="1"></asp:ListItem>
            <asp:ListItem Text="信息入库" Value="2"></asp:ListItem>
            <%-- <asp:ListItem Text="已出库" Value="3"></asp:ListItem>--%>
            <asp:ListItem Text="所有" Value="4"></asp:ListItem>
        </asp:RadioButtonList>
    </div>
    <div style="width: 1040px; overflow-x: auto;">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
                    DataKeyNames="EmployeeID" Width="1800px" PageSize="10">
                    <Columns>
                        <asp:TemplateField HeaderText="选择">
                            <ItemTemplate>
                                <input id="radioId" type="radio" employeeid='<%#Eval("EmployeeID")%>' value='<%#Eval("ID")%>'
                                    name="radioId" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="员工编号" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("Code")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="单位" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("OrgName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="姓名" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("EmployeeName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="经理类别" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("CandidateManagerGrade") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="所在部门" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("DeptName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="现任职务" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("PositionName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="现任级别" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("PostGrade")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="性别">
                            <ItemTemplate>
                                <%#Eval("Gender").ToString()=="0" ? "男":"女"%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="出生日期" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%# ((string.IsNullOrEmpty(Eval("Birthday").ToString())) ? DateTime.MinValue : (DateTime)Eval("Birthday")).ToString("yyyy-MM-dd") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="年龄">
                            <ItemTemplate>
                                <%#Eval("Age")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="任现职时间" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("InPostDate")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="任现级时间" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("InGradeDate")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="任现级年限">
                            <ItemTemplate>
                                <%#Eval("Tenure")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="全日制学历" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("FulltimeEducation")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="最高学历" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("InserviceEducation")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="2008">
                            <ItemTemplate>
                                <%#Eval("Assessment1")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="2009">
                            <ItemTemplate>
                                <%#Eval("Assessment2")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="2010">
                            <ItemTemplate>
                                <%#Eval("Assessment3")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="是否破格推荐">
                            <ItemTemplate>
                                <%#Eval("IsAnomalous").ToString()=="1" ? "是":"否"%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="民主推荐率">
                            <ItemTemplate>
                                <%#Eval("DemocracyPecent")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="后备类型" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("TargetCandidate")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="后备成熟度" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("CandidateMaturity")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="后备排名">
                            <ItemTemplate>
                                <%#Eval("CandidateOrder")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="状态" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("Status").ToString() == "1" ? "后备汇总" : "信息入库"%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="是否县分总经理后备" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("IsPresident").ToString() =="1" ? "是":"否"%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="入库员" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#Eval("InitorName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="入库时间" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#((DateTime)Eval("InitTime")).ToString("yyyy-MM-dd HH:mm")%>
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
                <dt class="rowlable">员工编号<a class="download" href="../FileTemplate/导入SapID进行批量查询.xls">
                    (模板)</a></dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterEmployeeCode" runat="server" CssClass="text" ToolTip="以逗号隔开即可以进行批量查询"></asp:TextBox>
                    <input type="file" name="uploadify" id="uploadSapID" />
                    <div id="fileQueue2" style="display: none;">
                    </div>
                </dd>
                <dt class="rowlable">单位</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterOrgName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">姓名</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterEmployeeName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">所在部门</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterDeptName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">现任职务</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterPositionName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">现任职级</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterPostGrade" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">性别</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterGender" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="男" Value="0"></asp:ListItem>
                        <asp:ListItem Text="女" Value="1"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">全日制学历</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterFulltimeEducation" DropDownStyle="DropDownList" runat="server">
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">最高学历</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterInserviceEducation" DropDownStyle="DropDownList" runat="server">
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">是否破格推荐</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterIsAnomalous" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">后备类型</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterTargetCandidate" DropDownStyle="DropDownList" runat="server">
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">后备成熟度</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterCandidateMaturity" DropDownStyle="DropDownList" runat="server">
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable" style="display: <%= Grade=="grade3" ? "block":"none" %>">是否县分总经理后备</dt>
                <dd class="rowinput" style="display: <%= Grade=="grade3" ? "block":"none" %>">
                    <suntek:ComboBox ID="filterIsPresident" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
            </dl>
        </fieldset>
        <div id="loading" style="display: none; position: absolute; top: 18px; left: 200px">
            <img src="../Skins/Default/Images/loading.gif" />
        </div>
    </div>
    <asp:Button ID="cmdRefresh" Style="display: none;" ClientIDMode="Static" Width="0px"
        runat="server" OnClick="cmdRefresh_Click" />
</asp:Content>
