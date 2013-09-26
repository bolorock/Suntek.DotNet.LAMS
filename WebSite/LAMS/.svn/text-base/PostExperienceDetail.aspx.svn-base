
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="PostExperienceDetail.aspx.cs" Inherits="WebSite.PostExperienceDetail" %>

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
			$("#<%=txtPostDate.ClientID%>").formValidator().inputValidator({max:16, onerror: "【任职时间】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtPosition.ClientID%>").formValidator().inputValidator({max:32, onerror: "【职务名称】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtPostGrade.ClientID%>").formValidator().inputValidator({max:32, onerror: "【职务等级】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtAppointDocNumber.ClientID%>").formValidator().inputValidator({max:32, onerror: "【任职文号】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtCreator.ClientID%>").formValidator().inputValidator({max:36, onerror: "【创建者】长度不能超过36" });
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
			<label for="<%=txtPostDate.ClientID%>" class="label">
			                任职时间
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPostDate" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtPosition.ClientID%>" class="label">
			                职务名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPosition" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtPostGrade.ClientID%>" class="label">
			                职务等级
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPostGrade" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtAppointDocNumber.ClientID%>" class="label">
			                任职文号
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAppointDocNumber" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtCreator.ClientID%>" class="label">
			                创建者
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCreator" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
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

