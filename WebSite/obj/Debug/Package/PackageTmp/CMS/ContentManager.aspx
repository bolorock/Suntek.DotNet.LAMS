<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ContentManager.aspx.cs" Inherits="WebSite.ContentManager" %>

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
        dialogSetting.detailWidth = 950;
        dialogSetting.detailHeight = 800;

        function openActionDialog(container, cmdName, argument, actionName, showModal, style, refreshParent) {
            var dialogShowModal = true;
            var dialogStyle = 1; //0表示弹出div,1表示弹出窗体
            var refresh = 1; //1刷新
            var currentID = cmdName == "Add" ? "" : "&CurrentId=" + $("#hidCurrentId").val();
            var url = dialogSetting.actionUrl;
            if (url == "")
                url = getCurrentUrl().replace("Manager.aspx", "Detail.aspx");

            if (cmdName == "View") url = url.replace("Entry=Manager", "Entry=View").replace("Entry=Update", "Entry=View");
            if (url.indexOf('?') > 0)
                url += "&Runat=3&ActionFlag=" + cmdName + currentID + "&radom=" + Math.random();
            else
                url += "?Runat=3&ActionFlag=" + cmdName + currentID + "&radom=" + Math.random();

            if (url.indexOf('Entry=') < 1) {
                url += "&Entry=" + cmdName;
            }

            if (dialogStyle == 1) {
                if (showModal) {
                    var cssDialog = "dialogHeight:" + dialogSetting.detailHeight + "px; dialogWidth:" + dialogSetting.detailWidth + "px; edge: Raised; center: Yes; resizable: Yes; status: No;scrollbars=no,";
                    return window.showModalDialog(url, cmdName, cssDialog);
                }
                else {
                    var cssDialog = 'center: Yes,status=yes,menubar=no,scrollbars=no,resizable=yes,width=' + dialogSetting.detailWidth + ',height=' + dialogSetting.detailHeight;
                    window.open(url, cmdName, cssDialog);
                }
            }
            else {
                container = "#" + container;
                if ($(container).html() != "")
                    $(container).dialog("destroy");
                $(container).html('<iframe id="bg_div_iframe" scrolling="no"  width="100%" height="98%" allowTransparency="true" frameborder="0"></iframe>');
                $('#bg_div_iframe').attr('src', url);

                $(container).dialog({
                    bgiframe: true,
                    autoOpen: false,
                    width: dialogSetting.detailWidth,
                    height: dialogSetting.detailHeight,
                    maxWidth: dialogSetting.detailWidth,
                    maxHeight: dialogSetting.detailHeight,
                    minWidth: dialogSetting.detailWidth,
                    minHeight: dialogSetting.detailHeight,
                    modal: dialogShowModal,
                    position: ['center', 30],
                    close: function () {
                        if (cmdName != "View" && refresh == 1)
                            doPostBack();
                    }
                });
                $(container).dialog("option", "title", actionName);
                $(container).dialog("open");
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div id="divContent" class="div_content">
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="选择">
                    <ItemTemplate>
                        <input id="radioId" type="radio" value='<%#Eval("ID") %>' name="radioId" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="标题">
                    <ItemTemplate>
                        <%#Eval("Title").ToString().Length>30 ? Eval("Title").ToString().Substring(0,25)+"……": Eval("Title")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="所属部件">
                    <ItemTemplate>
                        <%#Eval("WidgetsCode")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="作者">
                    <ItemTemplate>
                        <%#Eval("author")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="发布时间">
                    <ItemTemplate>
                        <%#((DateTime)Eval("PublishedTime")).ToShortDateString()%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否头条">
                    <ItemTemplate>
                        <%#Eval("IsMain").ToString()=="1" ? "是":"否"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否发布">
                    <ItemTemplate>
                        <%#Eval("IsPublished").ToString()=="1" ? "是":"否"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="是否可评论">
                    <ItemTemplate>
                        <%#Eval("IsCommentsenabled").ToString() == "0" ? "否" : "是"%>
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
                <dt class="rowlable">标题</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterTitle" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">作者</dt>
                <dd class="rowinput">
                    <asp:TextBox ID="filterauthor" runat="server" CssClass="text"></asp:TextBox>
                </dd>
                <dt class="rowlable">所属部件</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterWidgetsCode" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">是否发布</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterIsPublished" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
                <dt class="rowlable">是否可评论</dt>
                <dd class="rowinput">
                    <suntek:ComboBox ID="filterIsCommentsenabled" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                        runat="server">
                        <asp:ListItem Text="全部" Value="-1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                    </suntek:ComboBox>
                </dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>
