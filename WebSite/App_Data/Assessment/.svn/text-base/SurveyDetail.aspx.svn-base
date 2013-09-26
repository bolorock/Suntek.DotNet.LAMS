<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SurveyDetail.aspx.cs" Inherits="WebSite.SurveyDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <style type="text/css">
        .chooseCell
        {
            text-align: left;
            margin-left: 5px;
        }
        
        .gridview th
        {
            font-weight: normal;
            font-size: 12px;
            font-weight: bold;
            color: #2C59AA;
            text-indent: 4px;
            text-align: left;
            background: url(../Skins/Default/Images/th.gif);
            height: 22px;
            padding-left: 59px;
            border-color: #B5D6E6;
            border: 1px solid #8DB2E3;
        }
        
        .gridview td
        {
            font-size: 12px;
            text-indent:4px;
            text-align: left;
            padding-left:60px;
            border-color: #B5D6E6;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript" language="javascript">

        //校验脚本
        function initValidator() {
            $.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function (msg) { promptMessage(msg); } });
            /*默认验证字段*/
            $("#<%=txtTitle.ClientID%>").formValidator().inputValidator({ max: 128, onerror: "【测评名称】长度不能超过128" });
            /*必选项*/
            $("#<%=chbExamPaperID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【试卷ID】不能为空" });

            /*日期*/
            $("#<%=dtpEndTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【结束时间】格式错误" });

        }

        //页面初始化
        $(document).ready(function () {
            //初始化校验脚本
            initValidator();
            addChkAllClick();
            pageInit();
        });

        //gridview全选
        function addChkAllClick() {  
            $("#chkAll").click(function () {
                if ($("#chkAll").is(":checked")) {
                    $(".gridview input[type=checkbox]").attr("checked", true);
                }
                else {
                    $(".gridview input[type=checkbox]").attr("checked", false);
                }
            });
        }

        //保存
        function save(me, argument) {
            var survey = getObjectValue("surveyDetail");
            var value = JSON.stringify(survey);
            $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: value, CurrentId: $("#hidCurrentId").val() }, function (result) {
                var ajaxResult = JSON.parse(result);
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
        }
        //新增答卷
        function addExamPaper() {
            openOperateDialog("新增问卷", "ExamPaperDetail.aspx?Entry=AddFromSurvey&m=" + Math.random(), 700, 500);

        }

        //增加答题人
        function addTester() {
            var ids = openOperateDialog("选择评估人", "../LAMS/CandidateManagerTree.aspx?m=" + Math.random(), 700, 700, true, 1);
            if (ids != undefined && ids != "") {
                var endTime = $("#ctl00_contentPlace_dtpEndTime").val();
                var limitTime = $("#ctl00_contentPlace_txtLimitTime").val();
                $.post(getCurrentUrl(), { AjaxAction: "SaveTester", UserIDs: ids, EndTime: endTime,LimitTime:limitTime }, function (value) {
                    var ajaxResult = JSON.parse(value);
                    if (ajaxResult) {
                        if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                            //alert(ajaxResult.PromptMsg);
                            refreshGrid();
                            if (window.parent)
                                window.parent.closeDialog();
                        }
                    }
                    else {
                        alert("系统出错，请与管理员联系！");
                    }
                });
            }
        }

        //导入答题人
        function importTester() {
            openOperateDialog("导入评估人", "../Assessment/Uploadify.aspx?m=" + Math.random() + "&surveyID=<%= CurrentId %>", 700, 300);
        }

        //解锁加锁
        function changeLock(me) {
            var id = $(me).parent().parent().find("td:first input").val();
            //解锁
            $.post(getCurrentUrl(), { AjaxAction: "ChangeLock", SurveyResultID: id }, function (value) {
                var ajaxResult = JSON.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        //alert(ajaxResult.PromptMsg);
                        var par = $(me).parent()
                        var prev = $(par).prev()

                        $(prev).text(ajaxResult.RetValue == "1" ? "锁定" : "未锁定")
                        $(par).html(ajaxResult.RetValue == "1" ? "<SPAN title=\"双击进行操作\" ondblclick=\"changeLock(this)\">解锁</SPAN>" : "<SPAN title=\"双击进行操作\" ondblclick=\"changeLock(this)\">锁定</SPAN>");

                        if (window.parent)
                            window.parent.closeDialog();
                    }
                }
                else {
                    alert("系统出错，请与管理员联系！");
                }
            });
        }

        //发布测试
        function publicshed() {
            var status = $("#hidSurveyStatus").val();
            if (status == "1" || status == "2") {
                alert("该测评已经发布，不需再发布！");
                return;
            }
            if (!confirm("是否确定发布测试？")) {
                return false;
            }
            $.post(getCurrentUrl(), { AjaxAction: "Publicshed", AjaxArgument: '<%= CurrentId %>' }, function (value) {
                var ajaxResult = JSON.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        alert(ajaxResult.PromptMsg);

                        if (window.parent)
                            window.parent.closeDialog();
                    }
                }
                else {
                    alert("系统出错，请与管理员联系！");
                }
            });

        }

        //删除左右两端的空格
        function trim(str){  
         return str.replace(/(^\s*)|(\s*$)/g, "");
        }

        //删除评估人
        function delTester() {
            var status = $("#hidSurveyStatus").val();
            if (status != "0") {
                var statusName = ["已发布", "已完成", "已完成"];
                alert("测评处于" + statusName[status - 1] + "状态,不能删除！");
                return;
            }
            //获取所有已选择的
            var surveyResultIDs = "";
            $(".gridview tbody").find("input[checked]").each(function () {
                surveyResultIDs += $(this).val() + ",";
            });

            if (surveyResultIDs == "") {
                alert("请先选择要删除的记录！");
                return;
            }

            if (!confirm("是否确定删除记录？")) {
                return false;
            }

            $.post(getCurrentUrl(), { AjaxAction: "DelTester", AjaxArgument: surveyResultIDs }, function (value) {
                var ajaxResult = JSON.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        // $("#cmdRefresh").click();
                        refreshGrid();//刷新Grid
                        $("#chkAll").removeAttr("checked");

                        //alert(ajaxResult.PromptMsg);

                        if (window.parent)
                            window.parent.closeDialog();
                    }
                }
                else {
                    alert("系统出错，请与管理员联系！");
                }
            });
        }

        //-----------------------------------------gridview有关--------------------------------------------------------

        //分页控件初始化
        function pageInit() {
            //修改分页函数为Ajax分页
            var page = $(".gridview_footer");
            $(page).find("a[href]").each(function () {
                $(this).attr("href", "javascript:pageIndexChange('2')");
            });
            //设置当前页和每页条数为只读
            $("#ctl00\\$contentPlace\\$gvListintputPageIndex").attr("readonly", "true");
            $("#ctl00\\$contentPlace\\$gvListinputPageSize").attr("readonly", "true");
        }

        //分页事件
        function pageIndexChange(pageIndex) {
            $.post(getCurrentUrl(), { AjaxAction: "RefreshGrid", AjaxArgument: pageIndex }, function (value) {
                var ajaxResult = JSON.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        refresh(ajaxResult);
                        $("#chkAll").removeAttr("checked"); //取消全选
                    }
                }
            });
        }

        //局部刷新列表
        function refreshGrid() {
            $.post(getCurrentUrl(), { AjaxAction: "RefreshGrid" }, function (value) {
                var ajaxResult = JSON.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        refresh(ajaxResult)
                    }
                }
                else {
                    alert("系统出错，请与管理员联系！");
                }
            });
        }

        //刷新gridview
        function refresh(ajaxResult) {
            var gridview = $(".gridview")
            var tbody = $(".gridview tbody");

            //不存在分页控件就添加
            if ($(".gridview_footer").length == 0) {
                $("#gvList").after("<div class=\"gridview_footer\"></div>");
            }
            var page = $(".gridview_footer");
            $(page).empty();

            if ($(".gridview thead").length == 0) {//没有数据时
                $(tbody).before("<thead></thead>");
                $(".gridview thead").append($(tbody).html());
                $(gridview).attr({ "cellspacing": "0", "border": "1", "id": "ctl00_contentPlace_gvList" });
                $(gridview).css("border-collapse", "collapse");
                addChkAllClick(); //gridview全选事件
            }
            var thead = $(".gridview thead");
            $(tbody).empty();

            //清空分页控件后再增加
            if (ajaxResult.RetValue) {
                $(page).append("<span style=\"margin-right:5px;\">共1页 </span>"
                            + "<span id=\"gvList_ItemCount\">13</span> 条记录"
                            + " <a disabled=\"true\" style=\"margin-right:5px;\">&lt;&lt;</a>"
                            + "<a disabled=\"true\" style=\"margin-right:5px;\">&lt;</a>"
                            + "<input readonly=\"true\" type=\"text\" value=\"1\" name=\"ctl00$contentPlace$gvListintputPageIndex\""
                            + " id=\"ctl00$contentPlace$gvListintputPageIndex\" onkeypress=\"if (event.keyCode == 13) pageIndexChange('ctl00$contentPlace$gvList');\" style=\"margin-right:5px;\" />"
                            + "<a disabled=\"true\" style=\"margin-right:5px;\">&gt;</a>"
                            + "<a disabled=\"true\" style=\"margin-right:5px;\">&gt;&gt;</a>"
                            + "<span style=\"margin-right:5px;margin-right:5px;\">每页</span>"
                            + "<input readonly=\"true\" type=\"text\" value=\"20\" name=\"ctl00$contentPlace$gvListinputPageSize\" id=\"ctl00$contentPlace$gvListinputPageSize\""
                            + " onkeypress=\"if (event.keyCode == 13) pageIndexChange('ctl00$contentPlace$gvList');\" />"
                            + "<span>条记录</span>");

                var html = CreateTR(ajaxResult.RetValue);
                $(tbody).append(html);

                //设置分页
                var pageIndex = ajaxResult.RetValue.pageIndex;//当前页
                var pageSize = ajaxResult.RetValue.pageSize; //每页条数
                var ItemCount = ajaxResult.RetValue.ItemCount; //总条数

                $("#ctl00\\$contentPlace\\$gvListintputPageIndex").val(pageIndex); //当前页
                $("#ctl00\\$contentPlace\\$gvListinputPageSize").val(pageSize); //每页条数
                $(page).find("span:eq(0)").text("共" + ajaxResult.RetValue.total + "页"); //总页数
                $("#gvList_ItemCount").text(ItemCount); //总条数

                var firstAll = $(page).find("a:eq(0)");
                var first = $(page).find("a:eq(1)");
                var next = $(page).find("a:eq(2)");
                var nextAll = $(page).find("a:eq(3)");

                if (pageIndex > 1) {
                    $(first).removeAttr("disabled");
                    $(firstAll).removeAttr("disabled");
                    $(first).attr("href", "javascript:pageIndexChange('" + (pageIndex - 1) + "')");
                    $(firstAll).attr("href", "javascript:pageIndexChange('" + (pageIndex - 1) + "')");
                }
                else {
                    $(first).attr("disabled", "disabled");
                    $(first).removeAttr("href");
                    $(firstAll).attr("disabled", "disabled");
                    $(firstAll).removeAttr("href");
                }
                if (ItemCount <= pageSize*pageIndex) {
                    $(next).attr("disabled", "disabled");
                    $(next).removeAttr("href");
                    $(nextAll).attr("disabled", "disabled");
                    $(nextAll).removeAttr("href");
                }
                else {
                    $(next).removeAttr("disabled");
                    $(nextAll).removeAttr("disabled");
                    $(next).attr("href", "javascript:pageIndexChange('" + ajaxResult.RetValue.total + "')");
                    $(nextAll).attr("href", "javascript:pageIndexChange('" + ajaxResult.RetValue.total + "')");
                }
            }
        }

        //创建tr
        function CreateTR(retValue) {
            var htmlStr="";
            var surveyResultStatus = ["初始化", "测评中", "已完成", "超时"];
            var rows = retValue.rows;
            for (i = 0; i < rows.length; i++) {
                htmlStr += "<tr onmouseover=\"rowOver(this);\" onclick=\"rowClick(this,'" + rows[i].ID + "',true)\" onmouseout=\"rowOut(this);\" style=\"cursor: hand\">"
					   + "<td align=\"left\">"
                       + "<input id=\"radioId\" type=\"checkbox\" value='" + rows[i].ID + "' name=\"radioId\" />"
                       + "</td><td>"
                       + ((i + 1) + (retValue.pageSize * (retValue.pageIndex - 1)))
                       + " </td><td>"
                       + rows[i].Code
                       + "</td><td>"
                       + rows[i].Name
                       + "</td><td>"
                       + surveyResultStatus[rows[i].Status]
                       + "</td><td>"
                       + (rows[i].IsLock == "0" ? "未锁定" : "已锁定")
                       + "</td><td>"
                       + "    <span ondblclick=\"changeLock(this)\" title=\"双击进行操作\">" + (rows[i].IsLock == "1" ? "解锁" : "锁定") + "</span>"
                       + "</td>"
				+ "</tr>"
            }
            return htmlStr;
        }
        //-----------------------------------------------------------------------------------------------------------------------------------------
    </script>
    <div class="div_block" id="surveyDetail">
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtTitle.ClientID%>" class="label">
                    测评名称
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtTitle" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=chbExamPaperID.ClientID%>" class="label">
                    <em>*</em> 试卷ID
                </label>
            </div>
            <div class="div_row_input">
                <suntek:ChooseBox ID="chbExamPaperID" OpenUrl="ExamPaperManager.aspx?Entry=Choose"
                    DialogTitle="选择试卷" runat="server"></suntek:ChooseBox>
                <input type="button" value="新增" onclick="addExamPaper()" />
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=cboCategory.ClientID%>" class="label">
                    <em>*</em> 所属分类
                </label>
            </div>
            <div class="div_row_input">
                <suntek:Combox ID="cboCategory" runat="server" />
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtLimitTime.ClientID%>" class="label">
                    考试时间
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtLimitTime" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=dtpEndTime.ClientID%>" class="label">
                    结束时间
                </label>
            </div>
            <div class="div_row_input">
                <suntek:DatePicker ID="dtpEndTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <div class="block_title">
                    评估人：</div>
            </div>
        </div>
        <div>
            <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
                DataKeyNames="ID" PageSize="15">
                <Columns>
                    <asp:TemplateField HeaderText='<input id="chkAll" type="checkbox" name="chkAll" style="margin-left:1px;" />选择'>
                        <ItemTemplate>
                            <input id="radioId" type="checkbox" value='<%#Eval("ID") %>' name="radioId" />
                        </ItemTemplate>
                        <ItemStyle  HorizontalAlign="Left"/>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="序号">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="评估人编号">
                        <ItemTemplate>
                            <%#Eval("Code")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="评估人姓名">
                        <ItemTemplate>
                            <%#Eval("Name")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="状态">
                        <ItemTemplate>
                            <%#RemarkAttribute.GetEnumRemark((SurveyResultStatus)Enum.Parse(typeof(SurveyResultStatus), Eval("Status").ToString()))%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="是否锁定">
                        <ItemTemplate>
                            <%#Eval("IsLock").ToString() == "0" ? "未锁定":"已锁定"%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="操作">
                        <ItemTemplate>
                            <%--<input type="button"  value='<%#Eval("IsLock").ToString() =="1" ? "  解 锁  ":"  锁定  " %>' id="cmdLock" onclick="changeLock(this)" />--%>
                            <span ondblclick="changeLock(this)" title="双击进行操作"><%#Eval("IsLock").ToString() =="1" ? "解锁":"锁定" %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </suntek:PagedGridView>
            <asp:Button ID="cmdRefresh" Style="display: none;" ClientIDMode="Static" Width="0px"
                runat="server" OnClick="cmdRefresh_Click" />
        </div>
    </div>
     <suntek:HidTextBox ID="hidSurveyStatus" runat="server" />
</asp:Content>
