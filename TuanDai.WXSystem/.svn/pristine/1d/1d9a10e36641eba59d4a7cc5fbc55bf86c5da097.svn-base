var jsonData = {};
var maxUnit = 0;
var nowUnit = 0;
var unitMoney = 0; //每笔单价
var isLogin = 0; 
var repeatInvestType = 0; //复投方式 1：本息复投 2：本金复投
var browser = {
            versions: function () {
                var u = navigator.userAgent, app = navigator.appVersion;
                return { //移动终端浏览器版本信息
                    ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                    android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或uc浏览器
                    iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
                    iPad: u.indexOf('iPad') > -1 //是否iPad
                };
            }()
        }

//投资页面 底部通用上滑投资表单
$(function () {
    var initNavSuccess = false;
    function show() {
        if (initNavSuccess) {
            return;
        } 
        getUserAviMoney();
        if (isWeFQB == "1")
            repeatInvestType = 1;
        //计算收益
        var expectMoney = CalcChanges(nowUnit);

 var html =  
           '<section class="automaticwayBox pt15 clearfix" id="tip" style="bottom: -390px; padding: 10px 15px;">'+
           '<div class="hbody clearfix" style="margin-bottom: 9px;">'+
           '<i class="ico-exclamation40 lf mr10"></i>'+
           '<span id="msg" style="  font-size: 14px;line-height: 39px;"></span>'+
           '</div>'+
           '<div class="completeBox clearfix">'+
           '<span style="float: right;max-width: 45%;">'+
           '  <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>' + 
           '</span>'+
           '<span style="float: right;max-width: 55%;padding-right: 10px;">'+
           '  <a href="javascript:Done();" class="btn btnGreen h40"  id="btnCancel"  style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">取消</a>' +
            '</span>'+
            '</div>'+
            '</section>'+  
            '<div class="maskLayer hide"></div>' +
             GetShowTZMsg() + 
            '<div class="invest-form-bg" ></div>' +
            '<div class="invest-form" ' + (isWeFQB == "1" ? 'style="height:350px;bottom:-350px;">' : 'style="height:300px;bottom:-300px;">') +
            '<div class="item1">' +
            '<div class="cn pos-r">' +
            '<p class="pos-a cn-l">可用余额:</p>' +
            '<div class="pos-a cn-r">' +
            '<span class="c-ff6600">' + fmoney(jsonData.AviMoney, 2) + '</span><span>元</span>';
            if(jsonData.IsLogin==1){
                html += '<a href="/Member/Bank/Recharge.aspx?ReturnUrl=' + window.location.href + '" class="recharge">充值</a>';
            }else{
                html+='<a href="javascript:window.location.href=\'/user/login.aspx?ReturnUrl=\'+location.href" class="recharge">登录</a>' ;
            }
            html += '</div>' +
                  '</div>' +
                  '</div>' +
                  '<div class="item1">' +
                  '<div class="cn pos-r">' +
                  '<p class="pos-a cn-l">认购份数:</p>' +
                  '<a href="javascript:void(0)" class="pos-a minus count-but" id="minus">' +
                  '<img src="/imgs/images/minus.png" alt=""/>' +
                  '</a>' +
                  '<div class="pos-a input-box">' +
                  '<input class="number-text" name="" type="text" value="1" id="invest_share" maxshares="">' +
                  '</div>' +
                  '<a href="javascript:void(0)" class="pos-a plus count-but" id="plus">' +
                  '<img src="/imgs/images/plus.png" alt=""/>' +
                  '</a>' +
                  '</div>' +
                  '</div>' +
                  '<div class="item2">' +
                  '<div class="cn pos-r">' +
                  '<p class="pos-a cn-l">预期收益:</p>' +
                  '<p class="pos-a cn-r c-ff6600" id="profit">' + fmoney(expectMoney, 2) + '<span>元</span></p>' +
                  '</div>' +
                  '</div>';
            if (isWeFQB == "1") {
                html += '<div class="item2">' +
				'<div class="pos-r" style="z-index: 301;">' +
				'	<p class="pos-a cn-l">复投方式:</p>' +
				'	<div class="pos-a reInvest">' +
				'		<div class="reInvest1 f14px c-ababab pos-r"><p class="f14px c-ababab">本息复投</p><div class="arrowDown"></div></div>' +
				'		<div class="reInvest2 f13px c-ababab bt-e5e5e5 hide"><p class="f13px c-ababab">本金复投</p></div>' +
				'	</div>' +
				'</div>' +
			    '</div>'; 
            }

        html += '<div class="item2">' +
               ' <div class="cn pos-r">' +
               ' <p class="pos-a cn-l">实际支付:</p>' +
               ' <div class="pos-a cn-r">' +
               ' <p class="c-ff6600 f16px" id="payamount">0.00<span>元</span></p>' +
               ' </div>' +
               ' </div>' +
               ' </div>' +
               ' <a href="javascript:void(0)" class="invest-but">马上加入</a>' +
               ' </div>'; 
        $('footer').before(html);

        //实际支付
        var realM = jsonData.LowerUnit * nowUnit;
        $("#payamount").html(fmoney(realM, 2) + "<span>元</span>");

        var isOpen = false;

        $('.loan-button').click(function () { 
            if (isOpen) {
                $('.invest-form').animate({
                    'bottom': '-350px'
                });

                $('.invest-form-bg').hide();
                $('.invest-form-bg').animate({
                    opacity: 0
                });
                $('.invest-form-bg').hide();
                isOpen = false;
            } else {

                $('.invest-form').animate({
                    'bottom': '0px'
                });

                $('.invest-form-bg').show();
                $('.invest-form-bg').css({
                    opacity: 0
                });
                
                isOpen = true;
            }

        }); 

        $('.invest-form-bg').bind('touchstart', function (e) {
            e.preventDefault();

            $('.invest-form').animate({
                'bottom': '-350px'
            });

            $('.invest-form-bg').hide();
            $('.invest-form-bg').animate({
                opacity: 0
            });
            $('.invest-form-bg').hide();
            isOpen = false;
        });  
        initNavSuccess = true;
    }
    $(".dropdownTit").click(function () {
        var next = $(this).next();
        var triangle = $(this).find('i');
        if (next.hasClass('hide')) {
            triangle.removeClass('rotate0');
            next.removeClass('hide');
        } else {
            triangle.addClass('rotate0');
            next.addClass('hide');
        }
    });

    show();
});

$(function () { 
    //减去
    $("#minus").click(function () {
        var obj = $("#invest_share");
        var currentShare = $(obj).val().toString().replace("份", "").replace(" ", "");
        if (currentShare > 1) {
            AddOrSubtract('Minus');
        }
    });
    //增加
    $("#plus").click(function () {
        var obj = $("#invest_share");
        var currentShare = $(obj).val().toString().replace("份", "").replace(" ", "");
        if (currentShare != $(obj).attr("maxShares")) {
            AddOrSubtract('Plus');
        }
    });
    //格式化输入份数 
    $("#invest_share").keyup(function () {
        $this = $(this);
        var thevalue = $this.val().toString().replace(/[^\d]+/, "");
        $this.val(thevalue);
        $("#invest_share").val(thevalue);
        if (parseInt($this.val()) == "") {
            $this.val("1");
        }
        if (parseInt($this.val()) <= 0) {
            $this.val("1");
        }
        if (parseInt($this.val()) > parseInt(maxUnit)) {
            $(this).val(maxUnit); 
        }
        CalcChanges($this.val());
    });

    $("#invest_share").change(function (e) {
        if (parseInt($this.val()) >= parseInt(maxUnit)) {
            $(this).val($this.val());
            CalcChanges(maxUnit);
            return;
        }
    });
    $("#invest_share").blur(function () {
        if ($(this).val() == "") {
            $(this).val("1");
        }
        CalcChanges($(this).val());
    });

    //加入按钮事件
    $(".invest-but").click(function () {
        if ("" == $("#invest_share").val()) {
            $("#invest_share").focus();
            return;
        }
        var nowUnit = $("#invest_share").val().replace("份", "").replace(" ", "");
        if (parseInt(nowUnit) < 1) {
            nowUnit = 1;
        }
        if ('' == nowUnit) {
            nowUnit = maxUnit;
        } else {
            nowUnit = parseInt(nowUnit);
        }
        buyWePlan();
    });
    //复投方式 点击事件 开始 
    if (isWeFQB == "1") {
        //复投方式 点击事件 开始
        var reInvest1 = $(".reInvest1"), reInvest2 = $(".reInvest2"); 
        reInvest1.click(function () {
            if (reInvest2.hasClass('hide')) {
                reInvest1.find('.arrowDown').css('transform', 'rotateZ(180deg)');
                reInvest2.removeClass('hide'); 
            }
            else {
                reInvest1.find('.arrowDown').css('transform', 'rotateZ(0)');
                reInvest2.addClass('hide'); 
            } 
        });
        reInvest2.click(function () {
            var tmpRepeatType = repeatInvestType;
            reInvest1.find('.arrowDown').css('transform', 'rotateZ(0)');
            reInvest2.addClass('hide');
            var p1 = reInvest1.find('p'),
                txt1 = p1.html(),
                p2 = reInvest2.find('p'),
                txt2 = p2.html();
            p1.html(txt2);
            p2.html(txt1);
            if (txt2 == "本息复投")
                repeatInvestType = 1;
            else
                repeatInvestType = 2;
            if (tmpRepeatType != repeatInvestType)
                CalcChanges(parseInt($("#invest_share").val())); 
        });
        //复投方式 点击事件 结束 
    }
    //We计划倒计时
    fnTimeCountDown();
});

//获取用户金额
function getUserAviMoney() {
    $.ajax({
        type: "post",
        async: false,
        url: "/ajaxCross/InvestAjax.ashx",
        data: { cmd: "GetUserWePlanMoney", projectId: projectId },
        dataType: "json",
        timeout: 3000,
        success: function (json) {
            var result = json.result;
            if (result == "1") {
                eval("jsonData =" + json.msg);
                if (jsonData.IsLogin == 1) {
                    $("#spAviMoney").text(fmoney(jsonData.AviMoney, 2) + "元");
                }
                nowUnit = 1;
                maxUnit = jsonData.MaxUnit;
                unitMoney = jsonData.LowerUnit;
                isLogin = jsonData.IsLogin; 
                //计算收益
                CalcChanges(1);
            }
            else {
                alert(json.msg);
            }
        },
        error: function () {
        }
    });
}

function buyWePlan() {
    var tendValue = $("#invest_share").val().replace(" ", "");
    if (isLogin==0) {
        ShowMsg('您未登录，请先登录!', '1', '马上登录', '/user/Login.aspx?ReturnUrl=' + window.location.href);   
    }
    else {
        nowUnit = parseInt(tendValue);
        if (jsonData.AviMoney < jsonData.LowerUnit) {
            ShowMsg('您的可用金额不足，请充值!', '1', '立即充值', '/Member/Bank/Recharge.aspx?ReturnUrl='+window.location.href);
            return;
        }
        if (nowUnit > jsonData.MaxUnit) {
            ShowMsg('投标份数超出最大份数:' + jsonData.MaxUnit, '0', '', '');
            return;
        }
        PostFinalDataNew(nowUnit); 
    }
}
//弹出申购层
function PostFinalDataNew(tendValue) {
    $("#dvPopmsg").show();
    $.ajax({
        url: "/ajaxCross/InvestAjax.ashx",
        type: "post",
        async: true,
        dataType: "json",
        data: { Cmd: "BuyWePlan", ProductId: projectId, BuyQty: tendValue, RepeatInvestType: repeatInvestType },
        success: function (json) {
            var d = json.result;
            var msg = json.msg;
            $("#dvPopmsg").hide();
            if (d == "1") { 
                var tipContent = "恭喜您，申请成功！<br/>加入We计划“" + parseInt(tendValue) * parseInt(unitMoney) + "”元！";
                ShowMsg(tipContent, '1', '确定', 'javascript:window.location.href="' + location.href + '"');
                $("#btnCancel").parent().hide(); 
            } else if (d == "-11") {
                ShowMsg("您的可用金额不足，请充值!", '1', '确定', '/Member/Bank/Recharge.aspx?ReturnUrl='+window.location.href);
            } else if (d == "-3") {
                dialogTip("购买失败：" + msg);
            } else if (d == "-99") {
                ShowMsg("您好，请先登录后再进行投标操作。", '1', '马上登录', "/user/Login.aspx?ReturnUrl=" + window.location.href);
            } else if (d == "-7" || d == "-8") {
                ShowMsg("为保证您的合法权益,请完成所有信息验证之后进行投标！", '1', '确定', "/Member/safety/safety.aspx");
            } else {
                dialogTip(msg);
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            $("#dvPopmsg").hide();
            ShowMsg('投标失败!', '0', '', '');
        }
    });
}
//加减项事件
function AddOrSubtract(type) {
    var oldUnit = 0;
    nowUnit = $("#invest_share").val();
    if ('' == nowUnit) {
        oldUnit = 0;
    } else {
        oldUnit = parseInt(nowUnit);
    }
    if ('Plus' == type) {
        if (parseInt(oldUnit) >= parseInt(maxUnit)) {
            return;
        }
        else {
            nowUnit = parseInt(oldUnit) + 1;
        } 
    } else if ('Minus' == type) {
        nowUnit = parseInt(oldUnit) - 1;
        if (parseInt(nowUnit) < 1) {
            return;
        }
    }

    $("#invest_share").val(nowUnit);
    if (nowUnit != oldUnit) {
        CalcChanges(nowUnit);
    }
}

//计算收益
function CalcChanges(nowUnit) {
    if ($("#invest_share").length > 0) {
        var txt = $("#invest_share").val().trim().replace(/,/g, "");
        nowUnit = txt.replace("份", "").replace(" ", "");
    }
    var theYearRate = jsonData.InterestRate;
    if (isWeFQB == "1") {
        if (repeatInvestType == 1)
            theYearRate = jsonData.InterestRate;
        else
            theYearRate = jsonData.MaxYearRate2;
    }
    //预期收益 
    var expentMoney = parseFloat(unitMoney) * parseFloat(nowUnit) * theYearRate / 100 * parseFloat(jsonData.Deadline) / 12;
    $("#profit").html(fmoney(expentMoney, 2) + "<i class=\"f14px c-ababab\">元</i>");
    //实际支付
    var jMoney = parseInt(unitMoney) * parseInt(nowUnit);
    $("#payamount").html(fmoney(jMoney, 2) + "<i class=\"f14px c-ababab\">元</i>");
    return expentMoney;
}

function dialogTip(str) {
    ShowMsg(str, '0', '', '');
} 

//弹出层事件
function Done() {
    $(".maskLayer").fadeOut(); 

    $("#tip").animate({
        bottom: "-430px"
    }, 200)
}
function ShowMsg(msg, isShowOk, okValue, url, cancelValue,url2) {
    $(".maskLayer").fadeIn();
    $("#msg").html(msg);
    if (isShowOk == "1") {
        $("#btnOk").html(okValue);
        $("#btnOk").attr("href", url);
        if (cancelValue != "") {
            $("#btnCancel").html(cancelValue);
            $("#btnCancel").attr("href", url2);
        } else {
            $("#btnCancel").html("取消");
            $("#btnCancel").attr("href", "javascript:Done();");
        }
        $("#btnOk").parent().show();
        $("#btnCancel").parent().show();
    } else {
        $("#btnOk").parent().hide();
        $("#btnCancel").val("确定");
        $("#btnCancel").attr("href", "javascript:Done();");
    }
    var bottom = (document.documentElement.clientHeight - document.getElementById("tip").offsetHeight) / 2; 

    $("#tip").animate({
        bottom: bottom
    }, 200)
}
function GetShowTZMsg() {
    return '<div class="alert" style="display:none;z-index:1000;" id="dvPopmsg"><div class="loadTips"><div class="loadingCirle"></div><div class="yan"><img src="/imgs/images/yan.png" alt="" /></div><div class="loadTips_txt"><h3>投资中，请稍等...</h3><p>成功后可在\"我的投资\"中查看记录</p></div></div></div>';
};


/*we计划开放倒计时  start*/
function zero(n) {
    var n = parseInt(n, 10);
    if (n > 0) {
        if (n <= 9) {
            n = "0" + n;
        }
        return String(n);
    } else {
        return "00";
    }
}
function dv(tcount) {
    var sec = zero(tcount % 60);
    var mini = Math.floor((tcount / 60)) > 0 ? zero(Math.floor((tcount / 60)) % 60) : "00";
    var hour = Math.floor((tcount / 3600)) > 0 ? parseInt(tcount / 3600) % 24 : "00";
    var day = Math.floor((tcount / 86400)) > 0 ? parseInt(Math.floor((tcount / 86400))) : "0";
    return "<span style='color: #ffffff;font-size:16px;'>" + hour + "</span>小时<span style='color: #ffffff;font-size:16px;'>" + mini
    + "</span>分<span style='color: #ffffff;font-size:16px;'>" + sec + "</span>秒";
}

function fnTimeCountDown() {
    $(".timeSet").each(function () {
        var timecount = parseInt($(this).attr("count"));
        if (timecount >= 0) {
            $(this).html(dv(timecount));
            if (timecount == 0) {
                var content = $(this).parent().html();
                if (content.indexOf("离开放还有") >= 0) {
                    $(this).parent().removeClass("buy-btn-time");
                    $(this).parent().html("马上加入");
                }
            }
            timecount = timecount - 1;
            $(this).attr("count", timecount);
        }
    });
    setTimeout("fnTimeCountDown()", 1000);
}
/*we计划开放倒计时  end*/