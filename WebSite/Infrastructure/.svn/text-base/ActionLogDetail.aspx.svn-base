
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ActionLogDetail.aspx.cs" Inherits="WebSite.ActionLogDetail" %>

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
			/*默认验证字段*/
			$("#<%=txtUserName.ClientID%>").formValidator().inputValidator({max:16, onerror: "【操作员名称】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtClientIP.ClientID%>").formValidator().inputValidator({max:16, onerror: "【操作机器IP】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtAppModule.ClientID%>").formValidator().inputValidator({max:32, onerror: "【应用名称】长度不能超过32" });
            /*非空字段*/
            $("#<%=txtMessage.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【操作信息】不能为空" });
            /*必选项*/
            $("#<%=chbUserID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【操作员ID】不能为空" });
			/*日期*/
            $("#<%=dtpCreateTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【操作时间】格式错误" });
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
			<label for="<%=txtUserName.ClientID%>" class="label">
			                操作员名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboLogType.ClientID%>" class="label">
			<em>*</em>
                日志类型
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboLogType" DropDownStyle="DropDownList" 
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
			<label for="<%=txtClientIP.ClientID%>" class="label">
			                操作机器IP
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtClientIP" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtAppModule.ClientID%>" class="label">
			                应用名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAppModule" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row" style=" height:50px;">
            <div class="div_row_lable">
			<label for="<%=txtMessage.ClientID%>" class="label">
			<em>*</em>
                操作信息
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtMessage" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboResult.ClientID%>" class="label">
			<em>*</em>
                1－成功，0－失败，2－系统异常，3-事务回滚
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboResult" DropDownStyle="DropDownList" 
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
			<label for="<%=chbUserID.ClientID%>" class="label">
			<em>*</em>
                操作员ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbUserID" OpenUrl="UserIDTree.aspx" DialogTitle="选择操作员ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpCreateTime.ClientID%>" class="label">
			<em>*</em>
                操作时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpCreateTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
    </div>
</asp:Content>

