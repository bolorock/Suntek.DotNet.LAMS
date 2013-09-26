
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="CacheDataDetail.aspx.cs" Inherits="WebSite.CacheDataDetail" %>

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
            $("#<%=txtName.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【缓存名】不能为空" });
            /*非空字段*/
            $("#<%=txtValue.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【缓存值】不能为空" });
			/*日期*/
            $("#<%=dtpCreateTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【生效时间】格式错误" });
			/*日期*/
            $("#<%=dtpExpireTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【失效时间】格式错误" });
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
                缓存名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtValue.ClientID%>" class="label">
			<em>*</em>
                缓存值
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtValue" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=dtpCreateTime.ClientID%>" class="label">
			                生效时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpCreateTime" runat="server"></suntek:DatePicker>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpExpireTime.ClientID%>" class="label">
			                失效时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpExpireTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
    </div>
</asp:Content>

