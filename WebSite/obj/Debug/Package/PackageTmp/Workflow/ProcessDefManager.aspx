<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ProcessDefManager.aspx.cs" Inherits="WebSite.ProcessDefManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <script type="text/javascript" language="javascript">
        dialogSetting.detailWidth = 800;
        dialogSetting.detailHeight = 480;
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript">
        function publish() {
            $.post(getCurrentUrl(), { AjaxAction: "Publish", AjaxArgument: $("#hidCurrentId").val() }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        var tr = $("#<%=gvList.ClientID %>").find(":checked ").parent().parent();
                        tr.find("td")[4].innerText = ajaxResult.RetValue;
                    }
                }
                //$("#hidCurrentId").val(ajaxResult.RetValue);
                alert(message);
            });
        }

        function showProcessChart() {
            var id = $("#hidCurrentId").val();
            openOperateDialog("流程图", "ProcessChart.aspx?processDefID=" + id, 700,500);
        }


        function stop() {
            $.post(getCurrentUrl(), { AjaxAction: "Stop", AjaxArgument: $("#hidCurrentId").val() }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        var tr = $("#<%=gvList.ClientID %>").find(":checked ").parent().parent();
                        tr.find("td")[4].innerText = ajaxResult.RetValue;
                    }
                }
                //$("#hidCurrentId").val(ajaxResult.RetValue);
                alert(message);
            });
        }
    </script>
    <div id="divContent" class="div_content">
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="选择">
                    <ItemTemplate>
                        <input id="radioId" type="radio" value='<%#Eval("ID") %>' name="radioId" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="名称">
                    <ItemTemplate>
                        <%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="显示名">
                    <ItemTemplate>
                        <%#Eval("Text")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:TemplateField HeaderText="流程内容">
                    <ItemTemplate>
						<%#Eval("Content")%>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                <asp:TemplateField HeaderText="所属分类">
                    <ItemTemplate>
                        <%#GetDictItem(Eval("CategoryID").ToSafeString()).Text%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="当前状态">
                    <ItemTemplate>
                        <%# RemarkAttribute.GetEnumRemark((EAFrame.Workflow.Enums.ProcessStatus)Enum.Parse(typeof(EAFrame.Workflow.Enums.ProcessStatus), Eval("CurrentState").ToString()))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否当前版本">
                    <ItemTemplate>
                        <%# Eval("CurrentFlag").ToSafeString()=="1"?"是":"否"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="流程启动者">
                    <ItemTemplate>
                        <%#Eval("Startor")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否有活动实例">
                    <ItemTemplate>
                        <%# Eval("IsActive").ToSafeString() == "1" ? "是" : "否"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="版本">
                    <ItemTemplate>
                        <%#Eval("Version")%>
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
                <dt class="rowlable">名称</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">显示名</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterText" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">流程内容</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterContent" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">所属分类</dt>
                <dd class="rowinput">
                    <suntek:ComboBox runat="server" ID="filterCategoryID" DropDownStyle="DropDownList"
                        AppendDataBoundItems="true">
                    </suntek:ComboBox>
                </dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>
