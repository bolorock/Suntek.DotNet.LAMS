
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="OperateDetail.aspx.cs" Inherits="WebSite.OperateDetail" %>

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
            /*非空字段*/
            $("#<%=txtOperateName.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【操作名称】不能为空" });
            /*非空字段*/
            $("#<%=txtOperateKey.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【操作关键字】不能为空" });
            /*非空字段*/
            $("#<%=txtCommandName.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【命令】不能为空" });
            /*非空字段*/
            $("#<%=txtCommandArgument.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【命令参数】不能为空" });
			/*默认验证字段*/
			$("#<%=txtDescription.ClientID%>").formValidator().inputValidator({max:128, onerror: "【说明】长度不能超过128" });
            /*非空字段*/
            $("#<%=txtOwnerOrg.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【归属组织】不能为空" });
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
			<label for="<%=txtOperateName.ClientID%>" class="label">
			<em>*</em>
                操作名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOperateName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtOperateKey.ClientID%>" class="label">
			<em>*</em>
                操作关键字
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOperateKey" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtCommandName.ClientID%>" class="label">
			<em>*</em>
                命令
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCommandName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtCommandArgument.ClientID%>" class="label">
			<em>*</em>
                命令参数
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCommandArgument" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboIsValid.ClientID%>" class="label">
			<em>*</em>
                是否有效
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboIsValid" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="否" Value="0" ></asp:ListItem>
							<asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboIsVerify.ClientID%>" class="label">
			<em>*</em>
                是否验证
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboIsVerify" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="否" Value="0" ></asp:ListItem>
							<asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtSortOrder.ClientID%>" class="label">
			<em>*</em>
                序号
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtSortOrder" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtDescription.ClientID%>" class="label">
			                说明
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtOwnerOrg.ClientID%>" class="label">
			<em>*</em>
                归属组织
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboRunat.ClientID%>" class="label">
			                运行方式
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboRunat" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
        </div>
    </div>
</asp:Content>

