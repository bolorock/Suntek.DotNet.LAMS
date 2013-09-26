
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="AssessmentRoleDetail.aspx.cs" Inherits="WebSite.AssessmentRoleDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("DetailJs") %>
	<%if (false)
      { %>
		<script src="<%=string.Format("{0}/Scripts/jquery-vsdoc.js",RootPath)%>"
        type="text/javascript"></script> 
    <%}%>	

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">

   <script type="text/javascript" language="javascript">

        //校验脚本
        function initValidator()
        {
			$.formValidator.initConfig({ formid: "aspnetForm", showallerror: true, onerror: function(msg) { $("#promptMsg").html(msg); } });
            /*非空字段*/
            $("#<%=txtName.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【角色名称】不能为空" });
			/*默认验证字段*/
			$("#<%=txtCategory.ClientID%>").formValidator().inputValidator({max:64, onerror: "【360测评=1;
   动机测评=2;
   团队效能测评=3;
   优势与特点测评=4;
   Disc测评=5;
   情景模拟=21;
   案例分析=22;
   关键事件访谈=23;】长度不能超过64" });
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
			<em>*</em>
                角色名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtCategory.ClientID%>" class="label">
			                360测评=1;
   动机测评=2;
   团队效能测评=3;
   优势与特点测评=4;
   Disc测评=5;
   情景模拟=21;
   案例分析=22;
   关键事件访谈=23;
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCategory" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtWeight.ClientID%>" class="label">
			                评测权重
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtWeight" runat="server" CssClass="text"></asp:TextBox>
            </div>
		</div>
    </div>
</asp:Content>

