<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="CorpSort.aspx.cs" Inherits="WebSite.Register.CorpSort" %>

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
        $(document).ready(function () {
            //全选操作
            $("#CBselectAll").click(function () {
                var flag = $(this).attr("checked")
                $(".gridview tbody").find("input[type=checkbox]").each(function () {
                    $(this).attr("checked", flag);
                });
            });
            sorTable();
        });

        //删除左右两端的空格
        function trim(str) {

            return str.replace(/(^\s*)|(\s*$)/g, "");
        }

        function rowOut(me) {
            if (oldRow != null) {
                if (currentRow != me) {
                    me.className = "rowout";
                }
                oldRow = me;
            }
        }


        /*拖动排序*/
        function sorTable() {
            var $table = $('.gridview');

            var $tbody = $table.find("tbody");
            $tbody.find("tr").css("cursor", "move")
                            .attr("title", "拖动行可以进行排序");

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
                        $(this).children(":eq(1)").text(i + 1);
                    });
                }
            }).disableSelection();

        }

        /*保存拖动排序*/
        function saveSort() {
            var $tbody = $('.gridview').find("tbody");
            var jsonData = "";
            var arr = [];
            $tbody.find("tr").each(function (i) {
                var td = $(this).children();
                var obj = {};
                obj.SortOrder = $.trim(td.eq(1).text());
                obj.CorpID = $.trim(td.eq(2).text());
                obj.CorpName = $.trim(td.eq(3).text());
                obj.ID = $.trim(td.eq(2).text());
                arr[i] = obj;
            });
            jsonData = JSON2.stringify(arr);
            $.post(getCurrentUrl(), { AjaxAction: "SaveSort", AjaxArgument: jsonData }, function (result) {
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
                        var tmp = $.trim($(this).text());
                        $(this).text($.trim(destCells.eq(i).text()));
                        destCells.eq(i).text(tmp);
                    }
                });
            }
        }
        /*添加新行*/
        function addRow(array) {
            var $tbody = $('.gridview').find("tbody");
            var rowCount = $tbody.find("tr").length;
            for (var i = 0; i < array.length; i++) {
                rowCount++;
                var item = array[i];
                var newRow = "<tr onmouseout=\"rowOut(this);\" onmouseover=\"rowOver(this);\" onclick=\"rowClick(this,'',true)\" style=\"cursor: pointer\" id='" + item.CorpID + "'>"
                   + "<td style=\"cursor: default;\" flag=\"combox\"><input id=\"checkboxId\" type=\"checkbox\" value='" + item.CorpID + "' name=\"items\" /></td>"
            + "<td>" + rowCount + "</td><td>" + item.CorpID + "</td><td>" + item.CorpName + "</td>"
            + "<td flag=\"operate\"><span class='btn_delete' onclick=\"executeOperate(this,'delete')\">&nbsp;&nbsp;&nbsp;</span>|<span class=\"btn_up\" title='上移' onclick=\"executeOperate(this,'up')\">&nbsp;&nbsp;&nbsp;</span>|<span class=\"btn_down\" title='下移' onclick=\"executeOperate(this,'down')\">&nbsp;&nbsp;&nbsp;</span></td></tr>";
                $tbody.append(newRow);
            }
        }

        /*删除当前行*/
        function del(currentRow) {
            if (!confirm("是否确定删除记录？")) {
                return false;
            }

            $.post(getCurrentUrl(), { AjaxAction: "Remove", AjaxArgument: currentRow.attr("id") }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        if (message == "")
                            message = "操作成功！";

                        // 重新显示序号
                        var $td = currentRow.find("td:eq(1)");
                        var index = parseInt($td[0].innerText);
                        currentRow.nextAll().find("td:eq(1)").each(function (i) {
                            $(this).text(i + index);
                        });
                        currentRow.remove();
                    }
                }
                alert(message);
            });
        }

        /*删除多行数据*/
        function dels() {
            if (!confirm("是否确定删除记录？")) {
                return false;
            }

            var $tbody = $(".gridview").find("tbody");

            $tbody.find("input[checked]").each(function () {
                $(this).parent().parent().remove();
            });

            //重新显示序号
            $tbody.find("tr").find("td:eq(1)").each(function (i) {
                $(this).text(i + 1);
            });

            saveSort();

            
        }


        function add(me, argument) {
            var rtnVal = openOperateDialog("新增组织", "ChooseOrgTree.aspx?Entry=Choose", 400, 500, true, 1);
            if (rtnVal.length != 0) {
                addRow(rtnVal);
            }
        }
    
    </script>
    <div id="divContent" class="div_content" style="overflow: scroll; height: 100%; width: 100%;
        overflow-x: hidden;">
        <table class="gridview" rules="all" border="1" style="border-collapse: collapse;
            width: 100%; display: inline-table;">
            <thead>
                <tr>
                    <th style="width: 5%">
                        <input id="CBselectAll" type="checkbox" name="checkboxId" />
                    </th>
                    <th style="width: 8%">
                        序号
                    </th>
                    <th style="width: 8%">
                        公司ID
                    </th>
                    <th style="width: 32%">
                        公司名称
                    </th>
                    <th style="width: 15%">
                        操作
                    </th>
                </tr>
            </thead>
            <asp:Repeater ID="rptSubject" runat="server">
                <ItemTemplate>
                    <tr onmouseout="rowOut(this);" onmouseover="rowOver(this);" style="cursor: pointer"
                        id='<%#Eval("ID") %>'>
                        <td style="cursor: default;" flag="combox">
                            <input id="checkboxId" type="checkbox" value='<%#Eval("ID") %>' name="items" />
                        </td>
                        <td>
                            <%# 1+Container.ItemIndex %>
                        </td>
                        <td>
                            <%#Eval("CorpID") %>
                        </td>
                        <td>
                            <%#Eval("CorpName")%>
                        </td>
                        <td flag="operate">
                            <span class='btn_delete' onclick="executeOperate(this,'delete')">&nbsp;&nbsp;&nbsp;</span>
                            |<span class="btn_up" title='上移' onclick="executeOperate(this,'up')">&nbsp;&nbsp;&nbsp;</span>
                            |<span class="btn_down" title='下移' onclick="executeOperate(this,'down')">&nbsp;&nbsp;&nbsp;</span>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
</asp:Content>
