<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reg.aspx.cs" Inherits="TuanDai.WXApiWeb.user.user.reg" %>

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
    <script src="js/zepto.min.js"></script>
    <script src="js/config.js"></script>
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
                $.init()
            };
            recalc();
            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false);
        })(document, window);
    </script>
    <!-- Google Web Fonts -->

    <link rel="stylesheet" href="dist/css/sm.css">
    <link rel="stylesheet" href="dist/css/sm-extend.css">
    <link rel="stylesheet" href="css/demos.css">

    <link rel="apple-touch-icon-precomposed" href="/assets/img/apple-touch-icon-114x114.png">
    <!--<script src="//hm.baidu.com/hm.js?ba76f8230db5f616edc89ce066670710"></script> -->   
    <link rel="stylesheet" href="css/reg.css?v=20160830" />
</head>

<body>
    <header>
        <img src="images/logo.png" class="logo">
        <p>欢迎您，完善以下信息即可完成注册！</p>
    </header>

    <section class="input-box md1" id='input-box'>
        <div class="input_wraper">
            <input type="text" name="phone" class="codeIpt" id="phone" placeholder="手机号" maxlength="11" />
            <input type="text" name="user_name" class="codeIpt" id="user_name" placeholder="姓名" />
            <input type="text" name="id_card" class="codeIpt" id="id_card" placeholder="身份证号" />
            <input type="text" name="bank_card" class="codeIpt" id="bank_card" placeholder="银行卡号" />

            <div class="content native-scroll">
                <div id="page-city-picker" class="page page-current">
                    <div class="content-block">
                        <div class="list-block">
                            <ul>
                                <!-- Text inputs -->
                                <li>
                                    <div class="item-content">
                                        <div class="item-inner">
                                            <div class="item-title label">开户行(省市区)</div>
                                            <div class="item-input">
                                                <input type="text" placeholder="" id="city-picker" readonly="">
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <input type="text" name="bank_branches" class="codeIpt" id="bank_branches" placeholder="开户行网点（支行）" />
            <div class="verification_wraper">
                <input type="text" name="verification" class="codeIpt verification" id="verification" placeholder="手机验证码" />
                <input type="button" id="btnSendMsg" class=" btnSendMsg" value="获取验证码" />
            </div>
        </div>
        <a href="#" class="btn-reg">马上注册</a>
        <p class="error" id="error">请填写正确的身份证号码</p>
        <script src="dist/js/sm.js"></script>
        <script src="dist/js/sm-extend.js"></script>
        <script src="dist/js/sm-city-picker.js"></script>
        <script src="js/demos.js"></script>
</body>
<script type="text/javascript">
    /*获取手机验证码*/
    function GetVerificationCode() {        
        var mobileNumber = $("#phone").val();
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
        var mobileNumber = $("#phone").val();       
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

    var phoneReg = new RegExp("^(13|14|15|17|18)[0-9]{9}$", "i");
    $(function () {
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
            $('#error').hide();

            if ($("#phone").val() == "")
            {
                $('#error').html('手机号不能为空!');
                $('#error').show();
                return false;
            }
            if (!phoneblur())
                return;
           
            if ($("#user_name").val() == "") {
                $('#error').html('姓名不能为空!');
                $('#error').show();
                return false;
            }
            if (!usernameblur())
                return false;
           
            if ($("#id_card").val() == "") {
                $('#error').html('身份证号不能为空!');
                $('#error').show();
                return false;
            }
            if (!idcardblur())
                return false;

            $("#id_card").blur();
            if ($("#bank_card").val() == "") {
                $('#error').html('银行卡号不能为空!');
                $('#error').show();
                return false;
            }

            if (!bankcardblur())
                return;

            $("#bank_card").blur();
            if ($("#bank_branches").val() == "") {
                $('#error').html('开户行网点不能为空!');
                $('#error').show();
                return false;
            }
            $("#bank_branches").blur();
            if ($("#verification").val() == "")
            {
                $('#error').html('验证码不能为空!');
                $('#error').show();
                return false;
            }
            if ($('#error').css("display") == "block")
            {
                return false;
            }

            var utelno = $("#phone").val();
            var uname = $("#user_name").val();
            var ucard = $("#id_card").val();
            var ubankno = $("#bank_card").val();
            var uprovince = "";
            var ucity = "";
            var list = $("#city-picker").val().split(" ");
            if (list.length >= 2)
            {
                uprovince = list[0] + "省";
                ucity = list[1] + "市";
            }
            //city-picker
            var uopenname = $("#bank_branches").val();
            var ucode = $("#verification").val();
            var from = "";

            $.ajax({
                url: "/ajaxCross/ajax_cgt.ashx",
                type: "post",
                dataType: "json",
                data: {
                    cmd: "Register", from: from, mobileNumber: utelno, verificationCode: ucode,
                    uname: uname, ucard: ucard, ubnakno: ubankno, uprovince: uprovince, ucity: ucity, uopenname: uopenname, registertype: "1"
                },
                success: function (json) {
                    var i = 3;
                    if (json.result == "1") {
                        $('#error').html("");
                        $('#error').hide();                        
                        window.location.href = "/user/user/seccessful.html";
                    }
                    else {
                        if (json != null && json != undefined)
                        {
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
      
    var nameReg = /^([\u4e00-\u9fa5]){2,7}$/;
    var cardReg = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
    var bankCardReg = /^(\d{16}|\d{19})$/;
    var phoneReg = new RegExp("^(13|14|15|17|18)[0-9]{9}$", "i");

    function usernameblur()
    {
        var rtn = false;

        var Val = $("#user_name").val();
        if (!nameReg.test(Val) && Val != '') {
            $('#error').html('填写正确的姓名');
            $('#error').show();
            rtn = false;
        } else {
            $('#error').hide();
            rtn = true;
        }
        return rtn;
    }
    $('#user_name').blur(function () {
        usernameblur();
    });

    function phoneblur()
    {
        var rtn = false;
        var Val = $("#phone").val();
        if (!phoneReg.test(Val) && Val != '') {
            $('#error').html('请填写正确的手机号码');
            $('#error').show();
            rtn = false;
        } else {
            $('#error').hide();
            rtn = true;
        }
        return rtn;
    }

    $('#phone').blur(function () {
        phoneblur();
    });

    function idcardblur()
    {
        var rtn = false;
        var Val = $("#id_card").val();
        if (!cardReg.test(Val) && Val != '') {
            $('#error').html('请填写正确的身份证号码');
            $('#error').show();
            rtn = false;
        } else {
            $('#error').hide();
            rtn = true;
        }
        return rtn;
    }

    $('#id_card').blur(function () {
        idcardblur();
    });

    function bankcardblur()
    {
        var rtn = false;
        var Val = $("#bank_card").val();
        if (!bankCardReg.test(Val) && Val != '') {
            $('#error').html('请填写正确的银行卡号');
            $('#error').show();
            rtn = false;
        } else {
            $('#error').hide();
            rtn = true;
        }
        return rtn;
    }

    $('#bank_card').blur(function () {
        bankcardblur();
    });

    $('.btn-reg').on('touchstart', function () {
        $(this).addClass('btn-click');
    });

    $('.btn-reg').on('touchend', function () {
        $(this).removeClass('btn-click');
    });
</script>

</html>
