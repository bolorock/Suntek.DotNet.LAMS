
<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="AssessmentRoleWeightManager.aspx.cs" Inherits="WebSite.AssessmentRoleWeightManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<%= WebExtensions.CombresLink(Skin+"SiteCss") %>
	<%= WebExtensions.CombresLink(Skin+"ManagerCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
	<%= WebExtensions.CombresLink("ManagerJs") %>
	  <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
  <script type="text/javascript" language="javascript">

   

      function chooseConfirm(me, argument) {
          var roles = new Array();
          $("#gvList").find(":checked").each(function (i) {
              var currentRow = $(this).parent().parent();

              var tds = currentRow.find("td");
              if (tds.length > 0) {
                  var role = new Object();
                  role["RoleID"] = $.trim($(this).val());
                      role["Name"] = $.trim(tds.eq(1).text());
                      role["Weight"] = $.trim(tds.eq(2).find("input").eq(0).val());
                      role["SurveyID"] = $.trim(GetQueryString("SurveyID"));
                      roles[roles.length] = role;
                 
              }

          });

          var value = JSON2.stringify(roles)

          $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: value, CurrentId: $("#hidCurrentId").val() }, function (result) {
              var ajaxResult = JSON2.parse(result);
              var message = "操作失败";
              if (ajaxResult) {
                  if (ajaxResult.PromptMsg != null)
                      message = ajaxResult.PromptMsg
                  if (ajaxResult.ActionResult == 1) {
                      if (message == "") {
                          message = "操作成功！";
                      }
                  }

                  alert(message);
                  if (message == "操作成功") {
                      window.returnValue = value;
                      window.close();
                  }

              }

          });


      }


      //获取参数
//      function GetQueryString(name) {
//          var url = window.location.url;
//          var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
//          var r = url.substr(1).match(reg);
//          if (r != null) return r[2]; return null;
//      }

      function GetQueryString(name) {
          var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
          var r = window.location.search.substr(1).match(reg);
          if (r != null) return unescape(r[2]); return null;
      }  




  </script>


    <div id="divContent" class="div_content">
   
   提示：请先勾选角色，然后设置权重，权重为0-100的整数，权重总和应为100。
        <SunTek:PagedGridView ID="gvList" runat="server" PageIndex="1" CssClass="gridview" DataKeyNames="ID">
            <Columns>
                <asp:TemplateField HeaderText="选择">
                    <ItemTemplate>
                        <input id="radioId" type="checkbox" value='<%#Eval("ID") %>'  <%# (double)Eval("Weight")>0?"checked='checked'":"" %>  name="radioId" />
                    </ItemTemplate>
                </asp:TemplateField>
		        <asp:TemplateField HeaderText="角色名称">
                    <ItemTemplate>
						<%#Eval("Name")%>
                    </ItemTemplate>
                </asp:TemplateField>
		     
		        <asp:TemplateField HeaderText="权重">
                    <ItemTemplate>
						
                        <input  type="text" value='<%#(double)Eval("Weight")>0?Eval("Weight"):""%>' class="weight"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </SunTek:PagedGridView>
    </div>
    <div id="filterDialog" title="查询">
        <p id="validateTips">
        </p>
        <fieldset>
            <dl>
				<dt class="rowlable">角色名称</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterName" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable"></dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterCategory" runat="server" CssClass="text"></asp:TextBox>
				</dd>
				<dt class="rowlable">评测权重</dt>
				<dd class="rowinput">
						 <asp:TextBox ID="filterWeight" runat="server" CssClass="text"></asp:TextBox>
				</dd>
            </dl>
        </fieldset>
    </div>
</asp:Content>


