<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/Page.Master"
    CodeBehind="StartProcess.aspx.cs" Inherits="WebSite.Workflow.StartProcess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript">
        function startProcess() {
            $.post(getCurrentUrl(), { AjaxAction: "StartProcessInst", AjaxArgument: $("#hidCurrentId").val() }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        var parameters = ajaxResult.RetValue.split("$");
                        var url = 'StartProcessForm.aspx?processInstID=' + parameters[0] + '&workItemID=' + parameters[1];
                        openDialog('actionDialog', '流程', url, 980, 700, true, 1);
                    }
                }
                if(message!="操作成功")
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
                <asp:TemplateField HeaderText="所属分类">
                    <ItemTemplate>
                        <%#GetDictItem(Eval("CategoryID").ToSafeString()).Text%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="显示名">
                    <ItemTemplate>
                        <%#Eval("Text")%>
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
</asp:Content>
