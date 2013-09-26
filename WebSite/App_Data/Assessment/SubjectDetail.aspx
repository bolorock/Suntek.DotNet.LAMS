
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SubjectDetail.aspx.cs" Inherits="WebSite.SubjectDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("DetailJs") %>
	<%if (false)
      { %>
		<script   src="../Scripts/jquery-vsdoc.js" 
        type="text/javascript"></script> 
    <%}%>	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">

   <script type="text/javascript" language="javascript">

        //校验脚本
        function initValidator()
        {
			$.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function(msg) { promptMessage(msg); } });
            /*非空字段*/
            $("#<%=txtSubjectTitle.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【题目标题】不能为空" });
			/*默认验证字段*/
            $("#<%=txtAnswer.ClientID%>").formValidator().inputValidator({ max: 512, onerror: "【参考答案】长度不能超过512" });
            $("#<%=txtDefaultScore.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【默认分值】不能为空" });
			$("#<%=txtDefaultScore.ClientID%>").formValidator().inputValidator({ type: "number", onerror: "【默认分值】格式错误" });
        }

		
		//页面初始化
        $(document).ready(function() {
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
                          + "<td>" + rowCount + "</td><td>选项" + rowCount + "</td><td>0</td>" +
                            "<td flag='operate'><span class='btn_delete' title='删除' onclick=\"executeOperate(this,'delete')\">&nbsp;&nbsp;&nbsp;</span> ｜ <span class='btn_up' title='上移' onclick=\"executeOperate(this,'up')\">&nbsp;&nbsp;&nbsp;</span> ｜ <span class='btn_down' title='下移' onclick=\"executeOperate(this,'down')\">&nbsp;&nbsp;&nbsp;</span></td></tr>";
        tblSubjectItem.append(newRow);
    }

    function swapRow(srcRow, destRow) {
        if (srcRow[0] && destRow[0]) {
            var destCells = destRow.find("td[flag!='operate']");
            srcRow.find("td[flag!='operate']").each(function (i) {
                if (i > 0) {
                    var tmp = $.trim($(this).html());
                    $(this).html($.trim(destCells.eq(i).html()));
                    destCells.eq(i).html(tmp);
                }
            });
        }
    }

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
        }

        return false;
    }

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

        var subject = getObjectValue("subjectDetail");
        subject.SubjectItems = subjectItems;
        

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
        }

        subject.SubSubjects = subSubjects;
        var value = JSON.stringify(subject);

        //提交后台处理
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
            if (ajaxResult.ActionResult == 1) {
                refreshParent();
            }
        });
    }

    //-----------矩阵子题目操作开始--------------------
   
    function addSubSubject() {
        var tblSubjectItem = $("#tblSubSubject");
        var rowCount = $("#tblSubSubject").find("tr").length;

        var newRow = "<tr ondblclick=\"rowDbClick(this,'',true)\"  style='cursor: hand' id=''>"
                          + "<td>" + rowCount + "</td><td>题目" + rowCount + "</td>" +
                            "<td flag='operate'><span class='btn_delete' title='删除' onclick=\"executeOperate(this,'delete')\">&nbsp;&nbsp;&nbsp;</span> ｜ <span class='btn_up' title='上移' onclick=\"executeOperate(this,'up')\">&nbsp;&nbsp;&nbsp;</span> ｜ <span class='btn_down' title='下移' onclick=\"executeOperate(this,'down')\">&nbsp;&nbsp;&nbsp;</span></td></tr>";
        tblSubjectItem.append(newRow);
    }


    //-------------矩阵子题目操作结束

    </script>

    <div id="subjectDetail" class="div_block">
     <div class="div_row">
            <div class="block_title">
                题目明细</div>
        </div>


        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtSubjectTitle.ClientID%>" class="label">
			<em>*</em>
                题目标题
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtSubjectTitle" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboSubjectType.ClientID%>" class="label">
			<em>*</em>
              题型
			</label>
            </div>
           
            <div class="div_row_input">
            <suntek:Combox ID="cboSubjectType" runat="server"></suntek:Combox>
					
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboCategory.ClientID%>" class="label">
			<em>*</em>
                所属分类
   
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComBox ID="cboCategory"  runat="server"/>
                          
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
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtDefaultScore.ClientID%>" class="label">
			                默认分值
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDefaultScore" runat="server" Text="0" CssClass="text"></asp:TextBox>
            </div>
           
        </div>
       


        <div id="item_block">
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
                            选项值
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
                        <tr ondblclick="rowDbClick(this,'',true)"  style="cursor: pointer" id='<%#Eval("ID") %>'>
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
                                ｜ <span class="btn_up" title='上移' onclick="executeOperate(this,'up')">&nbsp;&nbsp;&nbsp;</span>
                                ｜ <span class="btn_down" title='下移' onclick="executeOperate(this,'down')">&nbsp;&nbsp;&nbsp;</span>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>

        </div>

          <div id="subSubject" style="display:none;">
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
                        <tr ondblclick="rowDbClick(this,'',true)"  style="cursor: pointer" id='<%#Eval("ID") %>'>
                            <td>
                                <%#Eval("SortOrder")%>
                            </td>
                            <td>
                                <%#Eval("SubjectTitle")%>
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

    <script language="javascript" type="text/javascript">
        if ($("#cboSubjectType").val() == "问答" || $("#cboSubjectType").val() == "填空") {
            $("#item_block").hide();
        }
        if ($("#cboSubjectType").val() == "矩阵") {
            $("#subSubject").show();
        }

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

                switch ($(srcObject).attr('data')) {
                    case "1": $("#item_block").show(); $("#subSubject").hide(); break;
                    case "2": $("#item_block").show(); $("#subSubject").hide(); break;
                    case "3": $("#item_block").hide(); $("#subSubject").hide(); break;
                    case "4": $("#item_block").hide(); $("#subSubject").hide(); break;
                    case "5": $("#item_block").show();
                        $("#subSubject").show();
                        break;
                }
            }


            return false; //防止a href="#"滚动 
        }
        </script>

</asp:Content>

