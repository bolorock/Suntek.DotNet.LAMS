<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ExamPaperManager.aspx.cs" Inherits="WebSite.ExamPaperManager" %>

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
        //返回选择对象
        //    function chooseConfirm() {
        ////        var rad = $("#divContent").find(":checked ").first().val();
        ////        $.post(getCurrentUrl(), { AjaxAction: "SaveChoose", AjaxArgument: rad }, function (result) {
        ////            var ajaxResult = JSON2.parse(result);
        ////            var message = "操作失败";
        ////            if (ajaxResult) {
        ////                if (ajaxResult.PromptMsg != null)
        ////                    message = ajaxResult.PromptMsg
        ////                if (ajaxResult.ActionResult == 1) {
        ////                    if (message == "")
        ////                        message = "操作成功！";

        ////                }
        ////            }
        ////            alert(message);
        ////        });
        //    }

        function rowDbClick(me, id, remember) {
        }
        function add(me, argument) {
            openOperateDialog("新增问卷", "ExamPaperDetail.aspx", 860, 500, true, 1);
            refresh(); //刷新当前页面
        }


        function edit(me, argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            openOperateDialog("修改问卷", "ExamPaperDetail.aspx?CurrentId=" + rad, 860, 500, true, 1);
            refresh(); //刷新当前页面
        }

        function preview(me, argument) {
            var rad = $("#divContent").find(":checked ").first().val();
            openOperateDialog("预览问卷", "ExamShow.aspx?CurrentId=" + rad + "&Entry=Preview", 1010, 720, true, 1);

        }




        function del(me, argument) {
            if (!confirm("是否确定删除记录？")) {
                return false;
            }
            var rad = $("#divContent").find(":checked ").first(); //.val();
            var id = rad.val();
            if ($.trim(id) == "") {

                alert("操作失败");
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

        /*复制问卷*/
        function copy() {
            var $checked = $("#divContent").find("input:checked ");
            if ($checked.length == 0) {
                alert("还没有选择一条记录");
                return;
            }
            if (!confirm("是否确定复制所选记录？")) {
                return false;
            }
            var id = $checked.val();
            $.post(getCurrentUrl(), { AjaxAction: "Copy", AjaxArgument: id }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.ActionResult == 1) {
                        refresh(); //刷新当前页面
                    }
                }
                alert(ajaxResult.PromptMsg);
            });
        }

    </script>
    <div id="divContent" class="div_content" style="overflow: scroll; height: 100%; width: 100%;
        overflow-x: hidden;">
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="选择">
                    <ItemTemplate>
                        <input id="radioId" type="radio" name="radioId" value='<%#Eval("ID") %>' text='<%#Eval("Title")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="试卷标题">
                    <ItemTemplate>
                        <%#Eval("Title")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="说明" ItemStyle-Width="50%">
                    <ItemTemplate>
                        <%#Eval("Description")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所属分类">
                    <ItemTemplate>
                        <%# RemarkAttribute.GetEnumRemark((SubjectCategory)Enum.Parse(typeof(SubjectCategory), Eval("Category").ToString()))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="默认分值">
                    <ItemTemplate>
                        <%#Eval("DefaultScore")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="创建时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("CreateTime")).ToShortDateString() %>
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
                <dt class="rowlable">试卷标题</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterTitle" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">说明</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterDescription" runat="server" CssClass="text"></asp:TextBox>
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
                <dt class="rowlable">默认分值</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterDefaultScore" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">归属组织</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
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
