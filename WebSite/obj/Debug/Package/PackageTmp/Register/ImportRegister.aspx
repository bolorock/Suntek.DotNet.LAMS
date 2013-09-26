<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ImportRegister.aspx.cs" Inherits="WebSite.Register.ImportRegister" %>

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
        #loader_container
        {
            text-align: center;
            position: absolute;
            top: 40%;
            width: 100%;
            left: 0;
        }
        #loader
        {
            font-family: Tahoma, Helvetica, sans;
            font-size: 11.5px;
            color: #000000;
            background-color: #FFFFFF;
            padding: 10px 0 16px 0;
            margin: 0 auto;
            display: block;
            width: 130px;
            border: 1px solid #5a667b;
            text-align: left;
            z-index: 2;
        }
        #progress
        {
            height: 5px;
            font-size: 1px;
            width: 1px;
            position: relative;
            top: 1px;
            left: 0px;
            background-color: #8894a8;
        }
        #loader_bg
        {
            background-color: #e4e7eb;
            position: relative;
            top: 8px;
            left: 8px;
            height: 7px;
            width: 113px;
            font-size: 1px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript" language="javascript">

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler(sender, args) {//updatepanel触发事件后
            if (sender._activeElement.id == '<%= drpMonth.ClientID %>' || sender._activeElement.id == 'cmdRefresh') { //如果是drpMontht触发事件的
                registerStatus = $("#<%= hidRegisterStatus.ClientID %>").val();
                showDivUpload();
                setCommandbar();
            }
            SetCheckBox();
        }

        var current = new Date();
        var yearMonth = "";
        var registerStatus = "";
        var type = $.query.get("Entry"); //经理类别
        var complete = 0; //是否导入完整名册;
        var isComplete = 0; //是否刚导完完整名册；

        $(function () {
            registerStatus = $("#<%= hidRegisterStatus.ClientID %>").val(); //名册状态
            yearMonth = current.getFullYear().toString() + (current.getMonth() + 1).toString();
            initYearMonth();
            initUploadify(yearMonth);
            setCommandbar();
            showDivUpload();
            initChkComplete();
            if (type == "4") { //资深经理导入
                $("#chkIsComplete").hide();
                $("#lblComplete").hide();
                $("#lblLine").hide();
            }

            setFilterDialog();
            openFromSummary();
        });

        /*从汇总页面打开*/
        function openFromSummary() {
            if ($.query.get("rtnFlag") != "1") {
                $(".commandbar").find("li[id]:contains('返回')").hide();
            }
            else {
                var $drpYear = $("#divDate").find("#<%= drpYear.ClientID %>");
                var $drpMonth = $("#divDate").find("#<%= drpMonth.ClientID %>");
                $drpYear.attr("disabled", "disabled");
                $drpMonth.attr("disabled", "disabled");
            }
        }

        /*清除查询条件*/
        function clearValues() {
            $("input[type='text'][name*='filter']").each(function () {
                $(this).val('');
            });
            $("select[name*='filter']").each(function () {
                $(this).val('-1');
            });
        }

        /*设置GridView*/
        function SetCheckBox() {
            $(".gridview tbody").find("tr:eq(0) td input").attr("checked", "checked");
            $("#hidCurrentId").val($(".gridview tbody").find("tr:eq(0) td input").val()); //要重设CurrentID
        }

        /*初始化完整导入按钮*/
        function initChkComplete() {
            $("#chkIsComplete").change(function () {
                var registerType = "<%= RegisterType  %>";
                var $template = $("#template");
                yearMonth = $("#<%= drpYear.ClientID %>").val() + $("#<%= drpMonth.ClientID %>").val();

                if ($(this).attr("checked") == true) {
                    complete = 1;
                    $template.attr("href", "../FileTemplate/Register/Complete/" + registerType + "完整名册导入模板.xls");
                }
                else {
                    complete = 0;
                    $template.attr("href", "../FileTemplate/Register/" + registerType + "名册导入模板.xls");
                }
                var auth = $("#<%=hfAuth.ClientID %>").val();
                var AspSessID = $("#<%=hfAspSessID.ClientID %>").val();
                $('#uploadify').uploadifySettings('scriptData', { 'type': type, 'yearMonth': yearMonth, 'complete': complete, ASPSESSID: AspSessID, AUTHID: auth }); //动态改变参数值
            });
        }

        /*初始化时间选取按钮*/
        function initYearMonth() {
            var $divDate = $("#divDate");
            var $drpYear = $divDate.find("#<%= drpYear.ClientID %>");
            var $drpMonth = $divDate.find("#<%= drpMonth.ClientID %>");

            $drpYear.change(function () {
                $drpMonth.val("");
            });
            $drpMonth.change(function () {
                clearValues();
                $("#hidCurrentId").val("");
                yearMonth = $drpYear.val() + $(this).val();
                //如果把divUpload隐藏了，谷歌浏览器会报错"updateSettings is not a function",IE浏览器不会;
                var auth = $("#<%=hfAuth.ClientID %>").val();
                var AspSessID = $("#<%=hfAspSessID.ClientID %>").val();
                $('#uploadify').uploadifySettings('scriptData', { 'type': type, 'yearMonth': yearMonth, ASPSESSID: AspSessID, AUTHID: auth }); //动态改变参数值

                $("#msg").empty();
                $("#msg").removeAttr("style");
                $("#cmdRefresh").click();
            });
        }

        /*设置按钮状态*/
        function setCommandbar() {
            var $commandbar = $(".commandbar");
            var cmdConfirm = $commandbar.find("li[id]:contains('确认')");
            var cmdDel = $commandbar.find("li[id]:contains('删除')");
            var cmdUpdate = $commandbar.find("li[id]:contains('修改')");
            var cmdSAP = $commandbar.find("li[id]:contains('从SAP同步')");
            var arr = [cmdConfirm, cmdDel, cmdUpdate, cmdSAP];
            if (registerStatus != "0" && registerStatus != "") {
                $.each(arr, function () {
                    $(this).hide();
                });
            }
            else {
                $.each(arr, function () {
                    $(this).show();
                });
            }
        }

        /*设置上传控件是否可见*/
        function showDivUpload() {
            var $divUpload = $("#divUpload");
            var $cmdUpload = $("#cmdUpload");
            var $cmdCancel = $("#cmdCancel");
            var $lblLine = $("#lblLine");
            if (registerStatus != "0" && registerStatus != "") {
                $cmdUpload.hide();
                $cmdCancel.hide();
                $lblLine.hide();
            }
            else {
                $cmdUpload.show();
                $cmdCancel.show();
                $lblLine.show();
            }
        }

        /*初始化上传控件*/
        function initUploadify(yearMonth) {
            var auth = $("#<%=hfAuth.ClientID %>").val();
            var AspSessID = $("#<%=hfAspSessID.ClientID %>").val();
            $("#uploadify").uploadify({
                'uploader': '../Scripts/JQuery.uploadify/uploadify.swf?t=' + new Date().getTime(), //加随机数解决在QQ、TT浏览器中，uploadify上传控件不能正常工作，显示出了上传进度条，但是进度不走
                'script': 'ImportRegisterExcel.aspx',
                'scriptData': { 'type': type, 'yearMonth': yearMonth, ASPSESSID: AspSessID, AUTHID: auth }, //后面两个参数是解决在非IE浏览器不能上传的问题。
                'cancelImg': '../Scripts/JQuery.uploadify/cancel.png',
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
                    removeWaiting(timeID);
                    $("#msg").empty();
                    if (response != "") {
                        var ajaxResult = JSON2.parse(response);
                        if (ajaxResult) {
                            if (ajaxResult.ActionResult != 1) {
                                $("#msg").css({ "overflow-y": "auto", "height": "40px", "border": "1px solid" });
                                $("#msg").append("【" + fileObj.name + "】：<br>")
                                $("#msg").append(ajaxResult.PromptMsg + "<br>");
                            }
                            else {
                                $("#cmdRefresh").click();
                                synchronizeSapInfo(); //从Sap同步数据
                            }
                        }
                    }
                }
                //                'onAllComplete': function (event, data) {
                //                    $("#cmdRefresh").click();
                //                }
            });

            //导入确认
            $("#cmdUpload").click(function () {
                if ($("#fileQueue").html() == "") {
                    alert("请先选取要导入的Excel文件！")
                    return;
                }
                $('#uploadify').uploadifyUpload()
                //显示等待条
                $("#divText").text("正在从Excel导入数据...");
                $("#loader_container").show();
                timeID = setInterval(animate, 20);
            });

        }

        /*删除所有数据*/
        function deleteAll() {
            if ($(".gridview thead").length == 0) {
                alert("没有数据，不能删除！");
                return;
            }
            if (!confirm("你确定删除本月份的所有数据？")) return;

            $.post(getCurrentUrl(), { AjaxAction: "DeleteAll", AjaxArgument: yearMonth }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.ActionResult == 1) {
                        $("#cmdRefresh").click();
                    }
                }
                else {
                    alert("系统出错，请与管理员联系！");
                    return;
                }
                alert(ajaxResult.PromptMsg);
            });
        }

        /*从SAP同步数据*/
        function synchronizeSapInfo() {
            if (complete != 1 && type != "4") {
                if (!confirm("导入数据成功！是否继续从SAP同步数据？")) return;
            }
            else {
                isComplete = complete;
            }
            synchronize();
        }

        /*返回*/
        function returnAct() {
            history.go(-1);
        }

        /*确认*/
        function confirmSubmit() {
            if (registerStatus == "") {
                alert("还没有导入名册信息，不能确认！");
                return;
            }
            if (!confirm("确认后将转为当前名册，不能再导入和修改！")) return;

            $.post(getCurrentUrl(), { AjaxAction: "ConfirmSubmit", AjaxArgument: yearMonth }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.ActionResult == 1) {
                        $("#<%= hidRegisterStatus.ClientID %>").val("1");
                        registerStatus = "1";
                        showDivUpload()
                        setCommandbar();
                    }
                }
                else {
                    alert("系统出错，请与管理员联系！");
                    return;
                }
                alert(ajaxResult.PromptMsg);
            });
        }
        /* ........正在同步进度条..............................................*/
        var timeID = null;
        var pos = 0; var dir = 2; var len = 0;
        function animate() {
            var elem = document.getElementById('progress');
            if (elem != null) {
                if (pos == 0) len += dir;
                if (len > 32 || pos > 79) pos += dir;
                if (pos > 79) len -= dir;
                if (pos > 79 && len == 0) pos = 0;
                elem.style.left = pos;
                elem.style.width = len;
            }
        }
        function removeWaiting(tID) {
            this.clearInterval(tID);
            $("#loader_container").hide();
        }
        /* ........end..............................................*/

        /*SAP同步*/
        function synchronize() {
            $("#divText").text("正在从SAP同步数据...");
            $("#loader_container").show();
            var t_id = setInterval(animate, 20);
            $.post(getCurrentUrl(), { AjaxAction: "Synchronize", AjaxArgument: yearMonth, "isComplete": isComplete }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.RetValue != null && ajaxResult.RetValue != "") {
                        $("#msg").empty();
                        $("#msg").css({ "overflow-y": "auto", "height": "40px", "border": "1px solid" });
                        $("#msg").append(ajaxResult.RetValue);
                    }
                }
                else {
                    removeWaiting(t_id);
                    alert("系统出错，请与管理员联系！");
                    return;
                }
                removeWaiting(t_id);
                alert(ajaxResult.PromptMsg);
            });
            isComplete = 0;
        }

        /*导出Excel*/
        function exportExcel() {
            if ($(".gridview thead").length == 0) {
                alert("没有数据，不能导出！");
                return;
            }
            window.open("ExportExcel.aspx?type=" + type + "&yearMonth=" + yearMonth);
        }

        var employeeid = '';
        var candidateManagerID = '';

        function openActionDialog(container, cmdName, argument, actionName, showModal, style, refreshParent) {
            var currentID = $("#hidCurrentId").val();
            if (currentID == "") {
                alert("没有选取记录!");
                return;
            }
            var dialogShowModal = showModal || false;
            var dialogStyle = 1; //0表示弹出div,1表示弹出窗体
            var refresh = refreshParent || 1; //1刷新
            currentID = "&CurrentId=" + currentID;
            var url = "";
            if (type == "4") {
                url = "SeniorManagerDetail.aspx";
                dialogSetting.detailWidth = 700;
                dialogSetting.detailHeight = 400;
            }
            else {
                url = "RegisterDetail.aspx";
                dialogSetting.detailWidth = 900;
                dialogSetting.detailHeight = 780;
            }
            switch (cmdName) {
                case "Update":
                    url += "?Entry=Update";
                    break;
                case "View":
                    url += "?Entry=View";
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

        /*设置查询显示控件*/
        function setFilterDialog() {
            //首先全部控件隐藏
            $("#filterDialog dt").each(function () { $(this).hide(); });
            $("#filterDialog dd").each(function () { $(this).hide(); });

            var docPath = "../FileTemplate/Register/<%= managerType.ToString() %>.xml";
            $.ajax({
                type: "GET",
                url: docPath,
                datatype: "xml",
                success: function (xmlData) {
                    $(xmlData).find("RegisterInfo").children().each(function () {
                        $("#lb" + this.nodeName).show();
                        $("#input" + this.nodeName).show();
                    });
                },
                error: function (xml) {
                    alert('Error loading XML document' + xml);
                }
            });
        }

    </script>
    <div id="divContent" class="div_content" style="overflow: auto; height: 100%; width: 100%;
        overflow-x: hidden;">
        <div id="loader_container" style="display: none;">
            <div id="loader">
                <div id="divText" align="center">
                    正在从SAP同步数据...</div>
                <div id="loader_bg">
                    <div id="progress">
                    </div>
                </div>
            </div>
        </div>
        <div id="divUpload">
            <a id="template" href="../FileTemplate/Register/<%= RegisterType  %>名册导入模板.xls">下载名册导入模板</a>
            <input type="file" name="uploadify" id="uploadify" /><label title="选取要导入的Excel文件"
                style="font-size: larger; color: #c0c0c0; font-weight: bold;">导入</label>&nbsp;&nbsp;&nbsp;&nbsp;
            <a id="cmdUpload" href="#">确定</a><label id="lblLine">&nbsp;&nbsp;|&nbsp;&nbsp;</label>
            <%-- <a id="cmdCancel" href="javascript:$('#uploadify').uploadifyClearQueue();">取消导入</a>--%>
            <input id="chkIsComplete" type="checkbox" /><label id="lblComplete">导入完整名册</label>
            <div id="fileQueue">
            </div>
            <div id="msg">
            </div>
        </div>
        <hr />
        <div id="divDate" style="text-align: left; padding-left: 10px;">
            <asp:DropDownList ID="drpYear" runat="server">
                <asp:ListItem>2011</asp:ListItem>
                <asp:ListItem>2012</asp:ListItem>
                <asp:ListItem>2013</asp:ListItem>
                <asp:ListItem>2014</asp:ListItem>
                <asp:ListItem>2015</asp:ListItem>
                <asp:ListItem>2016</asp:ListItem>
                <asp:ListItem>2017</asp:ListItem>
                <asp:ListItem>2018</asp:ListItem>
            </asp:DropDownList>
            年
            <asp:DropDownList ID="drpMonth" runat="server">
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
                <asp:ListItem>6</asp:ListItem>
                <asp:ListItem>7</asp:ListItem>
                <asp:ListItem>8</asp:ListItem>
                <asp:ListItem>9</asp:ListItem>
                <asp:ListItem>10</asp:ListItem>
                <asp:ListItem>11</asp:ListItem>
                <asp:ListItem>12</asp:ListItem>
                <asp:ListItem></asp:ListItem>
            </asp:DropDownList>
            月
        </div>
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
                        DataKeyNames="ID" PageSize="15" OnRowDataBound="gvList_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="选择">
                                <ItemTemplate>
                                    <input id="radioId" type="radio" value='<%#Eval("ID")%>' name="radioId" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </suntek:PagedGridView>
                    <suntek:HidTextBox ID="hidRegisterStatus" runat="server" />
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="cmdRefresh" />
                    <asp:AsyncPostBackTrigger ControlID="ctl00$commandBar" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
    <div id="filterDialog" title="查询">
        <p id="validateTips">
        </p>
        <fieldset>
            <dl>
                <%--CountyManager,RegisterManager3列项--%>
                <dt id="lbDepartment" class="rowlable">单位</dt>
                <%-- RegisterManager2,CountyManager,SeniorManager--%>
                <dd id="inputDepartment" class="rowinput">
                    <asp:TextBox ID="filterDepartment" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOrgName" class="rowlable">机构名称</dt>
                <dd id="inputOrgName" class="rowinput">
                    <asp:TextBox ID="filterOrgName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOrgType" class="rowlable">机构分类</dt>
                <dd id="inputOrgType" class="rowinput">
                    <asp:TextBox ID="filterOrgType" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOrgGrade" class="rowlable">机构等级</dt>
                <dd id="inputOrgGrade" class="rowinput">
                    <asp:TextBox ID="filterOrgGrade" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbName" class="rowlable">姓名</dt>
                <%-- RegisterManager2,CountyManager,SeniorManager--%>
                <dd id="inputName" class="rowinput">
                    <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <%-- RegisterManager2,CountyManager--%>
                <dt id="lbPosition" class="rowlable">现职务</dt>
                <dd id="inputPosition" class="rowinput">
                    <asp:TextBox ID="filterPosition" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbCode" class="rowlable">员工编号</dt>
                <dd id="inputCode" class="rowinput">
                    <asp:TextBox ID="filterCode" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <%-- MarketingManager列项--%>
                <dt id="lbCityBranch" class="rowlable">市分公司</dt>
                <dd id="inputCityBranch" class="rowinput">
                    <asp:TextBox ID="filterCityBranch" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbDistrictBranch" class="rowlable">县分公司</dt>
                <dd id="inputDistrictBranch" class="rowinput">
                    <asp:TextBox ID="filterDistrictBranch" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbMarketingService" class="rowlable">营销服务中心</dt>
                <dd id="inputMarketingService" class="rowinput">
                    <asp:TextBox ID="filterMarketingService" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbCategorizedFile" class="rowlable">分类分档</dt>
                <dd id="inputCategorizedFile" class="rowinput">
                    <asp:TextBox ID="filterCategorizedFile" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <%-- RegisterManager2列项--%>
                <dt id="lbPostGrade" class="rowlable">岗位等级</dt>
                <%--SeniorManager--%>
                <dd id="inputPostGrade" class="rowinput">
                    <asp:TextBox ID="filterPostGrade" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbIsChief" class="rowlable">正副职</dt>
                <dd id="inputIsChief" class="rowinput">
                    <asp:TextBox ID="filterIsChief" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbChargeWork" class="rowlable">分管工作</dt>
                <dd id="inputChargeWork" class="rowinput">
                    <asp:TextBox ID="filterChargeWork" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <%--SeniorManager列项--%>
                <dt id="lbPostName" class="rowlable">岗位名称</dt>
                <dd id="inputPostName" class="rowinput">
                    <asp:TextBox ID="filterPostName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbBirthday" class="rowlable">出生年月</dt>
                <dd id="inputBirthday" class="rowinput">
                    <asp:TextBox ID="filterBirthday" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbGender" class="rowlable">性别</dt>
                <dd id="inputGender" class="rowinput">
                    <suntek:ComboBox ID="filterGender" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="男" Value="男">
                        </asp:ListItem>
                        <asp:ListItem Text="女" Value="女">
                        </asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt id="lbOldPosition" class="rowlable">原职务</dt>
                <dd id="inputOldPosition" class="rowinput">
                    <asp:TextBox ID="filterOldPosition" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOldPostGrade" class="rowlable">原职级</dt>
                <dd id="inputOldPostGrade" class="rowinput">
                    <asp:TextBox ID="filterOldPostGrade" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOldPostGradeTime" class="rowlable">任原职级时间</dt>
                <dd id="inputOldPostGradeTime" class="rowinput">
                    <asp:TextBox ID="filterOldPostGradeTime" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbChangedTime" class="rowlable">改任时间</dt>
                <dd id="inputChangedTime" class="rowinput">
                    <asp:TextBox ID="filterChangedTime" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbOldPost" class="rowlable">转任前职位</dt>
                <dd id="inputOldPost" class="rowinput">
                    <asp:TextBox ID="filterOldPost" runat="server" CssClass="text"></asp:TextBox>
                </dd>
            </dl>
        </fieldset>
        <div id="loading" style="display: none; position: absolute; top: 18px; left: 200px">
            <img src="../Skins/Default/Images/loading.gif" />
        </div>
    </div>
    <asp:Button ID="cmdRefresh" Style="display: none;" ClientIDMode="Static" Width="0px"
        runat="server" OnClick="cmdRefresh_Click" />
    <asp:HiddenField ID="hfAuth" runat="server" />
    <asp:HiddenField ID="hfAspSessID" runat="server" />
</asp:Content>
