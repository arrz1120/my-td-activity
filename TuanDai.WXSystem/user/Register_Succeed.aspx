﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register_Succeed.aspx.cs" Inherits="TuanDai.WXApiWeb.user.Register_Succeed" %>

<!DOCTYPE html >

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>注册成功</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
<style type="text/css">
    .td_4th{
        position: fixed;
        left: 0;
        bottom: 0;
        width: 100%
    }

    .td_4th img{ 
        width: 100%;
    }

    .td_4th .close{
        position: absolute;
        right: 0;
        top: 0;
        width: 12.4%;
        height: 30px;
        background: none;
    }
</style>
</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">注册成功</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>
<!--注册成功-->
<div class="succeed-box text-center">
    <div class="box-t">
        <p class="f15px c-694514 pt30">
            <span class="ico-y-cn"><img src="/imgs/images/ico-y.png" alt=""/></span>
            恭喜您成为我们第
        </p>
        <P class="f15px"><span class="c-fd6040 f24px"><%=this.UserCount %></span>位尊贵的客户</P>
        <p class="f14px pt10">您的用户名是:<span class="f14px"><%= this.UserName %></span></p>
    </div>
    <div class="ico-b-bg"></div>
    <div class="box-b mt40">
        <% if (tdfrom.Contains("sinab-M1606"))
           {
               %>
        <p class="f16px">APP签到送超级会员哦</p>
        <div class="link-cn">
            <a class="yes-but f15px download">立即下载APP</a>
        </div>
        <div  onclick="JAVASCRIPT:location.href ='http://hd.tuandai.com/weixin/fuli/index.aspx'+ location.search;" ><span style="margin-right:9%;text-decoration: underline; color: rgb(253,96,64); float: right;" class="f12px">去投资</span></div>
        <%
           }
           else if (!string.IsNullOrEmpty(channel) && channel != "null" && channel != "undefined")
           {
               %>
         <p class="f16px">APP签到送超级会员哦</p>
        <div class="link-cn">
            <a class="yes-but f15px download1">立即下载APP</a>
        </div>
        <div  onclick="JAVASCRIPT:location.href ='http://hd.tuandai.com/weixin/fuli/index.aspx'+ location.search;"><span style="margin-right:9%;text-decoration: underline; color: rgb(253,96,64); float: right;" class="f12px">去投资</span></div>
        <%
           }
           else
           {
               %>
        <p class="f16px">马上参与投资，参考年回报率7%~12.6%</p>
        <div class="link-cn">
            <%if (!string.IsNullOrWhiteSpace(this.returnUrl))
            {%>
            <%--<a href="<%=this.returnUrl %>" class="no-but f15px">暂不认证</a>--%>
            <a href="/Member/UserPrize/RedPacket.aspx?type=3" class="yes-but f15px">查看红包</a>
            <a href="javascript:;" onclick="JAVASCRIPT:location.href ='http://hd.tuandai.com/weixin/fuli/index.aspx'+ location.search;" class="yes-but f15px">马上投资</a>
            <%}
            %>
            <%else 
            {%>
            <%--<a href="<%=TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser?"/WeiXinIndex.aspx":"/Index.aspx" %>" class="no-but f15px">暂不认证</a>--%>
            <a href="/Member/UserPrize/RedPacket.aspx?type=3" class="yes-but f15px">查看红包</a>
            <a onclick="JAVASCRIPT:location.href ='http://hd.tuandai.com/weixin/fuli/index.aspx'+ location.search;" class="yes-but f15px">马上投资</a>
            <%}
            %>
            </div>
        <%
           } %>
    </div>
</div>
<% if ((tdfrom.Contains("SNSMH-M1607-fzzxTT") || !string.IsNullOrEmpty(showActivity)) && DateTime.Parse(WebSetting.Param1Value) < DateTime.Now && DateTime.Now < DateTime.Parse(WebSetting.Param2Value))
   {
       %>
<a class="td_4th" href="http://hd.tuandai.com/weixin/Anniversary4/index.aspx?tdsource=WXzc" id="td_4th">
    <img src="/imgs/images/4thbanner.png" />
        <div class="close"></div>
</a>    
    <%
   } %>
<% if ((tdfrom.Contains("SNSMH-M1607-fzzxTT") || !string.IsNullOrEmpty(showActivity)))
   {
       %>
<a class="td_4th" href="http://a.app.qq.com/o/simple.jsp?pkgname=com.junte&ckey=CK1335207855362">
    <img src="/imgs/images/app.png" />
</a>
 <%
   } %>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20160421001"></script>
<script type="text/javascript" src="/scripts/zepto.js"></script>
<script type="text/javascript">
    var browser = {
        versions: function () {
            var u = navigator.userAgent, app = navigator.appVersion;
            return { //移动终端浏览器版本信息
                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或uc浏览器
                iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
                iPad: u.indexOf('iPad') > -1, //是否iPad
            };
        }(),
    }
    $(".download").click(function () {
        if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
            window.location.href = "http://www.tuandai.com/app/install.aspx";
        }
        else if (browser.versions.android) {
            window.location.href = "http://image.tuandai.com/tuandaiapp/tuandai4.3.6.3_sina-m.apk";
        } else {
            window.location.href = "http://hd.tuandai.com/weixin/tuandaiAppNew/IndexApp.aspx?type=weixinapp";
        }
    });
    $(".download1").click(function () {
        var nickname = getCookie("TDW_WapUserName");
        nwbi_api.nwbi_logWebEvent(nickname, new Date(), 'APPDownload', 'regAPPDownload', '20160624', 1, '', '', 'TDW_WAP');
        
        if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
            window.location.href = "http://www.tuandai.com/app/install.aspx";
        }
        else if (browser.versions.android) {
            window.location.href = "http://image.tuandai.com/tuandaiapp/tuandai.apk";
        } else {
            window.location.href = "http://hd.tuandai.com/weixin/tuandaiAppNew/IndexApp.aspx?type=weixinapp";
        }
    });
    /*四周年banner 关闭按钮*/
    //var td_4th = $('#td_4th');
    //td_4th.find('.close').on('click', function(e) {
    //    e.preventDefault();
    //    td_4th.hide();
    //});
</script>
    <% var qudaofromjs = Request.QueryString["tdfrom"] == null ? "" : Request.QueryString["tdfrom"]; %>
                    <%if (qudaofromjs.ToLower().IndexOf("pydsp-p-") >= 0)
                    {%>
              <script type="text/javascript">

                  var vPhone = '<%=(!string.IsNullOrEmpty(userBasicObj.TelNo)&&userBasicObj.TelNo.Length>10)?userBasicObj.TelNo.Substring(5,6):""%>';
                  !function (w, d, e) {
                      var _orderno = vPhone;
                      var b = location.href, c = d.referrer, f, s, g = d.cookie, h = g.match(/(^|;)\s*ipycookie=([^;]*)/), i = g.match(/(^|;)\s*ipysession=([^;]*)/); if (w.parent != w) { f = b; b = c; c = f; }; u = '//stats.ipinyou.com/cvt?a=' + e('ZO.pTh.A5qmS_AilhX50Co5_vspp0') + '&c=' + e(h ? h[2] : '') + '&s=' + e(i ? i[2].match(/jump\%3D(\d+)/)[1] : '') + '&u=' + e(b) + '&r=' + e(c) + '&rd=' + (new Date()).getTime() + '&OrderNo=' + e(_orderno) + '&e=';
                      function _() { if (!d.body) { setTimeout(_(), 100); } else { s = d.createElement('script'); s.src = u; d.body.insertBefore(s, d.body.firstChild); } } _();
                  }(window, document, encodeURIComponent);

            </script>
    <%} %>
</body>
</html>
