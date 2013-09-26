
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ExtendAttrDetail.aspx.cs" Inherits="WebSite.ExtendAttrDetail" %>

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
			$("#<%=txtEntity.ClientID%>").formValidator().inputValidator({max:32, onerror: "【扩展实体】长度不能超过32" });
            /*必选项*/
            $("#<%=chbEntityID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【实例ID】不能为空" });
			/*默认验证字段*/
			$("#<%=txtName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【属性名】长度不能超过32" });
			/*默认验证字段*/
			$("#<%=txtValue.ClientID%>").formValidator().inputValidator({max:128, onerror: "【属性值】长度不能超过128" });
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
			<label for="<%=txtEntity.ClientID%>" class="label">
			                扩展实体
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtEntity" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=chbEntityID.ClientID%>" class="label">
			<em>*</em>
                实例ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbEntityID" OpenUrl="EntityIDTree.aspx" DialogTitle="选择实例ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtName.ClientID%>" class="label">
			                属性名
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtValue.ClientID%>" class="label">
			                属性值
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtValue" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
    </div>
</asp:Content>

