
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="WorkItemDetail.aspx.cs" Inherits="WebSite.WorkItemDetail" %>

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
			$("#<%=txtName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【名称】长度不能超过32" });
			/*日期*/
            $("#<%=dtpCreateTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【创建时间】格式错误" });
            /*非空字段*/
            $("#<%=txtCreator.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【创建者】不能为空" });
			/*日期*/
            $("#<%=dtpStartTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【启动时间】格式错误" });
			/*日期*/
            $("#<%=dtpEndTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【结束时间】格式错误" });
			/*默认验证字段*/
			$("#<%=txtDescription.ClientID%>").formValidator().inputValidator({max:256, onerror: "【描述】长度不能超过256" });
            /*非空字段*/
            $("#<%=txtParticipant.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【参与者】不能为空" });
			/*日期*/
            $("#<%=dtpTimeOutTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【超时时间】格式错误" });
			/*日期*/
            $("#<%=dtpRemindTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【提醒时间】格式错误" });
			/*默认验证字段*/
			$("#<%=txtActionURL.ClientID%>").formValidator().inputValidator({max:128, onerror: "【响应URL】长度不能超过128" });
			/*默认验证字段*/
			$("#<%=txtActionMask.ClientID%>").formValidator().inputValidator({max:16, onerror: "【操作码】长度不能超过16" });
            /*必选项*/
            $("#<%=chbProcessInstID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【所属流程实例】不能为空" });
			/*默认验证字段*/
			$("#<%=txtProcessInstName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【所属流程实例名】长度不能超过32" });
            /*必选项*/
            $("#<%=chbActivityInstID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【所属活动实例】不能为空" });
			/*默认验证字段*/
			$("#<%=txtActivityInstName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【所属活动实像名】长度不能超过32" });
            /*必选项*/
            $("#<%=chbProcessID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【所属流程】不能为空" });
			/*默认验证字段*/
			$("#<%=txtProcessText.ClientID%>").formValidator().inputValidator({max:32, onerror: "【所属流程显示名】长度不能超过32" });
            /*非空字段*/
            $("#<%=txtExecutor.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【工作项当前执行者】不能为空" });
            /*必选项*/
            $("#<%=chbRootProcessInstID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【所属根流程实例】不能为空" });
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
			<label for="<%=txtName.ClientID%>" class="label">
			                名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboType.ClientID%>" class="label">
			                工作项类型
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboType" DropDownStyle="DropDownList" 
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
			<label for="<%=dtpCreateTime.ClientID%>" class="label">
			                创建时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpCreateTime" runat="server"></suntek:DatePicker>
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
			<label for="<%=dtpStartTime.ClientID%>" class="label">
			                启动时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpStartTime" runat="server"></suntek:DatePicker>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpEndTime.ClientID%>" class="label">
			                结束时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpEndTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtDescription.ClientID%>" class="label">
			                描述
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboCurrentState.ClientID%>" class="label">
			                当前状态
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboCurrentState" DropDownStyle="DropDownList" 
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
			<label for="<%=txtParticipant.ClientID%>" class="label">
			<em>*</em>
                参与者
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtParticipant" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboIsTimeOut.ClientID%>" class="label">
			                是否超时
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboIsTimeOut" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="否" Value="0" ></asp:ListItem>
							<asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=dtpTimeOutTime.ClientID%>" class="label">
			                超时时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpTimeOutTime" runat="server"></suntek:DatePicker>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpRemindTime.ClientID%>" class="label">
			                提醒时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpRemindTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtActionURL.ClientID%>" class="label">
			                响应URL
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtActionURL" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtActionMask.ClientID%>" class="label">
			                操作码
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtActionMask" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbProcessInstID.ClientID%>" class="label">
			<em>*</em>
                所属流程实例
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbProcessInstID" OpenUrl="ProcessInstIDTree.aspx" DialogTitle="选择所属流程实例"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtProcessInstName.ClientID%>" class="label">
			                所属流程实例名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtProcessInstName" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbActivityInstID.ClientID%>" class="label">
			<em>*</em>
                所属活动实例
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbActivityInstID" OpenUrl="ActivityInstIDTree.aspx" DialogTitle="选择所属活动实例"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtActivityInstName.ClientID%>" class="label">
			                所属活动实像名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtActivityInstName" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbProcessID.ClientID%>" class="label">
			<em>*</em>
                所属流程
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbProcessID" OpenUrl="ProcessIDTree.aspx" DialogTitle="选择所属流程"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtProcessText.ClientID%>" class="label">
			                所属流程显示名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtProcessText" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboAllowAgent.ClientID%>" class="label">
			                是否允许代理
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboAllowAgent" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboBizState.ClientID%>" class="label">
			                业务状态
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboBizState" DropDownStyle="DropDownList" 
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
			<label for="<%=txtExecutor.ClientID%>" class="label">
			<em>*</em>
                工作项当前执行者
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtExecutor" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbRootProcessInstID.ClientID%>" class="label">
			                所属根流程实例
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbRootProcessInstID" OpenUrl="RootProcessInstIDTree.aspx" DialogTitle="选择所属根流程实例"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
    </div>
</asp:Content>

