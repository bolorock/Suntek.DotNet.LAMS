<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Page.Master" AutoEventWireup="true"
    CodeBehind="ExamShow.aspx.cs" Inherits="WebSite.Assessment.ExamShow" %>

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
        /*解决IE下滚动显示不全的问题*/
        html,body,form
        {
            margin:0px;
            height:100%;
        }
        .subject
        {
            border-bottom: 1px solid #eeeeee;
            text-align: left;
            width: 95%;
            margin: 5px;
        }
        .subject .title
        {
            font-weight: bold;
            margin-bottom: 10px;
            width: 100%;
        }
        .subject .item
        {
            line-height: 20px;
            padding-left: 24px;
            width: 100%;
        }
        
        .Maintitle
        {
            font-weight: bold;
            font-size: 14px;
            color: #660000;
            padding: 10px;
            border-bottom: 1px dotted #cc6600;
            text-align: left;
        }
        
        .Maintitle span
        {
            font-weight: normal;
            font-size: 12px;
            color: Gray;
            text-indent: 24px;
        }
        
        .MainCtn
        {
            padding: 20px;
        }
        table
        {
            border-collapse: collapse;
        }
        .tips
        {
            text-align: left;
            margin: 20px 10px;
            font-weight: bold;
            font-size: 14px;
        }
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
            var surveyResultID = $("#ctl00_contentPlace_hdfSurveyResultID").val();
            var remainTime = $("#remainSecondsNow").val();

            $("input[type='hidden'][id^='data_']").each(function (i) {
                var item = new Object();
                item["SubjectID"] = $(this).attr("id").replace("data_", "");
                item["Anwser"] = $(this).val();
                item["AssessmentResultID"] = surveyResultID;
                items[i++] = item;
            });



            var value = JSON2.stringify(items)
            $.post(getCurrentUrl(), { AjaxAction: "Save", AjaxArgument: value, CurrentId: $("#hidCurrentId").val(), SurveyResultID: surveyResultID, SubmiteOK: isSubmit, RemainTime: remainTime }, function (result) {
                var ajaxResult = JSON2.parse(result);
                var message = "保存失败";
                if (ajaxResult) {
                    if (ajaxResult.PromptMsg != null)
                        message = ajaxResult.PromptMsg
                    if (ajaxResult.ActionResult == 1) {
                        if (message == "")
                            message = "保存成功！";

                    }

                }

                alert(message);
            });
        }

        function submit() {
            formSubmit("OK");
            $("#ctl00_contentPlace_remainTime").html("0小时0分0秒");
            window.clearInterval(InterValObj);
        }



        var SysSecond;
        var InterValObj;
        $(document).ready(function () {
            SysSecond = parseInt($("#ctl00_contentPlace_remainSeconds").val()); //这里获取倒计时的起始时间  
            if (SysSecond > -1) {
                InterValObj = window.setInterval(SetRemainTime, 1000); //间隔函数，1秒执行  
            }

        });

        //将时间减去1秒，计算天、时、分、秒  
        function SetRemainTime() {
            if (SysSecond > 0) {

                if (SysSecond == 180) {
                    alert("您还剩下3分钟的答题时间，时间到时系统将自动对问卷进行提交！请点击确定继续进行答题！");
                }

                SysSecond = SysSecond - 1;
                $("#remainSecondsNow").val(SysSecond);
                var second = Math.floor(SysSecond % 60);             // 计算秒      
                var minite = Math.floor((SysSecond / 60) % 60);      //计算分  
                var hour = Math.floor((SysSecond / 3600) % 24);      //计算小时  
                //  var day = Math.floor((SysSecond / 3600) / 24);        //计算天  
                $("#ctl00_contentPlace_remainTime").html(hour + "小时" + minite + "分" + second + "秒");

            } else {//剩余时间小于或等于0的时候，就停止间隔函数  
                window.clearInterval(InterValObj);
                //这里可以添加倒计时时间为0后需要执行的事件
                alert("评测时间已到，系统自动提交当前问卷");
                formSubmit("OK");
            }

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
    <div class="div_block" id="examPaperDetail" style="overflow-y: auto; height: 100%; width: 100%; overflow-x: hidden;">
        <div class="tips">
            <asp:Literal ID="litTips" runat="server"></asp:Literal>
        </div>
        <div style="text-align: center; width: 100%; display: block; float: left">
            试卷：<span id="exapPaperTitle" runat="server"></span></div>
        <br />
        <div id="remainTime2" style="font-size: 13px; font-weight: 700; color: #FF9900">
        </div>
        <br />
        <div style="float: right; margin-right: 12px;">
            共<span id="subjectCount" runat="server"></span>题 剩余时间:<span id="remainTime" runat="server">0</span>
        </div>
        <div style="clear: both">
        </div>
        <input type="hidden" name="remainSecondsNow" id="remainSecondsNow" />
        <input type="hidden" runat="server" value="-100" name="remainSeconds" id="remainSeconds" />
        <asp:HiddenField ID="hdfSurveyResultID" runat="server" />
        <asp:PlaceHolder ID="phdExamPaper" runat="server"></asp:PlaceHolder>
    </div>
</asp:Content>
