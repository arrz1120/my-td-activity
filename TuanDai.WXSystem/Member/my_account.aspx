﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_account.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.my_account" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>我的账户</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" href="/wap/css/personalCenter.css?v=<%=GlobalUtils.Version %>">
    <script>
        //动态算rem
        (function (doc, win) {
            var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function () {
                    // if (docEl.style.fontSize) return;
                    clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    docEl.style.fontSize = 20 * (clientWidth / 320) + "px";
                    if (document.body) {
                        document.body.style.fontSize = docEl.style.fontSize;
                    }
                };
            recalc();
            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener("DOMContentLoaded", recalc, false);
        })(document, window);
    </script>
</head>

<body class="bg-f1f3f5">
    <div class="loading-box" id="cMloading">
        <div class="loading-tips">
            <img src="/imgs/images/icon/ico_loading.png" alt=""><span>加载中...</span>
        </div>
    </div>

    <div class="wrapper">
        <div class="top-bar bg-fff">
            <div class="avatar" style="background-image:url(<%=headImage%>);background-size:1.5rem 1.5rem;">
                <%--<img src="<%=headImage%>" alt="">--%>
            </div>
            <!--特级标识v1 v2 v3 v4 v5 v6 v7 v8-->
            <span class="name"><%=userModel!=null?userModel.NickName:""%> <i class="grade <%=UserVipModel!=null ?"v"+UserVipModel.Level:"v1" %>"></i></span>
            <%--<a href="/Member/my_userInfo.aspx" class="to-cg">存管，密码<i></i></a>--%>
            <% if (IsHavaTQJiaXi)
               {
            %>
            <a id="float_1218" class="to-hd">
                <img src="/wap/images/personalCenter/icon-jx.png" alt="">
            </a>
            <%
               } %>
            
            <a href="my_account_more.aspx" class="to-setting"></a>
        </div>
        <div class="zc-con bg-fff">
            <div class="my-zc">
                <span class="txt-zc">我的团贷资产 <i id="eye" class="eye ico_unsee"></i></span>
                <span class="money" id="totalAmount">--</span>
                <a href="<%=GlobalUtils.IsOpenSubscribeApi?"":"//m.tdw.cn" %>/member/fundStatistics/incomeCount.aspx">查看详情<i></i></a>
            </div>
            <div class="balance">
                <span class="yue">可用余额</span>
                <span class="yue-nb" id="totalAviMoney">--</span>
                <a href="/pages/downOpenApp.aspx" class="to-tx">提现</a>
                <a href="/pages/downOpenApp.aspx" class="to-cz">充值</a>
            </div>
            <div class="webkit-box link-con">
                <a href="/Member/Repayment/return_plan_list.aspx" class="box-flex1"><i class="icon-hk"></i>回款计划</a>
                <a href="/Member/Repayment/my_return_list.aspx" class="box-flex1"><i class="icon-jl"></i>投资记录</a>
            </div>
        </div>
        <div class="j-con">
            <a href="/Member/Repayment/my_return_date.aspx" class="j-a"><i class="c1"></i>财富日历</a>
            <a href="/Member/Repayment/my_bills.aspx" class="j-a"><i class="c2"></i>账单</a>
            
            <a href="/Member/zx_manager.aspx" class="j-a"><i class="c3"></i>周转管理</a>
           
            <% if ((DQDueInMoney > 0 && userModel.AddDate < DateTime.Parse(xiajia.Param1Value)) || (new GlobalUtils().GetNewVipUserInfo(WebUserAuth.UserId.Value).Level >= 5 && userModel.AddDate < DateTime.Parse(xiajia.Param1Value)))
               {
                   %>
            <a href="/Member/PSWealth.aspx" class="j-a"><i class="c4"></i>迅辉财富</a>
            <%
               } %>
            <a href="/Member/UserPrize/Index.aspx" class="j-a"><i class="c5"></i>团宝箱</a>
            <a href="https://at.tuandai.com/201708/invite/weixin/invite.aspx" class="j-a"><i class="c6"></i>我的邀请</a>
        </div>
    </div>

    <!--底部-->
    <div class="pageBottom">
        <a href="//m.tuandai.com" class="bottom-item bottom-index" style="padding-top: 1rem;">首页</a>
        <a class="bottom-item bottom-my-cur" style="padding-top: 1rem;">我</a>
    </div>
    
    <!--下载app弹框-->
    <div class="alert webkit-box box-center" id="downApp" style="display: none;">
		<div class="account_alert">
			<img src="/imgs/account/dlapp.png?v=20171201"/>
			<div class="account_alert_close"></div>
			<a href="javascript:void(0);" class="dlbtn download">下载APP</a>
		</div>
	</div>

    <!--新手注册完成后进入个人中心显示的弹框-->
    <div class="alert" style="display: none;" id="newHandDiv">
        <div class="res_finish comonAni">
            <div class="r_f_close"></div>
            <img src="/imgs/account/res_finish.png" />
            <div class="r_f_bot pb15 pl15 pr15">
                <a href="<%=GlobalUtils.MVipUrl %>/pages/invest/invest_newHand.aspx">查看新手福利</a>
                <a href="/Member/ready/ready.aspx">投资前准备</a>
                <p class="c-ffffff f13px text-center mt3">完成投资前准备，马上投资赚收益</p>
            </div>
        </div>
    </div>
    
    <!--加息特权弹框-->
	<div class="alert webkit-box box-center" style="display: none;" id="jiaxi">
		<div class="account_alert jiaxi_alert">
			<img src="/imgs/20171218/jiaxi_mask.png"/>
			<div class="account_alert_close"></div>
			<a href="/Member/jiaxitequan/html/jiaxitequan.aspx" class="jiaxibtn">
				<img src="/imgs/20171218/jiaxi_btn.png"/>
			</a>
		</div>
	</div>

</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/Common.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript">
    var IsInWeiXin = "<%=IsInWeiXin %>";
    function encryptAmount(seeType) {
        if (seeType == "" || seeType == undefined)
            seeType = "0";
        var seeCtrl = $("#eye");
        if (seeType == "0") {
            $("#totalAmount").html("--<i class=\"s-arrow\"></i>");
            $("#totalAviMoney").text("--");
            seeCtrl.removeClass("ico_see").addClass("ico_unsee");
        } else {
            $("#totalAmount").html("<%=ToolStatus.ConvertLowerMoney(pageModel.TotalAmount)%><i class=\"s-arrow\"></i>");
            $("#totalAviMoney").text("<%=ToolStatus.ConvertLowerMoney(pageModel.TotalAviAmount)%>");
            seeCtrl.removeClass("ico_unsee").addClass("ico_see");
        }
    }

    $(function () {
        $("#showDownloadAlert").click(function () {
            showAniFadeIn("#downApp");
        });

        $(".account_alert_close").click(function () {
            hideAniFadeOut("#downApp");
        });
        var noSee = getCookie("noSee");
        encryptAmount(noSee);

        $("#eye").click(function () {
            if ($(this).hasClass("ico_see")) {
                setCookie("noSee", "0");
                encryptAmount("0");
            } else {
                setCookie("noSee", "1");
                encryptAmount("1");
            }
        });

        $("#autoBid").click(function () {
            try {
                //--------存管通验证----2016-12-21------
                if (isOpenCGT == "1" && !checkIsOpen())
                    return false;
                //--------存管通验证结束------------
                window.location.href = "<%= GlobalUtils.MTuanDaiURL%>/Member/setAuto/auto_invest.aspx";
            } catch (e) {

            }
        });
        $("#myVip").click(function () {
            try {
                //--------存管通验证----2016-12-21------
                if (isOpenCGT == "1" && !checkIsOpen())
                    return false;
                //--------存管通验证结束------------
                window.location.href = "<%=GlobalUtils.MVipUrl%>/Member/MemberCenter/memberCenter.aspx";
            } catch (e) {

            }
        });
    });
    var browser = {
        versions: function () {
            var u = navigator.userAgent, app = navigator.appVersion;
            return {
                //移动终端浏览器版本信息
                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或uc浏览器
                iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
                iPad: u.indexOf('iPad') > -1, //是否iPad
            };
        }(),
    };
    $(".download").click(function () {
        if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
            window.location.href = "http://www.tuandai.com/app/install.aspx";
        }
        else if (browser.versions.android) {
            window.location.href = "http://image.tuandai.com/tuandaiapp/tuandai.apk";
        } else {
            window.location.href = "http://hd.tuandai.com/weixin/tuandaiAppNew/IndexApp.aspx?type=weixinapp";
        }
    });

    var wxtype = GetQueryString("wxtype");
    if (wxtype == "newhand")
        showAniFadeIn("#newHandDiv");
    $(".r_f_close").click(function () {
        hideAniFadeOut("#newHandDiv");
    });


    $("#float_1218").click(function() {
        $("#jiaxi").show();
    });
    $(".account_alert_close").click(function() {
        $("#jiaxi").hide();
    });
</script>

</html>
