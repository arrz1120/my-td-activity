<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="accredit.aspx.cs" Inherits="TuanDai.WXApiWeb.user.user.accredit" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="format-detection" content="telephone=no">
		<title>授权页</title>
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
        <link rel="stylesheet" href="css/reg.css?v=20160830" />
	  </head>

	  <p class="reg_cgh">为了让您后续的借款及还款更加便捷，请您先进行以下授权：</p>
	   <ul class="select_list">
	   	<li><span class='select_icon'></span> <p class="text">自动投标<span>（适用于设置自动投标的用户）</span></p></li>
	   	<li><span class='select_icon'></span> <p class="text">自动购买债权<span>（适用于购买WE计划的用户）</span></p></li>
	   	<li><span class='select_icon'></span> <p class="text">自动还款<span>（适用于有借款的用户）</span></p></li>
	   	<li id="li_tixian"><span class='select_icon'></span> <p class="text">自动提现<span>（适用于企业及业务相关用户）</span></p></li>
	   </ul>	
      <a href="#" class="btn-reg" id="accredit_btn">立即授权</a>




<script src="js/zepto.min.js"></script>
<script type="text/javascript">

    $('.btn-reg').on('touchstart', function () {
        $(this).addClass('btn-click');
    });

    $('.btn-reg').on('touchend', function () {
        $(this).removeClass('btn-click');
    });
    var isshow = '<%= (userMode != null && userMode.UserTypeId == 1) ? 1 : 0 %>';

    $(function () {
        if (isshow == "1")
        {
            $("#li_tixian").hide();
        }
        else
            $("#li_tixian").show();

        $("#accredit_btn").click(function () {
            $.ajax({
                url: "/ajaxCross/ajax_cgt.ashx",
                type: "post",
                dataType: "json",
                data: {
                    cmd: "USER_AUTHORIZATION", TypeId: isshow, opertype: 1
                },
                success: function (json) {
                    if (json.result == "cgt") {
                        var url = unescape(json.msg);
                        window.location.href = url;
                    }
                    else if (json.result == "1") {
                        $('#error').html("");
                        $('#error').hide();
                        window.location.href = "/user/user/seccessful.html";
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



