<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebSite._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>领导力测评管理系统</title>
    <%= WebExtensions.CombresLink(Skin + "SiteCss")%>
    <%= WebExtensions.CombresLink("SiteJs") %>
    <script src="Scripts/Jquery/jquery.easyui.min.js" type="text/javascript"></script>
    <link rel="Stylesheet" href="Skins/Default/PluginStyles/JQueryUI/easyui.css" type="text/css" />
    <%if (false)
      { %>
    <script src="Scripts/jquery-vsdoc.js" type="text/javascript"></script>
    <link href="Skins/Default/Styles/site.css" rel="stylesheet" type="text/css" />
    <%} %>
    <script language="javascript" type="text/javascript">
        //        window.onbeforeunload = function (e) {
        //            var n = window.event.screenX - window.screenLeft;
        //            var b = n > document.documentElement.scrollWidth - 20;
        //            if (!(b && window.event.clientY < 0 || window.event.altKey)) {
        //                setCookie("Refresh", true);
        //                setCookie("MenuState", document.getElementById("menu").style.display == "none" ? "none" : "block");
        //            }
        //        }

        //        function checkLoad() {
        //            var Refresh = getCookie("Refresh");
        //            var fromLogin = getCookie("fromLogin");
        //            if (Refresh != "" && fromLogin != "true") {
        //                document.getElementById("ifrContentPage").src = getCookie("CurUrl");
        //                showMenu(getCookie("MenuState") == "block" ? "none" : "");
        //                deleteCookie("MenuState");
        //                deleteCookie("Refresh");
        //                deleteCookie("fromLogin");
        //            }
        //            else {
        //                //   document.getElementById("ifrContentPage").src = "<%=RootPath%>Index.aspx";
        //            }
        //        }

        function switchSkin(skin, doc) {
            var reg = new RegExp("Skins\/.*?\/", "g");
            $("link", doc).each(function () {
                var oldHref = $(this).attr("href");
                var newHref = oldHref.replace(reg, "Skins/" + skin + "/");
                $(this).attr("href", newHref);
            });
        }

        function setSkin(skin) {
            switchSkin(skin, document);
            switchSkin(skin, window.frames["ifrContentPage"].document);
            var innerDocument = $("#actionDialog", window.frames["ifrContentPage"].document);
            if (innerDocument.html() != "") {
                if (innerDocument.find("#bg_div_iframe").attr("contentWindow") != null)
                    switchSkin(skin, innerDocument.find("#bg_div_iframe").attr("contentWindow").document);
            }

            $.post(getCurrentUrl(), { AjaxAction: "SwitchSkin", argument: skin }, function (value) {
                setCookie("currentSkin", skin);
            });
        }

        function autoHeight() {
            $("#main").height($(window).height() - $("#header").height() - $("#navigateBar").height());
        }

        function showNavigatePage() {
            var id = $("#mainmenuBar li:eq(0)").attr("id");
            $("#ifrNavigatePage").attr("src", "Navigate.aspx?ResourceID=" + id);
            setBackground(id);
            return id;
        }

        $(window).load(function () {
            autoHeight();
        });

        $(document).ready(function () {
            $("#skinCenter").bind("click", function () {
                $("#customSkins").toggle();
            });

            $("#orgList").bind("onchange", function () {
                alert("xixi");
            });

            var oldActiveMenuId = getCookie("ActiveMenuId");
            if (oldActiveMenuId != "")
                $("#" + oldActiveMenuId).addClass("currentmenu");

            var flag = showNavigatePage(); //初始化时，默认打开第一个导航页面 //flag标志符号

            $("#mainmenuBar a").mouseover(function () {
                $(this).attr("class", "currentnav_a");
            });

            $("#mainmenuBar a").mouseout(function () {
                $(this).removeAttr("class");
            });

            $("#mainmenuBar a").click(function () {
                if (flag != $(this).parent().attr("id")) {
                    $("#" + flag).removeAttr("class");
                    flag = $(this).parent().attr("id");
                    setBackground(flag);
                }
            });

            $("#mainmenuBar li").mouseover(function () {
                $(this).attr("class", "currentnav_li");
            });

            $("#mainmenuBar li").mouseout(function () {
                if (flag == $(this).attr("id")) {
                    setBackground(flag);
                }
                else {
                    $(this).removeAttr("class");
                }
            });

            
        });

        $(window).resize(function () {
            autoHeight();
        });

        function setBackground(obj) {
            $("#" + obj).attr("class", "currentmenu");
        }
       

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="masterPage">
        <div id="header">
            <div id="logo">
            </div>
            <div id="infoBar">
                <ul class="toplink">
                    <li><a target="ifrContentPage" href="<%=RootPath+"CMS/Index.aspx"%>">首页</a></li><li>|</li>
                    <li><a target="ifrContentPage" href="<%=RootPath+"PwdModify.aspx"%>">修改密码</a></li><li>
                        |</li>
                    <li><a href="<%=RootPath+"Login.aspx"%>">退出</a></li><li>|</li>
                    <li id="skinCenter"><a id="skinlink" href="#">主题</a>
                        <ul id="customSkins" class="style_switcher" style="display: none;">
                            <li class="style_center">主题</li>
                            <li id="Default" onclick="setSkin(this.id)" class="switcher"></li>
                            <li id="Blue" class="switcher" onclick="setSkin(this.id)"></li>
                            <%--                            <li id="Green" class="switcher" onclick="setSkin(this.id)"></li>
                            <li id="DarkBlue" class="switcher" onclick="setSkin(this.id)"></li>--%>
                        </ul>
                    </li>
                    <li>|</li>
                    <li><a target="ifrContentPage" href="<%=RootPath+"About.aspx"%>">关于我们</a></li><li>|</li>
                    <li><a target="ifrContentPage" href="<%=RootPath+"Help.aspx"%>">帮助</a></li>
                </ul>
            </div>
        </div>
        <div id="navigateBar">
            <%=BuildMenuBar()%>
        </div>
        <div id="UserInfo" style="width: 300px">
            <label style="width: 55%; text-align: right; float: left; height: 25px; vertical-align: text-bottom;">
                当前用户:<%=User.Name %>
                部门:</label><div style="width: 45%; text-align: left; float: left; height: 25px;">
                    <suntek:Combox runat="server" ID="orgList" />
                </div>
        </div>
        <div id="main" class="easyui-layout" style="width: 100%; height: 700px;">
            <!--677-->
            <div id="mainMenu" region="west" split="true" title="导航栏">
                <iframe id="ifrNavigatePage" name="ifrNavigatePage" frameborder="0" scrolling="auto"
                    height="100%"></iframe>
            </div>
            <div id="mainContainer" region="center">
                <iframe id="ifrContentPage" src="CMS/Index.aspx" name="ifrContentPage" frameborder="0" scrolling="no"
                    height="100%"></iframe>
            </div>
            <div id="footer" region="south" style="height: 17px;">
          <%--      <div style="width: 100%; height: 2px; background-image: url(./Skins/<%=Skin%>/images/gridtop.gif);
                    position: absolute; overflow: hidden;">
                </div>--%>
                <table id="FooterBanner" cellspacing="0" style="width: 100%">
                    <tr valign="bottom" align="center">
                        <td>
                            @2010-2019 Longtek Companion Corp. All rights reserved.
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    </form>
    <script language="javascript" type="text/javascript">
        function comboxChooseItem(srcObject, id) {
            var ev = getEvent();
            if (id) {
                $("#" + id).val($(srcObject).text());
                $("#" + id + 'data').val($(srcObject).attr('data'));
                $("#combox" + id).hide();
            }
            else {
                var eObj = ev.srcElement || ev.target; // 获得事件源        
                if (eObj.tagName == "INPUT") return false;
                var chk = $(srcObject).find("input:first");
                chk.attr("checked", chk.attr("checked") == false);
            }

            //保存到登录信息里边去
            $.post(getCurrentUrl(), { AjaxAction: "SwitchOrg", AjaxArgument: $("#" + id + 'data').val() }, function (result) {
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
                // alert(message);
            });

            return false; //防止a href="#"滚动 
        }
    </script>
</body>
</html>
