<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ContentDetail.aspx.cs" Inherits="WebSite.ContentDetail" ValidateRequest="False"
    EnableSessionState="True" %>

<%@ Register Src="~/CMS/tinyMCE.ascx" TagPrefix="Content" TagName="TextEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <style type="text/css">
        .editToolbar
        {
            margin: 0 0 5px;
            overflow: hidden;
        }
        .editToolbar a
        {
            float: right;
            margin-left: 10px;
        }
        input[type="text"], textarea, input[type="file"]
        {
            border: 1px solid #ccc;
            padding: 5px;
            color: #555;
            font-size: 13px;
            font-family: Arial, Helvetica, sans-serif;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            -khtml-border-radius: 5px;
            border-radius: 5px;
        }
        .tblForm
        {
            margin: 0 0 20px;
            border-collapse: collapse;
        }
        .tblForm td
        {
            padding: 0 20px 15px 0;
        }
        .fl
        {
            margin: 0;
            padding: 0;
            list-style: none;
            margin: 0 0 20px;
            text-align: left;
        }
        .fl li
        {
            margin: 0 0 15px;
            overflow: hidden;
        }
        
        label.lbl
        {
            display: block;
            margin: 0 0 5px 0;
        }
        .largeForm label.lbl
        {
            font-weight: bold;
        }
        .secondaryForm
        {
            width: 250px;
        }
        .secondaryForm input[type=text], .secondaryForm textarea
        {
            width: 200px;
        }
        .mianTitle
        {
            margin-left:15px;
        }
    </style>
    <script type="text/javascript" language="javascript">
        //设置发布时间
        function toggleAutomaticDate() {
            var panel = $("#datePanel");
            if ($("#rbtManual:checked").length > 0)
                $(panel).show();
            else
                $(panel).hide();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div style="height: 100%; overflow-x:hidden;overflow-y:aoto;">
        <table class="tblForm largeForm" style="width: 100%; height: 100%; margin: 0;">
            <tr>
                <td style="vertical-align: top; padding: 0 40px 0 0;">
                    <ul class="fl">
                        <li>
                            <label class="lbl" for="<%=txtTitle.ClientID%>">
                                <em>*</em>标题
                            </label>
                            <asp:TextBox ID="txtTitle" runat="server" Width="500px" CssClass="text"></asp:TextBox>
                            <asp:CheckBox runat="server" ID="cboIsMain" Text="头条" CssClass="mianTitle" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitle"
                                ErrorMessage="必须输入【标题】" Display="Dynamic" />
                        </li>
                        <li>
<%--                            <div class="editToolbar">
                                <asp:CheckBox runat="server" ID="cbUseRaw" Text="使用原生html编辑器" AutoPostBack="true" />
                                <a href="#" id="uploadImage" class="image">添加图片</a> <a href="#" id="uploadVideo"
                                    class="video">添加视频</a> <a href="#" id="uploadFile" class="file">添加附件</a>
                            </div>--%>
                            <Content:TextEditor runat="server" ID="txtContent" />
                            <asp:TextBox runat="server" ID="txtRawContent" Width="98%" TextMode="multiLine" Height="400px"
                                Visible="false" />
                        </li>
                        <li>
                            <label class="lbl" for="<%=cboWidgetsCode.ClientID%>">
                                <em>*</em> 所属部件
                            </label>
                            <suntek:ComboBox ID="cboWidgetsCode" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                                runat="server">
                            </suntek:ComboBox>
                        </li>
                        <li>
                            <label class="lbl" for="<%=txtDescription.ClientID%>">
                                描述</label>
                            <asp:TextBox runat="server" ID="txtDescription" TextMode="multiLine" Columns="50"
                                Rows="3" Width="600" Height="80" />
                        </li>
                    </ul>
                    <%--<div class="action_buttons">
                    <input type="button" id="btnSave" value="<%=Resources.labels.savePost %>" class="btn primary rounded"
                        onclick="return SavePost()" />
                    <%=Resources.labels.or %>
                    <% if (!string.IsNullOrEmpty(Request.QueryString["id"]))
                       { %>
                    <a href="<%=PostUrl %>" title="<%=Resources.labels.goToPost %>">
                        <%=Resources.labels.goToPost %></a>
                    <%}
                       else
                       {%>
                    <a href="Posts.aspx" title="<%=Resources.labels.cancel %>">
                        <%=Resources.labels.cancel %></a>
                    <%} %>
                    <span id="autoSaveLabel" style="display: none;"></span>
                </div>--%>
                </td>
                <td class="secondaryForm" style="padding: 0; vertical-align: top;">
                    <ul class="fl">
                        <li>
                            <label class="lbl" for="<%=txtAuthor.ClientID%>">
                                <em>*</em> 作者
                            </label>
                            <asp:TextBox ID="txtAuthor" runat="server"></asp:TextBox>
                        </li>
                        <li>
                            <label class="lbl" for="<%=txtPublishedTime.ClientID%>">
                                设置发布时间</label>
                            <input type="radio" name="PublishedTime" id="rbtAuto" onclick="toggleAutomaticDate()"
                                checked="checked" /><label for="rbtAuto">自动生成</label>
                            <input type="radio" name="PublishedTime" id="rbtManual" onclick="toggleAutomaticDate()" /><label
                                for="rbtManual">手动设置</label>
                            <div id="datePanel" style="display: none;">
                                <asp:TextBox ID="txtPublishedTime" runat="server" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
                                    class="Wdate"></asp:TextBox>
                            </div>
                        </li>
                        <li style="position: relative;">
                            <label class="lbl">
                                标签</label>
                            <asp:TextBox runat="server" ID="txtTags" TextMode="MultiLine" Rows="3" />
                            <span style="display:block;margin:0 0 5px 0;">用逗号(,)分割每个标签</span> </li>
                        <li>
                            <asp:CheckBox runat="server" ID="cboIsPublished" Text="发布" Checked="true" />
                            <asp:CheckBox runat="server" ID="cboIsCommentsenabled" Text="允许评论" Checked="true" />
                        </li>
                        <li>
                            <label for="<%=txtCreator.ClientID%>" class="lbl">
                                <em>*</em> 创建者
                            </label>
                            <asp:TextBox ID="txtCreator" runat="server" CssClass="text"></asp:TextBox>
                        </li>
                        <li>
                            <label for="<%=dtpCreateTime.ClientID%>" class="lbl">
                                创建时间
                            </label>
                            <suntek:DatePicker ID="dtpCreateTime" runat="server"></suntek:DatePicker>
                        </li>
                    </ul>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
