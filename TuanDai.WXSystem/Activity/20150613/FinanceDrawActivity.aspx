<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FinanceDrawActivity.aspx.cs"
    Inherits="TuanDai.WXApiWeb.Activity.FinanceDrawActivity" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <meta name="format-detection" content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=20150907" />
    <link rel="stylesheet" type="text/css" href="css/main.css?v=20150608" />
    <title>兑换红包</title>
    <!--安全中心-->
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#btnReceive").click(function () {
                if($("#txtCode").val()==""){
                    ShowMsg('请输入兑换密码');
                     return;
                }
                $.ajax({
                    url: "/ajaxCross/ajax_Acticity.ashx",
                    type: "post",
                    dataType: "json",
                    async: true,
                    data: {
                        Cmd: "ExchangeCode",
                        Code: $("#txtCode").val()
                    }, success: function (data) {
                        switch (data.result) {
                            case "1":
                                window.location = "FinanceDrawSuccess.aspx";
                                break;
                            case "2":
                                ShowMsg('您还未登录，登录之后才能兑换', '登录', '/user/Login.aspx');
                                break;
                            case "3":
                                ShowMsg('请输入兑换密码');
                                break;
                            case "-1":
                            case "-2":
                            case "-3":
                            case "-4":
                            case "-5":
                                window.location = "FinanceDrawFail.aspx?type=" + data.result;
                                break;
                            default:
                                ShowMsg(data.msg);
                                break;
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        ShowMsg("兑换失败，请重试!");
                    }
                });
            });
        });

        function Done() {
            $(".maskLayer").fadeOut();
            $("#tip").animate({
                bottom: "-430px"
            }, 200)
        }

        function ShowMsg(msg,btnName,url) {
            $(".maskLayer").fadeIn();
            $("#msg").html(msg);
            $("#btnOk").html(btnName);
            $("#btnOk").click(function () {
                if (url != '' && url!=undefined)
                 {
                     window.location=url;
                 }else{
                      Done();
                 }
             });
            var bottom = (document.documentElement.clientHeight -document.getElementById("tip").offsetHeight) / 2;
            $("#tip").animate({
                bottom: bottom
            }, 200)
        }
    </script>
</head>
<body>
  <header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location.href='/Member/my_account.aspx'">返回</div>
        <h1 class="title">兑换红包</h1>
    </div>
    <div class="none"></div>
</header>
   <section class="wrapper">
    <div class="main pos-r">
        <img src="imgs/logo.png" alt="" class="logo"/>
        <img src="imgs/p1.png?v=20150608001" alt="" class="p1"/>
        <div class="form-box">
            <div class="clearfix">
                  <p class="lf">用户名:<span><%=userName %></span></p>
                  <a href="/user/LogOut.aspx?ReturnUrl=<%=HttpContext.Current.Request.RawUrl %>" class="quit rf">[退出登录]</a>
            </div>
            <input type="text" placeholder="请输入兑换密码" class="exch-code" id="txtCode" />
            <input type="button" value="确定兑换" class="sub-but" id="btnReceive" />
        </div>
    </div>
</section>
    <!--弹窗-->
    <section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
  <div class="hbody clearfix" style="margin-bottom: 9px;">
    <i class="ico-exclamation40 lf mr10"></i>
    <span id="msg" style="  font-size: 14px;line-height: 39px;"></span>
  </div>
  <div class="completeBox clearfix">
    <span style="float: right;max-width: 60%;padding-right: 10px;">
         <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>
    </span>
  </div>
</section>
    <!--遮罩层-->
    <div class="maskLayer hide">
    </div>
</body>
</html>
