<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="operationInfo.aspx.cs"
    Inherits="TuanDai.WXApiWeb.Member.Repayment.operationInfo" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>操盘信息</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/account.css?v=2015090701" />
    <!--账户中心-->
</head>
<body>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="window.location.href='/Member/Repayment/borrowShow.aspx?id=<%=projectId%>'">返回</div>
            <h1 class="title">操盘信息</h1>
        </div>
        <div class="none"></div>
    </header>
    <div class="operationInfoMain pb75">
        <section class="tipBox">借款已完成，您的股票账户信息如下。请下载股票交易客户端进行投资。</section>
        <section class="pd15 c-212121 f14px">操盘资金预览</section>
        <section class="yellowBox">
            <div class="hd">总操盘资金(元)</div>
            <div class="bd">¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.TraderAmount)%></div>
            <div class="fd">
                <div class="contMain">
                    <p>亏损预警线（元）</p>
                    <p>¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.EarlyWarnAmount)%></p>
                </div>
                <div class="contMain">
                    <p>亏损平仓线（元）</p>
                    <p>¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.EveningUpAmount)%></p>
                </div>
            </div>
        </section>
        <% if (gpAcount != null)
           { %>
        <section class="bg-bdtopBom1-ccc bgNone pl15 mt20 clearfix">
            <div class="infoMain">
                <div class="leftBox">股票账户</div>
                <div class="rightBox pr15">
                    <div class="contBox"><%=gpAcount.GPUserName%></div>
                </div>
            </div>
            <div class="infoMain">
                <div class="leftBox">初始密码</div>
                <div class="rightBox pr15">
                    <div class="contBox"><%=gpAcount.FirstPassword %></div>
                </div>
            </div>
        </section>
        <%} %>
        <section class="pd15">
            <a href="javascript:downHomsApp()" class="appDownload">HOMS钱江版app下载</a>
        </section>
        <section class="hint">PC客户端请登录到“HOMS”首页下载</section>
        <section class="loanBtnBox">
           <a href="javascript:void();" onclick="alert('此功能正在开发中！')" class="btn btnYellow borderRadius0 h52">补充保证金</a>
           <%--  <a href="/Member/Repayment/deposit.aspx?id=<%=projectId%>" class="btn btnYellow borderRadius0 h52">补充保证金</a>--%>
        </section>
    </div>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript">
        $(function () {
            //统计
            $('.circle').each(function (index, el) {
                var num = $(this).find('span').text() * 3.6;
                if (num <= 180) {
                    $(this).find('.right').css('transform', 'rotate(' + num + 'deg)');
                }
                else {
                    $(this).find('.right').css('transform', 'rotate(180deg)');
                    $(this).find('.left').css('transform', 'rotate(' + (num - 180) + 'deg)');
                };
                if (num == 360) {
                    $(this).addClass("finish");
                };
            });
        });
        var browser = {
            versions: function () {
                var u = navigator.userAgent, app = navigator.appVersion;
                return { //移动终端浏览器版本信息
                    ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                    android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或uc浏览器
                    iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
                    iPad: u.indexOf('iPad') > -1 //是否iPad
                };
            } ()
        }
        function downHomsApp() {
            if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
                window.location.href = "http://www.ihoms.com/file/xunlei/downloadxunlei/HOMS_IPhone-Official.ipa?fileCode=43&sourceType=4";
                return;
            }
            if (browser.versions.android) {
                window.location.href = "http://www.ihoms.com/file/xunlei/downloadxunlei/HOMS_android-Official.apk?fileCode=45&sourceType=4";
                return;
            }
            window.location.href = "http://www.ihoms.com/file/xunlei/downloadxunlei/HOMS_QiJian/ZhengShi/BiaoZhun/HOMS_Installer_SC.exe?fileCode=2&sourceType=4";
        }
    </script>
</body>
</html>
