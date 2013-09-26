<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="RegisterSummary.aspx.cs" Inherits="WebSite.Register.RegisterSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript" language="javascript">
        /*名册汇总*/
        function gather() {
            if (!confirm("确定对名册汇总？")) return;
            var yearMonth = $("#<%= drpYear.ClientID %>").val() + $("#<%= drpMonth.ClientID %>").val();
            $.post(getCurrentUrl(), { AjaxAction: "Gather", AjaxArgument: yearMonth }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                }
                else {
                    alert("系统出错，请与管理员联系！");
                    return;
                }
                alert(ajaxResult.PromptMsg);
            });
        }
        /*名册回退*/
        function rollback() {
            if (!confirm("确定把名册回退到待审核状态？")) return;
            var yearMonth = $("#<%= drpYear.ClientID %>").val() + $("#<%= drpMonth.ClientID %>").val();
            $.post(getCurrentUrl(), { AjaxAction: "Rollback", AjaxArgument: yearMonth }, function (value) {
                var ajaxResult = JSON2.parse(value);
                if (ajaxResult) {
                }
                else {
                    alert("系统出错，请与管理员联系！");
                    return;
                }
                alert(ajaxResult.PromptMsg);
            });
        }

        function rowDbClick(me, id, remember, url) {
           /*do nothing*/
        }
    </script>
    <div id="divContent" class="div_content" style="overflow: scroll; height: 100%; width: 100%;
        overflow-x: hidden;">
        <div id="divDate" style="text-align: left; padding-left: 10px;">
            <asp:DropDownList ID="drpYear" runat="server" OnSelectedIndexChanged="drpMonth_SelectedIndexChanged"
                AutoPostBack="true">
                <asp:ListItem>2011</asp:ListItem>
                <asp:ListItem>2012</asp:ListItem>
                <asp:ListItem>2013</asp:ListItem>
                <asp:ListItem>2014</asp:ListItem>
                <asp:ListItem>2015</asp:ListItem>
                <asp:ListItem>2016</asp:ListItem>
                <asp:ListItem>2017</asp:ListItem>
                <asp:ListItem>2018</asp:ListItem>
            </asp:DropDownList>
            年
            <asp:DropDownList ID="drpMonth" runat="server" OnSelectedIndexChanged="drpMonth_SelectedIndexChanged"
                AutoPostBack="true">
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
                <asp:ListItem>6</asp:ListItem>
                <asp:ListItem>7</asp:ListItem>
                <asp:ListItem>8</asp:ListItem>
                <asp:ListItem>9</asp:ListItem>
                <asp:ListItem>10</asp:ListItem>
                <asp:ListItem>11</asp:ListItem>
                <asp:ListItem>12</asp:ListItem>
                <asp:ListItem></asp:ListItem>
            </asp:DropDownList>
            月
        </div>
        <div>
            <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
                DataKeyNames="CorpID" PageSize="10" OnRowDataBound="gvList_RowDataBound" ShowHeader="True"
                ViewPageUrl="">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <img title='<%#bool.Parse(Eval("IsSummit").ToString()) ? "已提交":"未提交" %>' src='..\Skins\Default\Images\<%#bool.Parse(Eval("IsSummit").ToString()) ? "Actions-dialog-ok-apply-icon.png":"del.gif" %>'
                                width="18px" height="18px" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="公司名称">
                        <ItemTemplate>
                            <%#Eval("CorpName")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="是否提交">
                        <ItemTemplate>
                            <%#bool.Parse(Eval("IsSummit").ToString())?"是":"否"%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="名册人数">
                        <ItemTemplate>
                            <%#Eval("RegisterSum")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="提交时间">
                        <ItemTemplate>
                            <%#DateTime.Parse(Eval("SummitDate").ToString()) !=DateTime.MinValue? DateTime.Parse(Eval("SummitDate").ToString()).ToShortDateString() : ""%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="名册详细">
                        <ItemTemplate>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </suntek:PagedGridView>
        </div>
    </div>
</asp:Content>
