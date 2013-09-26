<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ExamPaperSubjectManager.aspx.cs" Inherits="WebSite.ExamPaperSubjectManager" %>

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
                        if (i == 3) {
                            var tmp = $.trim(this.innerHTML);
                            $(this).html($.trim(destCells.eq(i).html()));
                            destCells.eq(i).html(tmp);
                        }
                        else {
                            var tmp = $.trim($(this).text());
                            $(this).text($.trim(destCells.eq(i).text()));
                            destCells.eq(i).text(tmp);
                        }
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
                var ajaxResult = JSON2.parse(result);
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

            var mark = "<input type='text' style='width:98%' value='" + $.trim(tds.eq(3).text()) + "'/>"
            tds.eq(3).html(mark);

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
            var value = JSON2.stringify(examPaper)

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
                refreshParent();
            });
        }

        function chooseConfirm(me, argument) {
            var tblSubjectItem = $("#tblSelectedSubject");
            var ret = "";
            var examPaperSubjects = new Array();

            $("tr", tblSubjectItem).each(function (i) {
                if (i > 0) {
                    var tds = $(this).find("td");
                    var item = new Object();
                    if (tds.length > 0) {
                        item["SortOrder"] = parseInt($.trim(tds.eq(0).text()));
                        item["SubjectID"] = $.trim($(this).attr("id"));
                        item["SubjectTitle"] = $.trim(tds.eq(1).text());
                        item["SubjectType"] = $.trim(tds.eq(2).text());

                        var text = $(":input", $(this)).eq(0);
                        if (text[0]) {
                            var innerText = text.val();
                            item["DefaultScore"] = innerText;
                        }
                        item["SubjectCategory"] = $.trim(tds.eq(4).text());
                    }

                    examPaperSubjects[i - 1] = item;
                }
            });

            ret = JSON2.stringify(examPaperSubjects);
            window.returnValue = ret;
            window.close();
        }
    
    </script>
    <div id="examPaperDetail"  style="overflow: auto; height: 100%; width: 100%; float: left;">
    
      
        <div style="clear: both">
        </div>
        <div id="selectedItem_block">
            <div class="div_row">
                <div class="block_title">
                    已选题目</div>
            </div>
            <div id="selectedItemList">
                <div style="height: 200px; overflow-y: scroll; width: 80%; margin-left: 10%; border: 1px solid;overflow-x: hidden;">
                    <table id="tblSelectedSubject" style="display: inline-table; width: 98%;">
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
               
            </div>
            <div id="itemList">
                <div style="height: 250px; overflow-y: scroll; width: 80%; margin-left: 10%; border: 1px solid;overflow-x: hidden;">
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
                    <table id="tblSubject" style="width: 98%; display: inline-table;">
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


