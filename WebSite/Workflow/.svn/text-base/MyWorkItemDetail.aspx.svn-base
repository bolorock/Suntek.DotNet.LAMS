<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="MyWorkItemDetail.aspx.cs" Inherits="WebSite.MyWorkItemDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#tabs").tabs({
                ajaxOptions: {
                    error: function (xhr, status, index, anchor) {
                        $(anchor.hash).html("无法加载此标签！");
                    }
                },
                show: function (event, ui)//不能用select事件
                {

                }
            });
            $("#ifHandle").attr("src", "<%= Url %>");
        });
        function save() {
            var frm = window.frames["ifHandle"].save();
        }
        function submit() {
            window.frames["ifHandle"].submit();
        }
        function cancel() {
            window.frames["ifHandle"].cancel();
        }
        //class="ui-tabs ui-widget ui-widget-content ui-corner-all"
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div id="tabs">
        <ul>
            <li><a href="#handle">处理</a></li>
            <li><a href="#process">处理过程</a></li>
            <li><a href="#processTracking">流程跟踪</a></li>
        </ul>
        <div id="handle">
            <iframe id="ifHandle" name="ifHandle" class="autoHeight" src="" width="100%" height="100%"
                frameborder="0" scrolling="no"></iframe>
        </div>
        <div id="process">
            <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
                DataKeyNames="ID">
                <Columns>
                    <asp:TemplateField HeaderText="环节">
                        <ItemTemplate>
                            <%#Eval("Name")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="处理部门">
                        <ItemTemplate>
                            <%#GetOrgNameByUserID(Eval("Executor").ToString()).Name%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="处理人">
                        <ItemTemplate>
                            <%#Eval("ExecutorName")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="处理时间">
                        <ItemTemplate>
                            <%#((DateTime)Eval("ExecuteTime")).ToShortDateString()%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="处理意见">
                        <ItemTemplate>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </suntek:PagedGridView>
        </div>
        <div id="processTracking">
            <iframe id="ifProcessTracking" name="ifProcessTracking" class="autoHeight" src="ProcessChart.aspx?processDefID=<%=ProcessDefID %>"
                width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
        </div>
    </div>
</asp:Content>
