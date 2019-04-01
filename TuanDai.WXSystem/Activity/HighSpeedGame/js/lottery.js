/*抽奖界面 Allen 2015-06-12 */

$(document).ready(function () {
    $('.a-box').click(function () {
        StartLottery();
    });
});
//开始抽奖
function StartLottery() {
    $.ajax({
        url: "/ajaxCross/HighSpeedGameAjax.ashx",
        type: "post",
        dataType: "json",
        async: true,
        data: {
            Cmd: "StartLottery",
            StarNum: starNum
        },
        success: function (data) {
            if (data.result == "-100") {
                ShowMsg("抽奖失败，请重试!");
            } else {
                switch (data.Status) {
                    case 1:
                    case 3:
                        var aToStr = JSON.stringify(data);
                        PostSubmit("/Activity/HighSpeedGame/LotteryResult.aspx", aToStr);
                        break;
                    case 2:
                        ShowMsg('您还未登录，登录之后才能抽奖', '登录', '/user/Login.aspx?ReturnUrl=' + location.href);
                        break;
                    case 4: //抽奖机会已用完
                        window.location.href = "/Activity/HighSpeedGame/LotteryNone.aspx";
                        break;
                    case 0:
                        ShowMsg(data.Msg);
                        break;
                    default:
                        ShowMsg(data.Msg);
                        break;
                }
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            ShowMsg("抽奖失败，请重试!");
        }
    });
}

function Done() {
    $(".maskLayer").fadeOut();
    $("#tip").animate({
        bottom: "-430px"
    }, 200);
}
function ShowMsg(msg, isShowOk, okValue, url) {
    $(".maskLayer").fadeIn();
    $("#msg").html(msg);
    if (isShowOk == "1") {
        $("#btnOk").html(okValue);
        $("#btnOk").attr("href", url);
        $("#btnCancel").val("取消");
        $("#btnOk").parent().show();
    } else {
        $("#btnOk").parent().hide();
        $("#btnCancel").val("确定");
    }
    var bottom = (document.documentElement.clientHeight - document.getElementById("tip").offsetHeight) / 2;
    $("#tip").animate({
        bottom: bottom
    }, 200);
}

function PostSubmit(url, data) {
    var postUrl = url; //提交地址  
    var postData = data; //第一个数据  
    var ExportForm = document.createElement("FORM");
    document.body.appendChild(ExportForm);
    ExportForm.method = "POST";
    var newElement = document.createElement("input");
    newElement.setAttribute("name", "jsondata");
    newElement.setAttribute("type", "hidden"); 
    ExportForm.appendChild(newElement);
    newElement.value = postData; 
    ExportForm.action = postUrl;
    ExportForm.submit();
}; 