
<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="SurveyResultDetail.aspx.cs" Inherits="WebSite.SurveyResultDetail" %>

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
            $("#<%=chbSurveyID.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【测评活动ID】不能为空" });
            /*非空字段*/
            $("#<%=txtTester.ClientID%>").formValidator().inputValidator({ min: 1, onerror: "【测评人】不能为空" });
			/*默认验证字段*/
			$("#<%=txtComment.ClientID%>").formValidator().inputValidator({max:512, onerror: "【测评评语】长度不能超过512" });
			/*默认验证字段*/
			$("#<%=txtScorer.ClientID%>").formValidator().inputValidator({max:36, onerror: "【评分人】长度不能超过36" });
			/*日期*/
            $("#<%=dtpScoreTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【评分时间】格式错误" });
			/*默认验证字段*/
			$("#<%=txtOwnerOrg.ClientID%>").formValidator().inputValidator({max:512, onerror: "【归属组织】长度不能超过512" });
			/*日期*/
            $("#<%=dtpStartTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【测评开始时间】格式错误" });
			/*日期*/
            $("#<%=dtpEntTime.ClientID%>").formValidator().inputValidator({ type: "date", onerror: "【测评结束时间】格式错误" });
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
			<label for="<%=chbSurveyID.ClientID%>" class="label">
			<em>*</em>
                测评活动ID
			</label>
            </div>
            <div class="div_row_input">
			    <suntek:ChooseBox ID="chbSurveyID" OpenUrl="SurveyIDTree.aspx" DialogTitle="选择测评活动ID"
                runat="server"></suntek:ChooseBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtTester.ClientID%>" class="label">
			<em>*</em>
                测评人
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtTester" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtScore.ClientID%>" class="label">
			                测评分数
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtScore" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=txtComment.ClientID%>" class="label">
			                测评评语
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtComment" runat="server" CssClass="text"></asp:TextBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtScorer.ClientID%>" class="label">
			                评分人
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtScorer" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpScoreTime.ClientID%>" class="label">
			                评分时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpScoreTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=cboStatus.ClientID%>" class="label">
			                初始化=0;
   在正测试=1;
   完成=2;
   超时=3;
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboStatus" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="请选择" Value="-1" Selected="True"></asp:ListItem>
							<asp:ListItem Text="类型1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="类型2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="类型3" Value="3"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=cboIsLock.ClientID%>" class="label">
			                是否锁定
			</label>
            </div>
            <div class="div_row_input">
					   <suntek:ComboBox ID="cboIsLock" DropDownStyle="DropDownList" 
                            AppendDataBoundItems="true" runat="server">
                            <asp:ListItem Text="否" Value="0" ></asp:ListItem>
							<asp:ListItem Text="是" Value="1" Selected="True"></asp:ListItem>
                        </suntek:ComboBox>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=txtOwnerOrg.ClientID%>" class="label">
			                归属组织
			</label>
            </div>
            <div class="div_row_input">
                <asp:TextBox ID="txtOwnerOrg" runat="server" CssClass="text"></asp:TextBox>
            </div>
            <div class="div_row_lable">
			<label for="<%=dtpStartTime.ClientID%>" class="label">
			                测评开始时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpStartTime" runat="server"></suntek:DatePicker>
            </div>
        </div>
        <div class="div_row">
            <div class="div_row_lable">
			<label for="<%=dtpEntTime.ClientID%>" class="label">
			                测评结束时间
			</label>
            </div>
            <div class="div_row_input">
				<suntek:DatePicker ID="dtpEntTime" runat="server"></suntek:DatePicker>
            </div>
		</div>
    </div>
</asp:Content>

