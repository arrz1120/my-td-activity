<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="change_msg_1.aspx.cs" Inherits="TuanDai.WXApiWeb.user.user.change_msg_1" %>
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
        <!-- Google Web Fonts -->

    <script src="js/zepto.min.js"></script>
        <link rel="stylesheet" href="css/reg.css?v=20160830" />
	  </head>
  <body class="change_msg">
    <h1 class="welcome">欢迎您</h1>
    <p class="phone_num phone_num_1"><%=telno %></p>
    <a href="#" class="reg_btn btn_1 change_btn change_btn_1" id="cbc_btn">修改银行卡信息</a>
    <a href="#" id="btn_modifyPwd" class="reg_btn btn_1 change_btn change_btn_1">修改交易密码</a>
    <a href="#" id="btn_modifyPhone" class="reg_btn btn_1 change_btn change_btn_1">修改银行预留手机号</a>
     <div class="change_bankcard change_phone_num" id="cbc">
            <h2 class="cpn_tit">修改银行卡信息</h2>
            <p>抱歉，目前暂不支持个人自主更换银行卡信息，如您确实需要更换，请联系客服进行办理，客服热线：400-6410-888   </p>
      <span class="close"></span>
    </div>
  </body>
   <script type="text/javascript">


       $(function () {
           $("#btn_modifyPwd").click(function () {
               ChangePWD();
           });
           $("#btn_modifyPhone").click(function () {
               ModifyPhone();
           });
       });


       $('.change_btn').on('touchstart', function () {
           $(this).addClass('reg_btn_click');
       });

       $('.change_btn').on('touchend', function () {
           $(this).removeClass('reg_btn_click');
       });


       $('#cbc_btn').on('click', function () {
           $('#cbc').show();
       });

       $('.close').on('click', function () {
           $(this).parent().hide();

       });

       function ChangePWD() {
           $.ajax({
               url: "/ajaxCross/ajax_cgt.ashx",
               type: "post",
               dataType: "json",
               async: true,
               data: { Cmd: "ModifyCGTPwd" },
               success: function (json) {
                   var obj = json;
                   if (obj.result == "1") {
                       var url = unescape(obj.msg);
                       window.location.href = url;
                   }
                   else {
                       alert("程序异常！");
                   }

               },
               error: function (err) {
                   var i = 0;
               }
           });
       }
       function ModifyPhone() {
           $.ajax({
               url: "/ajaxCross/ajax_cgt.ashx",
               type: "post",
               dataType: "json",
               async: true,
               data: { Cmd: "ModifyPhone" },
               success: function (json) {
                   var obj = json;
                   if (obj.result == "1") {
                       var url = unescape(obj.msg);
                       window.location.href = url;
                   }
                   else {
                       alert("程序异常！");
                   }

               },
               error: function (err) {
                   var i = 0;
               }
           });

       }


   </script>

</html>