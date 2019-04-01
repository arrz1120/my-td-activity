/**
* Created by Allen on 2015/07/10
*/

function closeLayer2() {
    $(".layer").fadeOut();
} 
/////////////弹窗(仅模拟)
function showLayer(obj) {
    $(obj).fadeIn();
}
///////////关闭弹窗
function closeLayer(obj) {
    $(obj).fadeOut();
}
function showPopLayer(msg,friendmsg,buttonText,fn) {
    $("#divCakePrize").html(msg);
    $("#divYaoFriend").html(friendmsg != "" ? friendmsg : "<br/>");
    $("#shareBtn").text(buttonText);
    $("#shareBtn").unbind("click");
    $("#shareBtn").click(fn);
    $(".layer").fadeIn();
}
//分享好友
function shareToFriend() {
    closeLayer2();
//    if (ExtendKey == "") {
//      $(".layerCont").fadeOut();
//      $(".sharepop").fadeIn(); 
//    } else {
//    //领取蛋糕
//        window.location.href = "/Activity/ThreeYearCeleb/AuthIndex.aspx";
//    }
}
//直接进入我的页面
function goToMyPage() {
    closeLayer2();
    // window.location.href = "/Activity/ThreeYearCeleb/AuthIndex.aspx";
}
//进入触屏版首页
function goToAboutMe() {
    window.location.href = "/Index.aspx";
}
 
//音乐播放
$(".music").click(function () {
    if ($(".icon-music").attr("num") == "1") {
        $(".icon-music").removeClass("open");
        $(".icon-music").attr("num", "2")
        $(".music-span").css("display", "none");
        document.getElementById("aud").pause();
        $(".music_text").html("关闭");
        $(".music_text").addClass("show_hide");
        setTimeout(musicHide, 2000);
    } else {
        $(".icon-music").attr("num", "1");
        $(".icon-music").addClass("open");
        $(".music-span").css("display", "block");
        document.getElementById("aud").play();
        $(".music_text").html("开启");
        $(".music_text").addClass("show_hide");
        setTimeout(musicHide, 2000);
    }
    function musicHide() {
        $(".music_text").removeClass("show_hide");
    }
}); 




//点击做蛋糕
function startDoCake() {
    $.ajax({
        url: "/Activity/ThreeYearCeleb/AjaxHandler.ashx",
        type: "post",
        dataType: "json",
        async: false,
        data: {
            Cmd: "StartDoCake",
            code: code,
            ExtendKey: ExtendKey
        },
        success: function (json) {
            if (json.result == "1") {
                var text2 = "<p>马上邀请好友一起来参与</p><p>攒人气排行 · 赢苹果系大奖</p>";
                var btext = "分享好友";
                if (ExtendKey != "") {
                    text2 = " <p>马上领取我的蛋糕</p><p>赢苹果系大奖</p>";
                    btext = "领取我的蛋糕";
                }
                json.msg = json.msg.replace(".小橘夫", "他");
                json.msg = json.msg.replace("何碧", "他");
                showPopLayer(json.msg, text2, btext, shareToFriend);
                //刷新数据
                getSelfCakeNum();
                getMyPrizeList();
                getTopDoCakeUserRank(1);
                //考滤到已做过蛋糕
            } else if (json.result == "-1") {
                var text2 = "<p>马上分享更多好友，赢苹果系大奖</p>";
                if (ExtendKey == "") {
                    showPopLayer("<p>" + json.msg + "</p>", text2, "分享好友", shareToFriend);
                } else {
                    //领取自已的蛋糕
                    showPopLayer("<p>" + json.msg + "</p>", "", "领取我的蛋糕", shareToFriend);
                }
            } else if (json.result == "-2") {
                showPopLayer("<p>" + json.msg + "</p>", "", "确定", goToMyPage);
            }
            else {
                showPopLayer("<p>" + json.msg + "</p>", "", "确定", closeLayer2);
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            showPopLayer("<p>做蛋糕失败，请重试!</p>", "", "确定", closeLayer2);
        }
    });
    $("#btnStartCacke").click(startDoCake);
}
//获取用户已有蛋糕数
function getSelfCakeNum() {
    $("#lblCakeNum").html("0");
    $.ajax({
        url: "/Activity/ThreeYearCeleb/AjaxHandler.ashx",
        type: "post",
        dataType: "json",
        async: false,
        data: {
            Cmd: "GetSelfCakeNum",
            code: code,
            ExtendKey: ExtendKey
        },
        success: function (data) {
             $("#lblCakeNum").html(data.msg);
        },
         error: function (XMLHttpRequest, textStatus, errorThrown) {
             $("#lblCakeNum").html("0");
           // ShowMsg("获取蛋糕数量失败，请重试!");
        }
    });
}
//绑定到事件
function setSlideBarEvent() {
    //获取两个排行榜数据
    $("#slideBar1").find("li").click(function () {
        $(this).parent().find("li").removeClass("on");
        var pIndex = parseInt($(this).text());
        getTopDoCakeUserRank(pIndex);
    });

    $("#slideBar2").find("li").click(function () {
        $(this).parent().find("li").removeClass("on");
        var pIndex = parseInt($(this).text());
        getTopInvestUserRank(pIndex);
    });
}
//蛋糕排行榜前10名
function getTopDoCakeUserRank(page) {
    $.ajax({
        url: "/Activity/ThreeYearCeleb/AjaxHandler.ashx",
        type: "post",
        dataType: "json",
        async: true,
        data: {
            Cmd: "GetTopDoCakeUserRank",
            code: code,
            pageindex: page
        },
        success: function (jsonstr) {
            $("#cakeList").children().remove();
            $("#slideBar1").children().remove();
            var html = new Array();
            var str = "";
            if (jsonstr.status == "1") { 
                for (var i = 0; i < jsonstr.list.length; i++) {
                    var licss = "";
                    if (jsonstr.list[i].IsSelf == 1) {
                        licss = "class=\"my bg-ff9d00\"";
                    }
                    str = "<li " + licss + " >" +
                          " <span>" + jsonstr.list[i].RankNo + "</span>" +
                          " <span>" + (jsonstr.list[i].IsSelf == 1 ? "我" : jsonstr.list[i].NickName) + "</span>" +
                          " <span>" + jsonstr.list[i].CakeNum + "</span>" +
                          "</li> ";
                    html.push(str);
                }
                $("#cakeList").append(html.join(""));
                //加载分页控件
                var pageStr = "";
                for (var i = 1; i <= jsonstr.pagecount; i++) {
                    pageStr += "<li " + (page == i ? "class='on'" : "") + " >" + i + "</li>";
                }
                $("#slideBar1").append(pageStr);
            }
            else {
                $("#cakeList").append("<li style=\"text-align: center;color:#ff4f4e\">暂无数据!</li>");
                $("#slideBar1").append("<li class=\"on\">1</li>");
            }
            setSlideBarEvent();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            //  ShowMsg("加载数据失败，请重试!");
            $("#cakeList").children().remove();
            $("#slideBar1").children().remove();
            $("#cakeList").append("<li style=\"text-align: center;color:#ff4f4e\">暂无数据!</li>");
            $("#slideBar1").append("<li class=\"on\">1</li>");
        }
    });
}
//投资排行榜前10名
function getTopInvestUserRank(page) {
    $.ajax({
        url: "/Activity/ThreeYearCeleb/AjaxHandler.ashx",
        type: "post",
        dataType: "json",
        async: true,
        data: {
            Cmd: "GetTopInvestUserRank",
            code: code,
            pageindex: page
        },
        success: function (jsonstr) {
            $("#investList").children().remove();
            $("#slideBar2").children().remove();
            var html = new Array();
            var str = "";
            if (jsonstr.status == "1") {
                for (var i = 0; i < jsonstr.list.length; i++) {
                    var licss = "";
                    if (jsonstr.list[i].IsSelf == 1) {
                        licss = "class=\"my bg-3fa9f5\"";
                    }

                    str = "<li " + licss + " >" +
                        " <span>" + jsonstr.list[i].RankNo + "</span>" +
                        " <span>" + (jsonstr.list[i].IsSelf == 1 ? "我" : jsonstr.list[i].NickName) + "</span>" +
                        " <span>" + GetMoney(jsonstr.list[i].Amount) + "</span>" +
                        "</li> ";
                    html.push(str);
                }
                $("#investList").append(html.join(""));
                //加载分页控件
                var pageStr = "";
                for (var i = 1; i <= jsonstr.pagecount; i++) {
                    pageStr += "<li " + (page == i ? "class='on'" : "") + " >" + i + "</li>";
                }
                $("#slideBar2").append(pageStr);
            }
            else {
                $("#investList").append("<li style=\"text-align: center;color:#ff4f4e\">暂无数据!</li>"); 
                $("#slideBar2").append("<li class=\"on\">1</li>");
            }
            setSlideBarEvent();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            //  ShowMsg("加载数据失败，请重试!");
            $("#investList").children().remove();
            $("#slideBar2").children().remove();
            $("#investList").append("<li style=\"text-align: center;color:#ff4f4e\">暂无数据!</li>");
            $("#slideBar2").append("<li class=\"on\">1</li>");
        }
    });
}
function getMyPrizeList() {
    $.ajax({
        url: "/Activity/ThreeYearCeleb/AjaxHandler.ashx",
        type: "post",
        dataType: "json",
        async: true,
        data: {
            Cmd: "GetMyPrizeList",
            code: code
        },
        success: function (jsonstr) {
            $("#prizeList").children().remove(); 
            if (jsonstr.result == "1") {
                $("#prizeList").append(jsonstr.msg);
            }
            else {
                $("#prizeList").append("<li style='text-align:center'>暂无获奖数据!</li>");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            //ShowMsg("加载数据失败，请重试!");
            $("#prizeList").children().remove();
            $("#prizeList").append("<li style='text-align:center'>暂无获奖数据!</li>");
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
//金额格式化并保留指定的小数位
function GetMoney(money) {
    var n = 2;
    money = parseFloat((money + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
    var l = money.split(".")[0].split("").reverse(),
    r = money.split(".")[1];
    t = "";
    for (i = 0; i < l.length; i++) {
        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
    }
    return t.split("").reverse().join("") + "." + r;
} 