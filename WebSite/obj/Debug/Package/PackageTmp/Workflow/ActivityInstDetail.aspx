
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ActivityInstDetail.aspx.cs" Inherits="WebSite.ActivityInstDetail" %>

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
            $("#<%=dtpStartTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【启动时间】格式错误" });
			/*日期*/
            $("#<%=dtpEndTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【结束时间】格式错误" });
            /*必选项*/
            $("#<%=chbSubProcessInstID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【子流程实例ID】不能为空" });
            /*必选项*/
            $("#<%=chbActivityDefID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【活动定义ID】不能为空" });
            /*必选项*/
            $("#<%=chbProcessInstID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【所属流程实例】不能为空" });
			/*默认验证字段*/
			$("#<%=txtDescription.ClientID%>").formValidator().inputValidator({max:256, onerror: "【描述】长度不能超过256" });
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
			<label for="<%=cboType.ClientID%>" class="label">
			                活动类型
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
			<label for="<%=chbSubProcessInstID.ClientID%>" class="label">
			                子流程实例ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbSubProcessInstID" OpenUrl="SubProcessInstIDTree.aspx" DialogTitle="选择子流程实例ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbActivityDefID.ClientID%>" class="label">
			<em>*</em>
                活动定义ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbActivityDefID" OpenUrl="ActivityDefIDTree.aspx" DialogTitle="选择活动定义ID"
                runat="server"></suntek:ChooseBox>
            </div>
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
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboRollbackFlag.ClientID%>" class="label">
			                回退标志
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboRollbackFlag" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
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

