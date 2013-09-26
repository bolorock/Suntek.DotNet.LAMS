<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/Page.Master" CodeBehind="OrgUserList.aspx.cs" Inherits="WebSite.OrgUserList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
     <script type="text/javascript">


         function setRole(me, argument) {
             var id = $("#divContent").find(":checked ").first().val();
             openOperateDialog("设置用户角色", "ObjectRoleManager.aspx?UserID=" + id + "&m=" + Math.random(), 500, 500);

         }

         function setSpecialPrivilege(me, argument) {
             var id = $("#divContent").find(":checked ").first().val();
             openOperateDialog("设置用户特殊权限", "SpecialPrivilegeManager.aspx?UserID=" + id + "&m=" + Math.random(), 500, 500);

         }

         function ShowDetail(me) {
             var tr = $(me).parent();
             var id = $("#id", tr).val();
             openOperateDialog("查看详细信息", "EmployeeDetail.aspx?CurrentID=" + id + "&m=" + Math.random(), 600, 450);

         }

         //关闭窗口
         function closeDialog(fieldTypeId) {
             $("#actionDialog").dialog("close");
         }


         function rowDbClick(me, id, remember) {
             var id = $("#id", me).val();
             openOperateDialog("查看详细信息", "EmployeeDetail.aspx?CurrentID=" + id + "&m=" + Math.random(), 600, 450);

         }
      
   </script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div id="divContent" class="div_content" style="overflow: scroll; height: 100%; width: 100%;
        overflow-x: hidden;">
        <div>
            <ul>
                <li>登陆名：<asp:TextBox ID="txtLoginName" runat="server"></asp:TextBox>
                    人员姓名：<asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                </li>
                <li>角色：
                    <suntek:ChooseBox ID="chbRole" OpenUrl="ObjectRoleManager.aspx?Entry=Choose" DialogWidth="600"
                        DialogTitle="选择角色" runat="server">
                    </suntek:ChooseBox>
                    <asp:Button ID="btnSearch" runat="server" Text="查询" OnClick="btnSearch_OnClick" />
                </li>
            </ul>
        </div>
        <suntek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview"
            DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="选择">
                    <ItemTemplate>
                        <input id="radioId" type="radio" value='<%#Eval("ID") %>' name="radioId" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="人员编码">
                    <ItemTemplate>
                        <%#Eval("ID")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="登陆名">
                    <ItemTemplate>
                        <%#Eval("LoginName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="人员姓名">
                    <ItemTemplate>
                        <%#Eval("UserName")%><input id="id" type="hidden" value='<%#Eval("ID") %>' name="id" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="角色">
                    <ItemTemplate>
                        <%#Eval("RoleName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="机构">
                    <ItemTemplate>
                        <%#Eval("CorpName")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="部门">
                    <ItemTemplate>
                        <%#Eval("Department")%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </suntek:PagedGridView>
    </div>
</asp:Content>
