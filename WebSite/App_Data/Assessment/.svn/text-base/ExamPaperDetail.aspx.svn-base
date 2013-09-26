<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ExamPaperDetail.aspx.cs" Inherits="WebSite.ExamPaperDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript" language="javascript">

        //校验脚本
        function initValidator() {
            $.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function (msg) { promptMessage(msg); } });
            /*非空字段*/
            $("#<%=txtTitle.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【试卷标题】不能为空" });
            /*默认验证字段*/
            $("#<%=txtDescription.ClientID%>").formValidator().inputValidator({ max: 256, onerror: "【说明】长度不能超过256" });

        }

        //页面初始化
        $(document).ready(function () {
            //初始化校验脚本
            initValidator();
        });


        function swapRow(srcRow, destRow) {
            if (srcRow[0] && destRow[0]) {
                var tempId = destRow.attr("id");
                destRow.attr("id", srcRow.attr("id"));
                srcRow.attr("id", tempId);
                var destCells = destRow.find("td[flag!='operate']");
                srcRow.find("td[flag!='operate']").each(function (i) {
                    if (i > 0) {
                        var tmp = $.trim($(this).text());
                        $(this).text($.trim(destCells.eq(i).text()));
                        destCells.eq(i).text(tmp);
                    }
                });
            }
        }

        //分页触发事件
        function pageChage(me, operate) {
            var pageIndexCurrent = $("#pageIndex").val();
            var pageIndex = 1;

            if (pageIndexCurrent == 1 && operate == "first") {
                alert("已经是第一页了");
                return false;
            }
            if (pageIndexCurrent == $("#ctl00_contentPlace_subjectPageCount").text() && operate == "last") {
                alert("已经是最后一页了");
                return false;
            }

            switch (operate) {
                case "next":
                    pageIndex = Number(pageIndexCurrent) + 1;
                    break;
                case "pre":
                    pageIndex = Number(pageIndexCurrent) - 1;
                    break;
                case "first":
                    pageIndex = 1;
                    break;
                case "last":
                    pageIndex = $("#ctl00_contentPlace_subjectPageCount").text();
                    break;
            }

            if (pageIndex == 0) {
                alert("已经是第一页了");
                return false;
            }
            if (pageIndex > $("#ctl00_contentPlace_subjectPageCount").text()) {
                alert("已经是最后一页了");
                return false;
            }


            $("#pageIndex").val(pageIndex);
            //根据当前页取一页的数据，用json包装
            $.post(getCurrentUrl(), { AjaxAction: "PageChange", AjaxArgument: pageIndex, CurrentId: $("#hidCurrentId").val() }, function (result) {
                var ajaxResult = JSON.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        if (message == "")
                            message = "操作成功！";

                    }

                    if (ajaxResult.RetValue) {
                        var tblSubjectItem = $("#tblSelectedSubject");
                        var selectedIDs = "";


                        $("tr", tblSubjectItem).each(function () {
                            selectedIDs += "," + $(this).attr("id");
                        });

                        //清空原来的列表
                        var tblSubject = $("#tblSubject")
                        var listStr = "";
                        $("tr", tblSubject).each(function (i) { if (i > 0) { $(this).remove(); } });

                        //加载异步返回的数据
                        for (i = 0; i < ajaxResult.RetValue.length; i++) {
                            //判断如果已经被选中了，则进行禁止再选择
                            var isSelected = "";
                            if (selectedIDs.indexOf(ajaxResult.RetValue[i]["ID"]) > 0)
                                isSelected = " checked=checked disabled=disabled ";

                            var operate = "<tr style=\"cursor: pointer\" id='" + ajaxResult.RetValue[i]["ID"] + "'>"
                                + "<td><input type=\"checkbox\" onclick=\"addSubject(this)\" " + isSelected + "/></td>"
                                + "<td align=\"left\">" + ajaxResult.RetValue[i]["SubjectTitle"] + "</td>"
                                + "<td>" + ajaxResult.RetValue[i]["SubjectType"] + "</td>"
                                + "<td>" + ajaxResult.RetValue[i]["DefaultScore"] + "</td>"
                                + "<td>" + ajaxResult.RetValue[i]["Category"] + "</td><td flag=\"operate\"></td></tr>"

                            tblSubject.append(operate);
                        }


                    }
                }

                //  alert(message);
            });



        }

        function executeOperate(me, operate) {
            var currentRow = $(me).parent().parent();
            if (operate == "delete") {
                //                var currentRow = $(me).parent().parent();
                //                var tds = currentRow.find("td");
                //                tds.eq(0).html("<input type=\"checkbox\" onclick=\"addSubject(this)\"/>");
                //                tds.eq(5).html("");
                //                $("#tblSubject").append(currentRow.clone());

                var setId = $("#" + currentRow.attr("id"), $("#itemList"));
                if (setId[0]) {
                    var chkSelected = setId.find("td").eq(0).find("input")
                    chkSelected.attr("checked", "");
                    chkSelected.attr("disabled", "");
                }
                currentRow.remove();





            } else if (operate == "up") {
                var prev = currentRow.prev();
                swapRow(prev, currentRow);
            } else if (operate == "down") {
                var next = currentRow.next();
                swapRow(next, currentRow);
            }

            return false;
        }

        function addSubject(me) {

            // if ($(me).attr("checked") = "checked") {
            var currentRow = $(me).parent().parent();
            var tblSelectedSubject = $("#tblSelectedSubject");
            var rowCount = $("#tblSelectedSubject").find("tr").length;

            var currentRowClone = currentRow.clone();

            var tds = currentRowClone.find("td");
            tds.eq(0).text(rowCount);
            var operate = "<span class='btn_delete' onclick=\"executeOperate(this,'delete')"
                + "\">&nbsp;&nbsp;&nbsp;</span>"
                + "｜<span class=\"btn_up\" title='上移' onclick=\"executeOperate(this,'up')\">&nbsp;&nbsp;&nbsp;</span>"
+ "｜<span class=\"btn_down\" title='下移' onclick=\"executeOperate(this,'down')\">&nbsp;&nbsp;&nbsp;</span>";

            tds.eq(5).html(operate);
            tblSelectedSubject.append(currentRowClone);
            $(me).attr("disabled", "disabled");
            //            }
            //            else {

            //            }
            // currentRow.remove();

            return false;
        }

        function searchSubject(me) {
            alert($(me).val());

        }



        function save(me, argument) {
            var tblSubjectItem = $("#tblSelectedSubject");
            var examPaperSubjects = new Array();


            $("tr", tblSubjectItem).each(function (i) {
                if (i > 0) {
                    var item = new Object();
                    var tds = $(this).find("td");

                    if (tds.length > 0) {
                        item["SortOrder"] = parseInt($.trim(tds.eq(0).text()));
                        item["SubjectID"] = $.trim($(this).attr("id"));
                        examPaperSubjects[i - 1] = item;
                    }
                }
            });

            var examPaper = getObjectValue("examPaperDetail");
            examPaper.ExamPaperSubjects = examPaperSubjects;
            var value = JSON.stringify(examPaper)

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

                    $("#hidCurrentId").val(ajaxResult.RetValue);
                }

                alert(message);
                refreshParent();
            });
        }


    
    </script>
    <div id="examPaperDetail"  style="overflow: auto; height: 100%; width: 100%; float: left">
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtTitle.ClientID%>" class="label">
                    <em>*</em> 试卷标题
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtTitle" runat="server" CssClass="text"></asp:TextBox>
            </div>
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
                <label for="<%=txtDefaultScore.ClientID%>" class="label">
                    默认分值
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDefaultScore" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtDescription.ClientID%>" class="label">
                    说明
                </label>
            </div>
            <div style="float: left; width: 70%;">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="text" TextMode="MultiLine"
                    Rows="5" Width="90%"></asp:TextBox>
            </div>
        </div>
        <div style="clear: both">
        </div>
        <div id="selectedItem_block">
            <div class="div_row">
                <div class="block_title">
                    已选题目</div>
            </div>
            <div id="selectedItemList">
                <div style="height: 200px; overflow-y: scroll; width: 80%; margin-left: 10%; border: 1px solid;
                    scrollbar-base-color: #ff6600;">
                    <table id="tblSelectedSubject" style="display: inline-table; width: 100%;">
                        <thead>
                            <tr>
                                <th style="width: 8%">
                                    序号
                                </th>
                                <th style="width: 32%">
                                    题目标题
                                </th>
                                <th style="width: 15%">
                                    题型
                                </th>
                                <th style="width: 10%">
                                    分值
                                </th>
                                <th style="width: 15%">
                                    所属分类
                                </th>
                                <th style="width: 20%">
                                    操作
                                </th>
                            </tr>
                        </thead>
                        <asp:Repeater ID="rptSelectedSubject" runat="server">
                            <ItemTemplate>
                                <tr ondblclick="rowDbClick(this,'',true)" style="cursor: pointer" id='<%#Eval("ID") %>'>
                                    <td>
                                        <%= ++index %>
                                    </td>
                                    <td align="left">
                                        <%#Eval("SubjectTitle")%>
                                    </td>
                                    <td>
                                        <%# RemarkAttribute.GetEnumRemark((SubjectType)Enum.Parse(typeof(SubjectType), Eval("SubjectType").ToString()))%>
                                    </td>
                                    <td>
                                        <%#Eval("DefaultScore")%>
                                    </td>
                                    <td>
                                        <%# RemarkAttribute.GetEnumRemark((SubjectCategory)Enum.Parse(typeof(SubjectCategory), Eval("Category").ToString()))%>
                                    </td>
                                    <td flag="operate">
                                        <span class='btn_delete' onclick="executeOperate(this,'delete')">&nbsp;&nbsp;&nbsp;</span>
                                        ｜ <span class="btn_up" title='上移' onclick="executeOperate(this,'up')">&nbsp;&nbsp;&nbsp;</span>
                                        ｜ <span class="btn_down" title='下移' onclick="executeOperate(this,'down')">&nbsp;&nbsp;&nbsp;</span>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
        </div>
        <div id="item_block">
            <div class="div_row">
                <div class="block_title">
                    待选题目</div>
                <div style="display: none;">
                    快捷通道： 题目标题：<input type="text" id="subjectKey" onchange="searchSubject(this)" />
                    所属分类：<suntek:Combox ID="cboCat" runat="server" />
                </div>
            </div>
            <div id="itemList">
                <div style="height: 250px; overflow-y: scroll; width: 80%; margin-left: 10%; border: 1px solid;
                    scrollbar-base-color: #ff6600;">
                    <%--  <style type="text/css">
                        div#mbDIV {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
	height:250px;
	background-color: #ddd;
	z-index: 1000;
	filter: alpha(opacity=30);
	opacity:0.3;
}
                        
                    </style>
                    <div  id="mbDIV">
                        <img src="../Skins/Default/Images/loading.gif" /> 加载中
                    </div>--%>
                    <table id="tblSubject" style="width: 100%; display: inline-table;">
                        <thead>
                            <tr>
                                <th style="width: 8%">
                                    选择
                                </th>
                                <th style="width: 51%">
                                    题目标题
                                </th>
                                <th style="width: 15%">
                                    题型
                                </th>
                                <th style="width: 10%">
                                    分值
                                </th>
                                <th style="width: 15%; border-right: 0px;">
                                    所属分类
                                </th>
                                <th style="width: 1%; border-left: 0px;">
                                </th>
                            </tr>
                        </thead>
                        <asp:Repeater ID="rptSubject" runat="server">
                            <ItemTemplate>
                                <tr ondblclick="rowDbClick(this,'',true)" style="cursor: pointer" id='<%#Eval("ID") %>'>
                                    <td>
                                        <input type="checkbox" onclick="addSubject(this)" <%# IsSelected((string)Eval("ID")) ? "checked=checked disabled=disabled":"" %> />
                                    </td>
                                    <td align="left">
                                        <%#Eval("SubjectTitle")%>
                                    </td>
                                    <td>
                                        <%# RemarkAttribute.GetEnumRemark((SubjectType)Enum.Parse(typeof(SubjectType), Eval("SubjectType").ToString()))%>
                                    </td>
                                    <td>
                                        <%#Eval("DefaultScore")%>
                                    </td>
                                    <td>
                                        <%# RemarkAttribute.GetEnumRemark((SubjectCategory)Enum.Parse(typeof(SubjectCategory), Eval("Category").ToString()))%>
                                    </td>
                                    <td flag="operate">
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                    <div class="gridview_footer">
                        <span style="margin-right: 5px;">共<span id="subjectPageCount" runat="server"></span>页&nbsp;&nbsp;
                            <span id="subjectCount" runat="server"></span>条记录 <a onclick="pageChage(this,'first')"
                                style="margin-right: 5px;">&lt;&lt;</a> <a style="margin-right: 5px;" onclick="pageChage(this,'pre')">
                                    &lt;</a>
                            <input type="text" value="1" id="pageIndex" style="margin-right: 5px;" />
                            <a onclick="pageChage(this,'next')" style="margin-right: 5px;">&gt;</a> <a onclick="pageChage(this,'last')"
                                style="margin-right: 5px;">&gt;&gt;</a><span style="margin-right: 5px; margin-right: 5px;">每页</span>
                            <input type="text" value="10" /><span>条记录</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
