/*广州交交会抽奖 */

$(function () {
    //中奖纪录
    $.ajax({
        url: "ajax_activity.ashx",
        type: "post",
        dataType: "json",
        async: false,
        data: { Cmd: "GetRecord" },
        success: function (jsonstr) {
            var html = new Array();
            var str = "";
            if (jsonstr.result == "1") {
                for (var i = 0; i < jsonstr.list.length; i++) {
                    str = "<li><div><span>" + jsonstr.list[i].UserName + "</span><span>抽中了</span><span>" + jsonstr.list[i].PrizeName + "</span></div></li>";
                    html.push(str);
                }
                $("#prize_list").append(html.join(""));
            }
            else {
                $("#prize_list").html("<li><div><span></span><span></span><span></span></div></li>");
            }
        },
        error: function (a, b, c) {
            $("#prize_list").html("加载中奖纪录失败...");
        }
    });
    //滚动中奖纪录
    new slider({ id: 'prize_list' });

    //抽奖
    $("#draw-but").click(function () {
        $.ajax({
            url: "ajax_activity.ashx",
            type: "post",
            dataType: "json",
            async: false,
            data: { Cmd: "GetPrize" },
            success: function (data) {
                switch (data.result) {
                    case "1":
                        var message = '<p class="prize-name">恭喜您获得</br><span>' + data.msg + '</span></p>';
                        var image = "";
                        if (data.msg.indexOf("pad") > 0) {
                            image = '<img src="imgs/prize6.png" />';
                        } else if (data.msg.indexOf("电源") > 0) {
                            image = '<img src="imgs/prize5.png" />';
                        } else if (data.msg.indexOf("U盘") > 0) {
                            image = '<img src="imgs/prize4.png" />';
                        } else if (data.msg.indexOf("15元") >= 0) {
                            image = '<img src="imgs/prize3.png" />';
                        } else if (data.msg.indexOf("10元") >= 0) {
                            image = '<img src="imgs/prize2.png" />';
                        } else if (data.msg.indexOf("5元") >= 0) {
                            image = '<img src="imgs/prize1.png" />';
                        }

                        setTimeout(function () {
                            showResult(message, image);
                        }, 2800)
                        $(".p21").addClass('wobble');
                        $(".p24").addClass('fadeOutDown');
                        $('#sound_bg')[0].play();

                        break;
                    case "2":
                        ShowMsg('您还未登录，登录之后才能抽奖', '登录', '/user/Login.aspx');
                        break;
                    case "-1":
                        ShowMsg('活动还未开始');
                        break;
                    case "-2":
                        ShowMsg('活动已经结束');
                        break;
                    case "-3":
                        ShowMsg('您不是新注册用户');
                        break;
                    case "-4":
                        ShowMsg('您已抽奖，不能再次抽奖');
                        break;
                    case "-5":
                        ShowMsg('奖品已全部抽完');
                        break;
                    default:
                        ShowMsg("抽奖失败");
                        break;
                }
            },
            error: function (a, b, c) {
                ShowMsg('抽奖失败');
            }
        });
    });

    //我的奖品
    $("#show_prize").click(function () {
        $.ajax({
            url: "ajax_activity.ashx",
            type: "post",
            dataType: "json",
            async: false,
            data: { Cmd: "GetRecordByUserId" },
            success: function (data) {
                if (data.result == "2") {
                    ShowMsg('您还未登录，登录之后才能抽奖', '登录', '/user/Login.aspx');
                } else if (data.result == "1") {
                    var message = '<span>恭喜您获得<span style="color:#ff790c">' + data.msg + '</span></span>';
                    var image = "";
                    if (data.msg.indexOf("pad") > 0) {
                        image = '<img src="imgs/prize6.png" class="no-prize"/>';
                    } else if (data.msg.indexOf("电源") > 0) {
                        image = '<img src="imgs/prize5.png" class="no-prize"/>';
                    } else if (data.msg.indexOf("U盘") > 0) {
                        image = '<img src="imgs/prize4.png" class="no-prize"/>';
                    } else if (data.msg.indexOf("15元") >= 0) {
                        image = '<img src="imgs/prize3.png" class="no-prize"/>';
                    } else if (data.msg.indexOf("10元") >= 0) {
                        image = '<img src="imgs/prize2.png" class="no-prize"/>';
                    } else if (data.msg.indexOf("5元") >= 0) {
                        image = '<img src="imgs/prize1.png" class="no-prize"/>';
                    }
                    showPrize(image, message);
                } else {
                    showPrize('<img src="imgs/prize0.png" class="no-prize"/>', '<span>您还没有奖品哦！</span>');
                }
            },
            error: function (a, b, c) {
                ShowMsg('查看奖品失败');
            }
        });
    });
})

////中奖弹窗
function closePopup() { $(".winPopupBox").remove(); }
function showResult(prize, img) {
    if (!$('winPopupBox').length) {
        $('.wrap').append('<div class="winPopupBox">' +
        '<div class="win-box">' +
        '<div class="popup-win">' +
        '<div class="win-cn">' + prize +
        '<div class="win-prize">' + img + '</div>' +
        '<img src="imgs/jb.png" alt="" class="jb"/>' +
        '<a href="javascript:;" class="share-but" id="shareBut"></a>' +
        '</div>' +
        '<a href="javascript:;" class="close-win" onclick="closePopup()"></a>' +
        '</div>' +
        '</div>' +
        '<div class="mask"></div>' +
        '</div>');
    }
    //分享
    var bd = document.body;
    var shareBut = document.getElementById("shareBut");

    var sharePopup = function (e) {
        if (!document.getElementById("shareTip")) {
            window.scrollTo(0, 0);
            var dom = document.createElement("div");
            dom.className = "modal-backdrop";
            dom.id = "shareTip";
            dom.innerHTML = '<div class="share-arrow"></div>';
            bd.appendChild(dom);
            dom.addEventListener("touchstart", clearShareTip, false);
        }
        return false;
    };
    function clearShareTip() {
        var shareTip = document.getElementById("shareTip");
        shareTip.removeEventListener("touchstart", clearShareTip, false);
        bd.removeChild(shareTip);
    }
    shareBut.onclick = sharePopup;
};
////我的奖品弹窗
function closePrize() { $(".prizePopupBox").remove(); }
function showPrize(img, prize) {
    if (!$('prizePopupBox').length) {
        $('body').append('<div class="prizePopupBox">' +
        '<div class="prize-box">' +
        '<div class="popup-prize">' +
        '<div class="prize-cn">' +
        '<div class="get-prize">' + img + '</div>' + prize +
        '</div>' +
        '<a href="javascript:;" class="close-prize" onclick="closePrize()"></a>' +
        '</div>' +
        '</div>' +
        '<div class="mask"></div>' +
        '</div>');
    }
};

////提示弹窗
function ShowMsg(msg, btnName, url) {
    $(".maskLayer").fadeIn();
    $("#msg").html(msg);
    $("#btnOk").html(btnName);
    $("#btnOk").click(function () {
        if (url != '' && url != undefined) {
            window.location = url;
        } else {
            Done();
        }
    });
    var bottom = (document.documentElement.clientHeight - document.getElementById("tip").offsetHeight) / 2;
    $("#tip").animate({
        bottom: bottom
    }, 200)
}

function Done() {
    $(".maskLayer").fadeOut();
    $("#tip").animate({
        bottom: "-430px"
    }, 200)
}