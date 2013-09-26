<%@ Page Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="CandidateManagerTree.aspx.cs" Inherits="WebSite.CandidateManagerTree" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("ManagerJs")%>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <div style="overflow: auto; height: 100%;vertical-align: top;">
        <suntek:AjaxTree ID="AjaxTree1" Runat="server" />
    </div>
    <script type="text/javascript" language="javascript">

        function getCheckedNodeIds() {
            var selectNodes = "";
            $("input:checked", $("#ajaxTree_Div_Id")).each(function () {
                if (this.id.indexOf("UR1") >= 0) {
                    selectNodes += this.id.replace("chk_", "") + ",";
                }
            });
            $("#ajaxTreeSelectNodeIds").val(selectNodes);

            return selectNodes;
        }

        /*选择多个人*/
        function getCheckedNodes() {
            var rtnValue = new Array();
            try {
                $("input:checked", $("#ajaxTree_Div_Id")).each(function () {
                    if (this.id.indexOf("UR1") >= 0) {
                        var me = $(this).parent();
                        var item = { id: me.attr("id"),
                            text: $(me).attr("title"),
                            value: $(me).attr("bindvalue"),
                            tag: $(me).attr("tag")
                        };
                        rtnValue.push(item);
                    }
                });
            } catch (e) { }

            return rtnValue;
        }

        //返回选择对象
        function chooseConfirm() {

            var items = getCheckedNodes();
            var ids = "";
            var names = "";
            for (var i = 0; i < items.length; i++) {
                ids += items[i].id + ","
                names += items[i].text + ",";
            }
            var retValue = new Object();
            retValue.text = names.slice(0, names.length - 1);
            retValue.value = ids.slice(0, ids.length - 1);
            // retValue.tag = item.tag;
            window.returnValue = retValue;
            window.close();
        }

        $(function () {
            bindValue();
        });

        /*绑定已选数据*/
        function bindValue() {
            var para = getUrlPara("bindValue");
            if (para == "1") {
                var obj = window.dialogArguments;
                var names = obj.name.split(',');
                var ids = obj.id.split(',');
                for (var i = 0; i < ids.length; i++) {
                    var chk = $("#chk_" + ids[i]);
                    if (chk[0]) {
                        chk.attr("checked", "true");
                    }
                }
            }
        }
    </script>
</asp:Content>
