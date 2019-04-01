/**
 * Created by Allen on 2015/4/28.
 */ 
var jsonData = {}; //投资项目信息及用户金额 
var oMoney = null; 
var Unit_expected = 0;
var Unit_commission = 0;
var PublicRate = 0;
var TuandaiRate = 0;
var LowerUnit = 0;
var maxUnit = 0;
var nowUnit = 0;
var perAmout = 0;
var RewardAmount = 0;
var tranpwd = "";
var isLogin = 0;
var deadLine = 12;
var NewHandRate = 0;
//是否私募宝浮动收益
var isSmbFloat = false;


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

                $.ajax({
                    type: "post",
                    async: false,
                    url: "/ajaxCross/InvestAjax.ashx",
                    data: { cmd: "GetUserInvestMoney", projectId: projectId },
                    dataType: "json",
                    timeout: 3000,
                    success: function (json) {
                        var result = json.result;
                        if (result == "1") {
                            eval("jsonData =" + json.msg);
                        }
                        else {
                            alert(json.msg);
                        }
                    },
                    error: function () {
                    }
                });

                //if (jsonData.MaxUnit == "0" && jsonData.IsLogin == "1") {
                //    $(".loan-button").css('background-color', '#d5d5d5');
                //    return;
                //}
                nowUnit = 1;
                Unit_expected = jsonData.Expected / nowUnit;
                Unit_commission = jsonData.CommissionMoney / nowUnit;
                PublicRate = jsonData.PublisherRate;
                TuandaiRate = jsonData.TuandaiRate;
                perAmout = jsonData.perAmout;
                RewardAmount = jsonData.RewardAmount;
                maxUnit = jsonData.MaxUnit;
                LowerUnit = jsonData.LowerUnit;
                NewHandRate = jsonData.NewHandRate;
                isLogin = jsonData.IsLogin;
                if (jsonData.DeadType == 2) {
                    deadLine = 365;
                }
                //计算收益
                var expectMoney = CalcChangesNew(nowUnit);

                var html =
            '<section class="automaticwayBox pt15 clearfix" id="tip" style="bottom: -390px; padding: 10px 15px;">' +
            '<div class="hbody clearfix" style="margin-bottom: 9px;">' +
            '<i class="ico-exclamation40 lf mr10"></i>' +
            '<span id="msg" style="  font-size: 14px;line-height: 39px;"></span>' +
            '</div>' +
            '<div class="completeBox clearfix">' +
            ' <span style="float: right;max-width: 45%;">' +
            ' <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>' +
            '</span>' +
            '<span style="float: right;max-width: 55%;padding-right: 10px;">' +
            ' <a href="javascript:Done();" class="btn btnGreen h40"  id="btnCancel"  style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">取消</a>' +
            '</span>' +
            '</div>' +
            '</section>' +
            '<div class="maskLayer hide"></div>' +
            GetShowTZMsg() +
            '<div class="invest-form-bg" ></div>' +
            '<div class="invest-form">' +
            '<div class="item1">' +
            '<div class="cn pos-r">' +
            '<p class="pos-a cn-l">可用余额:</p>' +
            '<div class="pos-a cn-r">' +
            '<span class="c-ff6600">' + fmoney(jsonData.AviMoney, 2) + '</span><span>元</span>';
                if (jsonData.IsLogin == 1) {
                    html += '<a href="/Member/Bank/Recharge.aspx?ReturnUrl='+window.location.href+'" class="recharge">充值</a>';
                } else {
                    html += '<a href="javascript:window.location.href=\'/user/login.aspx?ReturnUrl=\'+location.href" class="recharge">登录</a>';
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
                    '<input class="number-text" name="" type="tel" value="1" id="invest_share" maxshares="" onpaste="return false" oncontextmenu="return false" oncopy="return false" oncut="return false">' +
                    '</div>' +
                    '<a href="javascript:void(0)" class="pos-a plus count-but" id="plus">' +
                    '<img src="/imgs/images/plus.png" alt=""/>' +
                    '</a>' +
                    '</div>' +
                    '</div>' +
                    '<div class="item2">' +
                    '<div class="cn pos-r">' ;  
                    if (jsonData.ProfitType == 1) {
                        isSmbFloat = true;
                        html += '<p class="pos-a cn-l">预期年利率:</p><p class="pos-a cn-r c-ff6600" id="profit">' + jsonData.PreProfitRate_S + '~' + jsonData.PreProfitRate_E+ '<span>%</span></p>' +
                                '</div></div>';
                    } else if (jsonData.ProjectType == 23) {
                        //项目宝浮动
                        isSmbFloat = true;
                        html += '<p class="pos-a cn-l">预期年利率:</p><p class="pos-a cn-r c-ff6600" id="profit">' + jsonData.XmbMinInterestRate + '~' + jsonData.XmbMaxInterestRate + '<span>%</span></p>' +
                                '</div></div>';
                    } else {
                        html += '<p class="pos-a cn-l">预期收益:</p><p class="pos-a cn-r c-ff6600" id="profit" >' + fmoney(expectMoney, 2) + '<span>元</span></p>' +
                                '</div></div>';
                    } 

                html += '<div class="item2">' +
               ' <div class="cn pos-r">' +
               ' <p class="pos-a cn-l">实际支付:</p>' +
               ' <div class="pos-a cn-r">' +
               ' <p class="c-ff6600 f16px" id="payamount">0.00<span>元</span></p>' +
               ' </div>' +
               ' </div>' +
               ' </div>' +
               ' <a href="javascript:void(0)" class="invest-but">马上投资</a>' +
               ' </div>';

                html += '<div style="margin: 15px 10px; font-size: 14px; text-align: left; width: 100%; display: none;"  id="dvpaypwd">' +
               '您的交易密码：<span style="color: Red; display: none;" id="errPayPwd">交易密码错误</span>' +
               ' <div>' +
               '    <input type="password" id="txtPayPwd" style="width: 200px; height: 24px; border: 1px solid #ddd;' +
               '       font-size: 16px; font-weight: bold; line-height: 23px; margin: 5px 0;" /><br />' +
               '   你申请此项目需支付<span style="color: orange;" id="thePayAmount"></span>元！</div>' +
               '</div>';
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
                $(".invest-but").click(function () {
                    if ("" == $("#invest_share").val()) {
                        $("#invest_share").focus();
                        return;
                    }
                    var nowUnit = $("#invest_share").val().replace(" ", "");
                    if (parseInt(nowUnit) < 1) {
                        nowUnit = 1;
                    }
                    if ('' == nowUnit) {
                        nowUnit = jsonData.MaxUnit;
                    } else {
                        nowUnit = parseInt(nowUnit);
                    }
                    if (isLogin==0) {
                        ShowMsg('您还未登录，登录之后才能投资', '1', '登录', '/user/Login.aspx?ReturnUrl=' + window.location.href);
                    } else {
                        if (jsonData.AviMoney < jsonData.LowerUnit) {
                            ShowMsg('您的可用金额不足，请充值!', '1', '立即充值', '/Member/Bank/Recharge.aspx?ReturnUrl='+window.location.href);
                            return;
                        }
                        if (nowUnit > jsonData.MaxUnit) {
                            ShowMsg('投标份数超出最大份数:' + jsonData.MaxUnit, '0', '', '');
                            return;
                        }
                        PostFinalDataNew(projectId, parseInt(nowUnit) * parseFloat(jsonData.LowerUnit));
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
            show();
        });


//限制只能输入数字(不可以含有小数)
function limitInt(fn) {
    jQuery(fn).keydown(function (e) {
        // 注意此处不要用keypress方法，否则不能禁用　Ctrl+V 与　Ctrl+V,具体原因请自行查找keyPress与keyDown区分，十分重要，请细查
        if (((e.keyCode > 47) && (e.keyCode < 58)) || (e.keyCode == 9) || (e.keyCode == 8) || ((e.keyCode >= 96) && (e.keyCode <= 105))) {// 判断键值
            return true;
        } else {
            return false;
        } 
    }).focus(function () {
        this.style.imeMode = 'disabled';   // 禁用输入法,禁止输入中文字符
    });
}
//申请提交函数
var investlock = 0;
function PostFinalDataNew(id, tendValue) {
    if (parseInt(investlock) > 0) {
        investlock = parseInt(investlock) + 1;
        dialogTip("申购过于频繁,连续申购要超过30秒,请稍后重新申购！");
        if (parseInt(investlock) == 1) {
            window.setTimeout("fun_investlock()", 30000);
        }
        return;
    }
  
    //录入交易密码
    if (jsonData.IsNeedPayPwd == 1) {
        var vPayAmount = $("#payamount").text().replace("元", ""); 
        ShowPassMsg(vPayAmount,$("#dvpaypwd").html(), '1', '确定', 'javascript:inputPaypwdClick("'+id+'","'+tendValue+'");'); 
    } else {
        finishApplyInvest(id, tendValue);
    }
}
//输入交易密码后事件
function inputPaypwdClick(id,tendValue){
    var pwd = $("#txtPayPwd").val().trim();
    if (pwd == "") {
        $("#errPayPwd").html("请输入交易密码");
        $("#errPayPwd").css("display", "block");
        $("#txtPayPwd").focus(); 
        return false;
    }
    else {
        tranpwd = pwd; 
        Done();
        finishApplyInvest(id, tendValue);
    }
}


function finishApplyInvest(id, tendValue) {
    $("#dvPopmsg").show();
    //ShowMsg('正在投标中，请稍后...', '0', '', ''); 
    
    // 1手动投标（PC）,2手动投标（IOS）,3手动投标（Android）,4自动投标,5We计划
    devicesType=1;
    if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
        devicesType=2;
    }
    if (browser.versions.android) {
        devicesType=3;
    }
    investlock = 1;
    $.ajax({
        url: "/ajaxCross/InvestAjax.ashx",
        type: "post",
        dataType: "json",
        data: { Cmd: "addloan", bid: id, tendAmount: tendValue, TranPwd: tranpwd, DevicesType: devicesType, unit: $("#invest_share").val() },
        success: function (json) {  
            var d = json.result;
            var msg = json.msg;
            investlock = 0;
            $("#dvPopmsg").hide();
            if (d != "1") {
                if (d == "-22") {
                    ShowMsg('您的可用金额不足，请充值!', '1', '立即充值', '/Member/Bank/Recharge.aspx?ReturnUrl='+window.location.href);
                }
                else if (d == "-11") {
                   ShowMsg('为保证您的合法权益,请完成所有信息验证之后进行投标！', '1', '马上验证', '/Member/safety/safety.aspx');  
                }
                else if (d == "-99") { 
                   ShowMsg('您好，请先登录后再进行投标操作。', '1', '马上登录', '/user/Login.aspx?ReturnUrl=' + window.location.href);   
                }
                else {
                    dialogTip(msg);
                }
            }
            else if (d == "1") {
                ShowMsg('恭喜您，您投标<span style="color:red;">' + parseFloat(tendValue).toFixed(2) + '</span>元已经成功!', '1', '确定', 'javascript:window.location.href="' + location.href + '"');
                $("#btnCancel").parent().hide();
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            $("#dvPopmsg").hide();
            ShowMsg('投标失败!', '0', '', '');
        }
    });
}
function dialogTip(str) { 
      ShowMsg(str, '0', '', ''); 
}
function fun_investlock() {
    investlock = 0;
}
//申购页面函数
$(function () {
    //限制输入数字
    limitInt($("#invest_share"));
    //格式化输入份数 
    $("#invest_share").keyup(function () {
        $this = $(this);
        var thevalue = $this.val().toString().replace(/[^\d]+/, "");
        $this.val(thevalue);
        $("#invest_share").val(thevalue);
        if (parseInt($this.val()) == "") {
            $this.val("1");
        }
        if (/[\u4E00-\u9FA5]/i.test($this.val())) {
            $this.val("1");
        }
        if (parseInt($this.val()) <= 0) {
            $this.val("1");
        }
        if (parseInt($this.val()) > parseInt(maxUnit)) {
            $(this).val(maxUnit);
        }
        CalcChangesNew($this.val());
    });
    $("#invest_share").change(function (e) {
        if (parseInt($this.val()) >= parseInt(maxUnit)) {
            $(this).val($this.val());
            CalcChangesNew(maxUnit);
            return;
        }
    });
    $("#invest_share").blur(function () {
        if ($(this).val() == "") {
            $(this).val("1");
        }
        if (/[\u4E00-\u9FA5]/i.test($(this).val())) {
            $this.val("1");
        }
        CalcChangesNew($(this).val());
    });

    //减去
    $("#minus").click(function () {
        var obj = $("#invest_share");
        var currentShare = $(obj).val().replace("份", "").replace(" ", "");
        if (currentShare > 1) {
            AddOrSubtract('Minus');
        }
    });
    //增加
    $("#plus").click(function () {
        var obj = $("#invest_share");
        var currentShare = $(obj).val().replace("份", "").replace(" ", "");
        if (currentShare != $(obj).attr("maxShares")) {
            AddOrSubtract('Plus');
        }
    });
});

function GetMoney(amount) {
    if (amount.indexOf('.') > -1) {
        var len = amount.substr(amount.indexOf('.')).length;
        if (len == 2) {
            return amount + "0";
        }
        else {
            return amount;
        }
    } else {
        return amount + ".00";
    }
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
        CalcChangesNew(nowUnit);
    }
}
//最新的计算收益
function CalcChangesNew(nowUnit) {

    if ($("#invest_share").length > 0) {
        var txt = $("#invest_share").val().trim().replace(/,/g, "");
        nowUnit = txt.replace("份", "").replace(" ", "");
    }
    var InterestAmount = 0;
    if (nowUnit == "") {
        nowUnit = 0;
    }
    var profit = 0;
    var type = parseInt(jsonData.ProjectType); 
     profit=parseFloat(parseFloat(LowerUnit) * parseInt(nowUnit) * parseInt(jsonData.Deadline) * parseFloat(jsonData.InterestRate) / 100 / deadLine);
    
     if (type == 15 || type == 20) { //分期宝的奖励
         profit = GetInterestAmount((parseInt(nowUnit) * parseFloat(LowerUnit)), parseInt(jsonData.RepaymentType), parseInt(jsonData.Deadline), parseFloat(jsonData.InterestRate));
         var RewardRate = parseFloat(jsonData.PublisherRate) + parseFloat(jsonData.TuandaiRate) + parseFloat(NewHandRate);
         RewardAmount = GetInterestAmount((parseInt(nowUnit) * parseFloat(LowerUnit)), parseInt(jsonData.RepaymentType), parseInt(jsonData.Deadline), RewardRate);
     }
    profit = parseFloat(profit) + (nowUnit >= 1 ? parseFloat(RewardAmount) : 0);
    var expectedM = Math.floor(Number(profit) * 100) / 100;

    if (!isSmbFloat) {
        //预期收益
        $("#profit").html(fmoney(expectedM, 2) + "<span>元</span>");
    }
    //实际支付
    var realM = jsonData.LowerUnit * nowUnit;
    $("#payamount").html(fmoney(realM, 2) + "<span>元</span>"); 
    return expectedM;
}
//计算收益
function CalcChanges(nowUnit) {
    if ($("#invest_share").length > 0) {
        var txt = $("#invest_share").val().trim().replace(/,/g, "");
        nowUnit = txt.replace("份", "").replace(" ", "");
    }
    var InterestAmount = 0;
    if (nowUnit == "") {
        nowUnit = 0;
    }
    var Profit = GetInterestAmount((parseInt(nowUnit) * parseFloat(LowerUnit)), parseInt(jsonData.RepaymentType), parseInt(jsonData.Deadline), parseFloat(jsonData.InterestRate));
    var RewardAmount = parseFloat(RewardAmount * nowUnit); //团贷或借款人奖励金额
    if (isNaN(RewardAmount)) {
        RewardAmount = 0;
    }

    var type = parseInt(jsonData.ProjectType);
    if (type == 15) { //分期宝的奖励
        var RewardRate = parseFloat(jsonData.PublisherRate) + parseFloat(jsonData.TuandaiRate);
        RewardAmount = GetInterestAmount((parseInt(nowUnit) * parseFloat(LowerUnit)), parseInt(jsonData.RepaymentType), parseInt(jsonData.Deadline), RewardRate);
    }
    Profit = parseFloat(Profit) + parseFloat(RewardAmount);

    var expectedM = Math.floor(Number(Profit) * 100) / 100;
    if (!isSmbFloat)
    {
        //预期收益
        $("#profit").html(fmoney(expectedM, 2) +"<span>元</span>");
    }
    
    //实际支付
    var realM = jsonData.LowerUnit * nowUnit;
    $("#payamount").html(fmoney(realM, 2) + "<span>元</span>");
   // var Commission = Unit_commission * nowUnit;
    // $("#txtCommission").text(Round2(Commission));
    return expectedM;
}


/*
aaron
2015/03/16
计算预计收益
还款方式：0:不确定还款方式1:到期还本息2.每月付息到期还本3.每月等本等息4:先息后本5.每月等额本息6.满标付息7.等额本金
amount          申购金额
repaymentType   还款方式
deadline        还款期限
interestRate    申购利率
*/
function GetInterestAmount(amount, repaymentType, deadline, interestRate) {
    var interestAmount = 0.00;
    if (amount == "" || amount == "0" || repaymentType == "" || repaymentType == "0" || deadline == "" || deadline == "0" || interestRate == "" || interestRate == "0")
        return interestAmount;
    switch (repaymentType) {
        case 1:
        case 2:
        case 3: 
            {
                interestAmount = amount * interestRate * 0.01 / deadLine * deadline;
                interestAmount = Math.floor(Number(interestAmount) * 100) / 100;
                break;
            }
        case 5:
            {
                var monthRate = interestRate * 0.010000000000 / 12.00;
                var tempAmount = 0.00, tempInterestAmount = 0.00, tempAmountAndInterest = 0.00, totalInterest = 0.00, totalAmount = 0.00;
                var index = 1;
                while (index <= deadline) {
                    tempAmount = Number(amount * monthRate * Math.pow(1 + monthRate, index - 1) / (Math.pow(1 + monthRate, deadline) - 1)).toFixed(4);
                    tempAmountAndInterest = Number(amount * monthRate * Math.pow(1 + monthRate, deadline) / (Math.pow(1 + monthRate, deadline) - 1)).toFixed(4);
                    tempInterestAmount = Number(tempAmountAndInterest - tempAmount).toFixed(4);
                    if (index == deadline) {
                        tempAmount = Number(amount) - Number(totalAmount);
                        tempInterestAmount = Number(tempAmountAndInterest - tempAmount);
                    }
                    totalInterest += Number(tempInterestAmount);
                    totalAmount += Number(tempAmount);
                    index++;
                } 
                interestAmount = Math.floor(Number(totalInterest) * 100) / 100;
                break;
            }
        case 6:
            {
                interestAmount = amount * interestRate * 0.01 / 365 * deadline; 
                interestAmount = Math.floor(Number(interestAmount) * 100) / 100;
                break;
            } 
        default:
            {
                interestAmount = amount * interestRate * 0.01 / 12 * deadline; 
                interestAmount = Math.floor(Number(interestAmount) * 100) / 100;
                break;
            }
    }
    return interestAmount;
}
//弹出层事件
function Done() {
    $(".maskLayer").fadeOut(); 
    $("#tip").animate({
        bottom: "-430px"
    }, 200);
}
function ShowMsg(msg, isShowOk, okValue, url,cancelValue,url2) {
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
    }else {
        $("#btnOk").parent().hide(); 
        $("#btnCancel").val("确定");
        $("#btnCancel").attr("href", "javascript:Done();");
    }
    var bottom = (document.documentElement.clientHeight -document.getElementById("tip").offsetHeight) / 2; 
    $("#tip").animate({
        bottom: bottom
    }, 200);
}
function ShowPassMsg(payVal,msg, isShowOk, okValue, url){
    $(".maskLayer").fadeIn();
    $("#msg").html(msg);
    $("#thePayAmount").html(payVal);
    if (isShowOk == "1") {
        $("#btnOk").html(okValue);
        $("#btnOk").attr("href", url);
        $("#btnCancel").val("取消");
        $("#btnCancel").attr("href", "javascript:Done();");
        $("#btnOk").parent().show();
    } else {
        $("#btnOk").parent().hide();
        $("#btnCancel").val("确定");
    } 
    $("#tip").animate({
        bottom: "0px"
    }, 200);
}

function GetShowTZMsg() {
    return '<div class="alert" style="display:none;z-index:1000;" id="dvPopmsg"><div class="loadTips"><div class="loadingCirle"></div><div class="yan"><img src="/imgs/images/yan.png" alt="" /></div><div class="loadTips_txt"><h3>投资中，请稍等...</h3><p>成功后可在\"我的投资\"中查看记录</p></div></div></div>';
};