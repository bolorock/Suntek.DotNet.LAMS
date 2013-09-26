<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="FieldSetManager.aspx.cs" Inherits="WebSite.Register.FieldSetManage" %>

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
        function executeOperate(me, operate) {
            var currentRow = $(me).parent().parent();
            if (operate == "delete") {
                del(currentRow);
            } else if (operate == "up") {
                var prev = currentRow.prev();
                swapRow(prev, currentRow);
            } else if (operate == "down") {
                var next = currentRow.next();
                swapRow(next, currentRow);
            }
            return false;
        }

        function swapRow(srcRow, destRow) {
            if (srcRow[0] && destRow[0]) {
                var tempId = destRow.attr("id");
                destRow.attr("id", srcRow.attr("id"));
                srcRow.attr("id", tempId);
                var destCells = destRow.find("td[flag!='operate']");
                srcRow.find("td[flag!='operate']").each(function (i) {
                    if (i > 1) {
                        if (i == 3 || i == 4) {
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

        function del(currentRow) {
            if (!confirm("是否确定删除记录？")) {
                return false;
            }
            var type = $("#<%=drpGrade.ClientID%>").val();

            var $td = currentRow.find("td:eq(1)");
            var index = parseInt($td[0].innerText);
            currentRow.nextAll().find("td:eq(1)").each(function (i) {
                $(this).text(i + index);
            });
            currentRow.remove();
            saveAll();
            

        }

        /*保存所有*/
        function saveAll() {
            var $table = $('#tbFieldSet');
            var $tbody = $table.find("tbody");
            var value = "";
            $tbody.find("tr").each(function (i) {
                value += $(this).attr("id");
                value += ",";
            });
            var type = $("#<%=drpGrade.ClientID%>").val();

            $.post(getCurrentUrl(), { AjaxAction: "SaveAll", AjaxArgument: value, registerType: type }, function (result) {
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
        }

        function edit(me, argument) {
            var type = $("#<%=drpGrade.ClientID%>").val();
            var rtnVal = openOperateDialog("选取字段", "FieldSetDetail.aspx?registerType=" + type, 860, 500, true, 1);
            if (rtnVal == "1")
                window.location.reload();  //刷新页面
        }

        //修改操作

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
                /*如果currentRow存在input进行保存*/
                var $td = $(currentRow).find("td");
                if ($td.find("input").length > 1) {
                    var type = $("#<%=drpGrade.ClientID%>").val();

                    var fieldSet = {
                        FieldCode: $.trim($td.eq(2).text()),
                        FieldShow: $.trim($td.eq(3).find("input").val()),
                        Description: $.trim($td.eq(4).find("input").val())
                    }
                    var value = JSON2.stringify(fieldSet);
                    $.post(getCurrentUrl(), { AjaxAction: "SaveRow", AjaxArgument: value, registerType: type }, function (result) {
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
                }

                $td.each(function (i) {
                    if (i > 0) {
                        var text = $(this).find("input:eq(0)");
                        if (text[0]) {
                            var innerText = text.val();
                            $(this).empty();
                            $(this).text(innerText);
                        }
                    }
                });

            }
            currentRow = me;
        }

        var cacheArray = new Array();
        function rowDbClick(me, id, remember) {
            $("td", me).each(function (i) {
                var flag = $(this).attr("flag");
                if (i > 2 && flag != "operate" && flag != "combox") {
                    var innerText = $.trim($(this).text());
                    $(this).text("");
                    $(this).append("<input type='text' value='" + innerText + "' style='width:100px;' flag='edit'/>");
                    cacheArray[i] = innerText;
                }
            });
        }


        $(function () {
            //全选操作
            $("#CBselectAll").click(function () {
                var flag = $(this).attr("checked")
                $("#tbFieldSet tbody").find("input[type=checkbox]").each(function () {
                    $(this).attr("checked", flag);
                });
            });
            sorTable();
        });

        /*拖动排序*/
        function sorTable() {
            var $table = $('#tbFieldSet');

            var $tbody = $table.find("tbody");
            $tbody.find("tr").css("cursor", "move")
                            .attr("title", "拖动行可以排序,双击行可以编辑");

            var fixHelper = function (e, ui) {
                ui.children().each(function () {
                    $(this).width($(this).width());
                });
                return ui;
            };

            $tbody.sortable({
                helper: fixHelper,
                cursor: 'move',
                distance: 0,
                delay: 100,
                //This event is triggered when the user stopped sorting and the DOM position has changed.
                update: function (event, ui) {
                    $tbody.find("tr").each(function (i) {
                        $(this).children().eq(1).text(i + 1);
                    });
                }
            }).disableSelection();

        }

        //删除多行数据
        function dels(me, argument) {
            if (!confirm("是否确定删除记录？")) {
                return false;
            }
            var $table = $('#tbFieldSet');
            var $tbody = $table.find("tbody");

            $tbody.find("input[checked]").each(function () {
                $(this).parent().parent().remove();
            });
            //重新显示序号
            $tbody.find("tr").find("td:eq(1)").each(function (i) {
                $(this).text(i + 1);
            });

            saveAll();
        }

      
    </script>
    <div id="divContent" class="div_content" style="overflow: scroll; height: 100%; width: 100%;
        overflow-x: hidden;">
        <div style="text-align: left; margin-left: 10px; margin-top: 10px;">
            <asp:DropDownList ID="drpGrade" runat="server" AutoPostBack="true" OnSelectedIndexChanged="drpGrade_SelectedIndexChanged">
                <asp:ListItem Value="CompleteRegisterManager2" Text="二级经理"></asp:ListItem>
                <asp:ListItem Value="CompleteRegisterManager3" Text="三级经理"></asp:ListItem>
                <asp:ListItem Value="CompleteCountyManager" Text="县分公司总经理"></asp:ListItem>
                <asp:ListItem Value="CompleteMarketingManager" Text="营销中心经理"></asp:ListItem>
                <asp:ListItem Value="SeniorManager" Text="资深经理"></asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="cmdInit" runat="server" Text="恢复原始设置" OnClick="cmdInit_Click" />
        </div>
        <table id="tbFieldSet" class="gridview" rules="all" border="1" style="border-collapse: collapse;
            width: 100%; display: inline-table;">
            <thead>
                <tr>
                    <th style="width: 5%">
                        <input id="CBselectAll" type="checkbox" name="checkboxId" />
                    </th>
                    <th style="width: 8%">
                        序号
                    </th>
                    <th style="width: 16%">
                        字段名
                    </th>
                    <th style="width: 16%">
                        字段中文
                    </th>
                    <th style="width: 32%">
                        描述
                    </th>
                    <th style="width: 15%">
                        操作
                    </th>
                </tr>
            </thead>
            <asp:Repeater ID="rptFieldSet" runat="server">
                <ItemTemplate>
                    <tr ondblclick="rowDbClick(this,'',true)" onmouseout="rowOut(this);" onmouseover="rowOver(this);"
                        onclick="rowClick(this,'',true)" style="cursor: pointer" id='<%#Eval("FieldCode") %>'>
                        <td style="cursor: default;" flag="combox">
                            <input id="checkboxId" type="checkbox" value='<%#Eval("FieldCode") %>' name="items" />
                        </td>
                        <td>
                            <%# 1+Container.ItemIndex %>
                        </td>
                        <td>
                            <%#Eval("FieldCode")%>
                        </td>
                        <td>
                            <%#Eval("FieldShow")%>
                        </td>
                        <td>
                            <%#Eval("Description") %>
                        </td>
                        <td flag="operate">
                            <span class='btn_delete' onclick="executeOperate(this,'delete')">&nbsp;&nbsp;&nbsp;</span>
                            |<span class="btn_up" title='上移' onclick="executeOperate(this,'up')">&nbsp;&nbsp;&nbsp;</span>
                            ｜ <span class="btn_down" title='下移' onclick="executeOperate(this,'down')">&nbsp;&nbsp;&nbsp;</span>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
</asp:Content>
