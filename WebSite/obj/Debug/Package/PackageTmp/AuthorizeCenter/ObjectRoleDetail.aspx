
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ObjectRoleDetail.aspx.cs" Inherits="WebSite.ObjectRoleDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("DetailJs") %>
	<%if (false)
      { %>
		<script   src="../Scripts/jquery-vsdoc.js" 
        type="text/javascript"></script> 
    <%}%>	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">

   <script type="text/javascript" language="javascript">

        //校验脚本
        function initValidator()
        {
			$.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function(msg) { promptMessage(msg); } });
            /*必选项*/
            $("#<%=chbRoleID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【角色ID】不能为空" });
            /*必选项*/
            $("#<%=chbObjectID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【对象ID】不能为空" });
		}
		
		//页面初始化
        $(document).ready(function() {
			//初始化校验脚本
      		initValidator();
		 });
			
    </script>

    <div class="div_block">
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbRoleID.ClientID%>" class="label">
			<em>*</em>
                角色ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbRoleID" OpenUrl="RoleIDTree.aspx" DialogTitle="选择角色ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboObjectType.ClientID%>" class="label">
			<em>*</em>
                取值范围业务字典 ABF_PARTYTYPE
   机构、工作组、岗位、职务
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboObjectType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbObjectID.ClientID%>" class="label">
			<em>*</em>
                对象ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbObjectID" OpenUrl="ObjectIDTree.aspx" DialogTitle="选择对象ID"
                runat="server"></suntek:ChooseBox>
            </div>
		</div>
    </div>
</asp:Content>

