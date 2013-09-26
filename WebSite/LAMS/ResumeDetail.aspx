
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ResumeDetail.aspx.cs" Inherits="WebSite.ResumeDetail" %>

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
			$("#<%=txtStartDate.ClientID%>").formValidator().inputValidator({max:16, onerror: "【起始时间】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtEndDate.ClientID%>").formValidator().inputValidator({max:16, onerror: "【结束时间】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtWorkplace.ClientID%>").formValidator().inputValidator({max:128, onerror: "【学习/工作地点】长度不能超过128" });
			/*默认验证字段*/
			$("#<%=txtPosition.ClientID%>").formValidator().inputValidator({max:16, onerror: "【职务】长度不能超过16" });
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
			<label for="<%=txtStartDate.ClientID%>" class="label">
			                起始时间
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtStartDate" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtEndDate.ClientID%>" class="label">
			                结束时间
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtWorkplace.ClientID%>" class="label">
			                学习/工作地点
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtWorkplace" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtPosition.ClientID%>" class="label">
			                职务
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPosition" runat="server" CssClass="text"></asp:TextBox>
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

