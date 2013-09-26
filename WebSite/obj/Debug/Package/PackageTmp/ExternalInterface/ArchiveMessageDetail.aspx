
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ArchiveMessageDetail.aspx.cs" Inherits="WebSite.ArchiveMessageDetail" %>

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
            $("#<%=txtMessageContent.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【消息内容】不能为空" });
			/*日期*/
            $("#<%=dtpArchiveTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【归档时间】格式错误" });
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
			<label for="<%=cboMessageType.ClientID%>" class="label">
			<em>*</em>
                消息类型
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboMessageType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtMessageContent.ClientID%>" class="label">
			<em>*</em>
                消息内容
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtMessageContent" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=dtpArchiveTime.ClientID%>" class="label">
			<em>*</em>
                归档时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpArchiveTime" runat="server"></suntek:DatePicker>
            </div>
		</div>
    </div>
</asp:Content>

