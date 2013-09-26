
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="DiplomaDetail.aspx.cs" Inherits="WebSite.DiplomaDetail" %>

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
			$("#<%=txtFulltimeEducation.ClientID%>").formValidator().inputValidator({max:32, onerror: "【全日制教育】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtFulltimeSchool.ClientID%>").formValidator().inputValidator({max:32, onerror: "【全日制教育学校】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtFulltimeMajor.ClientID%>").formValidator().inputValidator({max:32, onerror: "【全日制教育专业】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtInserviceEducation.ClientID%>").formValidator().inputValidator({max:32, onerror: "【在职教育】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtInserviceSchool.ClientID%>").formValidator().inputValidator({max:32, onerror: "【在职教育学校】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtInserviceMajor.ClientID%>").formValidator().inputValidator({max:32, onerror: "【在职教育专业】长度不能超过32" });
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
			<label for="<%=txtFulltimeEducation.ClientID%>" class="label">
			                全日制教育
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtFulltimeEducation" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtFulltimeSchool.ClientID%>" class="label">
			                全日制教育学校
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtFulltimeSchool" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtFulltimeMajor.ClientID%>" class="label">
			                全日制教育专业
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtFulltimeMajor" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtInserviceEducation.ClientID%>" class="label">
			                在职教育
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtInserviceEducation" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtInserviceSchool.ClientID%>" class="label">
			                在职教育学校
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtInserviceSchool" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtInserviceMajor.ClientID%>" class="label">
			                在职教育专业
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtInserviceMajor" runat="server" CssClass="text"></asp:TextBox>
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

