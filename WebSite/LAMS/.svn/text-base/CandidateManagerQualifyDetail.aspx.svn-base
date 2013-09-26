<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true" CodeBehind="CandidateManagerQualifyDetail.aspx.cs" Inherits="WebSite.CandidateManagerQualifyDetail" %>

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
       function initValidator() {
           $.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function (msg) { promptMessage(msg); } });
           /*非空字段*/
           $("#<%=txtCode.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【员工编号】不能为空" });
           /*非空字段*/
           $("#<%=txtCreator.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【创建者】不能为空" });
           /*日期*/
           $("#<%=dtpCreateTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【创建时间】格式错误" });
       }

       //页面初始化
       $(document).ready(function () {
           //初始化校验脚本
           initValidator();
       });
			
    </script>

    <div class="div_block">
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtCode.ClientID%>" class="label">
			<em>*</em>
                员工编号
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCode" runat="server" CssClass="text" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboCandidatePost.ClientID%>" class="label">
			                后备岗位
			</label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboCandidatePost" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="管理二岗" Value="管理二岗"></asp:ListItem>
                    <asp:ListItem Text="管理三岗" Value="管理三岗" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="管理四岗" Value="管理四岗"></asp:ListItem>
                    <asp:ListItem Text="管理五岗" Value="管理五岗"></asp:ListItem>
                    <asp:ListItem Text="管理六岗" Value="管理六岗"></asp:ListItem>
                </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row" style="display:<%= Grade=="grade2" ? "block":"none" %>">
            <div class="div_row_lable">
			<label for="<%=cboIsChief.ClientID%>" class="label">
			                是否正职
			</label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboIsChief" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="否" Value="0"></asp:ListItem>
                    <asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                </suntek:ComboBox>
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
                <asp:TextBox ID="txtCreator" runat="server" CssClass="text" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpCreateTime.ClientID%>" class="label">
			                创建时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpCreateTime" runat="server" ReadOnly="true"></suntek:DatePicker>
            </div>
        </div>
    </div>
</asp:Content>


