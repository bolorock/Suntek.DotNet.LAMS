
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="EmployeeOrgDetail.aspx.cs" Inherits="WebSite.EmployeeOrgDetail" %>

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
            $("#<%=chbOrgID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【机构ID】不能为空" });
            /*必选项*/
            $("#<%=chbEmployeeID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【人员ID】不能为空" });
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
			<label for="<%=chbOrgID.ClientID%>" class="label">
			<em>*</em>
                机构ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbOrgID" OpenUrl="OrgIDTree.aspx" DialogTitle="选择机构ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbEmployeeID.ClientID%>" class="label">
			<em>*</em>
                人员ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbEmployeeID" OpenUrl="EmployeeIDTree.aspx" DialogTitle="选择人员ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboIsMajor.ClientID%>" class="label">
			                是否主机构
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboIsMajor" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="否" Value="0" ></asp:ListItem>
							<asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
		</div>
    </div>
</asp:Content>

