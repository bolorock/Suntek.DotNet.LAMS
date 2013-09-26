
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SubjectItemDetail.aspx.cs" Inherits="WebSite.SubjectItemDetail" %>

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
            $("#<%=chbSubjectID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【题目ID】不能为空" });
			/*默认验证字段*/
			$("#<%=txtItemTitle.ClientID%>").formValidator().inputValidator({max:128, onerror: "【选项标题】长度不能超过128" });
			/*默认验证字段*/
			$("#<%=txtItemValue.ClientID%>").formValidator().inputValidator({max:128, onerror: "【选项值】长度不能超过128" });
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
			<label for="<%=chbSubjectID.ClientID%>" class="label">
			<em>*</em>
                题目ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbSubjectID" OpenUrl="SubjectIDTree.aspx" DialogTitle="选择题目ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtItemTitle.ClientID%>" class="label">
			                选项标题
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtItemTitle" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtItemValue.ClientID%>" class="label">
			                选项值
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtItemValue" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtSortOrder.ClientID%>" class="label">
			                序号
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtSortOrder" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
    </div>
</asp:Content>

