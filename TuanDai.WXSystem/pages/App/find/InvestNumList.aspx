﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InvestNumList.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.App.find.InvestNumList" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="initial-scale=1, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no" />
    <meta name="format-detection" content="telephone=no"/>
    <title>邀请人数排行榜</title>
    <link rel="stylesheet" href="/pages/App/css/investNumList.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" href="/pages/App/css/common.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" href="/pages/App/js/lib/vendor/swiper/swiper.min.css?v=<%=GlobalUtils.Version %>" />
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
<body>
    <div class="content">
        <nav class="pl-tabs">
            <a href="#" class="pl-tab pl-active" data-index="0">周排行</a>
            <a href="#" class="pl-tab" data-index="1">月排行</a>
            <a href="#" class="pl-tab" data-index="2">总排行</a>
        </nav>
        <div class="listcont">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <div class="t-title">
                            <li class="in-row in-th">
                                <div>名次</div>
                                <div>邀请人数</div>
                            </li>
                        </div>
                        <div class="slide-page list-container" id="weekList" data-type="week">
                            <ul class="in-list">
                                <!--  <li class="in-row in-th">
                                   <div>名次</div>
                                   <div>邀请人数</div>
                               </li> -->
                            </ul>
                            <!-- <div class="no-data" id="noWeek">
                                <i class="icon-nodata"></i>
                                <span>暂无数据</span>
                            </div> -->
                            <div class="no-data" id="noWeek">
                                <i class="icon-norecord"></i>
                                <span class="nt">暂无数据</span>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="t-title">
                            <li class="in-row in-th">
                                <div>名次</div>
                                <div>邀请人数</div>
                            </li>
                        </div>
                        <div class="slide-page list-container" id="monthList" data-type="month">
                            <ul class="in-list">
                                <!--  <li class="in-row in-th">
                                    <div>名次</div>
                                    <div>邀请人数</div>
                                </li> -->
                            </ul>
                            <!--  <div class="no-data" id="noMonth">
                                <i class="icon-nodata"></i>
                                <span>暂无数据</span>
                            </div> -->
                            <div class="no-data" id="noMonth">
                                <i class="icon-norecord"></i>
                                <span class="nt">暂无数据</span>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="t-title">
                            <li class="in-row in-th">
                                <div>名次</div>
                                <div>邀请人数</div>
                            </li>
                        </div>
                        <div class="slide-page list-container" id="allList" data-type="all">
                            <ul class="in-list">
                                <!--  <li class="in-row in-th">
                                    <div>名次</div>
                                    <div>邀请人数</div>
                                </li> -->
                            </ul>
                            <!-- <div class="no-data" id="noAll">
                                <i class="icon-nodata"></i>
                                <span>暂无数据</span>
                            </div> -->
                            <div class="no-data" id="noAll">
                                <i class="icon-norecord"></i>
                                <span class="nt">暂无数据</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="fc">
            <div class="fc-txt">
                <span><font  id="txt">我上周已邀请</font><font class="font-34 text-orange" id="investCount">0</font>人，与第一名相差<font class="font-34 text-orange" id="diff">0</font>人</span>
                <span class="tmark">统计累积到昨日</span>
            </div>
            <div class="btn-yellow-big" id="inviteFriends">邀请好友</div>
        </div>
    </div>
</body>
    <script src="/pages/App/js/lib/fastclick-jquery.js?v=<%= DateTime.Now.ToString("yyyyMMddHHmmss") %>"></script>
    <script src="/pages/App/js/lib/vendor/jsbridge-3.0.0.js?v=<%= DateTime.Now.ToString("yyyyMMddHHmmss") %>"></script>
    <script src="/pages/App/js/lib/vendor/swiper/swiper.jquery.min.js?v=<%= DateTime.Now.ToString("yyyyMMddHHmmss") %>"></script>
    <script src="/pages/App/js/list.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
    <script src="/pages/App/js/util.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
    <script src="/pages/App/js/investNumList.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
</html>
