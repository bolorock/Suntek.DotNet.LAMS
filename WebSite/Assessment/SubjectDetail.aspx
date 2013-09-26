<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SubjectDetail.aspx.cs" Inherits="WebSite.SubjectDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <style type="text/css">
       html,body,form
       {
           margin:0px;
           height:100%;
       }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript" language="javascript">

        //校验脚本
        function initValidator() {
            $.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function (msg) { promptMessage(msg); } });
            /*非空字段*/
            $("#<%=txtSubjectTitle.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【题目标题】不能为空" });
            /*默认验证字段*/
            $("#<%=txtAnswer.ClientID%>").formValidator().inputValidator({ max: 512, onerror: "【参考答案】长度不能超过512" });
            $("#<%=txtDefaultScore.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【默认分值】不能为空" });
            $("#<%=txtDefaultScore.ClientID%>").formValidator().inputValidator({ type: "number", onerror: "【默认分值】格式错误" });
        }


        //页面初始化
        $(document).ready(function () {
            //初始化校验脚本
            initValidator();
        });


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
                $(currentRow).find("td").each(function (i) {
                    var text = $(":input", $(this)).eq(0);
                    if (text[0]) {
                        var innerText = text.val();
                        $(this).empty();
                        $(this).text(innerText);
                    }
                });
            }
            currentRow = me;
        }

        var cacheArray = new Array();
        function rowDbClick(me, id, remember) {
            if ($(":input", $(me)).eq(0)[0]) return;

            $("td", me).each(function (i) {
                var flag = $(this).attr("flag");
                if (i > 0 && flag != "operate" && flag != "combox") {
                    var innerText = $.trim($(this).text());
                    $(this).text("");
                    $(this).append("<input type='text' value='" + innerText + "' style='width:100px;'/>");
                    cacheArray[i] = innerText;
                }
                if (i == 3)//运行方式 
                {
                    //                var innerText = $.trim($(this).text());
                    //                $(this).text("");
                    //                $(this).append("<select style='width:100px;'><option " + (innerText == "弹出" ? "selected='selected'" : "") + " >弹出</option><option " + (innerText == "Post" ? "selected='selected'" : "") + ">Post</option><option " + (innerText == "Ajax" ? "selected='selected'" : "") + ">Ajax</option></select> ");
                    //                cacheArray[i] = innerText;
                }
                //            else if (i == 4)//是否验证
                //            {
                //                var innerText = $.trim($(this).text());
                //                $(this).text("");
                //                $(this).append("<select style='width:100px;'><option " + (innerText == "是" ? "selected='selected'" : "") + " >是</option><option " + (innerText == "否" ? "selected='selected'" : "") + ">否</option></select>");
                //                cacheArray[i] = innerText;
                //            }
            });
        }


        function addSubjectItem() {
            var tblSubjectItem = $("#tblSubjectItem");
            var rowCount = $("#tblSubjectItem").find("tr").length;

            var newRow = "<tr ondblclick=\"rowDbClick(this,'',true)\" style='cursor: hand' id=''>"
                          + "<td>" + rowCount + "</td><td><input type='text'/></td><td><input type='text' value='0'/></td>" +
                            "<td flag='operate'><span class='btn_delete' title='删除' onclick=\"executeOperate(this,'delete')\">&nbsp;&nbsp;&nbsp;</span> | <span class='btn_up' title='上移' onclick=\"executeOperate(this,'up')\">&nbsp;&nbsp;&nbsp;</span> ｜ <span class='btn_down' title='下移' onclick=\"executeOperate(this,'down')\">&nbsp;&nbsp;&nbsp;</span></td></tr>";
            tblSubjectItem.append(newRow);
        }


        function addSubjectItem_dim_2() {
            var tblSubjectItem_dim_2 = $("#tblSubjectItem_dim_2");
            var rowCount = $("#tblSubjectItem_dim_2").find("tr").length;

            var newRow = "<tr ondblclick=\"rowDbClick(this,'',true)\" style='cursor: hand' id=''>"
                          + "<td>" + rowCount + "</td><td><input type='text'/></td>" +
                            "<td flag='operate'><span class='btn_delete' title='删除' onclick=\"executeOperate(this,'delete')\">&nbsp;&nbsp;&nbsp;</span> | <span class='btn_up' title='上移' onclick=\"executeOperate(this,'up')\">&nbsp;&nbsp;&nbsp;</span> | <span class='btn_down' title='下移' onclick=\"executeOperate(this,'down')\">&nbsp;&nbsp;&nbsp;</span></td></tr>";
            tblSubjectItem_dim_2.append(newRow);
        }



        function swapRow(srcRow, destRow) {
            if (srcRow[0] && destRow[0]) {

                var tmp1 = srcRow.clone();
                var tmp2 = destRow.clone();
                var tmp = $(tmp1).find("td").eq(0).html();
                $(tmp1).find("td").eq(0).html($(tmp2).find("td").eq(0).html());
                $(tmp2).find("td").eq(0).html(tmp);

                srcRow.replaceWith(tmp2);
                destRow.replaceWith(tmp1);

                //            var destCells = destRow.find("td[flag!='operate']");
                //            srcRow.find("td[flag!='operate']").each(function (i) {
                //                if (i > 0) {
                //                    var tmp = $.trim($(this).html());
                //                    $(this).html($.trim(destCells.eq(i).html()));
                //                    destCells.eq(i).html(tmp);
                //                }
                //            });
            }
        }

        function changeOrder(me) {
            $("tr", me).each(function (j) {
                if (j > 0) {
                    $("td", this).eq(0).text(j);
                }
            });

        }


        function executeOperate(me, operate) {
            var currentRow = $(me).parent().parent();
            if (operate == "delete") {
                var tblID = currentRow.parent().parent().attr("id");
                currentRow.remove();
                changeOrder($("#" + tblID));

            } else if (operate == "up") {
                var prev = currentRow.prev();
                swapRow(prev, currentRow);
            } else if (operate == "down") {
                var next = currentRow.next();
                swapRow(next, currentRow);
            }

            return false;
        }


        //-------------互斥矩阵操作




        function showNextSubject(me) {
            if ($(me).attr("checked")) {
                alert("");
            }
            else {
                alert("xx");
            }
        }


        function save(me, argument) {


            //取得选项信息

            var tblSubjectItem = $("#tblSubjectItem");
            var subjectItems = new Array();
            if ($("#item_block").css("display") == "block" || $("#item_block").css("display") == "") {
                $("tr", tblSubjectItem).each(function (i) {
                    if (i > 0) {
                        var item = new Object();
                        var tds = $(this).find("td");
                        tds.each(function (i) {
                            var text = $(":input", $(this)).eq(0);
                            if (text[0]) {
                                var innerText = text.val();
                                $(this).empty();
                                $(this).text(innerText);
                            }
                        });

                        if (tds.length > 0) {
                            item["SortOrder"] = parseInt($.trim(tds.eq(0).text()));
                            item["ItemTitle"] = $.trim(tds.eq(1).text());
                            item["ItemScore"] = $.trim(tds.eq(2).text());
                            item["NextSubjectID"] = parseInt($.trim(tds.eq(3).text()));
                            item["CommandName"] = $.trim(tds.eq(2).text());
                            item["CommandArgument"] = "";
                            item["ID"] = $.trim($(this).attr("id"));
                            subjectItems[i - 1] = item;
                        }
                    }
                });
            }
            var subject = getObjectValue("subjectDetail");



            //取得子题目信息
            var subSubjects = new Array();
            if ($("#subSubject").css("display") == "block" || $("#subSubject").css("display") == "") {

                var tblSubSubject = $("#tblSubSubject");

                $("tr", tblSubSubject).each(function (i) {
                    if (i > 0) {
                        var item = new Object();
                        var tds = $(this).find("td");
                        tds.each(function (i) {
                            var text = $(":input", $(this)).eq(0);
                            if (text[0]) {
                                var innerText = text.val();
                                $(this).empty();
                                $(this).text(innerText);
                            }
                        });

                        if (tds.length > 0) {
                            item["SortOrder"] = parseInt($.trim(tds.eq(0).text()));
                            item["SubjectTitle"] = $.trim(tds.eq(1).text());
                            item["ID"] = $.trim($(this).attr("id"));
                            subSubjects[i - 1] = item;
                        }
                    }
                });
                subject.SubSubjects = subSubjects;
            }



            //取得顶部维度的内容

            var subjectItem_dim_2 = new Array();
            if ($("#item_block_dim_2").css("display") == "block" || $("#item_block_dim_2").css("display") == "") {

                var tblSubjectItem_dim_2 = $("#tblSubjectItem_dim_2");

                $("tr", tblSubjectItem_dim_2).each(function (i) {
                    if (i > 0) {
                        var item = new Object();
                        var tds = $(this).find("td");
                        tds.each(function (i) {
                            var text = $(":input", $(this)).eq(0);
                            if (text[0]) {
                                var innerText = text.val();
                                $(this).empty();
                                $(this).text(innerText);
                            }
                        });

                        if (tds.length > 0) {
                            item["SortOrder"] = parseInt($.trim(tds.eq(0).text()));
                            item["ItemTitle"] = $.trim(tds.eq(1).text());
                            item["ID"] = $.trim($(this).attr("id"));
                            item["Dim"] = 1;
                            subjectItems[subjectItems.length] = item;
                        }
                    }
                });

            }

            subject.SubjectItems = subjectItems;

            //subSubject_dim取得互拆矩阵的子题目
            var mainSubSubject_dim = new Array();

            if ($("#subSubject_dim").css("display") == "block" || $("#subSubject_dim").css("display") == "") {

                var tblSubSubject_dim = $("#tblSubSubject_dim");



                $(".ItemTitleList", tblSubSubject_dim).each(function (k) {
                    var mainItem_dim = new Object();
                    var subSubject_dim = new Array();
                    mainItem_dim["SortOrder"] = k + 1;
                    mainItem_dim["SubjectTitle"] = "互斥矩阵";
                    mainItem_dim["ID"] = $.trim($(this).attr("id"));

                    //---------
                    $(".ItemTitle", this).each(function (i) {

                        var item = new Object();
                        var tds = $(this).find("td");
                        tds.each(function (j) {
                            var text = $(":input", $(this)).eq(0);
                            if (text[0]) {
                                var innerText = text.val();
                                $(this).empty();
                                $(this).text(innerText);
                            }
                        });

                        if (tds.length > 0) {
                            item["SortOrder"] = i + 1;
                            item["SubjectTitle"] = $.trim(tds.eq(1).text());
                            item["ID"] = $.trim($(this).attr("id"));
                            subSubject_dim[i] = item;

                        }
                    });

                    mainItem_dim.SubSubjects = subSubject_dim;
                    mainSubSubject_dim[k] = mainItem_dim;
                    //--------
                });

                subject.SubSubjects = mainSubSubject_dim;
            }





            var value = JSON2.stringify(subject);

            //提交后台处理
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
                if (ajaxResult.ActionResult == 1) {
                    // refreshParent();
                    if ($.query.get("copy") == "1") {
                        var retObj = {};
                        retObj["id"] = ajaxResult.RetValue;
                        retObj["SubjectTitle"] = subject["SubjectTitle"];
                        retObj["DefaultScore"] = subject["DefaultScore"];
                        retObj["SubjectType"] = $("#cboSubjectType").val();
                        retObj["Category"] = $("#cboCategory").val();
                        ret = JSON2.stringify(retObj);
                        window.returnValue = ret;
                    }
                    window.close();
                }
            });
        }

        //-----------矩阵子题目操作开始--------------------

        function addSubSubject() {
            var tblSubjectItem = $("#tblSubSubject");
            var rowCount = $("#tblSubSubject").find("tr").length;

            var newRow = "<tr ondblclick=\"rowDbClick(this,'',true)\"  style='cursor: hand' id=''>"
                          + "<td>" + rowCount + "</td><td><input type='text'/></td>" +
                            "<td flag='operate'><span class='btn_delete' title='删除' onclick=\"executeOperate(this,'delete')\">&nbsp;&nbsp;&nbsp;</span> ｜ <span class='btn_up' title='上移' onclick=\"executeOperate(this,'up')\">&nbsp;&nbsp;&nbsp;</span> ｜ <span class='btn_down' title='下移' onclick=\"executeOperate(this,'down')\">&nbsp;&nbsp;&nbsp;</span></td></tr>";
            tblSubjectItem.append(newRow);
        }


        //-------------矩阵子题目操作结束





        //2.大题
        function executeOperateH(me, operate) {
            var currentRow = $(me).parent().parent();
            if (operate == "delete") {
                currentRow.remove();
                $(".ItemTitleList").each(function (j) {
                    $("td", this).eq(1).text("第" + (j + 1) + "题");
                });

            } else if (operate == "up") {
                var prev = currentRow.prev();
                swapRow(prev, currentRow);
            } else if (operate == "down") {
                var next = currentRow.next();
                swapRow(next, currentRow);
            }

            return false;
        }



        function executeOperateM(me, operate) {
            var currentRow = $(me).parent().parent();

            if (operate == "delete") {
                var parentid = currentRow.parent().parent().attr("parentid");
                currentRow.remove();

                $("tr", $("table[parentid='" + parentid + "']")).each(function (j) {
                    $("td", this).eq(0).text(j + 1);
                });

            } else if (operate == "up") {
                var prev = currentRow.prev();
                swapRowM(prev, currentRow);
            } else if (operate == "down") {
                var next = currentRow.next();
                swapRowM(next, currentRow);
            }
            return false;
        }


        function swapRowM(srcRow, destRow) {
            if (srcRow[0] && destRow[0]) {

                //            var tmpValue1 = srcRow.find("textarea").val();
                //            var tmpValue2 = destRow.find("textarea").val();

                var tmp1 = srcRow.clone();
                var tmp2 = destRow.clone();

                var tmp = $(tmp1).find("td").eq(1).text();
                $(tmp1).find("td").eq(1).text($(tmp2).find("td").eq(1).text());
                $(tmp2).find("td").eq(1).text(tmp);
                //            tmp1.find("textarea").val(tmpValue1);
                //            tmp2.find("textarea").val(tmpValue2);
                //交换textarea的值


                srcRow.replaceWith(tmp2);
                destRow.replaceWith(tmp1);
            }
        }




    </script>
    <div id="subjectDetail" class="div_block" style="overflow: auto; height: 100%; width: 100%;
        overflow-x: hidden;">
        <div class="div_row">
            <div class="block_title">
                题目明细</div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtSubjectTitle.ClientID%>" class="label">
                    <em>*</em> 题目标题
                </label>
            </div>
            <div style="float: left; width: 70%;">
                <asp:TextBox ID="txtSubjectTitle" Width="85%" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=cboSubjectType.ClientID%>" class="label">
                    <em>*</em> 题型
                </label>
            </div>
            <div class="div_row_input">
                <suntek:Combox ID="cboSubjectType" runat="server"></suntek:Combox>
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
                <asp:TextBox ID="txtDefaultScore" runat="server" Text="0" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=txtAnswer.ClientID%>" class="label">
                    参考答案
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAnswer" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div id="item_block_dim_2" style="display: none;">
            <div class="div_row">
                <div class="block_title">
                    顶部维度</div>
            </div>
            <div style="float: left; width: 100%; text-align: center;">
                <table id="tblSubjectItem_dim_2" style="width: 80%; display: inline-table;">
                    <thead>
                        <tr>
                            <th style="width: 12%">
                                序号
                            </th>
                            <th style="width: 15%">
                                选项文字
                            </th>
                            <th style="width: 28%">
                                <span onclick="addSubjectItem_dim_2();" class='btn_add' title='添加'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            </th>
                        </tr>
                    </thead>
                    <asp:Repeater ID="rptSubjectItem_dim_2" runat="server">
                        <ItemTemplate>
                            <tr ondblclick="rowDbClick(this,'',true)" style="cursor: pointer" id='<%#Eval("ID") %>'>
                                <td>
                                    <%#Eval("SortOrder")%>
                                </td>
                                <td>
                                    <%#Eval("ItemTitle")%>
                                </td>
                                <%--  <td><%#Eval("NextSubjectID")%>
                            </td>--%>
                                <td flag="operate">
                                    <span class='btn_delete' onclick="executeOperate(this,'delete')">&nbsp;&nbsp;&nbsp;</span>
                                    | <span class="btn_up" title='上移' onclick="executeOperate(this,'up')">&nbsp;&nbsp;&nbsp;</span>
                                    | <span class="btn_down" title='下移' onclick="executeOperate(this,'down')">&nbsp;&nbsp;&nbsp;</span>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </div>
        <div id="item_block" style="display: block;">
            <div class="div_row">
                <div class="block_title">
                    选项</div>
            </div>
            <div style="float: left; width: 100%; text-align: center;">
                <table id="tblSubjectItem" style="width: 80%; display: inline-table;">
                    <thead>
                        <tr>
                            <th style="width: 12%">
                                序号
                            </th>
                            <th style="width: 15%">
                                选项文字
                            </th>
                            <th style="width: 15%">
                                选项分值
                            </th>
                            <%--  <th style="width: 15%"><input type="checkbox" onclick="showNextSubject(this)" />
                            跳题
                        </th>--%>
                            <th style="width: 28%">
                                <span onclick="addSubjectItem();" class='btn_add' title='添加'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            </th>
                        </tr>
                    </thead>
                    <asp:Repeater ID="rptSubjectItem" runat="server">
                        <ItemTemplate>
                            <tr ondblclick="rowDbClick(this,'',true)" style="cursor: pointer" id='<%#Eval("ID") %>'>
                                <td>
                                    <%#Eval("SortOrder")%>
                                </td>
                                <td>
                                    <%#Eval("ItemTitle")%>
                                </td>
                                <td>
                                    <%#Eval("ItemScore")%>
                                </td>
                                <%--  <td><%#Eval("NextSubjectID")%>
                            </td>--%>
                                <td flag="operate">
                                    <span class='btn_delete' onclick="executeOperate(this,'delete')">&nbsp;&nbsp;&nbsp;</span>
                                    | <span class="btn_up" title='上移' onclick="executeOperate(this,'up')">&nbsp;&nbsp;&nbsp;</span>
                                    | <span class="btn_down" title='下移' onclick="executeOperate(this,'down')">&nbsp;&nbsp;&nbsp;</span>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </div>
        <div id="subSubject" style="display: none;">
            <div class="div_row">
                <div class="block_title">
                    子题目</div>
            </div>
            <div style="float: left; width: 100%; text-align: center;">
                <table id="tblSubSubject" style="width: 80%; display: inline-table;">
                    <thead>
                        <tr>
                            <th style="width: 12%">
                                序号
                            </th>
                            <th style="width: 15%">
                                题目标题
                            </th>
                            <th style="width: 28%">
                                <span onclick="addSubSubject();" class='btn_add' title='添加'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            </th>
                        </tr>
                    </thead>
                    <asp:Repeater ID="rptSubSubject" runat="server">
                        <ItemTemplate>
                            <tr ondblclick="rowDbClick(this,'',true)" style="cursor: pointer" id='<%#Eval("ID") %>'>
                                <td>
                                    <%#Eval("SortOrder")%>
                                </td>
                                <td>
                                    <%#Eval("SubjectTitle")%>
                                </td>
                                <td flag="operate">
                                    <span class='btn_delete' onclick="executeOperate(this,'delete')">&nbsp;&nbsp;&nbsp;</span>
                                    | <span class="btn_up" title='上移' onclick="executeOperate(this,'up')">&nbsp;&nbsp;&nbsp;</span>
                                    | <span class="btn_down" title='下移' onclick="executeOperate(this,'down')">&nbsp;&nbsp;&nbsp;</span>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </div>
        <div id="subSubject_dim" style="display: none;">
            <div class="div_row">
                <div class="block_title">
                    子题目</div>
            </div>
            <div style="float: left; width: 100%; text-align: center;">
                <table id="tblSubSubject_dim" style="width: 80%; display: inline-table; border-collapse: collapse;"
                    border="1">
                    <thead>
                        <tr>
                            <th style="width: 12%">
                                序号
                            </th>
                            <th style="width: 15%">
                                题目
                            </th>
                            <th style="width: 55%">
                                细项
                            </th>
                            <th style="width: 28%">
                                <span onclick="addSubSubject_dim_group();" class='btn_add' title='添加题目'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                &nbsp;&nbsp;<span onclick="addSubSubject_dim();" class='btn_add' title='添加题目子项'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            </th>
                        </tr>
                    </thead>
                    <asp:Repeater ID="rptSubSubject_dim" runat="server">
                        <ItemTemplate>
                            <tr ondblclick="rowDbClick(this,'',true)" class="ItemTitleList" style="cursor: pointer"
                                id='<%#Eval("ID") %>'>
                                <td valign="top">
                                    <input type="radio" checked='checked' name='radioId' id='<%#Eval("ID") %>' />
                                </td>
                                <td>
                                    第<%#Eval("SortOrder")%>题
                                </td>
                                <td>
                                    <table style="width: 80%; display: inline-table;" parentid='<%#Eval("ID")%>'>
                                        <asp:Repeater ID="rptSubSubject_dimItem" runat="server" DataSource='<%#GetSubSubjects((string)Eval("ID")) %>'>
                                            <ItemTemplate>
                                                <tr ondblclick="rowDbClick(this,'',true)" style="cursor: hand" class="ItemTitle"
                                                    id='<%#Eval("ID") %>' parentid='<%#Eval("ParentID") %>'>
                                                    <td>
                                                        <%#Eval("SortOrder")%>
                                                    </td>
                                                    <td>
                                                        <%#Eval("SubjectTitle")%>
                                                    </td>
                                                    <td flag="operate">
                                                        <span class="btn_delete" title="删除" onclick="executeOperateM(this,'delete')">&nbsp;&nbsp;&nbsp;</span>
                                                        ｜ <span class="btn_up" title="上移" onclick="executeOperateM(this,'up')">&nbsp;&nbsp;&nbsp;</span>
                                                        ｜ <span class="btn_down" title="下移" onclick="executeOperateM(this,'down')">&nbsp;&nbsp;&nbsp;</span>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </table>
                                </td>
                                <td flag="operate">
                                    <span class='btn_delete' onclick="executeOperateH(this,'delete')">&nbsp;&nbsp;&nbsp;</span>
                                    | <span class="btn_up" title='上移' onclick="executeOperateH(this,'up')">&nbsp;&nbsp;&nbsp;</span>
                                    | <span class="btn_down" title='下移' onclick="executeOperateH(this,'down')">&nbsp;&nbsp;&nbsp;</span>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </div>
    </div>
    <script language="javascript" type="text/javascript">


        //添加互斥大题
        function addSubSubject_dim_group() {
            var tblSubSubject_dim = $("#tblSubSubject_dim");
            var rowCount = $("#tblSubSubject_dim").find("table").length + 1;
            var parentID = Math.round(Math.random() * 1000000000000);
            $(":radio").removeAttr("checked");
            var newRow = "<tr ondblclick=\"rowDbClick(this,'',true)\" style='cursor: hand' class=\"ItemTitleList\" id='" + parentID + "'>"
                          + "<td valign=\"top\"><input type=\"radio\" checked='checked' name='radioId' id='" + parentID + "'/></td><td>第" + rowCount + "题</td>"
                          + "<td>"
                          + "<table style=\"width: 80%; display: inline-table;\" parentID='" + parentID + "'>"
                          + "</table></td>"
                          + "<td flag='operate'><span class='btn_delete' title='删除' onclick=\"executeOperateH(this,'delete')\">&nbsp;&nbsp;&nbsp;</span> | <span class='btn_up' title='上移' onclick=\"executeOperateH(this,'up')\">&nbsp;&nbsp;&nbsp;</span> | <span class='btn_down' title='下移' onclick=\"executeOperateH(this,'down')\">&nbsp;&nbsp;&nbsp;</span></td></tr>";
            tblSubSubject_dim.append(newRow);
        }


        function addSubSubject_dim() {

            var tblSubSubject_dim = $("#tblSubSubject_dim").find(":checked ").parent().parent().find("table").eq(0);

            var parentID = tblSubSubject_dim.attr("ID");
            var rowCount = tblSubSubject_dim.find("tr").length + 1;

            var newRow = "<tr ondblclick=\"rowDbClick(this,'',true)\" style='cursor: hand' class='ItemTitle' parentID='" + parentID + "'>"
                          + "<td>" + rowCount + "</td>"
                          + "<td>"
                          + "<input type='text'/></td>"
                          + "<td flag='operate'><span class='btn_delete' title='删除' onclick=\"executeOperateM(this,'delete')\">&nbsp;&nbsp;&nbsp;</span> ｜ <span class='btn_up' title='上移' onclick=\"executeOperateM(this,'up')\">&nbsp;&nbsp;&nbsp;</span> ｜ <span class='btn_down' title='下移' onclick=\"executeOperateM(this,'down')\">&nbsp;&nbsp;&nbsp;</span></td></tr>";
            tblSubSubject_dim.append(newRow);
        }



        showBlock($("#cboSubjectTypedata").attr('value'));
        function comboxChooseItem(srcObject, id) {
            var ev = getEvent();
            if (id) {
                $("#" + id).val($(srcObject).text());
                $("#" + id + 'data').val($(srcObject).attr('data'));
                $("#combox" + id).hide();
            }
            else {
                var eObj = ev.srcElement || ev.target; // 获得事件源        
                if (eObj.tagName == "INPUT") return false;
                var chk = $(srcObject).find("input:first");
                chk.attr("checked", chk.attr("checked") == false);
            }

            if (id && id == "cboSubjectType") {
                //判断进行选项操作，如果是填空，则隐藏去选项
                showBlock($(srcObject).attr('data'));
            }


            return false; //防止a href="#"滚动 
        }


        function showBlock(subjectType) {
            hideAllBlock();
            switch (subjectType) {
                case "1": $("#item_block").show(); break;
                case "2": $("#item_block").show(); break;
                case "3": break;
                case "4": break;
                case "5": $("#item_block").show();
                    $("#subSubject").show();
                    break;
                case "6": $("#item_block").show();
                    $("#subSubject_dim").show();
                    break;
                case "7": $("#item_block").show(); $("#item_block_dim_2").show();
                    $("#subSubject").show();
                    break;
            }
        }

        function hideAllBlock() {
            $("#item_block").hide();
            $("#subSubject").hide();
            $("#item_block_dim_2").hide();
            $("#subSubject_dim").hide();

        }
    </script>
</asp:Content>
