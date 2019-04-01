﻿var jsonData = {}; //投资项目信息及用户金额 
var oMoney = null;
var Unit_expected = 0;
var Unit_commission = 0;
var PublicRate = 0;
var TuandaiRate = 0;
var LowerUnit = 0;//出借单位
var maxUnit = 0;
var nowUnit = 0;
var perAmout = 0;
var RewardAmount = 0;
var tranpwd = "";//交易密码
var isLogin = 0;//是否有登录
var deadLineType = 12;//投资期限
var deadLine = 0;
var NewHandRate = 0;//新手投资奖励利率
var isFTB = 0;//是否复投宝
var isWeFQB = 0;
var repeatInvestType = 0;//复投方式 1：本息复投 2：本金复投
var isNewHandProject = 0;//是否新手标
var IsInvested = 0; //是否有投资过
var NewHandMsg = "新手标仅限未成功投资过的用户";
var isRisk = false; //是否完成风险评测
var RedPacketObj =null;//红包初始查询列表
var PrizeAddRate = 0; //选择加息券利率


document.write("<script src='/scripts/select_redbox.js?v=20170629001' type='text/javascript'></script>");

var browser = {
    versions: function () {
        var u = navigator.userAgent, app = navigator.appVersion;
        return {
            //移动终端浏览器版本信息
            ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
            android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或uc浏览器
            iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
            iPad: u.indexOf('iPad') > -1 //是否iPad
        };
    }()
};

$(function () {
    //iScroll.onLoadData = refreshPage;
    //we计划开放倒计时
    fnTimeCountDown();
    //标记在We计划详情（加息时使用）
    isWePlan = true;

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
        //刷新高度
        //myScroll.refresh();
    });
    limitInt($("#InvestShares"));
    $.ajax({
        type: "post",
        async: false,
        url: "/ajaxCross/InvestAjax.ashx",
        data: { cmd: "GetUserWePlanMoney", projectId: projectId },
        dataType: "json",
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
    isFTB = jsonData.IsFTB;
    isWeFQB = jsonData.IsWeFQB;
    isLogin = jsonData.IsLogin;
    isNewHandProject = jsonData.IsNewHandProject;
    IsInvested = jsonData.IsInvested;
    NewHandMsg = jsonData.NewHandMsg;
    isRisk = jsonData.IsRisk;
    deadLine = jsonData.Deadline;

    if (jsonData.RedPacketListStr != "" && jsonData.RedPacketListStr != null) {
        RedPacketObj = JSON.parse(jsonData.RedPacketListStr);
    }
    if (jsonData.DeadType == 2) {
        deadLineType = 365;
    }
    var html = '<div class="coverBox invest-alert bg-fff hide" style="z-index:501;" id="invest_alert">' +
        '<div class="pt10 pb10 pl15 bg-fff">' +
        '<div class="ico-round-close" id="detail-close"></div>' +
        '<div class="f20px c-212121 text-center"></div>' +
        '</div>' +
        '<div class="pl15 pr15">' +
         '<div class="f13px pl15" id="SharesDesc">1000元/份  剩余30,000份</div>' +
        '<div class="invest-alert-inp mt10 clearfix">' +
        '<input type="tel" placeholder="请输入投资份数" id="InvestShares"/>' +
        '<span class="minus " id="InvestMinus"></span>' +
        '<span class="add " id="InvestAdd"></span>' +
        '</div>';
    if (isWeFQB == "1") { 
        html += '<div class="pt20 pb20 invest_type bb-dashed">' +
                ' <ul class="pl15 pr15">' +
                '     <li>投资方式：</li>' +
                '        <li class="active" dataValue="1"><i><b></b></i>本息复投</li>' +
                '      <li dataValue="2"><i><b></b></i>本金复投</li>' +
                '   </ul>' +
                ' </div>';
    }
    if (RedPacketObj != null) {
        html += '<div class="bb-dashed">' +
            '		<div class="pt20 pb20 clearfix" id="ues_rp">' +
            '			<div class="lf c-999999 f15px">使用优惠券：</div>' +
            '			<div class="rf">' +
            '				<span class="f15px c-fab600" id="redValue" prizeid="" >' + RedPacketObj.ShowTips + '</span>' +
            '				<i class="ico-a-r-999"></i>' +
            '			</div>' +
            '		</div>' +
            ' </div>';
    }
    html += ' <div class="f14px c-212121 pt15">' +
	        '  	        <div class="clearfix pl15 pr15">' +
            '   		    <div class="lf c-ababab f15px">投资总额：</div>'+
            '	    		<div class="rf f15px" id="TotalMoney2">￥0.00</div>' +
            '	    	</div>'+
            '	    	<div class="clearfix pl15 pr15 pt10 pb10">'+
            '	    		<div class="lf c-ababab f15px">参考总回报：</div>' +
            '	    		<div class="rf f15px c-ffc000 hide" id="spPrizeInterest">+￥0.00</div> ' +
            '	    		<div class="rf f15px" id="ProfitMoney">￥0.00</div> ' +
      
 	        '	    	</div>'+
	        '  </div>' + 
            '<div class="btn btnYellow  mt15" id="btnSubmit">马上加入</div>' +        
            '<div class="mt10 f13px text-center c-ababab">投资即表示同意';
    if(isWeFQB =="1"){
        html += '<a class="f12px c-fab600" href="' + ContractViewUrl + '/p2p/weixin/WeFQBPlanServiceContract.html">《We计划[分期宝]服务协议》</a>';
    } else if (isFTB == "1" && jsonData.IsNewHandProject == "1") {
        html += '<a class="f12px c-fab600" href="' + ContractViewUrl + '/p2p/weixin/WeNewHandServiceContract.html">《新手专享复投宝服务协议》</a>';
    } else if (isFTB == "1" && jsonData.FTBSubType == "3") {
        html += '<a class="f12px c-fab600" href="' + ContractViewUrl + '/p2p/weixin/WeFTBSubTypeServiceContract.html">《速盈宝服务协议》</a>';
    }
    else if (isFTB == "1") {
        html += '<a class="f12px c-fab600" href="' + ContractViewUrl + '/p2p/weixin/WeFTBServiceContract.html">《复投宝服务协议》</a>';
    } else {
        html += '<a class="f12px c-fab600" href="' + ContractViewUrl + '/p2p/weixin/WePlanServiceContract.html">《We计划服务协议》</a>';
    }
    html += '</div>' +
        '<div class="mt30 tips-box scaleX scaleX0" id="pay-tips">' +
            '<p style="display: none;">登录密码不正确</p>' +
        '</div>' +
        '</div>' +
        '</div>';
    html += '<!--弹框-->' +
    '<div class="alert webkit-box box-center hide" id="repay-alert">' +
        '<div class="bg-fff alert-con moveTop">' +
            '<p class="text-center c-212121 f17px fb ">回款日期说明</p>' +
            '<p class="pt12 f15px c-808080 text-justify pl20 pr20">回款日期仅供参考，请以实际回款时间为准。</p>' +
            '<div class="bt-e6e6e6 pt10 pb10 c-fcb700 text-center f17px mt25" id="iKnowRepay">我知道了</div>' +
        '</div>' +
    '</div>';
    html += '<div class="z-index100 invest-alert rp-ways hide pb30" id="rp_ways"> ' +
            '<div class="rp-ways-top clearfix">' +
			'   <div class="ico-rp-close lf" id="rpways_close"></div>' +
			'   <a href="/pages/invest/redpacketrule.aspx" class="rf">使用规则<i></i></a>' +
			'</div>' +
    		'<div class="rp-list" id="rpList">' +
            '</div>' +
            '</div>'; 
    $('footer').before(html);

        //回款日期问号事件
        $("#i_repay").bind("click", function () {
            $("#repay-alert").removeClass("hide");
        });
        //关闭回款日期问号事件
        $("#iKnowRepay").bind("click", function () {
            $("#repay-alert").addClass("hide");
        });

        //马上加入按钮点击事件
        $("#btnJoin").bind("click", function () {
            if (LowerUnit == undefined) {
                $("body").showMessage({
                    message: "~0~网络超时<br />请刷新一下试试哟", showCancel: false,okString:"我要刷新", okbtnEvent: function () {
                        window.location.href = window.location.href;
                    }
                });
                return false;
            }

            $("#bigDiv").hide();
            if (isWeFQB == "0") {
                repeatInvestType = 0; 
            } else {
                repeatInvestType = 1; 
            }
            aviShares = parseInt(jsonData.TotalShares) - parseInt(jsonData.ComplateShares);
            $("#SharesDesc").html(LowerUnit + "元/份  　剩余" + aviShares + "份");

            $("#InvestShares").val("投资 1 份");
            $("#ProfitMoney").html("￥0");
            $("#TotalMoney").html("0");
            $("#TotalMoney2").html("￥0");
            $("#invest_alert").removeClass("hide");
            $("#invest_alert").addClass("moveToTop");
            $("#invest_alert").removeClass("moveToBottom");
            if (RedPacketObj != null) {
                $("#rpList").html(getShowRedPacketList());
                initRedFormEvent();
            }
            calcMoney();
        });
        //投资窗口左上角关闭按钮点击事件
        $("#detail-close").bind("click", function () {
            $("#bigDiv").show();
            $("#invest_alert").removeClass("moveToTop");
            $("#invest_alert").addClass("moveToBottom");
        });
        //出借份数框离开事件
        $("#InvestShares").bind("blur", function () {
            var shares = $(this).val();
            if (isNaN(shares)) {
                showError("投资份数必须是数字");
                $(this).val("投资 1 份");
                calcMoney();
                return false;
            }
            if (shares == "")
                return false;
            if (shares.indexOf(".") > -1)
                shares = parseInt(shares).toFixed(0);
            if (parseInt(shares) > parseInt(aviShares))
                shares = parseInt(aviShares).toFixed(0);
            if (shares.indexOf("投资") == -1 && parseInt(shares) > 0) {
                $(this).val("投资 " + shares + " 份");
            }
            if (parseInt(shares) <= 0) {
                showError("投资份数必须大于0");
                shares = 1;
                $(this).val("投资 " + 1 + " 份");
            }
            calcMoney();
        });
        //出借份数框事件
        $("#InvestShares")[0].oninput = function() {
            var shares = $(this).val();
            if(shares.indexOf("投资") > -1)
                $(this).val(shares.replace("投资 ", "").replace(" 份", ""));
            if (isNaN(shares)) {
                showError("投资份数必须是数字");
                $(this).val("1");
                calcMoney();
                return false;
            }
            if(shares == ""){
                $("#InvestMinus").removeClass('minus-onInp');
                return false;
            }else{
                $("#InvestMinus").addClass('minus-onInp');
            }
            if (shares.indexOf(".") > -1)
                shares = parseInt(shares).toFixed(0);
            if (parseInt(shares) > parseInt(aviShares)) {
                shares = parseInt(aviShares).toFixed(0);
                $(this).val(parseInt(aviShares).toFixed(0));
            }
            if (parseInt(shares) <= 0) {
                showError("投资份数必须大于0");
                shares = 1;
                $(this).val("1");
            }
            calcMoney();
        };
        //出借份数框获取焦点事件
        $("#InvestShares").bind("focus", function () {
            var shares = $(this).val();
            if (shares.indexOf("投资") > -1)
                $(this).val(shares.replace("投资 ", "").replace(" 份", ""));
        });
        //减号点击事件
        $("#InvestMinus").bind("click", function () {
            sharesMinus();
        });
        //加号点击事件
        $("#InvestAdd").bind("click", function () {
            sharesAdd();
        });
        //本金复投 本息复投
        $(".invest_type ul li").bind("click", function () {
            if ($(this).hasClass("active")) {
                repeatInvestType = parseInt($(this).attr("dataValue"));
            } else {
                repeatInvestType = parseInt($(this).attr("dataValue"));
                $(this).addClass("active");
                if (repeatInvestType == 1) {
                    $(this).next().removeClass("active"); 
                } else {
                    $(this).prev().removeClass("active"); 
                } 
            }
            if ("" != $("#InvestShares").val())
                calcMoney();
        });
        //马上投资点击事件
        $("#btnSubmit").bind("click", function () {
            if ("" == $("#InvestShares").val()) {
                $("#InvestShares").focus();
                showError("请输入投资份数");
                return false;
            }
            var shares = $("#InvestShares").val();
            if (shares.indexOf("投资") > -1)
                shares = shares.replace("投资 ", "").replace(" 份", "");
            var nowUnit = shares;
            if (parseInt(nowUnit) < 1) {
                nowUnit = 1;
            }
            if ('' == nowUnit) {
                nowUnit = jsonData.MaxUnit;
            } else {
                nowUnit = parseInt(nowUnit);
            }
            //判断是否可投新手标
            if (isNewHandProject == 1 && isLogin == 1 && IsInvested ==1) {
                showError(NewHandMsg);
                return false;
            }

            if (isLogin == 0) {
                //$("#invest_login").removeClass("hide");
                //$("#invest_login").addClass("moveToTop");
                //$("#invest_login").removeClass("moveToBottom");
                //$("#txtInvestType").val("weplan");
                window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href;
            } else if (isRisk) {
                //if (!CheckWeZnq(parseInt(nowUnit) , parseFloat(LowerUnit))) {
                //    return false;
                //}
                try {
                    //-------存管通验证---2016-12-21----
                    if (isOpenCgtSubWe == "1" && !checkIsOpen())
                        return false;
                    //-------存管通验证结束----------
                } catch(e) {

                }
                var prizeId = $("#redValue").attr("prizeid");
                var goUrl = "/Member/Bank/invest_confirm.aspx?payMoney=" + parseInt(nowUnit) * parseFloat(LowerUnit) + "&unit=" + nowUnit + "&projectid=" + projectId +
                            "&backurl=" + backurl + "&investType=weplan&profitMoney=" + $("#ProfitMoney").html().replace("￥", "") + "&repeatInvestType=" + repeatInvestType+
                            "&PrizeId=" + prizeId + "&PrizeName=" + $("#redValue").text();
                window.location.href = goUrl;
            } else {
                if ($.isFunction($("body").showMessage)) {
                    $("body").showMessage({
                        message: "请先完善存管账户信息！", showCancel: true, okString: "马上完善", cancelString: "取消",
                        okbtnEvent: function () {
                            window.location.href = "/Member/safety/pre_invest.aspx";
                        }
                    });
                } else {
                    alert("请先完善存管账户信息！");
                    window.location.href = "/Member/safety/pre_invest.aspx";
                }
            }
        });
        //减号操作
        function sharesMinus() {
            var shares = $("#InvestShares").val();
            if (shares == "") {
                $("#InvestShares").val("投资 1 份");
            } else {
                if (shares.indexOf("投资") > -1) {
                    shares = shares.replace("投资 ", "").replace(" 份", "");
                    if (shares == "1")
                        return false;
                    $("#InvestShares").val("投资 " + (parseInt(shares) - 1) + " 份");
                }
            }
            calcMoney();
        };
        //加号操作
        function sharesAdd() {
            var shares = $("#InvestShares").val();
            if (shares == "") {
                $("#InvestShares").val("投资 1 份");
            } else {
                if (shares.indexOf("投资") > -1) {
                    shares = shares.replace("投资 ", "").replace(" 份", "");
                    if (parseInt(shares) >= parseInt(aviShares)) {
                        shares = parseInt(aviShares).toFixed(0);
                        return false;
                    } else
                        $("#InvestShares").val("投资 " + (parseInt(shares) + 1) + " 份");
                }
            }
            calcMoney();
        };
    
    });
//计算收益和投资总额
function calcMoney() {
    var shares = $("#InvestShares").val();
    if (shares.indexOf("投资") > -1) {
        shares = shares.replace("投资 ", "").replace(" 份", "");
    }
    if (shares == "" || parseInt(shares) <= 0)
        return;
    var totalInvest = fmoney(parseInt(shares) * parseInt(LowerUnit), 2);
    $("#TotalMoney").html(totalInvest);
    $("#TotalMoney2").html("￥" + totalInvest);
    nowUnit = shares;
    var theYearRate = jsonData.InterestRate;
    if (isWeFQB == "1") {
        if (repeatInvestType == 1)
            theYearRate = jsonData.InterestRate;
        else
            theYearRate = jsonData.MaxYearRate2;
    }
    //预期收益 
    var expentMoney = parseFloat(LowerUnit) * parseFloat(nowUnit) * theYearRate / 100 * parseFloat(jsonData.Deadline) / deadLineType;
    $("#ProfitMoney").html("￥" + fmoney(expentMoney, 2));
};
//错误提示
function showError(msg) {
    $("#pay-tips p").html(msg);
    $("#pay-tips").removeClass('opacity0').removeClass('scaleX0').addClass('scaleX1');
    setTimeout(function () {
        $("#pay-tips").find('p').fadeIn(240);
    }, 240);
    setTimeout(function () {
        $("#pay-tips").find('p').fadeOut(240);
        }, 2000);
    setTimeout(function () {
        $("#pay-tips").removeClass('scaleX1').addClass('scaleX0');
        }, 2240);
    setTimeout(function () {
        $("#pay-tips").addClass('opacity0');
        }, 2480);
        };
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
                interestAmount = amount * interestRate * 0.01 / deadLineType * deadline;
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
};

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
    return "<span style='color: #ffffff;font-size:16px;'><span style='color: #ffffff;font-size:16px;'>" + hour + "</span>小时<span style='color: #ffffff;font-size:16px;'>" + mini
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
                    $(this).parent().removeClass("btnGray");
                    $(this).parent().addClass("btnYellow");
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


//检测we计划周年庆
function CheckWeZnq(nowUnit,lowUnit) {
    if (IsWeZnq == "True") {
        var isCurrDayJoinMoney = 0;
        var isCurrDayJoinCount = 0;
        $.ajax({
            type: "post",
            async: false,
            url: "/ajaxCross/InvestAjax.ashx",
            data: { cmd: "GetWeZnqCurrDayJoinMoney" },
            dataType: "json",
            success: function (json) {
                if (json != null && json != undefined && json != "") {
                    isCurrDayJoinMoney = parseFloat(json.CurrDayJoinMoney);
                    isCurrDayJoinCount = parseInt(json.CurrDayJoinCount);
                } else {
                    $("body").showMessage({ message: "服务器繁忙，请稍后再试。",showCancel:false });
                    return false;
                }
            },
            error: function () {
                $("body").showMessage({ message: "服务器繁忙，请稍后再试。",showCancel:false });
                return false;
            }
        });
        if (isCurrDayJoinCount >= DayJoinCount) {
            $("body").showMessage({
                message: "您已成功购买过加息标，请明天再来抢加息标。", showCancel: false, okbtnEvent: function () {
                    $("#divPopTips").hide();
                    window.location.href = window.location.href;
                }
            });
            return false;
        }
        if (nowUnit * lowUnit > DayJoinMoney) {
            if (parseFloat(lowUnit) == 0)
                lowUnit = 5000;
            var maxUnit = parseInt(DayJoinMoney / lowUnit);
            $("body").showMessage({
                message: "您最多可加入" + maxUnit + "份，请重新设置加入份数。", showCancel: false, okbtnEvent: function () {
                    $("#InvestShares").val("投资 "+maxUnit+" 份");
                    calcMoney();
                    $("#divPopTips").hide();
                }
            });
            return false;
        }
        if (isCurrDayJoinMoney + nowUnit * lowUnit >= DayJoinMoney) {
            $("body").showMessage({
                message: "您最多可加入" + (DayJoinMoney - isCurrDayJoinMoney) / lowUnit + "份，请重新设置加入份数。", showCancel: false, okbtnEvent: function () {
                    $("#InvestShares").val("投资 " + (DayJoinMoney - isCurrDayJoinMoney) / lowUnit + " 份");
                    calcMoney();
                    $("#divPopTips").hide();
                }
            });
            return false;
        }
    }
    return true;
}