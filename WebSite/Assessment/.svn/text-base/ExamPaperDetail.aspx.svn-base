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

        function addMainSubject(me, argument) {
            var tblMainSubject = $("#subjectList");
            $(":radio").removeAttr("checked");
            var rad = Math.floor(Math.random() * 10000000000);

            var operate = "<span class='btn_delete' onclick=\"executeOperateM(this,'delete')"
                + "\">&nbsp;&nbsp;&nbsp;</span>"
                + "｜<span class=\"btn_up\" title='上移' onclick=\"executeOperateM(this,'up')\">&nbsp;&nbsp;&nbsp;</span>"
+ "｜<span class=\"btn_down\" title='下移' onclick=\"executeOperateM(this,'down')\">&nbsp;&nbsp;&nbsp;</span>";

            var newRow = "<div class=\"mainSubject\" id='m_" + rad + "'><div class=\"title\" style=\"width:100%;\"><table width=\"100%\"><tr><td width=\"5%\" align='center'> <input id=\"radioId\" checked='checked' type=\"radio\" name=\"radioId\" value='" + rad + "'/></td><td width=\"50%\"><textarea rows='2' style=\" width:98%\"></textarea></td><td width=\"20%\">(<input type=\"text\" style=\" width:20%\"  value='' class='sz'/>分)</td><td width=\"20%\" blockid='m_" + rad + "'>" + operate + "</td></tr></table></div>"
            +"<div class=\"item\"><table  style=\"display: inline-table; width: 100%;\" id='s_" + rad + "'><thead><tr><th style=\"width: 8%\">序号</th><th style=\"width: 32%\">题目标题</th><th style=\"width: 15%\">题型</th><th style=\"width: 10%\">分值</th><th style=\"width: 15%\">所属分类</th><th style=\"width: 20%\">操作</th></tr></thead></table></div></div>";
            tblMainSubject.append(newRow);

            // $("#gvList_ItemCount").text(parseInt($("#gvList_ItemCount").text()) + 1);
        }


        function delMainSubject(me, argument) {
            var id = $("#subjectList").find(":checked ").first().val();
            $("#m_" + id).remove();

        }

        function setSubject(me, argument) {
            var id = $("#subjectList").find(":checked ").first().val();
            if (id == null) {
                alert("您还没有选择任何大题。");
                return false;
            }
            var catID = $("#cboCategorydata").val();  //所属分类ID
            var tblMainSubject = $("#s_" + id);
            var ret = openOperateDialog("设置试题", "ExamPaperSubjectManager.aspx?MainSubjectID=" + id+"&catID="+catID, 700, 600, true, 1);
            var operate = "<span class='btn_edit' title='编辑' onclick=\"executeOperate(this,'edit')\">&nbsp;&nbsp;&nbsp;</span>｜"
            + "<span class='btn_delete' onclick=\"executeOperate(this,'delete')"
                + "\">&nbsp;&nbsp;&nbsp;</span>"
                + "｜<span class=\"btn_up\" title='上移' onclick=\"executeOperate(this,'up')\">&nbsp;&nbsp;&nbsp;</span>"
+ "｜<span class=\"btn_down\" title='下移' onclick=\"executeOperate(this,'down')\">&nbsp;&nbsp;&nbsp;</span>";

            var result = JSON2.parse(ret);
            if (result) {
                if (result.length > 0) {
                    tblMainSubject.find("tr").each(function (i) {
                        if (i > 0)
                            $(this).remove();
                    });
                }

                for (i = 0; i < result.length; i++) {

                    var subject = "<tr style=\"cursor: pointer\" id='" + result[i]["SubjectID"] + "'>"
                                + "<td>" + result[i]["SortOrder"] + "</td>"
                                + "<td align=\"left\">" + result[i]["SubjectTitle"] + "</td>"
                                + "<td>" + result[i]["SubjectType"] + "</td>"
                                + "<td><input type='text' value='" + result[i]["DefaultScore"] + "' class='sz'/></td>"
                                + "<td>" + result[i]["SubjectCategory"] + "</td>"
                                + " <td flag=\"operate\">" + operate + "</td>"
                                +"</tr>"
                    tblMainSubject.append(subject);
                }


            }

            // subStr = "<tr><td>jdfd</td><td></td><td></td><td></td></tr>";


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
                    if (i == 3) {
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
            if (!checkStatus("修改")) return;
            $("td", me).each(function (i) {
                var flag = $(this).find("span");
                if (!flag[0] && i > 0 && i < 6) {
                    var innerText = $.trim($(this).text());
                    if (i == 2) return true;
                    if (i == 3) {
                        var text = $(this).find("input").eq(0);
                        $(this).text("");

                        var appText = $(this).find("select").eq(0);
                        appText.val(text.val());
                    }
                    else if (i == 5) {
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




        //校验脚本
        function initValidator() {
            $.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function (msg) { promptMessage(msg); } });

            $("#<%=txtDefaultScore.ClientID%>").formValidator().inputValidator({ min: 1, max:100, type: "intege", onerror: "【默认分值】要为数字(范围1-100)" });
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





        function save(me, argument) {
            var isok = true;
            $(".sz").each(function () {
                if (!(/^[0-9]+$/.test($(this).val()))) {
                    isok = false;
                    alert("【说明】分数要为数字(范围0-100)");
                    return false;
                }
                else if (parseInt($(this).val()) < 0 || parseInt($(this).val()) > 100) {
                    isok = false;
                    alert("【说明】分数要为数字(范围0-100)");
                    return false;
                }

                //                if ($(this).val() == "" || $(this).val() < 0 || $(this).val() > 100) {
                //                    isok = false;
                //                    alert("【说明】分数要为数字(范围0-100)");
                //                    return false;
                //                }

            });
            if (!isok) return false;

            var examMainSubjects = new Array();

            $("div[class='mainSubject']").each(function (i) {
                var mainItem = new Object();
                var examPaperSubjects = new Array();
                var tds = $(".title", this).find("td");
                if (tds.length > 0) {
                    mainItem["SortOrder"] = i;

                    var mainTitle = $(":input", $(this)).eq(1);
                    if (mainTitle[0]) {
                        mainItem["Title"] = $.trim(mainTitle.val());
                    }

                    var mainScore = $(":input", $(this)).eq(2);
                    if (mainScore[0]) {
                        mainItem["Score"] = $.trim(mainScore.val());
                    }

                    //取得子项
                    $("tr", $(this).find("div[class='item']")).each(function (j) {
                        var subjectItem = new Object();
                        var subtds = $(this).find("td");
                        if (subtds.length > 0 && j > 0) {
                            subjectItem["SortOrder"] = j;
                            subjectItem["SubjectID"] = $(this).attr("id");
                            subjectItem["SubjectScore"] = subtds.eq(3).find("input").eq(0).val();
                            examPaperSubjects[j - 1] = subjectItem;

                        }

                    });

                    mainItem.ExamPaperSubjects = examPaperSubjects;
                }
                examMainSubjects[i] = mainItem;
            });


            var examPaper = getObjectValue("examPaperDetail");
            examPaper.ExamMainSubjects = examMainSubjects;


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
                // refreshParent();
                if (ajaxResult.ActionResult == 1) {
                    //refreshParent();
                    window.close();
                }
            });
        }


        //===============题目操作===========

        //1.小题
        function executeOperate(me, operate) {
            var currentRow = $(me).parent().parent();
            if (operate == "delete") {
                currentRow.remove();
            } else if (operate == "up") {
                var prev = currentRow.prev();
                swapRow(prev, currentRow);
            } else if (operate == "down") {
                var next = currentRow.next();
                swapRow(next, currentRow);
            } else if (operate == "edit") {
               var ret= openOperateDialog("编辑试题", "SubjectDetail.aspx?copy=1&CurrentId=" + currentRow.attr("id") + "&m=" + Math.random(), 800, 780, true, 1);
               if (ret != undefined) {
                   var result = JSON2.parse(ret);
                   currentRow.attr("id", result["id"]);
                  var tds = currentRow.find("td");
                  tds.eq(1).text(result["SubjectTitle"]);
                  tds.eq(2).text(result["SubjectType"]);
                  tds.eq(3).text(result["DefaultScore"]);
                  tds.eq(4).text(result["Category"]);
               }

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

        //2.大题
        function executeOperateM(me, operate) {
            var currentRow = $("#"+$(me).parent().attr("blockid"));

            if (operate == "delete") {
                currentRow.remove();
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
                //交换操作单元blockid
//                var tempId = destRow.attr("id");
//                destRow.attr("id", srcRow.attr("id"));
//                srcRow.attr("id", tempId);

//                //交换textarea的值

//                //交换主体内容
//                var tmp = srcRow.clone().children();
//                srcRow.html(destRow.clone().children());
                //                destRow.html(tmp);
                var tmpValue1 = srcRow.find("textarea").val();
                var tmpValue2 = destRow.find("textarea").val();

                var tmp1 = srcRow.clone();
                var tmp2 = destRow.clone();

                tmp1.find("textarea").val(tmpValue1);
                tmp2.find("textarea").val(tmpValue2);
                //交换textarea的值
                

                srcRow.replaceWith(tmp2);
                destRow.replaceWith(tmp1);
            }
        }

        function rowClick(me) {
            $(":radio").removeAttr("checked");
            $(":radio", me).eq(0).attr("checked", "checked");
        }

        //



        //==============题目操作结束=========
    
    </script>
    <div id="examPaperDetail" style="overflow: auto; height: 100%; width: 100%;overflow-x: hidden;">
        <asp:Literal ID="litTips" Visible="false" runat="server"></asp:Literal>

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
                   <em>*</em> 默认分值
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDefaultScore" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row" style=" height:80px;">
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
        <style type="text/css">
            html,body,form
            {
                magin:0px;
                height:100%;
            }
            .mainSubject
            {
                border: 1px solid #eeeeee;
                text-align: left;
                width: 95%;
                margin: 15px;
                 padding:15px;
            }
            .mainSubject .title
            {
                margin-bottom: 10px;
                width: 100%;
                background: none;
            }
            .mainSubject .item
            {
                line-height: 20px;
                text-align:center;
                width: 98%;
            }
        </style>
     
        <div id="subjectList">
            <asp:Repeater ID="rptMainSubject" runat="server">
                <ItemTemplate>
                    <div class="mainSubject"  id='m_<%#Eval("ID") %>'>
                        <div class="title" style=" width:100%;">
                            <table width="100%">
                                <tr onclick="rowClick(this)">
                                    <td width="5%" align="center">
                                        <input id="radioId" type="radio" name="radioId" value='<%#Eval("ID") %>' />
                                    </td>
                                    <td width="50%">
                                        <textarea rows="2" style="width: 98%;"><%#Eval("Title")%></textarea>
                                    </td>
                                    <td width="20%">
                                        (<input type="text" style="width: 20%" value='<%#Eval("score")%>' class="sz"/>分)
                                    </td>
                                    <td width="20%" blockid='m_<%#Eval("ID") %>'>
                                        <span class='btn_delete' onclick="executeOperateM(this,'delete')">&nbsp;&nbsp;&nbsp;</span>
                                        ｜ <span class="btn_up" title='上移' onclick="executeOperateM(this,'up')">&nbsp;&nbsp;&nbsp;</span>
                                        ｜ <span class="btn_down" title='下移' onclick="executeOperateM(this,'down')">&nbsp;&nbsp;&nbsp;</span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item">
                            <table style="display: inline-table; width: 100%;" id='s_<%#Eval("ID") %>'>
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

                               <asp:Repeater ID="rptSubject" runat="server" DataSource='<%# GetSubjectByMain((string)Eval("ID")) %>'>
                <ItemTemplate>
                                <tr id='<%#Eval("ID") %>'>
                                    <td>
                                        <%#Eval("SortOrder") %>
                                    </td>
                                    <td>
                                        <%#Eval("SubjectTitle")%>
                                    </td>
                                    <td>
                                         <%# RemarkAttribute.GetEnumRemark((SubjectType)Enum.Parse(typeof(SubjectType), Eval("SubjectType").ToString()))%>
                                    </td>
                                    <td>
                                       <input type="text" value='<%#Eval("DefaultScore")%>'  class="sz"/>
                                    </td>
                                    <td>
                                        <%# RemarkAttribute.GetEnumRemark((SubjectCategory)Enum.Parse(typeof(SubjectCategory), Eval("Category").ToString()))%>
                                    </td>
                                    <td flag="operate">
                                         <span class='btn_edit' title="编辑" onclick="executeOperate(this,'edit')">&nbsp;&nbsp;&nbsp;</span>｜ 
                                        <span class='btn_delete' title="删除" onclick="executeOperate(this,'delete')">&nbsp;&nbsp;&nbsp;</span>
                                        ｜ <span class="btn_up" title='上移' onclick="executeOperate(this,'up')">&nbsp;&nbsp;&nbsp;</span>
                                        ｜ <span class="btn_down" title='下移' onclick="executeOperate(this,'down')">&nbsp;&nbsp;&nbsp;</span>
                                    </td>
                                </tr>
                              </ItemTemplate>
                              </asp:Repeater>

                            </table>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
