
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="OrgUserMgr.aspx.cs" Inherits="WebSite.OrgUserMgr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("ManagerJs") %>
	<%if (false)
      { %>
		<script   src="../Scripts/jquery-vsdoc.js" 
        type="text/javascript"></script> 
    <%}%>	

    <script type="text/javascript">

        function delSelectedUser(me) {

            $(me).parent().remove();

            $("input[name='chkId']", window.frames["orgUser"].document).each(function () {
                       if ($(this).attr("value") == $(me).attr("value")) {
                                $(this).attr("checked","");
                           }
                       });
            showTips();
        }

        function showTips() {
            if ($("input:checked", $("#selectedUsers")).size() == 0) {
                $("#noneTip").show();
            }
            else {
                $("#noneTip").hide();
            }
        }


       

        function save() {

            var dataIDs = "";
            var roleID = "";
            var objectType = "";

            roleID = $("#ctl00_contentPlace_ddlRole").val();
            if (roleID == "-1") { alert("请选择系统角色！"); return; }

            objectType = $("#ctl00_contentPlace_ddlObjectType").val();
            if (objectType == "-1") { alert("请选择用户类型！"); return; }

            try {
                $("input:checked", $("#selectedUsers")).each(function (i) {
                    dataIDs += $(this).attr("value") + ",";
                });

            } catch (e) { }



            $.post(getCurrentUrl(), { AjaxAction: "Save", DataIDs: dataIDs, RoleID: roleID, ObjectType: objectType }, function (value) {

                var ajaxResult = JSON.parse(value);
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null && ajaxResult.PromptMsg != "") {
                        alert(ajaxResult.PromptMsg);
                        location.href = "OperatorManager.aspx";
                    }
                }
                else {
                    alert("保存出错，请与管理员联系！");
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div id="divContent" class="div_content">

    <div>

    <div style=" margin:10px 0px;">
    <table width="100%" cellpadding="5" style=" border-collapse:collapse;" border=1>
    <tr>
    <td colspan="3"> <div id="noneTip">您还没有选择任何用户！</div>
      <div id="selectedUsers"></div>
    </td>
    </tr>

    <tr><td width="20%">
    角色：<asp:DropDownList ID="ddlRole" runat="server">
        </asp:DropDownList>
        </td>
        <td width="20%">
        用户类型：<asp:DropDownList ID="ddlObjectType" runat="server">
         <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="超级管理员" Value="0"></asp:ListItem>
                            <asp:ListItem Text="分公司管理员" Value="1"></asp:ListItem>
                            <asp:ListItem Text="一般" Value="2"></asp:ListItem>
        </asp:DropDownList></td>
        <td align="left"> <input type="button" id="Button1" onclick="save();" value=" 保 存 " class="BtnCss" /></td>
        </tr>
    </table>
   </div>

    <table width="100%">
    <tr>
    <td width="30%"><iframe src="orgTree.aspx" id="orgTree" width="98%" style=" min-height:350px"> </iframe> </td>
    <td width="*" valign="top">
     <iframe id="orgUser" name="orgUser" width="98%"></iframe> 
    </td>
    </tr>
    </table>
 
   
   


    </div></div>
  
</asp:Content>
