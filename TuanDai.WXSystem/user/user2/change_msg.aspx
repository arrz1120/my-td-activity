<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="change_msg.aspx.cs" Inherits="TuanDai.WXApiWeb.user.user2.change_msg" %>

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


    <script src="js/zepto.min.js"></script>
    <link rel="stylesheet" href="css/reg.css?v=20160830" />
</head>
<body class="change_msg">

    <h1 class="welcome">欢迎您</h1>
    <p class="phone_num"><%=telno%></p>


    <a href="javascript:void(0);" class="reg_btn btn_1 change_btn" id="cpn_btn">修改企业基本信息</a>
    <a href="javascript:void(0);" class="reg_btn btn_1 change_btn" id="cbc_btn">修改交易密码</a>

    <p class="error" id="error">请填写正确的手机号码</p>


</body>
<script type="text/javascript">

    $(function () {
        $("#cpn_btn").click(function () {
            //ENTERPRISE_INFORMATION_UPDATE
            $.ajax({
                url: "/ajaxCross/ajax_cgt.ashx",
                type: "post",
                dataType: "json",
                data: {
                    cmd: "ENTERPRISE_INFORMATION_UPDATE"
                },
                success: function (json) {
                    if (json.result == "1") {
                        var url = unescape(json.msg);
                        window.location.href = url;
                    }
                    else {
                        if (json != null && json != undefined) {
                            $('#error').html(json.msg);
                            $('#error').show();
                        }
                        else {
                            $('#error').html("程序异常");
                            $('#error').show();
                        }
                    }
                },
                error: function () {
                    var i = 0;
                }
            });
        });
        $("#cbc_btn").click(function () {
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
        });
    });


    $('.change_btn').on('touchstart', function () {
        $(this).addClass('reg_btn_click');
    });

    $('.change_btn').on('touchend', function () {
        $(this).removeClass('reg_btn_click');
    });

    $('#change_btn_phone').on('touchstart', function () {
        $(this).addClass('btn-click');
    });

    $('#change_btn_phone').on('touchend', function () {
        $(this).removeClass('btn-click');
    });


    $('.close').on('click', function () {
        $(this).parent().hide();
        $('#error').hide();

    });


    $('.change_btn').on('touchstart', function () {
        $(this).addClass('btn-click');
    });

    $('.change_btn').on('touchend', function () {
        $(this).removeClass('btn-click');
    });

    //  $('#cpn_btn').on('click',function(){
    //      $('#cpn').show();
    //  });
    //  
    //  $('#cbc_btn').on('click',function(){
    //      $('#cbc').show();
    //  });


    var phoneReg = new RegExp("^(13|14|15|17|18)[0-9]{9}$", "i");


    $('#phone').blur(function () {
        var Val = $(this).val();
        if (!phoneReg.test(Val) && Val != '') {
            $('#error').html('请填写正确的手机号码');
            $('#error').show();
        } else {
            $('#error').hide();
        }
    });

    var win_h = $(window).height();
    $('.change_phone_num').css('height', win_h + 'px');


    $('.codeIpt').on('focus', function () {
        $('#error').hide();
    });
   </script>

</html>
