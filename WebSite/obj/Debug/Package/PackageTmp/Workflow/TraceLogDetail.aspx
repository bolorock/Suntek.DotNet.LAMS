
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="TraceLogDetail.aspx.cs" Inherits="WebSite.TraceLogDetail" %>

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
            $("#<%=txtOperator.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【操作人】不能为空" });
			/*默认验证字段*/
			$("#<%=txtClientIP.ClientID%>").formValidator().inputValidator({max:16, onerror: "【IP地址】长度不能超过16" });
            /*必选项*/
            $("#<%=chbProcessID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【流程ID】不能为空" });
            /*必选项*/
            $("#<%=chbProcessInstID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【流程实例ID】不能为空" });
            /*必选项*/
            $("#<%=chbActivityID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【活动ID】不能为空" });
            /*必选项*/
            $("#<%=chbActivityInstID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【活动实例ID】不能为空" });
            /*必选项*/
            $("#<%=chbWorkItemID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【工作项ID】不能为空" });
			/*默认验证字段*/
			$("#<%=txtMessage.ClientID%>").formValidator().inputValidator({max:128, onerror: "【消息】长度不能超过128" });
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
			<label for="<%=cboActionType.ClientID%>" class="label">
			                操作
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboActionType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtOperator.ClientID%>" class="label">
			<em>*</em>
                操作人
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOperator" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtClientIP.ClientID%>" class="label">
			                IP地址
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtClientIP" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbProcessID.ClientID%>" class="label">
			<em>*</em>
                流程ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbProcessID" OpenUrl="ProcessIDTree.aspx" DialogTitle="选择流程ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbProcessInstID.ClientID%>" class="label">
			<em>*</em>
                流程实例ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbProcessInstID" OpenUrl="ProcessInstIDTree.aspx" DialogTitle="选择流程实例ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbActivityID.ClientID%>" class="label">
			<em>*</em>
                活动ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbActivityID" OpenUrl="ActivityIDTree.aspx" DialogTitle="选择活动ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbActivityInstID.ClientID%>" class="label">
			<em>*</em>
                活动实例ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbActivityInstID" OpenUrl="ActivityInstIDTree.aspx" DialogTitle="选择活动实例ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbWorkItemID.ClientID%>" class="label">
			<em>*</em>
                工作项ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbWorkItemID" OpenUrl="WorkItemIDTree.aspx" DialogTitle="选择工作项ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtMessage.ClientID%>" class="label">
			                消息
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtMessage" runat="server" CssClass="text"></asp:TextBox>
            </div>
		</div>
    </div>
</asp:Content>

