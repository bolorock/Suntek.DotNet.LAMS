<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourceEdit.aspx.cs" Inherits="WebSite.ResourceEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
     <style>
        body
        {
            margin: 0;
            padding: 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="tbContainer_no_margin">
        <div class="tbHead">
            <div class="thHead_Model">
                基本设定
            </div>
        </div>
        <div class="tbContent">
            <table class="tableList" style="height: 60px">
                <tr>
                    <td width="90px" align="right">
                        上级资源：
                    </td>
                    <td>
                        <asp:HiddenField ID="hdfParentId" runat="server" />
                        <asp:TextBox ID="txtParentName" runat="server" Width="300px" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
                <tr> <td width="90px" align="right">
                        资源类型：
                    </td>
                  <td>
                        <asp:RadioButtonList ID="rblType" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Value="21" Text="菜单资源" Selected></asp:ListItem>
                        <asp:ListItem Value="22" Text="页面"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    </tr>
                <tr>
                    <td align="right">
                        <font color="#FF0000">*</font> 资源名称：
                    </td>
                    <td>
                        <asp:HiddenField ID="hdfCurrentId" runat="server" />
                        <asp:TextBox ID="txtCurrentName" runat="server" Width="300px" MaxLength="32"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <font color="#FF0000">*</font> 排列顺序：
                    </td>
                    <td>
                        <asp:TextBox ID="txtSortOrder" runat="server" Width="61px" MaxLength="5"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revSortOrder" runat="server" ErrorMessage="请输入数字"
                            ValidationExpression="^[0-9]*$" Display="Dynamic" ControlToValidate="txtSortOrder"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        关键字：
                    </td>
                    <td>
                    
                        <asp:TextBox ID="txtCurrentDescription" runat="server" Width="300px"  CssClass="txtCss" MaxLength="128"></asp:TextBox>
                    </td>
                </tr>
                
                 <tr>
                    <td align="right">
                        资源值：
                    </td>
                    <td>
                        <asp:TextBox ID="txtValue" runat="server" Width="300px"></asp:TextBox>
                    </td>
                </tr>
                
                
                
                <tr>
                    <td align="right">
                        图标：
                    </td>
                    <td>
                        <asp:TextBox ID="txtIcon" runat="server" Width="300px"></asp:TextBox>
                    </td>
                </tr>
                
                
                <tr>
                    <td align="right">
                        资源状态：
                    </td>
                    <td>
                        <asp:Literal ID="lResourceStatus" runat="server"></asp:Literal>
                    </td>
                </tr>
            </table>
        </div>
        <div class="tbFoot">
            <asp:Button ID="btnSubmit" runat="server" Text=" 提 交 " OnClick="btnSubmit_Click"
                CssClass="BtnCss" />
            <asp:Button ID="btnDelete" runat="server" Text=" 删 除 " OnClick="btnDelete_Click"
                CssClass="BtnCss" /></div>
    </div>

    <script>

        //修改对应树节点
        function reNewAjaxTreeNode(currentId, newName) {
            $(window.parent.frames["ifrTrees"].document).find("#" + currentId).find("a").first().text(newName);
        }
        //删除对应树节点
        function reMoveAjaxTreeNode(folderId, folderName) {
            $(window.parent.frames["ifrTrees"].document).find("#" + folderId).first().remove();
        } 
    </script>

    </form>
</body>
</html>
