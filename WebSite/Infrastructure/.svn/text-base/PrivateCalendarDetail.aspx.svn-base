
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="PrivateCalendarDetail.aspx.cs" Inherits="WebSite.PrivateCalendarDetail" %>

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
			$("#<%=txtDescription.ClientID%>").formValidator().inputValidator({max:256, onerror: "【描述】长度不能超过256" });
            /*必选项*/
            $("#<%=chbOperatorID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【操作员ID】不能为空" });
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
			<label for="<%=cboType.ClientID%>" class="label">
			                间隔单位：天，位：天小时，分钟
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:Combox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtYear.ClientID%>" class="label">
			                年份
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtYear" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboEventType.ClientID%>" class="label">
			                0表示请假，1表示加班
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboEventType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:Combox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtDescription.ClientID%>" class="label">
			                描述
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtDay.ClientID%>" class="label">
			                日期
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDay" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtOwnerOrg.ClientID%>" class="label">
			                所属机构
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbOperatorID.ClientID%>" class="label">
			<em>*</em>
                操作员ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbOperatorID" OpenUrl="OperatorIDTree.aspx" DialogTitle="选择操作员ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtCreator.ClientID%>" class="label">
			<em>*</em>
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

