
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="TransitionDetail.aspx.cs" Inherits="WebSite.TransitionDetail" %>

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
            $("#<%=chbSrcActID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【源活动定义ID】不能为空" });
            /*必选项*/
            $("#<%=chbSrcActInstID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【源活动ID】不能为空" });
			/*默认验证字段*/
			$("#<%=txtSrcActInstName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【源活动名称】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtSrcActName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【源活动定义名称】长度不能超过32" });
            /*必选项*/
            $("#<%=chbDestActInstID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【目标活动ID】不能为空" });
			/*默认验证字段*/
			$("#<%=txtDestActInstName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【目标活动名称】长度不能超过32" });
            /*必选项*/
            $("#<%=chbDestActID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【目标活动定义ID】不能为空" });
			/*默认验证字段*/
			$("#<%=txtDestActName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【目标活动定义名称】长度不能超过32" });
            /*必选项*/
            $("#<%=chbProcessInstID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【流程实例ID】不能为空" });
			/*日期*/
            $("#<%=dtpTransTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【迁移时间】格式错误" });
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
			<label for="<%=chbSrcActID.ClientID%>" class="label">
			<em>*</em>
                源活动定义ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbSrcActID" OpenUrl="SrcActIDTree.aspx" DialogTitle="选择源活动定义ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbSrcActInstID.ClientID%>" class="label">
			<em>*</em>
                源活动ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbSrcActInstID" OpenUrl="SrcActInstIDTree.aspx" DialogTitle="选择源活动ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtSrcActInstName.ClientID%>" class="label">
			                源活动名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtSrcActInstName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtSrcActName.ClientID%>" class="label">
			                源活动定义名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtSrcActName" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbDestActInstID.ClientID%>" class="label">
			<em>*</em>
                目标活动ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbDestActInstID" OpenUrl="DestActInstIDTree.aspx" DialogTitle="选择目标活动ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtDestActInstName.ClientID%>" class="label">
			                目标活动名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDestActInstName" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbDestActID.ClientID%>" class="label">
			<em>*</em>
                目标活动定义ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbDestActID" OpenUrl="DestActIDTree.aspx" DialogTitle="选择目标活动定义ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtDestActName.ClientID%>" class="label">
			                目标活动定义名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtDestActName" runat="server" CssClass="text"></asp:TextBox>
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
			<label for="<%=dtpTransTime.ClientID%>" class="label">
			<em>*</em>
                迁移时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpTransTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
    </div>
</asp:Content>

