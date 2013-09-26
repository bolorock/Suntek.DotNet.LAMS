/// <reference path="jquery-vsdoc.js" />
/// <reference path="Cookie.js" />

//====================================================================================================
//----------------------------------------------------------------------------------------------------
// [描    述] 用于放置整个站点的弹出层js脚本
//            
//            
//----------------------------------------------------------------------------------------------------
// [作者] 	    trenhui
// [日期]       2009-07-16
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// [历史记录]
// [作者]  
// [描    述]     
// [更新日期]
// [版 本 号] ver1.0
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//====================================================================================================


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Author     ：trenhui
//Descripton ：查询弹出层窗体相关方法
//Begin      ：
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
var dialogSetting = new Object();
dialogSetting.viewPageUrl;
dialogSetting.detailWidth = 650;
dialogSetting.detailHeight = 370;
dialogSetting.filterWidth = 400;
dialogSetting.filterHeight = 400;
dialogSetting.managerPageUrl;
dialogSetting.filterRunat = 1;
dialogSetting.actionUrl = "";

$(function () {
    //获取提示信息对象
    tips = $("#validateTips");

    //输入验证
    function validate() {
        return true;
    }

    //清除元素的值
    function clearValues() {
        $("input[type='text'][name*='filter']").each(function () {
            $(this).val('');
        });
        $("select[name*='filter']").each(function () {
            $(this).val('-1');
        });
    }

    //初始化查询窗体
    var filterDialog = $("#filterDialog");
    if (filterDialog[0]) {
        filterDialog.dialog({
            bgiframe: true,
            autoOpen: false,
            width: dialogSetting.filterWidth,
            height: dialogSetting.filterHeight,
            maxWidth: dialogSetting.filterWidth,
            maxHeight: dialogSetting.filterHeight,
            minWidth: dialogSetting.filterWidth,
            minHeight: dialogSetting.filterHeight,
            modal: false,
            position: ['center', 30],
            buttons: {
                '取 消': function () {
                    $(this).dialog('close');
                },
                '清 除': function () {
                    clearValues();
                },

                '确 定': function () {
                    if (validate()) {
                        $(this).dialog('close');
                        filterAction();
                    }
                }
            },
            close: function () {
                //clearValues();
            }
        });
    }

    //将弹出层移动到aspnetForm里
    $("div[role=dialog]").appendTo("form#aspnetForm");

    //提示信息
    messageBox();
});

function doPostBack() {
    document.location.reload();
    //__doPostBack('ctl00$commandBar', 'Search$Search');
}


//默认自定义查询方法有用勿删
function filterAction() {
    __doPostBack('ctl00$commandBar', 'Search$Search');
}

function promptMessage(message) {
    alert(message);
}

function initPromptMessageDialog() {
    //初始化查询窗体
    var dialog = $("#promptMsg");

    if (dialog[0]) {
        dialog.dialog({
            bgiframe: true,
            autoOpen: false,
            width: dialogSetting.filterWidth,
            height: dialogSetting.filterHeight,
            maxWidth: dialogSetting.filterWidth,
            maxHeight: dialogSetting.filterHeight,
            minWidth: dialogSetting.filterWidth,
            minHeight: dialogSetting.filterHeight,
            modal: false,
            position: ['center', 30],
            close: function () {
            }
        });
    }
}


function openFilterDialog(me, argument) {
    $('#filterDialog').dialog('open');
}

//弹出操作对话框：container 对话容器，cmdName执行的命令，argument命令参数，showModal是否模态显示，style弹出样式（0表示弹出div,1表示弹出窗体）
function openActionDialog(container, cmdName, argument, actionName, showModal, style, refreshParent) {
    var dialogShowModal = showModal || false;
    var dialogStyle = style || 0; //0表示弹出div,1表示弹出窗体
    var refresh = refreshParent || 1; //1刷新
    var currentID = cmdName == "Add" ? "" : "&CurrentId=" + $("#hidCurrentId").val();
    var url = dialogSetting.actionUrl;
    if (url == "")
        url = getCurrentUrl().replace("Manager.aspx", "Detail.aspx");

    if (cmdName == "View") url = url.replace("Entry=Manager", "Entry=View").replace("Entry=Update", "Entry=View");
    if (url.indexOf('?') > 0)
        url += "&Runat=3&ActionFlag=" + cmdName + currentID + "&radom=" + Math.random();
    else
        url += "?Runat=3&ActionFlag=" + cmdName + currentID + "&radom=" + Math.random();

    if (url.indexOf('Entry=') < 1) {
        url += "&Entry=" + cmdName;
    }

    if (dialogStyle == 1) {
        if (showModal) {
            var cssDialog = "dialogHeight:" + dialogSetting.detailHeight + "px; dialogWidth:" + dialogSetting.detailWidth + "px; edge: Raised; center: Yes; status: No;resizable: yes; scroll:off;";
            return window.showModalDialog(url, cmdName, cssDialog);
        }
        else {
            var cssDialog = 'center: Yes,status=yes,menubar=no,scrollbars=no,resizable=yes,width=' + dialogSetting.detailWidth + ',height=' + dialogSetting.detailHeight;
            window.open(url, cmdName, cssDialog);
        }
    }
    else {
        container = "#" + container;
        if ($(container).html() != "")
            $(container).dialog("destroy");
        $(container).html('<iframe id="bg_div_iframe" scrolling="no"  width="100%" height="98%" allowTransparency="true" frameborder="0"></iframe>');
        $('#bg_div_iframe').attr('src', url);

        $(container).dialog({
            bgiframe: true,
            autoOpen: false,
            width: dialogSetting.detailWidth,
            height: dialogSetting.detailHeight,
            maxWidth: dialogSetting.detailWidth,
            maxHeight: dialogSetting.detailHeight,
            minWidth: dialogSetting.detailWidth,
            minHeight: dialogSetting.detailHeight,
            modal: dialogShowModal,
            position: ['center', 30],
            close: function () {
                if (cmdName != "View" && refresh == 1)
                    doPostBack();
            }
        });
        $(container).dialog("option", "title", actionName);
        $(container).dialog("open");
    }
}

//弹出操作对话框：container 对话容器，title窗体标题，url页面地址，width弹出窗宽度，height弹出窗框高度,showModal是否模态显示，style弹出样式（0表示弹出div,1表示弹出窗体）
function openDialog(container, title, url, width, height, showModal, style) {
    var dialogWidth = width || 350;
    var dialogHeight = height || 400;
    var dialogShowModal = showModal || false;
    var dialogStyle = style || 0; //0表示弹出div,1表示弹出窗体

    var appendSign = url.indexOf("?") > 0 ? "&" : "?";
    url = url + appendSign + "random=" + Math.random();

    if (dialogStyle == 1) {
        if (showModal) {
            var cssDialog = "dialogHeight:" + height + "px; dialogWidth:" + width + "px; edge: Raised; center: Yes; status: No;resizable: yes; scroll:off;";
            return window.showModalDialog(url, title, cssDialog);
        }
        else {
            var cssDialog = 'center: Yes,status=yes,menubar=no,scrollbars=no,resizable=yes,width=' + width + ',height=' + height;
            window.open(url, title, cssDialog);
        }
    }
    else {
        container = "#" + container;

        if ($(container).html() != "")
            $(container).dialog("destroy");
        $(container).html('<iframe id="bg_div_iframe" width="100%" height="98%" allowTransparency="true" frameborder="0"></iframe>');
        $('#bg_div_iframe').attr('src', url);

        $(container).dialog({
            bgiframe: true,
            autoOpen: false,
            width: dialogWidth,
            height: dialogHeight,
            position: ['center', 30],
            modal: dialogShowModal
        });
        $(container).dialog("option", "title", title);
        $(container).dialog("open");
        return true;
    }
}

//弹出操作对话框：title窗体标题，url页面地址，width弹出窗宽度，height弹出窗框高度,showModal是否模态显示，style弹出样式（0表示弹出div,1表示弹出窗体）
function openOperateDialog(title, url, width, height, showModal, style) {
    var container = "actionDialog";
    var dialogWidth = width || 350;
    var dialogHeight = height || 400;
    var dialogShowModal = showModal || false;
    var dialogStyle = style || 0; //0表示弹出div,1表示弹出窗体

    var appendSign = url.indexOf("?") > 0 ? "&" : "?";
    url = url + appendSign + "random=" + Math.random();

    if (dialogStyle == 1) {
        if (showModal) {
            var cssDialog = "dialogHeight:" + height + "px; dialogWidth:" + width + "px; edge: Raised; center: Yes; status: No;resizable: yes; scroll:off;";
            return window.showModalDialog(url, title, cssDialog);
        }
        else {
            var cssDialog = 'center: Yes,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=' + width + ',height=' + height;
            window.open(url, title, cssDialog);
        }
    }
    else {
        container = "#" + container;

        if ($(container).html() != "")
            $(container).dialog("destroy");
        $(container).html('<iframe id="bg_div_iframe" width="100%" height="98%" allowTransparency="true" frameborder="0"></iframe>');
        $('#bg_div_iframe').attr('src', url);

        $(container).dialog({
            bgiframe: true,
            autoOpen: false,
            width: dialogWidth,
            height: dialogHeight,
            position: ['center', 30],
            modal: dialogShowModal
        });
        $(container).dialog("option", "title", title);
        //$(container).dialog('option', 'position', 'top');
        $(container).dialog("open");
        return true;
    }
}

function getAjaxObject(me, cmdName, argument) {
    return getObjectValue();
}

function getAjaxArgument(me, cmdName, argument) {
    return null;
}

function processAjaxResult(ajaxResult) {
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
}

function commandExecute(me, cmdName, argument, isAjax) {
    if (isAjax) {
        try {
            var actionName = cmdName.substring(0, 1).toLowerCase() + cmdName.substr(1);
            eval(actionName + "(me,'" + argument + "');");
        } catch (e) { }
    }
    else {
        if (cmdName == "Search")
            openFilterDialog(me, argument);
        else if (cmdName == "Add") {
            openActionDialog("actionDialog", cmdName, argument, "新增");
        }
        else if (cmdName == "Update") {
            openActionDialog("actionDialog", cmdName, argument, "修改");
        }
        else if (cmdName == "View")
            openActionDialog("actionDialog", cmdName, argument, "查看");
        else {
            if (cmdName == "Delete") {
                if (!confirm("是否确定删除记录？")) {
                    return false;
                }
                del($("#hidCurrentId").val());
            }
            if (cmdName == "ClearCache" || cmdName == "ClearAllCache") {
                if (!confirm("是否确定清除缓存？")) {
                    return false;
                }
            }
            var actionName = cmdName.substring(0, 1).toLowerCase() + cmdName.substr(1);
            try {
                eval(actionName + "(me,'" + argument + "');");
            } catch (e) { }
        }
    }
}

//########################################################################################################
//End 查询弹出层窗体相关方法
//########################################################################################################


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Author     ：trenhui
//Descripton ：查看弹出层窗体相关方法
//Begin      ：
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function initDialog(triggerObj, event, container, title, url, width, height, isModal) {

    container = "#" + container;
    triggerObj = "#" + triggerObj;

    $(container).attr("title", title);
    $(container).html('<iframe id="bg_div_iframe" width="100%" height="98%" allowTransparency="true" frameborder="0"></iframe>');
    $('#bg_div_iframe').attr('src', url);

    $(container).dialog({
        bgiframe: true,
        autoOpen: false,
        width: width,
        height: height,
        modal: isModal
    });

    $(triggerObj).bind(event, function () {
        $(container).dialog("open");
    });
    $(triggerObj).hover(
            function () {
                $(this).addClass("ui-state-hover");
            },
			function () {
			    $(this).removeClass("ui-state-hover");
			}
		).mousedown(function () {
		    $(this).addClass("ui-state-active");
		})
		.mouseup(function () {
		    $(this).removeClass("ui-state-active");
		});
}

//########################################################################################################
//End 查看弹出层窗体相关方法
//########################################################################################################

//删除记录
function del(id) {
    $.post(getCurrentUrl(), { AjaxAction: "Delete", AjaxArgument: id }, function (result) {
        var ajaxResult = JSON2.parse(result);
        var message = "操作失败";
        if (ajaxResult) {
            if (ajaxResult.PromptMsg != null)
                message = ajaxResult.PromptMsg
            if (ajaxResult.ActionResult == 1) {
                if (message == "")
                    message = "操作成功！";
                $("#gvList_ItemCount").text(parseInt($("#gvList_ItemCount").text()) - 1);
            }
        }
        alert(message);
    });
}