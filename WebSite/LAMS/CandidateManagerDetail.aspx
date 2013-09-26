
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="CandidateManagerDetail.aspx.cs" Inherits="WebSite.CandidateManagerDetail" %>

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
			$("#<%=txtCode.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【员工编号】不能为空" });
			/*默认验证字段*/
			$("#<%=txtInPostDate.ClientID%>").formValidator().inputValidator({max:16, onerror: "【任现职时间】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtInGradeDate.ClientID%>").formValidator().inputValidator({max:16, onerror: "【任现级时间】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtAssessment1.ClientID%>").formValidator().inputValidator({max:1024, onerror: "【考核结果1】长度不能超过1024" });
			/*默认验证字段*/
			$("#<%=txtAssessment2.ClientID%>").formValidator().inputValidator({max:1024, onerror: "【考核结果2】长度不能超过1024" });
			/*默认验证字段*/
			$("#<%=txtAssessment3.ClientID%>").formValidator().inputValidator({max:1024, onerror: "【考核结果3】长度不能超过1024" });
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
			<label for="<%=txtCode.ClientID%>" class="label">
			<em>*</em>
                员工编号
			</label>
            </div>
            <div class="div_row_input">
			     <asp:TextBox ID="txtCode" runat="server" CssClass="text" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboTargetCandidate.ClientID%>" class="label">
			                后备类型
			</label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboTargetCandidate" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="综合管理" Value="综合管理" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="市场经营" Value="市场经营"></asp:ListItem>
                    <asp:ListItem Text="业务技术" Value="业务技术"></asp:ListItem>
                </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtInPostDate.ClientID%>" class="label">
			                任现职时间
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtInPostDate" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtInGradeDate.ClientID%>" class="label">
			                任现级时间
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtInGradeDate" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtTenure.ClientID%>" class="label">
			                任现级年限
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtTenure" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboCandidateMaturity.ClientID%>" class="label">
			                后备成熟度
			</label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboCandidateMaturity" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="成熟" Value="成熟" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="待培养" Value="待培养"></asp:ListItem>
                </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtCandidateOrder.ClientID%>" class="label">
			                后备排名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCandidateOrder" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtDemocracyPecent.ClientID%>" class="label">
			                民主推荐率
			</label>
            </div>
            <div class="div_row_input">
				 <asp:TextBox ID="txtDemocracyPecent" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboIsAnomalous.ClientID%>" class="label">
			                是否破格推荐
			</label>
            </div>
            <div class="div_row_input">
                <suntek:ComboBox ID="cboIsAnomalous" DropDownStyle="DropDownList" AppendDataBoundItems="true"
                    runat="server">
                    <asp:ListItem Text="否" Value="0"></asp:ListItem>
                    <asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtAssessment1.ClientID%>" class="label">
			                考核结果1
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAssessment1" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtAssessment2.ClientID%>" class="label">
			                考核结果2
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAssessment2" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtAssessment3.ClientID%>" class="label">
			                考核结果3
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAssessment3" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row" style="display:<%= Grade=="grade3" ? "block":"none" %>">
            <div class="div_row_lable">
            <label for="<%=cboIsPresident.ClientID %>" class="label">
                    是否县分总经理
            </label>
            </div>
           <div class="div_row_input">
                <suntek:ComboBox ID="cboIsPresident" DropDownStyle="DropDownList" AppendDataBoundItems="true"
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

