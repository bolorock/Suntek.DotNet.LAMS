<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true" CodeBehind="PwdModify.aspx.cs" Inherits="WebSite.PwdModify" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin + "DetailCss")%>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>

    <script>
        $(document).ready(function () {
            $.formValidator.initConfig({ formid: "aspnetForm", onerror: function (msg) { alert(msg) } });
            $("#<%=txtNewPwd.ClientID %>").formValidator({ onshow: "请输入密码", onfocus: "密码不能为空", oncorrect: "密码合法" }).inputValidator({ min: 1, onerror: "密码不能为空,请确认" });
            $("#<%=txtNewPwd2.ClientID %>").formValidator({ onshow: "请输入重复密码", onfocus: "两次密码必须一致哦", oncorrect: "密码一致" }).inputValidator({ min: 1, onerror: "重复密码不能为空,请确认" }).compareValidator({ desid: "<%=txtNewPwd.ClientID %>", operateor: "=", onerror: "2次密码不一致,请确认" });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div>
        <table class="div_block">
            <thead style=" color:#2C59AA; background: url(Skins/Default/Images/th.gif); width:100%;">
                <tr align="center">
                    <th colspan="3">
                        <label style=" font-size:15px; font-weight:bold">密码修改</label>
                    </th>
                </tr>
            </thead>
            <tbody style=" width:100%; font-size:12px;">
                <tr style=" height:30px;">
                    <td align="right" style=" width:700px;">
                        <label for="<%=txtNewPwd.ClientID %>"> 登录名 </label>
                    </td>
                    <td style=" width:2%;"></td>
                    <td align="left" style=" width:700px;">
                        <label for="<%=txtNewPwd.ClientID %>" class="toptitle"> <%=User.LoginName%> </label>   
                    </td>
                </tr>
                <tr style=" height:30px;">
                    <td align="right">
                        <label for="<%=txtNewPwd.ClientID %>"> 
                            <em>*</em>输入新密码 
                        </label>
                    </td>
                    <td></td>
                    <td align="left">
                        <asp:TextBox ID="txtNewPwd" runat="server" CssClass="text"></asp:TextBox>
                    </td>
                </tr>
                <tr style=" height:30px;">
                    <td align="right">
                        <label for="<%=txtNewPwd2.ClientID %>">
                            <em>*</em>再次输入新密码
                        </label>
                    </td>
                    <td></td>
                    <td align="left">
                        <asp:TextBox ID="txtNewPwd2" runat="server" CssClass="text"></asp:TextBox>
                    </td>
                </tr>
                <tr style=" height:30px;">
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="btnSubmit" OnClick="btnSubmit_OnClick" runat="server" Text=" 确 定 "
                                                CssClass="BtnCss" OnClientClick="return $.formValidator.pageIsValid('1')" />
                    </td>
                    <td>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
