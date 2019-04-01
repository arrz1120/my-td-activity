<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reg_1.aspx.cs" Inherits="TuanDai.WXApiWeb.user.user2.reg_1" %>
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
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <link rel="stylesheet" href="css/reg.css?v=20160830" />
	  </head>

	<body>
  <header>
    <img src="images/logo.png" class="logo logo_1">
  </header>

    <section class="input-box md1" id='input-box'>  
      <div class="input_wraper">  
        <input type="text" name="phone" class="codeIpt" id="txtMobileNumber" placeholder="手机号" maxlength="11" />
        <div class="verification_wraper"> 
            <input type="text" name="verification" class="codeIpt verification" id="verification" placeholder="手机验证码" />
            <input type="button" id="btnSendMsg" class=" btnSendMsg" value="获取验证码"/>
        </div>
      </div>
      <a href="#" class="btn-reg btn-reg-2" id="login_btn">马上登录</a>
      <a href="reg.aspx" class="btn_reg_1" id="reg_btn">注册</a>
      <p class="error" id="error">请填写正确的手机号码</p>
  
	</body>
   <script type="text/javascript">
       /*获取手机验证码*/
       function GetVerificationCode() {
           var validCode = $("#txtValidNumber").val();
           var mobileNumber = $("#txtMobileNumber").val();
           var validCode;
           $.ajax({
               url: "/ajaxCross/ajax_cgt.ashx",
               type: "post",
               dataType: "json",
               data: { cmd: "GetPhoneCode", mobilenumber: mobileNumber, ValidCode: validCode,codetype:"login" },
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
           var mobileNumber = $("#txtMobileNumber").val();
           var telno = $("#txtTelNo").val() || "";
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
           else if (telno != "") {
               if (!phoneRegex.test(telno)) {
                   //$("body").showMessage({ message: "邀请人手机号码格式不正确!", showCancel: false });
                   $('#error').html('邀请人手机号码格式不正确!');
                   $('#error').show();
                   //$("#lblTelNo").text("邀请人手机号码格式不正确");
                   //$("#lblTelNo").show();
                   result = false;
               }
               else {
                   //$("#lblTelNo").hide();
                   result = true;
                   $('#error').html('');
                   $('#error').hide();
               }
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
                           $('#error').html('');
                           $('#error').hide();
                           //$("#lblMobileNumber").text("手机已注册");
                           //$("#lblMobileNumber").show();
                           result = true;
                       }
                       else {
                         
                           result = false;
                           $('#error').html('用户不存在!');
                           $('#error').show();
                       }
                   },
                   error: function () {
                       var i = 0;
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
               $("#btnSendMsg").val((181 - angle) +"秒后重试");               
           }
       }

       var phoneReg = new RegExp("^(13|14|15|17|18)[0-9]{9}$", "i");
       $(function () {
           $("#btnSendMsg").click(function () {
               if ($("#btnSendMsg").val() == "获取验证码" || $("#btnSendMsg").val()=="重新获取") {
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
       });

       function phoneblur()
       {
           var isOk = false;
           var Val = $("#txtMobileNumber").val();
           if (!phoneReg.test(Val) && Val != '') {
               isOk = false;
               $('#error').html('请填写正确的手机号码');
               $('#error').show();
           } else {
               isOk = true;
               $('#error').hide();
           }
           return isOk;
       }

       $('#txtMobileNumber').blur(function () {
           phoneblur();
       });

       $("#login_btn").click(function () {

           if ($("#txtMobileNumber").val() == "" || $("#txtMobileNumber").val() == "手机号")
           {
               $('#error').html('请输入手机号！');
               $('#error').show();
               return;
           }


           if (!phoneblur())
               return;

           if ($("#verification").val() == ""||$("#verification").val()=="手机验证码")
           {
               $('#error').html('请输入手机验证码！');
               $('#error').show();
               return;
           }
          
           var mobileNumber = $('#txtMobileNumber').val();
           var coderecord = $("#verification").val();

           $.ajax({
               url: "/ajaxCross/ajax_cgt.ashx?cmd=LoginSubmit",
               type: "post",             
               data: { cmd: "LoginSubmit", mobilenumber: mobileNumber, coderecord: coderecord },
               dataType: "json",
               timeout: 3000,
               success: function (jsondata) {
                   var data = jsondata.result;
                   if (data == "1") {
                       result = true;
                       $('#error').html('');
                       $('#error').hide();
                       window.location.href = "/user/user2/change_msg.aspx?telno=" + mobileNumber;
                   }
                   else {
                       //$("body").showMessage({ message: "手机已注册!", showCancel: false });
                       $('#error').html(jsondata.msg);
                       $('#error').show();
                       //$("#lblMobileNumber").text("手机已注册");
                       //$("#lblMobileNumber").show();
                       result = false;
                      
                   }
               },
               error: function (obj)
               {
                   var i = 0;
               }
           });           
       });


       $('#login_btn').on('touchstart', function () {
           $(this).addClass('btn-click');
       });

       $('#login_btn').on('touchend', function () {
           $(this).removeClass('btn-click');
       });

       $('#reg_btn').on('touchstart', function () {
           $(this).addClass('login_btn_click');
       });

       $('#reg_btn').on('touchend', function () {
           $(this).removeClass('login_btn_click');
       });

   </script>

</html>