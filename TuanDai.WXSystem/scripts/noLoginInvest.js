var ShowNewHandMsg = "新手标仅限未成功投资过的用户";
$(function () {
    //针后面登录的再弹出申购框
    if (window.location.href.indexOf("isshowinvest=1") >= 0) { 
        if ($("#btnJoin").length > 0) {
            $("#btnJoin").click();
        } else if ($(".loan-button").length > 0) {
            $(".loan-button").click();
        } 
    }

    //注册流程弹框
    var html = '<div class="coverBox invest-alert hide" style="z-Index:502;" id="invest_login">' +
	            '<div class="pt10 pb10 pl15 bg-fff">' +
                    '<div class="ico-round-close pos-r" id="detail-close1" style="z-index:400;left:0;top:0;"></div>' +
                    '<div class="f20px c-212121 text-center"></div>' +
                '</div>' +
                '<div class="" id="animate1">' +
    	            '<div class="moveToTop1">' +
		               ' <div class="pt17 text-center td_logo fadeOut1">' +
		    	            '<img src="/imgs/images/bg/tuandai_logo.png"/>' +
		                '</div>' +
		                '<div class="pt17 text-center font-box">' +
		    	            '<p class="fadeOut2">马上开始投资</p>' +
		    	            '<p class="loginTxt opacity0">登录</p>' +
		    	            '<p class="zhuceTxt opacity0">注册</p>' +
		                '</div>' +
		                '<div class="input-box pt38">' +
		    	            '<input type="tel" placeholder="手机号码"  id="tel-inp" />' +
		                '</div>' +
    	            '</div>' +
                '</div>' +

                '<div class="animate2 hide" id="animate2">' +
	                '<div class="input-box moveToTop2 opacity0">' +
	    	            '<input type="password" placeholder="登录密码" id="logincode-inp" />' +
                        '<div id="btnSee2" class="ico-eye-ban pos-a" ></div>' +
	                '</div>' +
                    '<div class="text-right moveToTop2 pr15 mt5"><a href="/member/safety/ResetPwd.aspx?backurl=' + backurl + '" class="f13px c-fd6040">忘记密码?</a></div>' +
	                '<div class="mt50 pl20 pr25 moveToTop3 opacity0">' +
	    	            '<div class="btn btnYellow opacity05" id="loginConfirm">确定</div>' +
		                '<div class="mt30 tips-box scaleX scaleX0" id="login-tips">' +
		    	            '<p style="display: none;">登录密码不正确</p>' +
		                '</div>' +
	                '</div>' +
                '</div>' +

                '<div class="animate2 hide" id="animate3">' +
	                '<div class="input-box moveToTop2" id="likeHolder">' +
    		            '<input type="password" name="txtPassword" id="txtPassword" class="codeIpt">' +
    		            '<p class="likePlaceholder">登录密码 <span>（6-16个字符，数字+字母）</span></p>' +
    		            '<div id="btnSee" class="ico-eye-ban pos-a" ></div>' +
	                '</div>' +
	                '<div class="input-box moveToTop2">' +
	    	            '<input type="text" placeholder="验证码" id="phoneCode-inp">' +
	    	            '<div class="phoneCode" id="sendMsgCode">发送验证码</div>' +
	                '</div>' +
	                '<div class="noPhoneCode moveToTop2" id="sendVCode">收不到验证码 ? 使用<a id="sendVoiceCode">语音验证码</a></div>' +
	                '<div class="mt25 pl20 pr25 moveToTop3">' +
	    	            '<div class="btn btnYellow opacity05" id="zhuceConfirm">确定</div>' +
		                '<div class="mt30 tips-box scaleX scaleX0" id="zhuce-tips">' +
		    	            '<p style="display: none;">登录密码不正确</p>' +
		                '</div>' +
	                '</div>' +
                '</div>' +
            '</div>'+
        '<input type="hidden" id="txtInvestType" />';
    html+='<!--设置交易密码-->'+
            '<div class="coverBox invest-alert bg-f6f7f8 hide" style="z-Index:503;" id="tranPwd_alert">' +
	            '<div class="pt10 pb10 pl15 bg-f6f7f8">'+
                    '<div class="ico-round-close" id="detail-close2"></div>'+
                    '<div class="f20px c-212121 text-center"></div>'+
                '</div>'+
               '<div class="text-center">'+
		            '<div class="pic-lock mt20">'+
			            '<img src="/imgs/images/pic/lock.png"/>'+
		            '</div>'+
		            '<p class="mt15 fb f14px c-212121">注册成功，设置交易密码</p>'+
		            '<p class="mt10 f11px c-999999 pr10 pl10">交易密码主要用于保障资金交易(投资、充值和提现)安全。</p>'+
	            '</div>'+
	            '<div class="clearfix inpBox4 bg-fff pt10 pb10 pl15 mt30 pos-r">'+
		            '<div class="lf f14px c-212121">交易密码</div>'+
		            '<input type="password" class="lf f14px" id="txtPayPwd" placeholder="请设置交易密码" />' +
                    '<div id="btnSee1" class="ico-eye-ban pos-a"  ></div>' +
	            '</div>'+
	            '<div class="c-999999 f11px pl15 mt5">6~16个字符，需包含字母和数字</div>'+
	            '<div class="pl15 pr15 mt30">' +
		            '<a class="btn btnYellow" id="btnUpdatePayPwd">确定</a>' +
                    '<div class="mt30 tips-box scaleX scaleX0" id="pay-tips">' +
		    	        '<p style="display: none;">登录密码不正确</p>' +
		            '</div>' +
                '</div>' +
            '</div>';
    $('footer').before(html);
    //登录流程窗口左上角关闭按钮点击事件
    $("#detail-close1").bind("click", function () {
        $("#invest_login").removeClass("moveToTop");
        $("#invest_login").addClass("moveToBottom");
    });
    //设置交易密码左上角关闭按钮点击事件
    $("#detail-close2").bind("click", function () {
        $("#tranPwd_alert").removeClass("moveToTop");
        $("#tranPwd_alert").addClass("moveToBottom");
    });
    
    //显示密码
    $("#btnSee").click(function () {
        var $txtTransPwd = $('#txtPassword'), $this = $(this);
            if($this.hasClass("ico-eye-ban")) {
    		$this.removeClass('ico-eye-ban').addClass('ico-eye-able');
    		$txtTransPwd.attr('type', 'text');
    	} else {
    		$this.removeClass('ico-eye-able').addClass('ico-eye-ban');
    		$txtTransPwd.attr('type', 'password');
    		}
    });
    //显示交易密码
    $("#btnSee1").click(function () {
        var $txtTransPwd = $('#txtPayPwd'), $this = $(this);
            if($this.hasClass("ico-eye-ban")) {
    		$this.removeClass('ico-eye-ban').addClass('ico-eye-able');
    		$txtTransPwd.attr('type', 'text');
    		} else {
    		$this.removeClass('ico-eye-able').addClass('ico-eye-ban');
    		$txtTransPwd.attr('type', 'password');
    		}
    		});
    //显示密码
    $("#btnSee2").click(function () {
        var $txtTransPwd = $('#logincode-inp'), $this = $(this);
            if($this.hasClass("ico-eye-ban")) {
    		$this.removeClass('ico-eye-ban').addClass('ico-eye-able');
    		$txtTransPwd.attr('type', 'text');
    		} else {
    		$this.removeClass('ico-eye-able').addClass('ico-eye-ban');
    		$txtTransPwd.attr('type', 'password');
    		}
    });
    function likePlaceHolder() {
        var txtPassword = document.getElementById('txtPassword');
        var $txtPassword = $("#txtPassword");
        var phoneCode = document.getElementById('phoneCode-inp');
        var $phoneCode = $("#phoneCode-inp");
        var placeholder = $(".likePlaceholder");
        $("#likeHolder").click(function () {
            if (txtPassword.value == '') {
                $txtPassword.focus();
            }
        });
        $txtPassword.blur(function () {
            if ($(this).val() == '') {
                placeholder.show();
            }
        });
        txtPassword.oninput = function () {
            if (this.value.length == 0) {
                placeholder.show();
            } else {
                placeholder.hide();
            }
            if (this.value.length >= 6 && phoneCode.value.length >= 6) {
                $("#zhuceConfirm").removeClass('opacity05');
            } else {
                $("#zhuceConfirm").addClass('opacity05');
            }
        }
        phoneCode.oninput = function () {
            if (txtPassword.value.length >= 6 && this.value.length >= 6) {
                $("#zhuceConfirm").removeClass('opacity05');
            } else {
                $("#zhuceConfirm").addClass('opacity05');
            }
        }

    }
    likePlaceHolder();

    //注册登录动画
    var telInp = document.getElementById('tel-inp');
    
    telInp.oninput = function () {
        var isReg = false;
        if (telInp.value.length == 11) {
            $("#tel-inp").blur();
            var tel = $("#tel-inp").val();
            $.ajax({
                url: "/ajaxCross/InvestAjax.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { Cmd: "IsReg", tel: tel },
                success: function (json) {
                    if (json.result == "1") {
                        isReg = true;
                    } 
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });

            //已注册,显示登录
            if (isReg == true) {
                $("#animate1").addClass('animate1');
                $(".loginTxt").addClass('fadeIn1');
                $("#animate2").removeClass('hide');
                $(".zhuceTxt").removeClass('fadeIn1');
                $("#animate3").addClass('hide');
            }
                //未注册,显示注册
            else {
                $("#animate1").addClass('animate1');
                $(".zhuceTxt").addClass('fadeIn1');
                $("#animate3").removeClass('hide');
                $(".loginTxt").removeClass('fadeIn1');
                $("#animate2").addClass('hide');
            }

        }
    }

    //改变登录确定按钮透明度
    document.getElementById('logincode-inp').oninput = function () {
        if (this.value.length >= 6) {
            $("#loginConfirm").removeClass('opacity05');
        } else {
            $("#loginConfirm").addClass('opacity05');
        }
    }

    //改变注册确定按钮透明度
    document.getElementById('logincode-inp').oninput = function () {
        if (this.value.length >= 6) {
            $("#loginConfirm").removeClass('opacity05');
        } else {
            $("#loginConfirm").addClass('opacity05');
        }
    }

    //登录操作
    $("#loginConfirm").click(function() {
        //透明度为0.5的时候不可点击
        if ($(this).hasClass('opacity05')) {
            return false;
        } else {
            if (!ValidateMobilerNumber("login"))
                return false;
            var txtUserName = fnStringJM($("#tel-inp").val());
            var txtPassword = fnStringJM($("#logincode-inp").val());
            $("#loginConfirm").html("<img src='/imgs/images/icon/ico_btnLoading.png' style='width:22px;height:22px;' alt='' >&nbsp;正在登录中...");
            $.ajax({
                async: true,
                url: "/ajaxCross/Login.ashx?cmd=LoginSubmit",
                type: "post",
                dataType: "json",
                data: { cmd: "LoginSubmit", username: txtUserName, password: txtPassword, verificationCode: "", returnUrl: "" },
                success: function (json) {
                    if (json.result != "1") {
                        $("#loginConfirm").html("确定");
                        if (json.result == "0")
                            json.msg = "密码错误，还剩" + (5-parseInt(json.msg)) + "次机会";
                        showLoginError(json.msg);
                    } else {
                        //判断是否可投新手标
                        if (isNewHandProject == 1) {
                            if (!checkIsNewHandUser()) {
                                isLogin = 1;
                                $("#loginConfirm").html("确定");
                                showLoginError(ShowNewHandMsg);
                                setTimeout(function () {
                                    $("#invest_login").removeClass("moveToTop");
                                    $("#invest_login").addClass("moveToBottom");
                                }, 3000)
                                return false;
                            }
                        }
                        //登录成功
                        isLogin = 1;
                        window.location.href = window.location.href += "&isshowinvest=1";
                        //var investType = $("#txtInvestType").val();
                        //if (investType == "project")
                        //    window.location.href = "/Member/Bank/invest_confirm.aspx?payMoney=" + nowUnit * LowerUnit + "&projectid=" + projectId + "&unit=" + nowUnit + "&backurl=" + backurl + "&investType=project&profitMoney=" + $("#ProfitMoney").html().replace("￥", "");
                        //else {
                        //    if (!CheckWeZnq(parseInt(nowUnit), parseFloat(LowerUnit))) {
                        //        $("#invest_login").removeClass("moveToTop");
                        //        $("#invest_login").addClass("moveToBottom");
                        //        return false;
                        //    }
                        //    window.location.href = "/Member/Bank/invest_confirm.aspx?payMoney=" + nowUnit * LowerUnit + "&unit=" + nowUnit + "&projectid=" + projectId + "&backurl=" + backurl + "&investType=weplan&repeatInvestType=" + repeatInvestType + "&profitMoney=" + $("#ProfitMoney").html().replace("￥", "");
                        //}
                    } 
                },
                error: function () {
                    $("#loginConfirm").html("确定");
                    showLoginError("系统繁忙：请重试");
                }
            });
            
        }
    });
    //注册操作
    $("#zhuceConfirm").bind("click", function () {
        //透明度为0.5的时候不可点击
        if ($(this).hasClass('opacity05')) {
            return false;
        }
        if (!ValidateMobilerNumber("reg"))
            return false;
        if (!ValidatePassword())
            return false;
        $("#zhuceConfirm").html("<img src='/imgs/loading24.gif' alt='' >&nbsp;正在注册中...");
        $.ajax({
            url: "/ajaxCross/Login.ashx",
            type: "post",
            dataType: "json",
            data: { cmd: "Register", password: fnStringJM($("#txtPassword").val()), mobilenumber: $("#tel-inp").val(), verificationCode: $("#phoneCode-inp").val() },
            success: function (json) {
                var result = json.result;
                if (result == "1") {
                    //注册成功,转到设置交易密码
                    //$("#tranPwd_alert").removeClass("hide");
                    //$("#tranPwd_alert").addClass("moveToTop");
                    //$("#tranPwd_alert").removeClass("moveToBottom"); 
                    var investType = $("#txtInvestType").val();
                    if (investType == "project")
                        window.location.href = "/Member/Bank/invest_confirm.aspx?payMoney=" + nowUnit * LowerUnit + "&projectid=" + projectId + "&unit=" + nowUnit + "&backurl=" + backurl + "&investType=project&profitMoney=" + $("#ProfitMoney").html();
                    else {
                        if (!CheckWeZnq(parseInt(nowUnit), parseFloat(LowerUnit))) {
                            $("#invest_login").removeClass("moveToTop");
                            $("#invest_login").addClass("moveToBottom");
                            return false;
                        }
                        window.location.href = "/Member/Bank/invest_confirm.aspx?payMoney=" + nowUnit * LowerUnit + "&unit=" + nowUnit + "&projectid=" + projectId + "&backurl=" + backurl + "&investType=weplan&repeatInvestType=" + repeatInvestType + "&profitMoney=" + $("#ProfitMoney").html();
                    }
                        
                }
                else {
                    $("#zhuceConfirm").html("确定");
                    //注册失败
                    showRegError(json.msg);
                }
            },
            error: function () {
                $("#zhuceConfirm").html("确定");
                //注册出错
                showRegError("注册失败：请重试");
            }
        });
    });
    //发送短信验证码
    $("#sendMsgCode").bind("click", function () {
        var tel = $("#tel-inp").val();
        if (!ValidateMobilerNumber("reg"))
            return false;
        $.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "BindMobilePhone", phoneNum: tel, vtype: '0' },
            success: function (jsondata) {
                var d = parseInt(jsondata.result);
                var msg = jsondata.msg;
                if (d == -100) {
                    showRegError("系统繁忙：请重试");
                    return false;
                } else if (d == 1) {
                    //手机号码未注册，成功发送验证码
                    showRegError("验证码发送成功");
                    $("#sendMsgCode").hide();
                    var time = 180;
                    setInterval(function () {
                        if (time <= 0) {
                            $("#sendMsgCode").show();
                            $("#sendVCode").html('收不到验证码 ? 使用<a id="sendVoiceCode">语音验证码</a>');
                        }
                        else
                            $("#sendVCode").html("发送成功，重新发送" + (time--)+"...");
                    }, 1000);
                    return false;
                } else if (d == -38) {
                    //手机号码已注册
                    showRegError("手机号码已注册");
                } else {
                    showRegError(msg);
                    return false;
                }
            }
        });
    });
    //发送语音验证码
    $("#sendVoiceCode").bind("click", function () {
        var tel = $("#tel-inp").val();
        if (!ValidateMobilerNumber("reg"))
            return false;
        $.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "GetCodeByMobile", phoneNum: tel, vtype: '1' },
            success: function (data) {
                var status = parseInt(data.result);
                if (status == 1) {
                    showRegError("验证码发送成功");
                    $("#sendMsgCode").hide();
                    var time = 180;
                    setInterval(function () {
                        if (time <= 0) {
                            $("#sendMsgCode").show();
                            $("#sendVCode").html('收不到验证码 ? 使用<a id="sendVoiceCode">语音验证码</a>');
                        }
                        else
                            $("#sendVCode").html("发送成功，重新发送" + (time--) + "...");
                    }, 1000);
                    return false;
                } else if (status == -100) {
                    showRegError("系统繁忙：请重试");
                    return false;
                } else {
                    showRegError(data.msg);
                    return false;
                }
            }
        });
    });
    //修改交易密码
    $("#btnUpdatePayPwd").bind("click", function () {
        if (!ValidatePayPwd())
            return false;
        $.ajax({
            type: "POST",
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            dataType: "json",
            data: { Cmd: "SimpleUpdatePayPwd", newpwd: fnStringJM($("#txtPayPwd").val()) },
            success: function (json) {
                var d = json.result;
                if (parseInt(d) == -100) {
                    showPayError("系统繁忙：请重试");
                    return false;
                }
                else if (parseInt(d) == -99) {
                    showPayError("登录账户丢失");
                    return false;
                }
                else if (d == "1") {
                    showPayError("修改成功");
                    var investType = $("#txtInvestType").val();
                    if (investType == "project")
                        window.location.href = "/Member/Bank/invest_confirm.aspx?payMoney=" + nowUnit * LowerUnit + "&projectid=" + projectId + "&unit=" + nowUnit + "&backurl=" + backurl + "&investType=project&profitMoney="+$("#ProfitMoney").html();
                    else
                        window.location.href = "/Member/Bank/invest_confirm.aspx?payMoney=" + nowUnit * LowerUnit + "&unit=" + nowUnit + "&projectid=" + projectId + "&backurl=" + backurl + "&investType=weplan&repeatInvestType=" + repeatInvestType + "&profitMoney=" + $("#ProfitMoney").html();
                } else {
                    showPayError(json.msg);
                    return false;
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                showPayError("系统繁忙：请重试");
                return false;
            }
        });
    });
});
//登录时错误提示
function showLoginError(msg) {
    $("#login-tips p").html(msg);
    $("#login-tips").removeClass('scaleX0').addClass('scaleX1');
    setTimeout(function () {
        $("#login-tips").find('p').fadeIn(240);
    }, 240);
    setTimeout(function () {
        $("#login-tips").find('p').fadeOut(240);
    }, 2000);
    setTimeout(function () {
        $("#login-tips").removeClass('scaleX1').addClass('scaleX0');
    }, 2240);
};
//注册时错误提示
function showRegError(msg) {
    $("#zhuce-tips p").html(msg);
    $("#zhuce-tips").removeClass('scaleX0').addClass('scaleX1');
    setTimeout(function () {
        $("#zhuce-tips").find('p').fadeIn(240);
    }, 240);
    setTimeout(function () {
        $("#zhuce-tips").find('p').fadeOut(240);
    }, 2000);
    setTimeout(function () {
        $("#zhuce-tips").removeClass('scaleX1').addClass('scaleX0');
    }, 2240);
};
//修改交易错误提示
function showPayError(msg) {
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
/*交易密码验证*/
function ValidatePayPwd() {
    var password = $("#txtPayPwd").val();
    var pattern1 = /^.*?[\d]+.*$/;
    var pattern2 = /^.*?[A-Za-z].*$/;
    var pattern3 = /^.{6,16}$/;
    if (password.indexOf(' ') > -1) {
        showPayError("交易密码不能含有空格");
        return false;
    }
    if (password == "") {
        showPayError("交易密码不能为空");
        return false;
    }
    else if (!(pattern1.test(password) && pattern2.test(password) && pattern3.test(password))) {
        showPayError("交易密码格式不正确");
        return false;
    }
    else if (password.length < 6 || password.length > 16) {
        showPayError("交易密码长度为6-16个字符");
        return false;
    }
    else {
        return true;
    }
};
/*注册密码验证*/
function ValidatePassword() {
    var password = $("#txtPassword").val();
    var pattern1 = /^.*?[\d]+.*$/;
    var pattern2 = /^.*?[A-Za-z].*$/;
    var pattern3 = /^.{6,16}$/;
    if (password.indexOf(' ') > -1) {
        showRegError("密码不能含有空格");
        return false;
    }
    if (password == "") {
        showRegError("密码不能为空");
        return false;
    }
    else if (!(pattern1.test(password) && pattern2.test(password) && pattern3.test(password))) {
        showRegError("密码格式不正确");
        return false;
    }
    else if (password.length < 6 || password.length > 16) {
        showRegError("密码长度为6-16个字符");
        return false;
    }
    else {
        return true;
    }
};
/*手机号码验证*/
function ValidateMobilerNumber(flag) {
    var mobileNumber = $("#tel-inp").val();
    var phoneRegex = /^(?:13\d|14\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$/;
    if (mobileNumber == "") {
        if (flag == "login") {
            showLoginError("手机号码不能为空");
        } else {
            showRegError("手机号码不能为空");
        }
        return false;
    }
    else if (!phoneRegex.test(mobileNumber)) {
        if (flag == "login") {
            showLoginError("输入手机号码格式不正确");
        } else {
            showRegError("输入手机号码格式不正确");
        }
        return false;
    }
    else {
        return true;
    }
};
//检测是否新手
function checkIsNewHandUser() {
    var isNewUser = false;
    $.ajax({
        type: "post",
        async: false,
        url: "/ajaxCross/InvestAjax.ashx",
        data: { cmd: "CheckIsNewHandUser"},
        dataType: "json",
        timeout: 3000,
        success: function (json) { 
            if (json.result == "1") {
                isNewUser = true; 
            } else {
                ShowNewHandMsg = json.msg;
            }
        },
        error: function () {
            isNewUser = false;
        }
    });
    return isNewUser;
}