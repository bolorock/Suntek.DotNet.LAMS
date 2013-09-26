<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="WidgetsDetail.aspx.cs" Inherits="WebSite.WidgetsDetail" %>

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

        //校验脚本
        function initValidator() {
            $.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function (msg) { promptMessage(msg); } });
            /*默认验证字段*/
            $("#<%=txtCode.ClientID%>").formValidator().inputValidator({ max: 64, onerror: "【部件名】长度不能超过64" });
            /*默认验证字段*/
            $("#<%=txtName.ClientID%>").formValidator().inputValidator({ max: 32, onerror: "【部件显示名】长度不能超过32" });
            /*默认验证字段*/
            $("#<%=txtDescription.ClientID%>").formValidator().inputValidator({ max: 256, onerror: "【描述】长度不能超过256" });
            /*非空字段*/
            $("#<%=txtCreator.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【创建者】不能为空" });
            /*日期*/
            $("#<%=dtpCreateTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【创建时间】格式错误" });
        }

        //页面初始化
        $(document).ready(function () {
            //初始化校验脚本
            initValidator();

            var cboAddType = $("#<%=cboAddType.ClientID%>");
            var label = $("label[for='<%=txtURL.ClientID%>']");
            var txtUrl = $("#<%=txtURL.ClientID%>");

            if (cboAddType.val() == "2") {
                txtUrl.show();
                label.show();
            }
            else {
                txtUrl.hide();
                label.hide();
            }

            cboAddType.change(function () {
                if ($(this).val() == "2") {
                    txtUrl.show();
                    label.show();
                }
                else {
                    txtUrl.hide();
                    label.hide();
                }

            });
        });
			
    </script>
    <div class="div_block">
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtCode.ClientID%>" class="label">
                    <em>*</em>部件名
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCode" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=txtName.ClientID%>" class="label">
                    <em>*</em>部件显示名
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=cboAddType.ClientID%>" class="label">
                    <em>*</em>部件添加方式
                </label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboAddType" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="自动创建" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="页面直接添加" Value="1"></asp:ListItem>
                    <asp:ListItem Text="链接其它页面" Value="2"></asp:ListItem>
                </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=txtURL.ClientID%>" class="label">
                    URL
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtURL" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtDescription.ClientID%>" class="label">
                    描述
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=cboIsShow.ClientID%>" class="label">
                    是否有效
                </label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboIsShow" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="否" Value="0"></asp:ListItem>
                    <asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=cboMovable.ClientID%>" class="label">
                    是否可移动
                </label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboMovable" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="否" Value="0"></asp:ListItem>
                    <asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=cboCollapsable.ClientID%>" class="label">
                    是否可收缩
                </label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboCollapsable" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="否" Value="0"></asp:ListItem>
                    <asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=cboRemovable.ClientID%>" class="label">
                    是否可关闭
                </label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboRemovable" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="否" Value="0"></asp:ListItem>
                    <asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=cboCloseconfirm.ClientID%>" class="label">
                    是否有关闭提示
                </label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboCloseconfirm" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="否" Value="0"></asp:ListItem>
                    <asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=cboEditable.ClientID%>" class="label">
                    是否可以编辑
                </label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboEditable" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="否" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="是" Value="1"></asp:ListItem>
                </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
                <label for="<%=txtCreator.ClientID%>" class="label">
                    <em>*</em> 创建者
                </label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCreator" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
                <label for="<%=dtpCreateTime.ClientID%>" class="label">
                    创建时间
                </label>
            </div>
            <div class="div_row_input">
                <suntek:DatePicker ID="dtpCreateTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
    </div>
</asp:Content>
