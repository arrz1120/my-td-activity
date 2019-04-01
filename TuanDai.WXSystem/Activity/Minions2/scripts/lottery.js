$(function () {

    var length = $(".scroll-row").length;
    var speed = 0.5 * length;
    if (length > 3) {
        $(".anit").css({
            "-webkit-animation-duration": speed + "s",
            "animation-duration": speed + "s",
        });
    }

    $(".button-5").off('click').on('click', function () {
        return;
        var top = document.body.scrollTop;
        var popTop;

        //检测该用户是否已经关注团贷网微信服务号.
        var isSubscribed = $("#isSubscribed").val();
        if (isSubscribed == "0") {
            if (top > 0) {
                popTop = top + $(".popup-4").offset().top / 6;
                $(".popup-4").attr("style", "display:block;top:" + popTop + "px;");
            }
            $(".mask").show();
            $(".pop1").hide();
            $(".pop2").hide();
            $(".pop3").hide();
            $(".pop4").show();
            disableScrolling();
            return;
        }

        //检测该用户是否已经登录.
        var isLogin = $("#isLogin").val();
        if (isLogin == "0") {
            var url = "/user/Login.aspx?ReturnUrl=" + window.location.href;
            window.location.href = url;
            return;
        }

        //检测该用户是否符合抽奖条件.
        var isEverBind = $("#isEverBind").val();
        var totalChances = $("#totalChances").val();
        var chances = $("#chances").val();
        if ((isEverBind == 0 && totalChances < 2 && chances < 1) ||
            (isEverBind == 1 && totalChances < 1)) {
            if (top > 0) {
                popTop = top + $(".popup-2").offset().top / 6;
                $(".popup-2").attr("style", "display:block;top:" + popTop + "px;");
            }
            $(".mask").show();
            $(".pop1").hide();
            $(".pop2").show();
            $(".pop3").hide();
            $(".pop4").hide();
            disableScrolling();
            return;
        }

        //检测该用户是否还有抽奖机会.
        if (chances < 1) {
            $(".mask").show();
            $(".pop1").hide();
            $(".pop2").hide();
            $(".pop3").show();
            $(".pop4").hide();
            if (top > 0) {
                popTop = top;
                $(".popup-3").attr("style", "display:block;top:" + popTop + "px;");
            }
            disableScrolling();
            return;
        }

        $(".icon-handle").addClass('handle-anite');

        //开始抽奖
        $(".minion-left").html('<div class="sprite-icon-minion-1 "></div><div class="sprite-icon-minion-2 "></div><div class="sprite-icon-minion-3 "></div>');
        $(".minion-left div").addClass("minion");
        setTimeout(function () {
            $(".minion-middle").html('<div class="sprite-icon-minion-1 "></div><div class="sprite-icon-minion-2 "></div><div class="sprite-icon-minion-3 "></div>');
            $(".minion-middle div").addClass("minion");
        }, 500);
        setTimeout(function () {
            $(".minion-right").html('<div class="sprite-icon-minion-1 "></div><div class="sprite-icon-minion-2 "></div><div class="sprite-icon-minion-3 "></div>');
            $(".minion-right div").addClass("minion");
        }, 1000);

        setTimeout(function () {

            $.ajax({
                url: "Prize.aspx?Action=GetPrize",
                type: "post",
                dataType: "json",
                data: {},
                success: function (result) {
                    if (!result.Success) {

                        $(".minion-left .minion").addClass("stop");
                        $(".minion-left").html('<div class="sprite-icon-minion-1"></div>');
                        setTimeout(function (e) {
                            $(".minion-middle .minion").addClass("stop");
                            $(".minion-middle").html('<div class="sprite-icon-minion-1"></div>');
                        }, 500);
                        setTimeout(function (e) {
                            $(".minion-right .minion").addClass("stop");
                            $(".minion-right").html('<div class="sprite-icon-minion-1"></div>');
                        }, 1000);

                        setTimeout(function (e) {
                            alert(result.Message);
                        }, 1000);
                    }
                    else {
                        setTimeout(function (e) {

                            $("#chances").val(result.Chances);

                            //抽奖结束
                            var selected = result.Codes;
                            $(".minion-left .minion").addClass("stop");
                            $(".minion-left").html('<div class="sprite-icon-minion-' + selected[0] + '"></div>');
                            setTimeout(function (e) {
                                $(".minion-middle .minion").addClass("stop");
                                $(".minion-middle").html('<div class="sprite-icon-minion-' + selected[1] + '"></div>');
                            }, 500);
                            setTimeout(function (e) {
                                $(".minion-right .minion").addClass("stop");
                                $(".minion-right").html('<div class="sprite-icon-minion-' + selected[2] + '"></div>');
                            }, 1000);

                            setTimeout(function () {

                                var top = document.body.scrollTop;
                                if (result.Type == 9) {
                                    if (top > 0) {
                                        popTop = top + $(".popup-1").offset().top / 6;
                                        $(".popup-1").attr("style", "display:block;top:" + popTop + "px;");
                                    }

                                    $("#msg").text("送您一张" + result.PrizeName + "哦！");
                                    $(".mask").show();
                                    $(".pop1").show()
                                    $(".pop2").hide();
                                    $(".pop3").hide();
                                    $(".pop4").hide();
                                    $(".pop5").hide();
                                } else {
                                    if (top > 0) {
                                        popTop = top + $(".popup-5").offset().top / 6;
                                        $(".popup-5").attr("style", "display:block;top:" + popTop + "px;");
                                    }

                                    $(".mask").show();
                                    $(".pop1").hide();
                                    $(".pop2").hide();
                                    $(".pop3").hide();
                                    $(".pop4").hide();
                                    $(".pop5").show();
                                }

                                disableScrolling();
                            }, 1500);

                            $(".icon-handle").removeClass('handle-anite');
                        }, 2000);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });

        }, 1000);
    });

    $(".button-1").off("click").on("click", function (e) {
        var url = "/Member/UserPrize/Index.aspx";
        window.location.href = url;
    });

    $(".button-3").off("click").on("click", function (e) {
        var url = "/pages/invest/invest_list.aspx";
        window.location.href = url;
    });

    $(".button-4").off("click").on("click", function (e) {
        var url = "/Member/UserPrize/Index.aspx";
        window.location.href = url;
    });

    $(".close-pop1,.close-pop2,.close-pop3,.close-pop4,.close-pop5").on("click", function () {
        $(".mask").hide();
        $(".pop1").hide();
        $(".pop2").hide();
        $(".pop3").hide();
        $(".pop4").hide();
        $(".pop5").hide();
        enableScrolling();

        if ($(this).hasClass('close-pop4')) {
            document.body.scrollTop = document.body.scrollHeight;
        }

        if ($(this).hasClass("close-pop1")) {
            window.location.href = window.location.href;
        }

        if ($(this).hasClass("close-pop5")) {
            window.location.href = window.location.href;
        }
    });
    $(".txt-title").off("click").on("click", function (e) {
        var target = $(e.currentTarget);
        var arrow = target.find("i");
        if (arrow.hasClass("up")) {
            arrow.removeClass("up");
            $(".icon-rule").addClass("hidden");
        } else {
            arrow.addClass("up");
            $(".icon-rule").removeClass("hidden");
        }
    });

    function scrolling(e) {
        preventDefault(e);
    }

    function preventDefault(e) {
        e = e || window.event;
        if (e.preventDefault) {
            e.preventDefault();
        }
        e.returnValue = false;
    }

    function disableScrolling() {
        if (window.addEventListener) {
            window.addEventListener('DOMMouseScroll', scrolling, false);
            window.addEventListener('touchmove', scrolling, false);
            window.onmousewheel = document.onmousewheel = scrolling;
            // document.onkeydown = keydown;
        }
    }

    function enableScrolling() {
        if (window.removeEventListener) {
            window.removeEventListener('DOMMouseScroll', scrolling, false);
            window.removeEventListener('touchmove', scrolling, false);
        }
        // window.onmousewheel = document.onmousewheel = document.onkeydown = null;
        window.onmousewheel = document.onmousewheel = null;
    }
});