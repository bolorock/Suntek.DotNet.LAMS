
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="BizOrgDetail.aspx.cs" Inherits="WebSite.BizOrgDetail" %>

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
			$("#<%=txtName.ClientID%>").formValidator().inputValidator({max:32, onerror: "【业务机构名称】长度不能超过32" });
            /*必选项*/
            $("#<%=chbParentID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【上级组织】不能为空" });
            /*必选项*/
            $("#<%=chbOrgID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【组织机构ID】不能为空" });
            /*非空字段*/
            $("#<%=txtGovernPosition.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【主管岗位】不能为空" });
            /*非空字段*/
            $("#<%=txtCreator.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【创建者】不能为空" });
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
			                业务机构名称
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtName" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtGrade.ClientID%>" class="label">
			                业务机构等级
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtGrade" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=chbParentID.ClientID%>" class="label">
			                上级组织
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbParentID" OpenUrl="ParentIDTree.aspx" DialogTitle="选择上级组织"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboBizType.ClientID%>" class="label">
			                业务字典ABF_NODETYPE
   虚拟节点，机构节点，如果是机构节点，则对应机构信息表的一个机构
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboBizType" DropDownStyle="DropDownList" 
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
			<label for="<%=chbOrgID.ClientID%>" class="label">
			<em>*</em>
                组织机构ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbOrgID" OpenUrl="OrgIDTree.aspx" DialogTitle="选择组织机构ID"
                runat="server"></suntek:ChooseBox>
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
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtGovernPosition.ClientID%>" class="label">
			<em>*</em>
                主管岗位
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtGovernPosition" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtCreator.ClientID%>" class="label">
			<em>*</em>
                创建者
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtCreator" runat="server" CssClass="text"></asp:TextBox>
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

