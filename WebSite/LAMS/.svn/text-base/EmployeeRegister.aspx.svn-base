<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="EmployeeRegister.aspx.cs" Inherits="WebSite.EmployeeRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
<%--    <style type="text/css">
        html, body, form
        {
            margin: 0px;
            height: 100%;
        }
    </style>--%>
    <script language="javascript" type="text/javascript">
        //校验脚本
        //        function initValidator() {
        //            $.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function (msg) { alert(msg); } });
        //            /*非空字段*/
        //            $("#<%=txtShouldCount.ClientID%>").formValidator().inputValidator({ min: 1, type: "number", onerror: "【应到人数】必须输入大于1的数字格式！\n" });
        //            $("#<%=txtAttendCount.ClientID%>").formValidator().inputValidator({ min: 1, type: "number", onerror: "【实到人数】必须输入大于1的数字格式！\n" });
        //            $("#<%=txtEmployeeCount.ClientID%>").formValidator().inputValidator({ min: 1, type: "number", onerror: "【其中员工代表人数】必须输入大于1的数字格式！\n" });

        //        }


        $(function () {
            $("#tabs").tabs({
                ajaxOptions: {
                    error: function (xhr, status, index, anchor) {
                        $(anchor.hash).html("无法加载此标签！");
                    }
                }
            });
            if (($.browser.msie && $.browser.version == '8.0')||(!$.browser.msie)) {
                $("#tabs").css({ "height": "100%", "overflow-x": "hidden", "overflow-y": "auto" });
                $(" html, body, form").css({ "margin": "0px", "height": "100%" });
            }
        });

        function save(me, argument) {
            var selected = $("#tabs").tabs("option", "selected"); //获取tabs选择索引
            var resource = getObjectValue("tabs-" + selected);
            resource.Type = selected;
            var value = JSON2.stringify(resource);

            $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: value, CurrentId: $("#hidCurrentId").val() }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        if (message == "")
                            message = "操作成功！";
                    }

                    $("#hidCurrentId").val(ajaxResult.RetValue);
                }

                alert(message);
            });
        }

        function rowOut(me) {
            if (oldRow != null) {
                if (currentRow != me) {
                    me.className = "rowout";
                }
                oldRow = me;
            }
        }

        var cacheArray = new Array();
        function rowDbClick(me, id, remember) {
            if ($(":input", $(me)).eq(0)[0]) return;

            $("td", me).each(function (i) {
                var innerText = $.trim($(this).text());
                $(this).text("");
                $(this).append("<input type='text' value='" + innerText + "' style='width:90%;' flag='edit'/>");
                cacheArray[i] = innerText;
            });
        }

        document.onclick = function (e) {
            var ev = e || window.event;
            var srcObj = ev.target || ev.srcElement; // 获得事件源

            if ($(srcObj).attr("flag") == "edit") return false;

            var objValue = new Object();
            var obj;
            $("#tbInfo").find("tr[id]").find("td:has(input)").each(function (i) {
                var text = $(":input", $(this)).eq(0);
                if (text[0]) {
                    var innerText = text.val();
                    $(this).empty();
                    $(this).text(innerText);
                    objValue[$(this).attr("id")] = innerText;
                    if (obj == null) {
                        obj = this;
                    }
                }
            });
            if (objValue.StartDate != undefined) {
                objValue["ID"] = $(obj).parent().attr("id");
                var value = JSON2.stringify(objValue)
                saveOneRow(value);
            }
        }

        //保存一行数据
        function saveOneRow(value) {
            $.post(getCurrentUrl(), { AjaxAction: "SaveOneRow", AjaxArgument: value }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                }
                if (ajaxResult.ActionResult != 1) {
                    alert(message);
                }
            });
        }

        //导出Excel
        function exportExcel() {
            window.open("ExportXMLExcel.aspx?type=3&employeeID=<%= CurrentId %>&candidateManagerID=<%= CandidateManagerID %>");
        }
    </script>
    <style type="text/css">
        table
        {
            font-size: 12px;
            border: 1px solid #DEDEDE;
            border-collapse: collapse;
            width: 100%;
            padding: 2px;
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
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
        <ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
            <li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active"><a href="#tabs-0">
                员工基本信息</a></li>
            <li class="ui-state-default ui-corner-top"><a href="#tabs-1">选拔推荐情况</a></li>
        </ul>
        <div id="tabs-0">
            <table id="tbInfo" style="background-color: White;">
                <tr>
                    <td class="toptitle5" colspan="7" height="40">
                        <div class="toptitle">
                            员工情况登记表</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        姓名
                    </td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td>
                        性别
                    </td>
                    <td>
                        <suntek:ComboBox ID="cboGender" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                            runat="server" Width="98%">
                            <asp:ListItem Text="男" Value="0">
                            </asp:ListItem>
                            <asp:ListItem Text="女" Value="1" Selected="True">
                            </asp:ListItem>
                        </suntek:ComboBox>
                    </td>
                    <td>
                        出生年月
                    </td>
                    <td>
                        <asp:TextBox ID="txtBirthday" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td width="130" rowspan="4">
                        <asp:Image ID="imgEmployee" runat="server" Width="100px" />
                    </td>
                </tr>
                <tr>
                    <td>
                        民族
                    </td>
                    <td>
                        <asp:TextBox ID="txtNation" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td>
                        籍贯
                    </td>
                    <td>
                        <asp:TextBox ID="txtNativeplace" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td>
                        出生地
                    </td>
                    <td>
                        <asp:TextBox ID="txtBirthplace" runat="server" Width="98%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap>
                        政治面貌
                    </td>
                    <td>
                        <asp:TextBox ID="txtPoliticsStatus" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td nowrap>
                        参加工作时间
                    </td>
                    <td>
                        <asp:TextBox ID="txtWorkFromDate" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td nowrap>
                        健康状况
                    </td>
                    <td>
                        <asp:TextBox ID="txtHealthStatus" runat="server" Width="98%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap>
                        专业技术职务
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtIndustrialGrade" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td nowrap>
                        熟悉专业有何专长
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtSpeciality" runat="server" Width="98%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="4" nowrap>
                        学历学位
                    </td>
                    <td rowspan="2" nowrap>
                        全日制教育
                    </td>
                    <td colspan="2" rowspan="2">
                        <suntek:ComboBox ID="cboFulltimeEducation" DropDownStyle="DropDownList" Width="98%"
                            runat="server">
                        </suntek:ComboBox>
                    </td>
                    <td nowrap>
                        毕业院校
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtFulltimeSchool" runat="server" Width="98%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap>
                        系及专业
                    </td>
                    <td colspan="2" nowrap>
                        <asp:TextBox ID="txtFulltimeMajor" runat="server" Width="98%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td rowspan="2" nowrap>
                        在职教育
                    </td>
                    <td colspan="2" rowspan="2">
                        <suntek:ComboBox ID="cboInserviceEducation" DropDownStyle="DropDownList" Width="98%"
                            runat="server">
                        </suntek:ComboBox>
                    </td>
                    <td nowrap>
                        毕业院校
                    </td>
                    <td colspan="2" nowrap>
                        <asp:TextBox ID="txtInserviceSchool" runat="server" Width="98%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap>
                        系及专业
                    </td>
                    <td colspan="2" nowrap>
                        <asp:TextBox ID="txtInserviceMajor" runat="server" Width="98%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap>
                        现任职务
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtPositionName" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td nowrap>
                        职务等级
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtPostGrade" runat="server" Width="98%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap>
                        任现职务时间
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtInPostDate" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td nowrap>
                        任现职别时间
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtInGradeDate" runat="server" Width="98%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap>
                        后备方向
                    </td>
                    <td colspan="3">
                        <suntek:ComboBox ID="cboTargetCandidate" DropDownStyle="DropDownList" runat="server"
                            Width="98%">
                        </suntek:ComboBox>
                    </td>
                    <td nowrap>
                        人才成熟度
                    </td>
                    <td colspan="3">
                        <suntek:ComboBox ID="cboCandidateMaturity" DropDownStyle="DropDownList" runat="server"
                            Width="98%">
                        </suntek:ComboBox>
                    </td>
                </tr>
                <!----------简历------->
                <tr>
                    <td rowspan="<%= resume.Count+1 %>" nowrap="nowrap">
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
                <% foreach (var item in resume)
                   {
                       if (Request.QueryString["Entry"].ToString() == "Update")
                       {
                %>
                <tr ondblclick="rowDbClick(this,'',true)" onmouseout="rowOut(this);" onmouseover="rowOver(this);"
                    style="cursor: pointer" id='<%= item.ID %>' title="鼠标双击即可编辑">
                    <% }
                       else
                       {
                    %>
                    <tr>
                        <%
                       } %>
                        <td id="StartDate" nowrap="nowrap">
                            <%= item.StartDate %>
                        </td>
                        <td id="EndDate" nowrap="nowrap">
                            <%= item.EndDate  %>
                        </td>
                        <td id="Workplace" colspan="3" nowrap="nowrap">
                            <%= item.Workplace %>
                        </td>
                        <td id="Position" nowrap="nowrap">
                            <%= item.Position %>
                        </td>
                    </tr>
                    <%
                   }
                    %>
                    <!----------简历结束------->
                    <!----------学习培训情况------->
                    <tr>
                        <td>
                            学习培训情况
                        </td>
                        <td colspan="6">
                            <asp:TextBox ID="txt3" runat="server" TextMode="MultiLine" Width="99%" Height="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <!----------学习培训情况------->
                    <!----------近三年年度考核------->
                    <tr>
                        <td>
                            近三年年度考核
                        </td>
                        <td colspan="6">
                            <asp:TextBox ID="txtAssessment" runat="server" TextMode="MultiLine" Width="99%" Height="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <!----------近三年年度考核------->
            </table>
        </div>
        <div id="tabs-1">
            <table style="background-color: White;">
                <tr>
                    <td class="toptitle5" colspan="7" height="40">
                        <div class="toptitle">
                            选拔推荐情况</div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="2">
                        民主推荐情况
                    </td>
                    <td nowrap="nowrap">
                        应到人数
                    </td>
                    <td style="width: 130px;">
                        <asp:TextBox ID="txtShouldCount" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap">
                        实到人数
                    </td>
                    <td style="width: 130px;">
                        <asp:TextBox ID="txtAttendCount" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap">
                        其中员工代表人数
                    </td>
                    <td style="width: 130px;">
                        <asp:TextBox ID="txtEmployeeCount" runat="server" Width="98%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">
                        同意票数
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtApproveCount" runat="server" Width="98%"></asp:TextBox>
                    </td>
                    <td nowrap="nowrap" colspan="2">
                        占总票数的百分比
                    </td>
                    <td>
                        <asp:TextBox ID="txtApprovePercent" runat="server" Width="98%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="height: 200px;">
                        主要业绩、重大贡献或创新
                    </td>
                    <td colspan="6">
                        <asp:TextBox ID="txtMajorKPI" runat="server" TextMode="MultiLine" Width="99%" Height="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="height: 200px;">
                        主要不足/有待提升
                    </td>
                    <td colspan="6">
                        <asp:TextBox ID="txtDeficiency" runat="server" TextMode="MultiLine" Width="99%" Height="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="height: 200px;">
                        培训发展计划(建议)
                    </td>
                    <td colspan="6">
                        <asp:TextBox ID="txtTrainingPlan" runat="server" TextMode="MultiLine" Width="99%"
                            Height="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="height: 200px;">
                        推荐意见
                    </td>
                    <td colspan="6">
                        <asp:TextBox ID="txtRecommendation" runat="server" TextMode="MultiLine" Width="99%"
                            Height="200px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
