
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ProcessInstDetail.aspx.cs" Inherits="WebSite.ProcessInstDetail" %>

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
            /*必选项*/
            $("#<%=chbProcessDefID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【流程定义ID】不能为空" });
			/*默认验证字段*/
			$("#<%=txtProcessDefName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【流程名称】长度不能超过32" });
            /*必选项*/
            $("#<%=chbParentProcessID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【父流程】不能为空" });
            /*必选项*/
            $("#<%=chbParentActivityID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【父活动】不能为空" });
			/*日期*/
            $("#<%=dtpLimitTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【限期时间】格式错误" });
			/*日期*/
            $("#<%=dtpStartTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【启动时间】格式错误" });
			/*日期*/
            $("#<%=dtpEndTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【结束时间】格式错误" });
			/*日期*/
            $("#<%=dtpFinalTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【终止时间】格式错误" });
			/*日期*/
            $("#<%=dtpRemindTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【提醒时间】格式错误" });
			/*日期*/
            $("#<%=dtpTimeOutTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【超时时间】格式错误" });
			/*默认验证字段*/
			$("#<%=txtProcessVersion.ClientID%>").formValidator().inputValidator({max:16, onerror: "【所属流程版本】长度不能超过16" });
			/*默认验证字段*/
			$("#<%=txtDescription.ClientID%>").formValidator().inputValidator({max:256, onerror: "【描述】长度不能超过256" });
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
			<label for="<%=txtName.ClientID%>" class="label">
			                名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbProcessDefID.ClientID%>" class="label">
			<em>*</em>
                流程定义ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbProcessDefID" OpenUrl="ProcessDefIDTree.aspx" DialogTitle="选择流程定义ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtProcessDefName.ClientID%>" class="label">
			                流程名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtProcessDefName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbParentProcessID.ClientID%>" class="label">
			                父流程
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbParentProcessID" OpenUrl="ParentProcessIDTree.aspx" DialogTitle="选择父流程"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbParentActivityID.ClientID%>" class="label">
			                父活动
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbParentActivityID" OpenUrl="ParentActivityIDTree.aspx" DialogTitle="选择父活动"
                runat="server"></suntek:ChooseBox>
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
			<label for="<%=dtpLimitTime.ClientID%>" class="label">
			                限期时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpLimitTime" runat="server"></suntek:DatePicker>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpStartTime.ClientID%>" class="label">
			                启动时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpStartTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=dtpEndTime.ClientID%>" class="label">
			                结束时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpEndTime" runat="server"></suntek:DatePicker>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpFinalTime.ClientID%>" class="label">
			                终止时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpFinalTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=dtpRemindTime.ClientID%>" class="label">
			                提醒时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpRemindTime" runat="server"></suntek:DatePicker>
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
			<label for="<%=txtProcessVersion.ClientID%>" class="label">
			                所属流程版本
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtProcessVersion" runat="server" CssClass="text"></asp:TextBox>
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
			                创建时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpCreateTime" runat="server"></suntek:DatePicker>
            </div>
		</div>
    </div>
</asp:Content>

