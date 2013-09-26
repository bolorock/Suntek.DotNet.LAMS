
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="AgentItemDetail.aspx.cs" Inherits="WebSite.AgentItemDetail" %>

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
            $("#<%=chbRelatedBizID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【代理业务ID】不能为空" });
            /*必选项*/
            $("#<%=chbAgentID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【所属代理】不能为空" });
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
			<label for="<%=cboType.ClientID%>" class="label">
			                代理项类型
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
            <div class="div_row_lable">
			<label for="<%=chbRelatedBizID.ClientID%>" class="label">
			<em>*</em>
                代理业务ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbRelatedBizID" OpenUrl="RelatedBizIDTree.aspx" DialogTitle="选择代理业务ID"
                runat="server"></suntek:ChooseBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboIsValid.ClientID%>" class="label">
			<em>*</em>
                是否生效
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboIsValid" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="否" Value="0" ></asp:ListItem>
							<asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboAgentPrivilege.ClientID%>" class="label">
			                代理权限
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboAgentPrivilege" DropDownStyle="DropDownList" 
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
			<label for="<%=chbAgentID.ClientID%>" class="label">
			<em>*</em>
                所属代理
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbAgentID" OpenUrl="AgentIDTree.aspx" DialogTitle="选择所属代理"
                runat="server"></suntek:ChooseBox>
            </div>
		</div>
    </div>
</asp:Content>

