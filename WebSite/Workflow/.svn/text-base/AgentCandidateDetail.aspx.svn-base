
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="AgentCandidateDetail.aspx.cs" Inherits="WebSite.AgentCandidateDetail" %>

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
            $("#<%=chbAgentToID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【代理人】不能为空" });
			/*默认验证字段*/
			$("#<%=txtAgentToName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【代理人名称】长度不能超过32" });
            /*非空字段*/
            $("#<%=txtAgentFrom.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【委托人ID】不能为空" });
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
			<label for="<%=chbAgentToID.ClientID%>" class="label">
			<em>*</em>
                代理人
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbAgentToID" OpenUrl="AgentToIDTree.aspx" DialogTitle="选择代理人"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtAgentToName.ClientID%>" class="label">
			                代理人名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAgentToName" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboAgentToType.ClientID%>" class="label">
			                代理人类型
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboAgentToType" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtAgentFrom.ClientID%>" class="label">
			<em>*</em>
                委托人ID
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtAgentFrom" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
    </div>
</asp:Content>

