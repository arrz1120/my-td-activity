<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoInvest.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.ExperienceGold.GoInvest" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no">
    <title>注册团贷网新用户即送18000元体验金</title>
    <meta name="keywords" content="团贷网,你我金融,互联网金融,P2P网贷,P2P理财">
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=20160509001" /><!--base-->
    <link rel="stylesheet" type="text/css" href="css/style.css?v=20160509001" /> 
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>  
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>     
    <script type="text/javascript" src="/scripts/weixinapi.js?v=3.4"></script> 
    
     <script type="text/javascript">
         wxData.isWxJsSDK = true;
         //wxData.debug = true;
         wxData.url = "http://m.tuandai.com/Activity/ExperienceGold/Index.aspx";
         wxData.title = "注册团贷网新用户即送18000元体验金";
         wxData.desc = "投资体验金专享标，到期即可获得利息收益红包!";
         wxData.img_url = "http://m.tuandai.com/Activity/ExperienceGold/imgs/banner1.png";
         wxData.ShareCallBack = function (ex) {
             // alert(ex == "success" ? "分享成功" : "取消分享");
         }
    </script>   
</head>
<body class="wrap-bg2">

<section class="wrap">
    <div>
        <img src="imgs/banner2.png?v=201605090001"/>
    </div>
    <section class="main-box pl40 pr40 mt15">
        <h3 class="f14px pb20 c-a25b06 title1">
            <img src="imgs/ico-j.png"/>
            <img src="imgs/ico-d.png"/>
            【体验金专享标1】
        </h3>
        <div class="main-cn">
            <p class="c-d97b0b mt15 f15px">借款金额：<span class="c-a25b06 f20px">200万</span></p>
            <div class="clearfix">
                <p class="lf c-d97b0b f15px mt15">期限：<span class="c-a25b06 f20px">1天</span> </p>
                <p class="rf c-d97b0b f15px mt15">利率：<span class="c-ff3526 f20px">10%</span></p>
            </div>
            <div class="pro-bar-box mt15">
                <div class="pos-r progress-bar">
                    <div class="progress bg-ffc840" style="width: 49.4%"></div>
                    <span class="solid-dot" style="left: 46%;">49.4%</span>
                </div>
            </div>
            <a href="javascript:;" class="invest-but f16px mt15" id="investBut">我要投资</a>
            <p class="mt15 c-a25b06"><img src="imgs/ico-z.png"/>此标的仅限新用户使用体验金投资</p>
        </div>

        <div class="popup-wrap">
            <div class="popup animated">
                <h3 class="f16px clearfix">赚钱就是这么简单 <a href="javascript:void(0);" class="rf" id="close"><img src="imgs/close.png" alt=""/></a></h3>
                <div class="nub-box pl15 pr15 mt15">
                    <p class="f12px c-d97b0b clearfix">您的可用余额：<span class="c-a25b06 f14px">18,000元</span>
                    <a href="/Member/Bank/Recharge.aspx" class="recharge f14px rf">我要充值</a></p>
                    <p class="f12px c-d97b0b">最大出借份数：<span class="c-a25b06 f14px">18000份</span></p>
                    <p class="f12px c-d97b0b">预期收益：<span class="c-ff3526 f15px">5元</span></p>
                    <div class="inp-wrap pos-r mt15">
                        <a href="javascript:void(0)" class="pos-a minus count-but" id="minus">
                           <%-- <img src="imgs/minus.png">--%>
                        </a>
                        <div class="pos-a input-box">
                            <input class="number-text" name="txtShares" type="text" value="18000份" maxshares="18000" disabled="disabled">
                        </div>
                        <a href="javascript:void(0)" class="pos-a plus count-but" id="plus">
                          <%--  <img src="imgs/plus.png">--%>
                        </a>
                        <input type="button" id="btnInvest"  class="loan-but f14px pos-a" value="确认出借">
                    </div>
                </div>
            </div>
        </div>
    </section>
</section>
  


<!--弹窗-->
<section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
  <div class="hbody clearfix" style="margin-bottom: 9px;">
    <i class="ico-exclamation40 lf mr10"></i>
    <span id="msg" style="  font-size: 14px;line-height: 39px;"></span>
  </div>
  <div class="completeBox clearfix">
    <span style="float: right;max-width: 40%;">
        <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>  
    </span>
    <span style="float: right;max-width: 60%;padding-right: 20px;">
        <input type="button" class="btn btnGreen h40" value="取消" id="btnCancel" onclick="Done()" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;"/> 
    </span>
  </div>
</section>
<!--遮罩层-->
<div class="maskLayer hide"></div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#btnInvest").click(function () {
            $("#btnInvest").unbind("click");
            DoInvest();
        });
        $("#investBut").click(function () {
            $(".popup-wrap").fadeIn(400);
            $(".popup").addClass("fadeInUp");
        });

        $("#close").click(function () {
            $(".popup-wrap").fadeOut(400);
        });
    });
   
    function DoInvest() { 
        $.ajax({
            type: "post",
            async: false,
            url: "/Activity/ExperienceGold/RegHandler.ashx",
            data: { cmd: "ExperienceGoldInvest" },
            dataType: "json",
            success: function (json) {
                if (json != null) {
                    switch (json.result) {
                        case "-1":
                            ShowMsg('您还未登录，登录之后才能投资', '1', '登录',
                            function(){
                                window.location.href = '/user/Login.aspx?ReturnUrl=' + window.location.href;
                            });
                            break;
                        case "-100":
                            ShowMsg("程序异常!");
                            break;
                        case "-101":
                        case "0":
                            ShowMsg("领取失败!");
                            break;
                        case "1": //成功后跳转到投资列表页 
                            window.location.href = "InvestSuccesed.aspx";
                            break;
                        case "2":
                            ShowMsg('您已经领取过体验金红包，不能再领取了！不过还有更多新手红包等您来领取', '1', '领更多红包',
                                      function(){
                                          window.location.href="/Member/UserPrize/Index.aspx";
                                      });
                            break;
                        case "3":
                            ShowMsg('未领取体验金红包', '1', '立即领取', function () {
                                window.location.href="/Member/UserPrize/Index.aspx";
                            });
                            break;
                        case "4":
                            ShowMsg('对不起，您的体验金红包已过期');
                            break;
                        case "5":
                            ShowMsg('对不起，您的体验金红包已经使用');
                            break;
                    }
                } else {
                    ShowMsg("领取失败,请重试!");
                }
            },
            error: function () {
                ShowMsg("领取失败,请重试!");
            }
        });
        $("#btnInvest").click(DoInvest);
    }

    function Done() {
        $(".maskLayer").fadeOut();
        $("#affirmLoanMain").animate({
            bottom: "-430px"
        }, 200)
        $("#tip").animate({
            bottom: "-430px"
        }, 200);
    }
    function ShowMsg(msg, isShowOk, okValue, handle) {
        $(".maskLayer").fadeIn();
        $("#msg").html(msg);
        if (isShowOk == "1") {
            $("#btnOk").html(okValue);
            $("#btnOk").attr("href", "javascript:;");
            $('#btnOk').unbind('click').bind('click', handle);
            $("#btnCancel").val("取消");
            $("#btnOk").parent().show();
        } else {
            $("#btnCancel").val("确定");
            $("#btnOk").parent().hide();
        }
        var bottom = (document.documentElement.clientHeight - document.getElementById("tip").offsetHeight) / 2;
        $("#affirmLoanMain").animate({
            bottom: "-430px"
        }, 200)

        $("#tip").animate({
            bottom: bottom
        }, 200);
    }
</script>
</body>
</html>
