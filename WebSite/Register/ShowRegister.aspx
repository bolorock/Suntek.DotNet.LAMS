<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ShowRegister.aspx.cs" Inherits="WebSite.Register.ShowRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <%-- jqgrid --%>
    <link type="text/css" rel="stylesheet" href="../Scripts/Jqgrid/styles/ui.jqgrid.css" />
    <%--<link type="text/css" rel="stylesheet" href="../Scripts/Jqgrid/styles/ui.multiselect.css" />--%>
    <%--<script type="text/javascript" src="../Scripts/Jquery/jquery-1.4.2.min.js"></script>--%>
    <%--<script type="text/javascript" src="../Scripts/jquery-ui-1.8.6.custom.min.js"></script>--%>
    <script type="text/javascript" src="../Scripts/Jqgrid/Scripts/i18n/grid.locale-cn.js"></script>
    <script type="text/javascript" src="../Scripts/Jqgrid/Scripts/jquery.jqGrid.min.js"></script>
    <%--<script type="text/javascript" src="../Scripts/Jqgrid/Scripts/ui.multiselect.js"></script>--%>
    <style type="text/css">
        .ui-jqgrid tr.jqgrow td
        {
            font-weight: normal;
            overflow: hidden;
            white-space: pre;
            white-space: normal !important; /*vertical-align:text-top;*/
            height: auto;
            padding: 0 2px 0 2px;
            border-bottom-width: 1px;
            border-bottom-color: inherit;
            border-bottom-style: solid;
        }
        /*     .ui-jqgrid tr.jqgrow td
        {
            white-space: normal !important;
            height: auto;
            vertical-align: text-top;
            padding-top: 2px;
            word-break: keep-all;
        }*/
        #grid tbody tr
        {
            border: 1px solid #dddddd;
            background: white;
            color: #362b36;
        }
    </style>
    <script type="text/javascript" language="javascript">
        var yearMonth = "";
        var registerType = "";
        var corpID = "";
        var corpName = "";

        var colNameArr = [];
        var colModelArr = [];
        var xmlObj = {}; //缓存数据

        $(function () {
            yearMonth = $("#<%= drpYear.ClientID %>").val() + $("#<%= drpMonth.ClientID %>").val();
            registerType = $("#<%= drpGrade.ClientID %>").val();
            var $drpCompany = $("#<%= drpCompany.ClientID %>")
            if ($drpCompany.length == 0) {
                corpID = "<%= User.CorpID %>";
            }
            else {
                corpID = $drpCompany.val();
                corpName = $drpCompany.find("option:selected").text();
            }

            initControl(); //控件按钮初始化
            bindGridData();
        });

        /*获取宽度和高度*/
        function getWidthAndHeigh(resize) {
            var iframeHeight = document.body.clientHeight;
            var iframeWidth = document.body.clientWidth;
            iframeWidth -= 12;
            iframeHeight -= 83;
            if (resize) {
                iframeHeight += 15;
                iframeWidth += 10;
            }
            return { width: iframeWidth - 30, height: iframeHeight - 100 };
        }

        /*不能直接这样写，因setGridWidth会在jqgrid的事件gridComplete前执行，
        会报“'p.cellLayout' 为空或不是对象”的错误,只能在girdComplete事件里调用windowResize();
        */
        //        window.onresize = function () {
        //            window.onresize = null;
        //            var size = getWidthAndHeigh(true);
        //            $("#grid").jqGrid('setGridHeight', size.height).jqGrid('setGridWidth', size.width);
        //            setTimeout(function () { window.onresize = windowResize; }, 1000); //解决IE下执行多次的bug
        //        };

        /*jqGrid自动宽度和高度*/
        function windowResize() {
            window.onresize = null;
            var size = getWidthAndHeigh(true);
            $("#divTable").width(size.width);
            $("#divTable").height(size.height);
            $("#grid").jqGrid('setGridHeight', size.height).jqGrid('setGridWidth', size.width);
            setTimeout(function () { window.onresize = windowResize; }, 1000);
        }


        /*jqgrid自动宽度和高度*/
        function autoWidthAndHeigh() {
            var size = getWidthAndHeigh(true);
            $("#divTable").width(size.width);
            $("#divTable").height(size.height);
            $("#grid").jqGrid('setGridHeight', size.height).jqGrid('setGridWidth', size.width);
        }

        function initControl() {
            $("#ctl00_divNav").find("label").text("当前位置：名册管理>>名册展示");
            //全省名册Excel展示
            $("#<%= cmdProvince.ClientID %>").click(function () {
                if ($("#grid tbody tr").length == 0) {
                    alert("没有数据，不能导出！");
                    return;
                }
                window.open("ExportRegister.aspx?type=all&yearMonth=" + yearMonth + "&registerType=" + registerType);
            });

            //经理类别
            $("#<%= drpGrade.ClientID %>").change(function () {
                $(this).blur();
                registerType = $(this).val();
                $('#grid').jqGrid('GridUnload'); //销毁gird
                bindGridData();
            });

            //年
            $("#<%= drpYear.ClientID %>").change(function () {
                $(this).blur();
                yearMonth = $(this).val() + $("#<%= drpMonth.ClientID %>").val();
                $("#grid").jqGrid('setGridParam', { postData: { 'yearMonth': yearMonth} }).trigger('reloadGrid');
            });

            //月
            $("#<%= drpMonth.ClientID %>").change(function () {
                $(this).blur();
                yearMonth = $("#<%= drpYear.ClientID %>").val() + $(this).val();
                $("#grid").jqGrid('setGridParam', { postData: { 'yearMonth': yearMonth} }).trigger('reloadGrid');
            });

            //分公司
            $("#<%= drpCompany.ClientID %>").change(function () {
                $(this).blur();
                corpName = $(this).find("option:selected").text();
                $("#grid").jqGrid('setGridParam', { postData: { 'corpName': corpName} }).trigger('reloadGrid');
            });

            //显示隐藏
            $("#pageMenuSelf").append("<div id=\"divFloat\" style=\"position:relative;margin:0 auto;margin-top:15px;\"><img title='点击隐藏内容' src='../Skins/Default/Images/Above.gif' /></div>");
            $("#divFloat").click(function () {
                var size = getWidthAndHeigh(true);
                var $divDate = $("#divDate");
                if ($divDate.css("display") == "none") {
                    $divDate.fadeIn("slow");
                    $(this).find("img").attr("src", "../Skins/Default/Images/Above.gif").attr("title", "点击隐藏内容");
                }
                else {
                    $divDate.fadeOut("slow");
                    $(this).find("img").attr("src", "../Skins/Default/Images/Below.gif").attr("title", "点击显示更多内容");
                    size.height = size.height + 20
                }
                $("#grid").jqGrid('setGridHeight', size.height);
            });

            //            if ("<%= User.LoginName %>" == "shengp") {
            //                $("#cmdSetWidth").show();
            //            }

            //设置字段宽度
            $("#cmdSetWidth").click(function () {
                var arr = [];
                $(".ui-jqgrid-btable").find("tbody tr td:gt(0)").each(function (i) {
                    arr.push({ "Key": i + 1, "Value": $(this).width() });
                });
                var jsonData = JSON2.stringify(arr);
                $.post(getCurrentUrl(), { AjaxAction: "SetFieldWidth", AjaxArgument: jsonData, "registerType": $("#<%= drpGrade.ClientID %>").val() }, function (result) {
                    var ajaxResult = JSON2.parse(result);
                    var message = "操作失败";
                    if (ajaxResult) {
                        if (ajaxResult.PromptMsg != null)
                            message = ajaxResult.PromptMsg
                        if (ajaxResult.ActionResult == 1) {
                            if (message == "")
                                message = "操作成功！";
                        }
                    }
                    alert(message);
                });
            });
        }

        /*简单名册*/
        function hideField() {
            $("#grid").jqGrid('hideCol', ["Photo", "PostGradeExperience", "GradeExperience"]);
        }

        /*完整名册*/
        function showField() {
            $("#grid").jqGrid('showCol', ["Photo", "PostGradeExperience", "GradeExperience"]);
        }


        /*获取显示字段，并绑定数据*/
        function bindGridData() {
            if (xmlObj[registerType]) {
                setCol(xmlObj[registerType]);
                initGrid();
            }
            else {//不存在就从服务器取
                var docPath = "../FileTemplate/Register/" + (registerType == "SeniorManager" ? "" : "Complete/") + registerType + ".xml";
                $.ajax({
                    cache: false,
                    type: "GET",
                    url: docPath,
                    datatype: "xml",
                    success: function (xmlData) {
                        setCol(xmlData);
                        initGrid();
                    },
                    error: function (xml) {
                        alert('Error loading XML document' + xml);
                    }
                });
            }
        }

        /*设置列参数*/
        function setCol(xmlData) {
            var sortOrder = 0;
            //初始化
            colNameArr = [];
            colModelArr = [];

            xmlObj[registerType] = xmlData; //缓存数据

            $(xmlData).find("RegisterInfo").find("[IsShow='1']").each(function () {
                sortOrder = parseInt($(this).attr("SortOrder"));
                if (sortOrder != "") {
                    colNameArr[sortOrder - 1] = $(this).attr("text");
                    if ($(this).attr("Width") == undefined) {
                        colModelArr[sortOrder - 1] = { name: this.nodeName, index: this.nodeName };
                    }
                    else {
                        colModelArr[sortOrder - 1] = { name: this.nodeName, index: this.nodeName, width: $(this).attr("Width") };
                    }
                }
            });
        }

        /*初始化jqGird*/
        function initGrid() {
            jQuery("#grid").jqGrid({
                url: 'jqgridData.ashx',
                postData: { "type": 0, "yearMonth": yearMonth, "registerType": registerType, "corpID": corpID, "corpName": corpName },
                datatype: 'json',
                colNames: colNameArr,
                colModel: colModelArr,
                rowNum: 8,
                shrinkToFit: false,
                autowidth: true,
                rowList: [8, 16],
                pager: '#pager',
                viewrecords: true,
                rownumbers: true,
                //                sortname: 'Code',
                //                sortorder: "desc",
                jsonReader: {
                    root: "rows", //arry containing actual data   
                    page: "page", //current page   
                    total: "total", //total pages for the query   
                    records: "records", //total number of records   
                    repeatitems: false,
                    id: "Code" //index of the column with the PK in it    
                },
                gridComplete: function (id) {
                    autoWidthAndHeigh();
                    var ids = jQuery("#grid").jqGrid('getDataIDs'); //取得各行的主键数组
                    $("#grid").find("tbody tr").each(function (index) {
                        $(this).hover(function () {
                            $(this).css("background", "#f2f5f7 url(images/ui-bg_highlight-hard_100_f2f5f7_1x100.png) 50% top repeat-x");
                        },
                        function () {
                            $(this).css("background", "White");
                        });

                        $(this).dblclick(function () {
                            url = "EmployeeRegister.aspx?Entry=View&Runat=3&ActionFlag=View&CurrentId=" + ids[index]
                            openOperateDialog("查看", url, 800, 680, false, 1);
                        });

                    });
                    if (registerType == 'SeniorManager') { //资深经理设置固定高度
                        $("#grid").find("tbody tr").each(function (index) {
                            $(this).height(40);
                        });
                    }
                    windowResize();
                    setHeadheight();
                }
                //caption: "名册展示"
            });
            jQuery("#grid").jqGrid('navGrid', '#pager', { edit: false, add: false, del: false, search: false });
            // $("#grid").closest(".ui-jqgrid-bdiv").css({ 'overflow-y': 'scroll' }); 
        }

        function setHeadheight() {
            var ar = [];
            $(".ui-jqgrid-htable").find("thead tr th").each(function (i) {
                var $this = $(this);
                var $div = $this.find("div");
                $this.height(20);
                //设置表头垂直居中，换行
                $this.css("white-space", "normal");
                $div.css("white-space", "normal");
                $this.css("vertical-align", "middle");
                $div.css("line-height", "20px");
            });

        }

        /*设置查询显示控件*/
        function setFilterDialog() {
            //首先全部控件隐藏
            $("#filterDialog dt").each(function () { $(this).hide(); });
            $("#filterDialog dd").each(function () { $(this).hide(); });

            if (xmlObj[registerType]) {
                $(xmlObj[registerType]).find("RegisterInfo").find("[IsShow]").each(function () {
                    $("#lb" + this.nodeName).show();
                    $("#input" + this.nodeName).show();
                });
            }
        }

        /*查询弹出框*/
        function search(me, argument) {
            setFilterDialog();
            openFilterDialog(me, argument);
        }

        /*重写查询确认事件*/
        function filterAction() {
            var obj = getObjectValue("filterDialog");
            var strJson = JSON2.stringify(obj);
            $("#grid").jqGrid('setGridParam', { postData: { 'filterStr': strJson} }).trigger('reloadGrid');
        }

        /*导出Excel*/
        function exportExcel() {
            if ($("#grid tbody tr").length == 0) {
                alert("没有数据，不能导出！");
                return;
            }
            var url = "ExportRegister.aspx?yearMonth=" + yearMonth + "&registerType=" + registerType + "&corpID=" + corpID + "&corpName=" + escape(corpName);
            var obj = getObjectValue("filterDialog");

            var strJson = JSON2.stringify(obj);
            if (strJson != "{}")
                url += "&filterStr=" + escape(strJson)

            window.open(url);
        }

        /*重写*/
        function getObjectValue(container) {
            var objValue = new Object();
            var inputs = container && container != "" ? $(":input", $("#" + container)) : $(":input");
            inputs.each(function () {
                if ($(this).val() == "" || $(this).val() == "-1") return;
                var values = this.id.split("_");
                var fullName = values[values.length - 1];
                var property = startWith(fullName, "filter") ? fullName.substr(6) : fullName.substr(3);

                if (property == "SortOrder") {
                    objValue[property] = parseInt($(this).val());
                }
                else if ($(this).attr("tag") == "choosebox") {
                    if (endWith(property, "data")) {
                        objValue[property.substr(0, property.length - 4)] = $(this).val();
                    }
                }
                else if ($(this).attr("tag") == "combox") {
                    if (endWith(property, "data")) {
                        var enumValue = parseInt($(this).val());
                        if (!enumValue)
                            enumValue = $(this).val();
                        objValue[property.substr(0, property.length - 4)] = enumValue;
                    }
                }
                else if (property != "ParentID") {
                    if ($(this).attr("type") == "checkbox") {
                        objValue[property] = $(this).attr("checked") == true ? 1 : 0;
                    }
                    else {
                        objValue[property] = $(this).val();
                    }
                }
            });
            return objValue;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
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
        月&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="drpGrade" runat="server">
            <asp:ListItem Value="CompleteRegisterManager2" Text="二级经理"></asp:ListItem>
            <asp:ListItem Value="CompleteRegisterManager3" Text="三级经理"></asp:ListItem>
            <asp:ListItem Value="CompleteCountyManager" Text="县分公司总经理"></asp:ListItem>
            <asp:ListItem Value="CompleteMarketingManager" Text="营销中心经理"></asp:ListItem>
            <asp:ListItem Value="SeniorManager" Text="资深经理"></asp:ListItem>
        </asp:DropDownList>
        <asp:DropDownList ID="drpCompany" DataTextField="CorpName" DataValueField="CorpID"
            runat="server">
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp; <a id="cmdProvince" href="#" runat="server" style="display: none;">
            2011全省名册汇总</a> <a id="cmdSetWidth" href="#" style="display: none;">设置宽度</a>
    </div>
    <div id="divTable" style="margin: 5px;">
        <table id="grid">
        </table>
        <div id="pager">
        </div>
    </div>
    <div id="filterDialog" title="查询">
        <p id="validateTips">
        </p>
        <fieldset>
            <dl>
                <%--CountyManager,RegisterManager3列项--%>
                <%-- RegisterManager2,CountyManager,SeniorManager--%>
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
                <%-- RegisterBaseInfo--%>
                <dt id="lbCurrentPostTime" class="rowlable">任现职时间</dt>
                <dd id="inputCurrentPostTime" class="rowinput">
                    <asp:TextBox ID="filterCurrentPostTime" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbCurrentGradeTime" class="rowlable">任现级时间</dt>
                <dd id="inputCurrentGradeTime" class="rowinput">
                    <asp:TextBox ID="filterCurrentGradeTime" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt id="lbBirthplace" class="rowlable">籍贯</dt>
                <dd id="inputBirthplace" class="rowinput">
                    <asp:TextBox ID="filterBirthplace" runat="server" CssClass="text"></asp:TextBox>
                </dd>
            </dl>
        </fieldset>
        <div id="loading" style="display: none; position: absolute; top: 18px; left: 200px">
            <img src="../Skins/Default/Images/loading.gif" />
        </div>
    </div>
</asp:Content>
