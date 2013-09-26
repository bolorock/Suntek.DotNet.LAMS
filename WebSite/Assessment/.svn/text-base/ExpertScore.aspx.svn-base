<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ExpertScore.aspx.cs" Inherits="WebSite.ExpertScore" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= WebExtensions.CombresLink(Skin+"SiteCss") %>
    <%= WebExtensions.CombresLink(Skin+"DetailCss") %>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <%= WebExtensions.CombresLink("DetailJs") %>
    <%if (false)
      { %>
    <script src="../Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <%}%>
    <style type="text/css">
        .subject
        {
            border-bottom: 1px solid #eeeeee;
            text-align: left;
            width: 100%;
            margin: 5px;
        }
        .subject .title
        {
            font-weight: bold;
            margin-bottom: 10px;
            width: 95%;
        }
        .subject .item
        {
            line-height: 20px;
            padding-left: 24px;
            width: 95%;
        }
        
        .Maintitle
        {
        	 font-weight:bold;
        	 font-size:14px;
        	 color: #660000;
        	 padding:10px;
        	border-bottom: 1px dotted #cc6600;
        	text-align:left;
        	}
        	
        	.Maintitle span
        	{
        		  font-weight: normal;
        	 font-size:12px;
        	 color: Gray;
        	  text-indent:24px;
        		}
        		
        		.MainCtn{ padding:20px 0px;}
        		.comment{ margin:20px 0px; line-height:30px; border:1px dotted grey; width:90%; padding:10px;}
        		.tips{ text-align:left; margin:20px 10px;}
        	table{border-collapse:collapse;}
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlace" runat="server">
    <script type="text/javascript" language="javascript">

        function save() {
            formSubmit("");
        }


        function formSubmit(isSubmit) {

            var items = new Array();
            // var i = 0;

            $("input[id^='score_']").each(function (i) {
                var item = new Object();
                item["SubjectID"] = $(this).attr("id").replace("score_", "");
                item["Score"] = $(this).val();
                item["Comment"] = $("#" + $(this).attr("id").replace("score_", "comment_")).val();
                items[i++] = item;
            });


            if (items.length == 0) {
                alert("没有任何记录");
                return false;
            }
            var value = JSON2.stringify(items)
            $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: value,  SubmiteOK: isSubmit}, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "操作失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        if (message == "")
                            message = "操作成功！";

                    }

                }

                alert(message);
            });
        }

        function submit() {
            formSubmit("OK");
        }

     
        function back(me, argument) {
            history.back();
        }

        //=============下边是处理答题的行为====================
        function comboxChooseItem(me) {
            var value = "";
            var ctnDiv = $(me).parent().parent();
            $(":checkbox", ctnDiv).each(function () {
                if ($(this).attr("checked")) {
                    value += "," + $(this).val();
                }
            });
            $("input:hidden", ctnDiv).eq(0).val(value);
        }

        function radioChooseItem(me) {
            var value = "";
            var ctnDiv = $(me).parent().parent();
            $("input:radio", ctnDiv).each(function () {
                if ($(this).attr("checked")) {
                    value += "," + $(this).val();
                }

            });
            $("input:hidden", ctnDiv).eq(0).val(value);
        }



        function textItem(me) {
            var ctnDiv = $(me).parent().parent();
            $("input:hidden", ctnDiv).eq(0).val($(me).val());
        }

        function textareaItem(me) {
            var ctnDiv = $(me).parent().parent();
            $("input:hidden", ctnDiv).eq(0).val($(me).val());
        }

        function TableBothChooseItem(me) {
            var inputName = $(me).attr("name");
            var values = inputName.split('_');
            var valueField = $("#data_" + values[1]).eq(0);
            var value = "";
            var position = "";


            $("input[name^='name_" + values[1] + "_']").each(function () {
                $(this).removeAttr("disabled");
                if ($(this).attr("checked")) {
                    value += "," + $(this).val();
                    if (position.indexOf($(this).attr("position")) == -1) {
                        position += "," + $(this).attr("position");
                    }
                    else {
                        alert("选项有误");
                    }
                }
            });
            $("input[name^='name_" + values[1] + "_']").each(function () {
                if (position.indexOf($(this).attr("position")) > 0 && $(this).attr("checked") == "") {
                    $(this).attr("disabled", "disabled");
                }
            });

            valueField.val(value);
        }

        function TableDimChooseItem(me) {
            var inputName = $(me).attr("name");
            var values = inputName.split('_');
            var valueField = $("#data_" + values[1]).eq(0);
            var value = "";
            var position = "";

            $("input[name^='name_" + values[1] + "_']").each(function () {

                if ($(this).attr("checked")) {
                    value += "," + $(this).val();
                }
            });

            valueField.val(value);
        }
    </script>
      <%--<div id="examPaperDetail" style="overflow: auto; height: 100%; width: 100%; overflow-x: hidden;">--%>
      <div id="examPaperDetail" style="overflow: scroll; width: 100%;height: 100%; overflow-x: hidden;">
    <div class="tips">
        <asp:Literal ID="litTips" runat="server"></asp:Literal>
</div>
        <div style="text-align: center; width:98%; display: block;">
            试卷：<span id="exapPaperTitle" runat="server"></span></div>
        <br />
        <div id="remainTime2" style="font-size: 13px; font-weight: 700; color: #FF9900">
        </div>
        <br />
        <div style="float: right; ">
            共<span id="subjectCount" runat="server"></span>题 剩余时间:<span id="remainTime" runat="server">0</span>
        </div>
        <div style=" clear:both"></div>
        <input type="hidden" name="remainSecondsNow" id="remainSecondsNow" />
        <input type="hidden" runat="server" value="-100" name="remainSeconds" id="remainSeconds" />
        <asp:HiddenField ID="hdfSurveyResultID" runat="server" />
        <asp:PlaceHolder ID="phdExamPaper" runat="server"></asp:PlaceHolder>
    </div>
</asp:Content>
