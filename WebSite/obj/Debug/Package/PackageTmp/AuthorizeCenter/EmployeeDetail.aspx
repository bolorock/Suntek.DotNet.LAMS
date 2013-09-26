
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="EmployeeDetail.aspx.cs" Inherits="WebSite.EmployeeDetail" %>

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
			$("#<%=txtCode.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【人员代码】不能为空" });
			/*默认验证字段*/
			$("#<%=txtLoginName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【登陆名】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【人员姓名】长度不能超过32" });
            /*必选项*/
			$("#<%=txtOperatorID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【操作员ID】不能为空" });
			/*日期*/
            $("#<%=dtpBirthday.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【出生日期】格式错误" });
            /*非空字段*/
            $("#<%=txtNation.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【民族】不能为空" });
			/*默认验证字段*/
			$("#<%=txtBirthplace.ClientID%>").formValidator().inputValidator({max:64, onerror: "【出生地】长度不能超过64" });
			/*默认验证字段*/
			$("#<%=txtNativeplace.ClientID%>").formValidator().inputValidator({max:64, onerror: "【籍贯】长度不能超过64" });
			/*默认验证字段*/
			$("#<%=txtPoliticsStatus.ClientID%>").formValidator().inputValidator({max:32, onerror: "【政治面貌】长度不能超过32" });
			/*日期*/
            $("#<%=dtpWorkFromDate.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【参加工作时间】格式错误" });
          
			/*默认验证字段*/
			$("#<%=txtIndustrialGrade.ClientID%>").formValidator().inputValidator({max:32, onerror: "【专业技术职务】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtSpeciality.ClientID%>").formValidator().inputValidator({max:256, onerror: "【特长】长度不能超过256" });
			/*默认验证字段*/
			$("#<%=txtPositionName.ClientID%>").formValidator().inputValidator({max:64, onerror: "【岗位名称】长度不能超过64" });
            /*非空字段*/
            $("#<%=txtPosition.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【基本岗位】不能为空" });
			/*默认验证字段*/
			$("#<%=txtPostGrade.ClientID%>").formValidator().inputValidator({max:32, onerror: "【岗位等级】长度不能超过32" });
			
			/*日期*/
            $("#<%=dtpInDate.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【入职日期】格式错误" });
			/*日期*/
            $("#<%=dtpOutDate.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【离职日期】格式错误" });
            /*必选项*/
            $("#<%=txtZipCode.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【邮编】不能为空" });
            /*邮箱*/
            $("#<%=txtEmail.ClientID%>").formValidator().inputValidator({ min: 6, max: 128, onerror: "【Email】格式不正确！" }).regexValidator({ regexp: "^([\\w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([\\w-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$", onerror: "你输入的邮箱格式不正确" });
			/*默认验证字段*/
			$("#<%=txtFax.ClientID%>").formValidator().inputValidator({max:12, onerror: "【传真号码】长度不能超过12" });
            /*手机号码 */
             $("#<%=txtMobile.ClientID%>").formValidator().inputValidator().regexValidator({ regexp: "mobile", datatype: "enum", onerror: "【手机号码】格式不正确" });
			/*默认验证字段*/
			$("#<%=txtMSN.ClientID%>").formValidator().inputValidator({max:12, onerror: "【MSN号码】长度不能超过12" });
            /*手机号码 */
             $("#<%=txtOfficePhone.ClientID%>").formValidator().inputValidator().regexValidator({ regexp: "mobile", datatype: "enum", onerror: "【办公电话】格式不正确" });
			/*默认验证字段*/
			$("#<%=txtAddress.ClientID%>").formValidator().inputValidator({max:128, onerror: "【住址】长度不能超过128" });
            /*非空字段*/
            $("#<%=txtDirector.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【直接主管】不能为空" });
            /*必选项*/
            $("#<%=txtMajorOrgID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【主机构ID】不能为空" });
			/*默认验证字段*/
			$("#<%=txtPhoto.ClientID%>").formValidator().inputValidator({max:128, onerror: "【照片】长度不能超过128" });
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
			<label for="<%=txtCode.ClientID%>" class="label">
			                人员代码
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCode" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtLoginName.ClientID%>" class="label">
			                登陆名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtLoginName" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtName.ClientID%>" class="label">
			                人员姓名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtOperatorID.ClientID%>" class="label">
			<em>*</em>
                操作员ID
			</label>
            </div>
            <div class="div_row_input">
			  
                 <asp:TextBox ID="txtOperatorID" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
    
            <div class="div_row_lable">
			<label for="<%=dtpBirthday.ClientID%>" class="label">
			                出生日期
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpBirthday" runat="server"></suntek:DatePicker>
            </div>
              <div class="div_row_lable">
			<label for="<%=dtpWorkFromDate.ClientID%>" class="label">
			                参加工作时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpWorkFromDate" runat="server"></suntek:DatePicker>
            </div>
           
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtNation.ClientID%>" class="label">
			<em>*</em>
                民族
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtNation" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtBirthplace.ClientID%>" class="label">
			                出生地
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtBirthplace" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtNativeplace.ClientID%>" class="label">
			                籍贯
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtNativeplace" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtPoliticsStatus.ClientID%>" class="label">
			                政治面貌
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPoliticsStatus" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
    
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtIndustrialGrade.ClientID%>" class="label">
			                专业技术职务
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtIndustrialGrade" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtSpeciality.ClientID%>" class="label">
			                特长
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtSpeciality" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtPositionName.ClientID%>" class="label">
			                岗位名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPositionName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtPosition.ClientID%>" class="label">
			<em>*</em>
                基本岗位
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPosition" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtPostGrade.ClientID%>" class="label">
			                岗位等级
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPostGrade" runat="server" CssClass="text"></asp:TextBox>
            </div>
            


        </div>
       
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=dtpInDate.ClientID%>" class="label">
			                入职日期
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpInDate" runat="server"></suntek:DatePicker>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpOutDate.ClientID%>" class="label">
			                离职日期
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpOutDate" runat="server"></suntek:DatePicker>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtZipCode.ClientID%>" class="label">
			                邮编
			</label>
            </div>
            <div class="div_row_input">
                 <asp:TextBox ID="txtZipCode" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtEmail.ClientID%>" class="label">
			                Email
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtFax.ClientID%>" class="label">
			                传真号码
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtFax" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtMobile.ClientID%>" class="label">
			                手机号码
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtMobile" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtMSN.ClientID%>" class="label">
			                MSN号码
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtMSN" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtOfficePhone.ClientID%>" class="label">
			                办公电话
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOfficePhone" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtAddress.ClientID%>" class="label">
			                住址
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAddress" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtDirector.ClientID%>" class="label">
			<em>*</em>
                直接主管
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDirector" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtMajorOrgID.ClientID%>" class="label">
			<em>*</em>
                主机构ID
			</label>
            </div>
            <div class="div_row_input">
                 <asp:TextBox ID="txtMajorOrgID" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtPhoto.ClientID%>" class="label">
			                照片
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtPhoto" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtCreator.ClientID%>" class="label">
			                创建者
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCreator" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpCreateTime.ClientID%>" class="label">
			<em>*</em>
                创建时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpCreateTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
    </div>
</asp:Content>

