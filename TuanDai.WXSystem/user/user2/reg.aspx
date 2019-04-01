<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reg.aspx.cs" Inherits="TuanDai.WXApiWeb.user.user2.reg" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="format-detection" content="telephone=no">
		<title>借款注册页</title>
		<meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财">
		<meta name="description" content="">
		<!--动态计算rem-->
		<script>
		    (function (doc, win) {
		        var dpr, rem, scale = 1;
		        var docEl = document.documentElement;
		        var metaEl = document.querySelector('meta[name="viewport"]');
		        var resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize';
		        metaEl.setAttribute('content', 'width=device-width,initial-scale=' + scale + ',maximum-scale=' + scale + ', minimum-scale=' + scale + ',user-scalable=no,shrink-to-fit=no');
		        docEl.setAttribute('data-dpr', dpr);
		        var recalc = function () {
		            clientWidth = docEl.clientWidth;
		            if (!clientWidth) return;
		            docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
		            if (document.body) {
		                document.body.style.fontSize = docEl.style.fontSize;
		            }

		        };
		        recalc();
		        if (!doc.addEventListener) return;
		        win.addEventListener(resizeEvt, recalc, false);
		        doc.addEventListener('DOMContentLoaded', recalc, false);
		    })(document, window);
		</script>
		
		<link rel="stylesheet" href="css/demos.css">
		<link rel="apple-touch-icon-precomposed" href="/assets/img/apple-touch-icon-114x114.png">
		<script src="js/jquery-2.1.1.min.js"></script>
		<script src="js/config.js"></script>
		<link rel="stylesheet" href="css/reg.css?v=20160830" />
	</head>

	<body>
		<header>
			<img src="images/logo.png" class="logo">
			<p>欢迎您，完善以下信息即可完成注册！</p>
		</header>

		<section class="input-box md1" id='input-box'>
			<div class="input_wraper">
				<input type="text" name="" class="codeIpt" id="e_name" placeholder="企业名称" />
				<input type="text" name="" class="codeIpt" id="e_bankxkz" placeholder="开户银行许可证号" />
				<input type="text" name="" class="codeIpt" id="e_unifiedCode" placeholder="统一社会信用代码（选填）" />
				<div class="codeIpt c-999" id="tabTit">企业三证（选填）<i class="ico_arrow"></i></div>
				<div class="tabCon" style="display: none;">
					<input type="text" name="" class="codeIpt" id="e_orgcode" placeholder="组织机构代码" />
					<input type="text" name="" class="codeIpt" id="e_zhizhao" placeholder="营业执照编号" />
					<input type="text" name="" class="codeIpt" id="e_shuiwudj" placeholder="税务登记号" />
				</div>
				<input type="text" name="" class="codeIpt" id="e_creditCode" placeholder="机构信息代码（选填）" />
				<input type="text" name="" class="codeIpt" id="e_faren" placeholder="法人姓名" />
				<input type="text" name="" class="codeIpt" id="e_fridcard" placeholder="法人身份证号" />
				<input type="text" name="" class="codeIpt" id="e_contract" placeholder="企业联系人" />
				<input type="text" name="" class="codeIpt" id="e_mobile" placeholder="联系人手机号" maxlength="11" />
				<input type="text" name="" class="codeIpt" id="e_bankno" placeholder="企业对公账户" />
				<input type="text" name="" class="codeIpt" id="e_bankcode" placeholder="银行编码" />
				<div class="verification_wraper">
					<input type="text" name="verification" class="codeIpt verification mb0" id="verification" placeholder="手机验证码" />
					<input type="button" id="btnSendMsg" class=" btnSendMsg" value="获取验证码" />
				</div>
			</div>
			<a href="javascript:void(0);" class="btn-reg">马上注册</a>
			<p class="error" id="error">请填写正确的身份证号码</p>
	</body>
	<script type="text/javascript">
	    var nameReg = /^([\u4e00-\u9fa5]){2,7}$/;
	    var cardReg = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
	    var bankCardReg = /^(\d{16}|\d{19})$/;
	    var phoneReg = new RegExp("^(13|14|15|17|18)[0-9]{9}$", "i");

	    $('.btn-reg').on('touchstart', function () {
	        $(this).addClass('btn-click');
	    });

	    $('.btn-reg').on('touchend', function () {
	        $(this).removeClass('btn-click');
	    });

	    $("#tabTit").click(function () {
	        var tabCon = $(".tabCon");
	        var ico = $(this).find('i');
	        if (tabCon.css('display') == 'none') {
	            ico.css('-webkit-transform', 'rotateZ(-180deg)');
	            tabCon.slideDown();
	        } else {
	            ico.css('-webkit-transform', 'rotateZ(0)');
	            tabCon.slideUp();
	        }
	    })

	    /*获取手机验证码*/
	    function GetVerificationCode() {
	        var mobileNumber = $("#e_mobile").val();
	        var validCode;
	        $.ajax({
	            url: "/ajaxCross/ajax_cgt.ashx",
	            type: "post",
	            dataType: "json",
	            data: { cmd: "GetPhoneCode", mobilenumber: mobileNumber, ValidCode: validCode },
	            success: function (json) {
	                var result = json.result;
	                if (result == "1") {

	                    $('#error').html("发送成功，如未收到请稍后重新获取!");
	                    $('#error').show();

	                    //$("#btncode").attr('disabled', true);
	                    //$('#btncode').addClass("disabled");
	                    ////$("#lblCode").text("发送成功，如未收到请稍后重新获取。");
	                    ////$("#lblCode").show();
	                    //$("body").showMessage({ message: "发送成功，如未收到请稍后重新获取!", showCancel: false });
	                    ////updateTimeLabel(180);
	                    return true;
	                }
	                else {

	                    if (json.msg == "图形验证码错误") {
	                        // $("#lblValidNumber").text(json.msg);
	                        //$("#lblValidNumber").show(); 
	                        $('#error').html(json.msg);
	                        $('#error').show();

	                        //$("body").showMessage({ message: json.msg, showCancel: false });
	                    }
	                    else if (json.msg == "") {
	                        $('#error').html("发送验证码失败！");
	                        $('#error').show();

	                    }
	                    else {
	                        //$("#lblCode").text(json.msg);
	                        //  $("#lblCode").show();
	                        $('#error').html(json.msg);
	                        $('#error').show();

	                        //$("body").showMessage({ message: json.msg, showCancel: false });
	                    }

	                    return false;
	                }
	            },
	            error: function () {
	                $('#error').html('网络异常，请重试!');
	                $('#error').show();

	                //$("#btncode").attr('disabled', true);
	                //$('#btncode').addClass("disabled");

	                //$("body").showMessage({ message: "网络异常，请重试!", showCancel: false });
	                //$("#lblCode").text("网络异常，请重试。");
	                //$("#lblCode").show();
	                //updateTimeLabel(0);
	                return false;
	            }
	        });
	    };

	    /*手机号码验证*/
	    function ValidateMobilerNumber() {
	        var result = false;
	        var mobileNumber = $("#e_mobile").val();
	        var phoneRegex = /^(?:13\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$/
	        if (mobileNumber == "") {
	            //$("body").showMessage({ message: "手机号码不能为空!", showCancel: false });
	            $('#error').html('手机号码不能为空!');
	            $('#error').show();
	            //$("#lblMobileNumber").text("手机号码不能为空");
	            //$("#lblMobileNumber").show();

	            result = false;
	        }
	        else if (!phoneRegex.test(mobileNumber)) {
	            //$("body").showMessage({ message: "输入手机号码格式不正确!", showCancel: false });
	            $('#error').html('输入手机号码格式不正确!');
	            $('#error').show();
	            //$("#lblMobileNumber").text("输入手机号码格式不正确");
	            //$("#lblMobileNumber").show();
	            result = false;
	        }
	        else {
	            $.ajax({
	                type: "post",
	                async: false,
	                url: "/ajaxCross/ajax_cgt.ashx",
	                data: "Cmd=CheckPhone&mobilenumber=" + mobileNumber,
	                dataType: "json",
	                timeout: 3000,
	                success: function (jsondata) {
	                    var data = jsondata.result;
	                    if (data == "True") {
	                        //$("body").showMessage({ message: "手机已注册!", showCancel: false });
	                        $('#error').html('手机已注册!');
	                        $('#error').show();
	                        //$("#lblMobileNumber").text("手机已注册");
	                        //$("#lblMobileNumber").show();
	                        result = false;
	                    }
	                    else {

	                        result = true;
	                        $('#error').html('');
	                        $('#error').hide();
	                    }
	                }
	            });
	        }
	        return result;
	    };
	    //圆形进度条
	    var second = 181;
	    var angle = 0;
	    var timer;
	    function getTime() {
	        second -= 1;
	        angle += 1;
	        if (angle >= 180) {
	            $("#btnSendMsg").val("1秒后重试");
	            //rightcircle.style.cssText = "transform: rotate(" + (45 - (angle - 180)) + "deg)";
	            //leftcircle.style.cssText = "transform: rotate(-135deg)";
	            if (second <= 0) {
	                clearInterval(timer);
	                $("#btnSendMsg").val("重新获取");
	                second = 181;
	                angle = 0;
	            }
	        } else {
	            $("#btnSendMsg").val((181 - angle) + "秒后重试");
	        }
	    }
	    function usernameblur() {
	        var rtn = false;

	        var Val = $("#e_faren").val();
	        if (!nameReg.test(Val) && Val != '') {
	            $('#error').html('填写正确的法人');
	            $('#error').show();
	            rtn = false;
	        } else {
	            $('#error').hide();
	            rtn = true;
	        }
	        return rtn;
	    }	    

	    function idcardblur() {
	        var rtn = false;
	        var Val = $("#e_fridcard").val();
	        if (!cardReg.test(Val) && Val != '') {
	            $('#error').html('请填写正确的法人身份证号码');
	            $('#error').show();
	            rtn = false;
	        } else {
	            $('#error').hide();
	            rtn = true;
	        }
	        return rtn;
	    }
	    function bankcardblur() {
	        var rtn = false;
	        var Val = $("#e_bankno").val();
	        if (!bankCardReg.test(Val) && Val != '') {
	            $('#error').html('请填写正确的企业对公账号');
	            $('#error').show();
	            rtn = false;
	        } else {
	            $('#error').hide();
	            rtn = true;
	        }
	        return rtn;
	    }

	    function ephoneblur() {
	        var rtn = false;
	        var Val = $("#e_mobile").val();
	        if (!phoneReg.test(Val) && Val != '') {
	            $('#error').html('请填写正确的联系人手机号码');
	            $('#error').show();
	            rtn = false;
	        } else {
	            $('#error').hide();
	            rtn = true;
	        }
	        return rtn;
	    }

	    $(function () {
	        $('#e_faren').blur(function () {
	            usernameblur();
	        });
	        $('#e_fridcard').blur(function () {
	            idcardblur();
	        });
	        $('#e_bankno').blur(function () {
	            bankcardblur();
	        });
            
	        $('#e_mobile').blur(function () {
	            ephoneblur();
	        });

	        $("#btnSendMsg").click(function () {
	            if ($("#btnSendMsg").val() == "获取验证码" || $("#btnSendMsg").val() == "重新获取") {
	                if (!ValidateMobilerNumber()) {
	                    return false;
	                }
	                else {
	                    timer = setInterval(function () {
	                        getTime();
	                    }, 1000);
	                    GetVerificationCode();

	                }
	            }
	        });

	        $(".btn-reg").click(function () {
	            if ($("#e_name").val() == "")
	            {
	                $(".error").html("企业名称不能为空！");
	                $(".error").show();
	                return false;
	            }
	            if ($("#e_bankxkz").val() == "")
	            {
	                $(".error").html("开户银行许可证号不能为空！");
	                $(".error").show();
	                return false;
	            }

	            if ($("#e_orgcode").val() == "" && $("#e_shuiwudj").val() == "" && $("#e_zhizhao").val() == "")
	            {
	                $(".error").html("企业三证至少填一项！");
	                $(".error").show();
	                return false;
	            }
	            if ($("#e_faren").val() == "")
	            {
	                $(".error").html("法人不能为空！");
	                $(".error").show();
	                return false;
	            }
	            if (!usernameblur())
	                return false;

	            if ($("#e_fridcard").val() == "")
	            {
	                $(".error").html("法人身份证号不能为空！");
	                $(".error").show();
	                return false;
	            }
	            if (!idcardblur())
	                return false;
                
	            if ($("#e_contract").val() == "")
	            {
	                $(".error").html("企业联系人不能为空！");
	                $(".error").show();
	                return false;
	            }
	            if ($("#e_mobile").val() == "") {
	                $(".error").html("联系人手机号不能为空！");
	                $(".error").show();
	                return false;
	            }
	            if (!ephoneblur())
	                return false;

	            if ($("#e_bankno").val() == "")
	            {
	                $(".error").html("企业对公账号不能为空！");
	                $(".error").show();
	                return false;
	            }
	            if (!bankcardblur())
	                return false;

	            if ($("#verification").val() == "") {
	                $(".error").html("手机验证码不能为空！");
	                $(".error").show();
	                return false;
	            }

	            var from = "";
	            var umobile = $("#e_mobile").val();
	            var ucode = $("#verification").val();
	            var ubankno = $("#e_bankno").val();	          
	            var bankLicense = $("#e_bankxkz").val();
	            var businessLicense = $("#e_zhizhao").val();
	            var contact = $("#e_contract").val();
	            var contactPhone = $("#e_mobile").val();
	            var creditCode = $("#e_creditCode").val();
	            var enterpriseName = $("#e_name").val();
	            var legal = $("#e_faren").val();
	            var legalIdCardNo = $("#e_fridcard").val();
	            var orgNo = $("#e_orgcode").val();
	            var taxNo = $("#e_shuiwudj").val();
	            var unifiedCode = $("#e_unifiedCode").val();
	            $.ajax({
	                url: "/ajaxCross/ajax_cgt.ashx",
	                type: "post",
	                dataType: "json",
	                data: {
	                    cmd: "Register", from: from, umobile: umobile, verificationCode: ucode,
	                    ubnakno: ubankno, bankLicense: bankLicense, registertype: "2", businessLicense: businessLicense,
	                    contact: contact, contactPhone: contactPhone, creditCode: creditCode, creditCode: creditCode,
	                    enterpriseName: enterpriseName, legal: legal, legalIdCardNo: legalIdCardNo, orgNo: orgNo, taxNo: taxNo,
	                    unifiedCode: unifiedCode
	                },
	                success: function (json) {
	                    if (json.result == "cgt") {
	                        var url = unescape(json.msg);
	                        window.location.href = url;
	                    }
	                    else if (json.result == "1") {
	                        $('#error').html("");
	                        $('#error').hide();
	                        window.location.href = "/user/user2/seccessful.html";
	                    }
	                    else {
	                        if (json != null && json != undefined) {
	                            $('#error').html(json.msg);
	                            $('#error').show();
	                        }
	                    }
	                },
	                error: function (obj) {
	                    var i = 0;
	                }
	            });


	        });
	    });	  
	</script>

</html>