
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="FamilyMemberDetail.aspx.cs" Inherits="WebSite.FamilyMemberDetail" %>

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
            $("#<%=chbEmployeeID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【员工编号】不能为空" });
			/*默认验证字段*/
			$("#<%=txtMemberRelation.ClientID%>").formValidator().inputValidator({max:16, onerror: "【称谓】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtName.ClientID%>").formValidator().inputValidator({max:16, onerror: "【姓名】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtGender.ClientID%>").formValidator().inputValidator({max:16, onerror: "【性别】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtBirthDay.ClientID%>").formValidator().inputValidator({max:16, onerror: "【出生年月】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtCompanyAndPosition.ClientID%>").formValidator().inputValidator({max:128, onerror: "【工作单位及职位】长度不能超过128" });
            /*非空字段*/
            $("#<%=txtCreator.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【创建者】不能为空" });
			/*日期*/
            $("#<%=dtpCreateTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【创建时间】格式错误" });
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
			<label for="<%=chbEmployeeID.ClientID%>" class="label">
			<em>*</em>
                员工编号
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbEmployeeID" OpenUrl="EmployeeIDTree.aspx" DialogTitle="选择员工编号"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtMemberRelation.ClientID%>" class="label">
			                称谓
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtMemberRelation" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtName.ClientID%>" class="label">
			                姓名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtGender.ClientID%>" class="label">
			                性别
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtGender" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtBirthDay.ClientID%>" class="label">
			                出生年月
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtBirthDay" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtCompanyAndPosition.ClientID%>" class="label">
			                工作单位及职位
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCompanyAndPosition" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtCreator.ClientID%>" class="label">
			<em>*</em>
                创建者
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

