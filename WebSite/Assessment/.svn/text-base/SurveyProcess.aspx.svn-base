<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true" CodeBehind="SurveyProcess.aspx.cs" Inherits="WebSite.SurveyProcess" %>

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
    <div id="divContent" class="div_content">
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="序号">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="评估人编号">
                        <ItemTemplate>
                            <%#Eval("Code")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="评估人姓名">
                        <ItemTemplate>
                            <%#Eval("Name")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="状态">
                        <ItemTemplate>
                            <%#RemarkAttribute.GetEnumRemark((SurveyResultStatus)Enum.Parse(typeof(SurveyResultStatus), Eval("Status").ToString()))%>
                        </ItemTemplate>
                    </asp:TemplateField>
            </Columns>
        </suntek:PagedGridView>
    </div>
</asp:Content>
