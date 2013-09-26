<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SurveyManager.aspx.cs" Inherits="WebSite.SurveyManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript" language="javascript">


        function add(me, argument) {
            var tblParameter = $("#divContent").find("table").eq(0);
            var rowCount = $("#<%=gvList.ClientID %>").find("tr").length;

            $(":radio").removeAttr("checked");
            var newRow = "<tr ondblclick=\"rowDbClick(this,'',true)\" onmouseout='rowOut(this);' onclick=\"rowClick(this,'',true)\" style='cursor: hand'>"
                          + "<td><input id='radioId' type='radio' value='' checked='checked' name='radioId' /></td><td><input type='text' style='width:98%'/></td>"
                          + "<td></td><td></td><td><%=GetCatDDl() %></td>"
                          + "<td><input type='text' style='width:98%'/></td><td><input style='width:98%;text-align:center;' class='wdate' value='" + getCurrentDate() + "' type='text' onclick='var skin=getSkin();WdatePicker({skin:skin})'></td>" +
                            "<td>初始化</td></tr>";
            tblParameter.append(newRow);
            $("#gvList_ItemCount").text(parseInt($("#gvList_ItemCount").text()) + 1);
        }

        function save(me, argument) {
            if (!checkStatus("保存")) return;
            var currentRow = $("#divContent").find(":checked ").first().parent().parent();
            var tds = $("td", currentRow);
            tds.each(function (i) {
                if (i > 0 && i != 2 && i!=3) {
                    if (i == 4) {
                        var appText = $(this).find("select").eq(0);
                        if (appText[0]) {
                            $(this).text(appText.find("option:selected").text());
                            $(this).append("<input type='hidden' value='" + appText.val() + "'/>");
                        }
                    }
                    else {

                        var text = $(this).find("input").eq(0);
                        if (text[0]) {
                            var innerText = $.trim(text.val());
                            $(this).empty();
                            $(this).text(innerText);
                        }
                    }
                }
            });

            var parameter = new Object();
            var values = currentRow.find("td");
            var ID = $("#divContent").find(":checked ").first().val();
            if (values.length > 0) {
                parameter["ID"] = ID;
                parameter["Title"] = $.trim(values.eq(1).text());
                parameter["ExamPaperID"] = $.trim(values.eq(2).find("input").eq(0).val());
                parameter["Category"] = $.trim(values.eq(4).find("input").eq(0).val());
                parameter["LimitTime"] = $.trim(values.eq(5).text());
                parameter["EndTime"] = $.trim(values.eq(6).text());

                if (parameter["Title"] == "") {
                    alert("【测评名称】不能为空");
                    return;
                }
                if (parameter["Description"] == "") {
                    alert("【所属分类】不能为空");
                    return;
                }
                if (parameter["LimitTime"] == "") {
                    alert("【考试时间】不能为空");
                    return;
                }
                if (parameter["EndTime"] == "") {
                    alert("【结束时间】不能为空");
                    return;
                }
            }

            var value = JSON2.stringify(parameter)

            $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: value, CurrentId: ID }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        if (message == "")
                            message = "操作成功！";
                        $("#divContent").find(":checked ").first().val(ajaxResult.RetValue);
                    }

                }

                alert(message);
            });
        }

        //删除左右两端的空格
        function trim(str) {
            return str.replace(/(^\s*)|(\s*$)/g, "");
        }

        //检查测评状态
        function checkStatus(action) {
        
            var status = $("#divContent tbody").find("input[checked]").parent().parent().find("td").last().text();
            status = trim(status)
            if (status == "已发布" || status == "已完成") {
                alert("该测评活动" + status + "，不能再" + action);
                return false;
            }
            return true;
        }

        function del(me, argument) {
            if (!checkStatus("删除")) return;
            if (!confirm("是否确定删除记录？")) {
                return false;
            }

            var rad = $("#divContent").find(":checked ").first(); //.val();
            var id = rad.val();
            if ($.trim(id) == "") {
                rad.parent().parent().remove();
                alert("操作成功");
                return;
            }

            $.post(getCurrentUrl(), { AjaxAction: "Delete", AjaxArgument: id }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        if (message == "")
                            message = "操作成功！";
                        rad.parent().parent().remove();
                        $("#gvList_ItemCount").text(parseInt($("#gvList_ItemCount").text()) - 1);
                    }
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
        function rowClick(me, id, remember) {
            if (currentRow) {
                currentRow.className = "gridview_row";
            }
            me.className = "rowcurrent";

            if (currentRow && currentRow != me) {
                var tds = $("td", currentRow);
                tds.each(function (i) {
                    if (i == 2) return true;
                    if (i == 4) {
                        var appText = $(this).find("select").eq(0);
                        if (appText[0]) {
                            $(this).text(appText.find("option:selected").text());
                            $(this).append("<input type='hidden' value='" + appText.val() + "'/>");
                        }
                    }
                    else {
                        var text = $(this).find("input").eq(0);
                        if (text[0] && text.attr("type") != "radio") {
                            var innerText = $.trim(text.val());
                            $(this).empty();
                            $(this).text(innerText);
                        }
                    }



                });
                // $(currentRow).find("input:checked").first().attr("checked", false);
            }
            currentRow = me;
            // $(currentRow).find("input:checked").first().attr("checked", true);
            $("input:radio", me).attr("checked", true);
        }

        cacheArray = new Array();

        function rowDbClick(me, id, remember) {
        var url = window.document.URL;
        if (url.indexOf("Entry=ExpertSet") > -1) {
            return false;
        }
       

            if (!checkStatus("修改")) return;
            $("td", me).each(function (i) {
                var flag = $(this).find("span");
                if (!flag[0] && i > 0 && i < 7) {
                    var innerText = $.trim($(this).text());
                    if (i == 2||i==3) return true;
                    if (i == 4) {
                        var text = $(this).find("input").eq(0);
                        $(this).text("");
                        $(this).append("<%=GetCatDDl() %>");
                        var appText = $(this).find("select").eq(0);
                        appText.val(text.val());
                    }
                    else if (i == 6) {
                        $(this).text("");
                        $(this).append("<input style='width:98%;text-align:center;' class='wdate' value='" + innerText + "' type='text' onclick='var skin=getSkin();WdatePicker({skin:skin})'>");
                    }
                    else {
                        $(this).text("");

                        $(this).append("<input type='text' style='width:98%' class='gridview_row' value='" + innerText + "' />");
                        cacheArray[i] = innerText;
                    }

                }
            });
        }


        function onCatSelect(me) {
            var appText = $(me);
            var text = $(me).parent().find("input").eq(0);
            if (text[0]) {
                text.val(appText.val());
            }
            else {
                $(me).parent().append("<input type='hidden' value='" + appText.val() + "'/>");
            }
        }



        function setExamPaper(me, argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            location.href = "SurveyDetail.aspx?CurrentID=" + rad + "&m=" + Math.random();

        }

        function testgo(me, argument) {
            var rad = $("#divContent").find(":checked ").first().attr("ExamPaperID");
            if (rad == "") {
                alert("试卷参数有误！");
                return false;
            }
            var surveyID = $("#divContent").find(":checked ").first().val();
            location.href = "ExamShow.aspx?CurrentId=" + rad + "&surveyID=" + surveyID + "&m=" + Math.random();

        }


        function setTester(me, argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            openOperateDialog("设置答题人", "MetaDataManager.aspx?SurveyID=" + rad + "&Entry=ChooseTester&m=" + Math.random(), 500, 500);
        }

        //关闭窗口
        function closeDialog(fieldTypeId) {
            $("#actionDialog").dialog("close");
        }

        function viewResult(me, argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            location.href = "SurveyResultManager.aspx?CurrentId=" + rad + "&m=" + Math.random();
        }


        function viewMyResult(me, argument) {
            var rad = $("#divContent").find(":checked ").first().attr("ExamPaperID");
            if (rad == "") {
                alert("试卷参数有误！");
                return false;
            }
            var surveyID = $("#divContent").find(":checked ").first().val();
            location.href = "ExamShow.aspx?CurrentId=" + rad + "&surveyID=" + surveyID + "&Entry=myResult&m=" + Math.random();

        }


        //设置专家
        function expertSet(me, argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            //location.href = "SurveyDetail.aspx?CurrentID=" + rad + "&m=" + Math.random();
            openOperateDialog("设置专家", "SurveyExpert.aspx?CurrentID=" + rad + "&Entry=ExpertSet", 900, 600, true, 1);

        }

        //查看进度
        function viewProcess(me, argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            openOperateDialog("查看进度", "ExpertProcess.aspx?CurrentID=" + rad + "", 900, 600, true, 1);

        }

        // 查看专家结果
        function viewExpertResult(me,argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            //openOperateDialog("查看评分详细", "ExpertResult.aspx?SurveyID=" + rad, 900, 600, true, 1);
            location.href ="ExpertResult.aspx?SurveyID=" + rad+"&m=" + Math.random();
        }

        //测评活动进程监控
        function process() {
            var rad = $("#divContent").find(":checked ").first().val();
            openOperateDialog("进程监控", "SurveyProcess.aspx?CurrentID=" + rad + "", 900, 600, true, 1);
        }

        //停用活动
        function stop() {
            var $td=$("#divContent tbody").find("input[checked]").parent().parent().find("td").last()
            var status =$.trim($td.text());
            if (status == "未发布" || status=="已停用") {
                alert("该活动"+status);
                return false;
            }

            var rad = $("#divContent").find(":checked ").first().val();

                if (!confirm("是否确定停用活动？")) {
                    return false;
                }

                $.post(getCurrentUrl(), { AjaxAction: "Stop", AjaxArgument: rad }, function (value) {
                    var ajaxResult = JSON2.parse(value);
                    if (ajaxResult) {
                        if (ajaxResult.ActionResult == 1) {
                            $td.text("已停用");
                        }
                        if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                            alert(ajaxResult.PromptMsg);
                        }
                    }
                    else {
                        alert("系统出错，请与管理员联系！");
                    }
                });

        }


    </script>
    <div id="divContent" class="div_content">
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <input id="radioId" type="radio" exampaperid='<%#Eval("ExamPaperID")%>' value='<%#Eval("ID") %>'
                            name="radioId" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="测评名称">
                    <ItemTemplate>
                        <%#Eval("Title")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="试卷">
                    <ItemTemplate>
                        <input type="hidden" value='<%#Eval("ExamPaperID") %>' />
                        <%#GetExamName((string)Eval("ExamPaperID"))%>
                    </ItemTemplate>
                </asp:TemplateField>

                  <asp:TemplateField HeaderText="测评对象">
                    <ItemTemplate>
                        <%#GetUserName(Eval("SurveyTarget"))%>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="所属分类">
                    <ItemTemplate>
                        <input type="hidden" value='<%#Eval("Category") %>' />
                        <%# RemarkAttribute.GetEnumRemark((SubjectCategory)Enum.Parse(typeof(SubjectCategory), Eval("Category").ToString()))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="答题时限">
                    <ItemTemplate>
                        <%#Eval("LimitTime")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="结束时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("EndTime")).ToShortDateString() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="状态" HeaderStyle-Wrap="false">
                    <ItemTemplate>
                       

                        <%#GetStatus(Eval("Status").ToString())%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </suntek:PagedGridView>
    </div>
    <div id="filterDialog" title="查询">
        <p id="validateTips">
        </p>
        <fieldset>
            <dl>
                <dt class="rowlable">测评名称</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterTitle" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">试卷ID</dt>
                <dd class="rowinput">
                    <suntek:ChooseBox ID="filterExamPaperID" OpenUrl="ExamPaperIDTree.aspx" DialogTitle="选择试卷ID"
                        runat="server"></suntek:ChooseBox>
                </dd>
                <dt class="rowlable">360测评=1; 动机测评=2; 团队效能测评=3; 优势与特点测评=4; Disc测评=5; 情景模拟=21; 案例分析=22;
                    关键事件访谈=23; </dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterCategory" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">归属组织</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">考试时间</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterLimitTime" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">结束时间</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterEndTime" runat="server"></suntek:DatePicker>
                </dd>
                <dt class="rowlable">创建者</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterCreator" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">创建时间</dt>
                <dd class="rowinput">
                    <suntek:DatePicker ID="filterCreateTime" runat="server"></suntek:DatePicker>
                </dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>
