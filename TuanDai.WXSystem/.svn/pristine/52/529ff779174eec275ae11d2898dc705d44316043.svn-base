<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InvestList.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.App.find.InvestList" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="initial-scale=1, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no" />
    <meta name="format-detection" content="telephone=no" />

    <link rel="stylesheet" href="/pages/App/css/investList.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" href="/pages/App/css/common.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" href="/pages/App/js/lib/vendor/swiper/swiper.min.css?v=<%=GlobalUtils.Version %>" />
    <title>邀请好友列表</title>
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
    <div class="content in-page">
        <div class="c-detail" style="background-image: url(/imgs/App/find/ibg.jpg);">
            <span class="cd-title">累计邀请人数</span>
            <span class="cd-num"><%=invitationCount %></span>
        </div>
        <nav class="l-tab">
            <a href="#" class="tab tab-active" data-index="0"><i class="icon-tri"></i><span>全部</span></a>
            <a href="#" class="tab" data-index="1"><i class="icon-tri"></i><span>最近一周</span></a>
            <a href="#" class="tab" data-index="2"><i class="icon-tri"></i><span>最近一月</span></a>
        </nav>
        <div class="il-title">
            <span>被邀请的人</span>
            <span>是否投资</span>
            <span>注册时间</span>
        </div>
        <div class="listcont">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <div class="list-container" id="allList" data-type="0">
                            <ul class="c-list">
                                <!-- <li class="c-row">
                                    <div class="il-item">145****3333</div>
                                    <div class="il-item">是</div>
                                    <div class="il-item">2016-04-09</div>
                                </li> -->
                            </ul>
                            <!--  <div class="no-data" id="noAll">
                                <i class="icon-nodata"></i>
                                <span>暂无数据</span>
                            </div> -->
                            <div class="no-data" id="noAll">
                                <i class="icon-norecord"></i>
                                <span class="nt">暂无数据</span>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="list-container" id="weekList" data-type="1">
                            <ul class="c-list">
                                <!--  <li class="c-row">
                                    <div class="il-item">145****3333</div>
                                    <div class="il-item">是</div>
                                    <div class="il-item">2016-04-09</div>
                                </li>
                                <li class="c-row">
                                    <div class="il-item">145****3333</div>
                                    <div class="il-item">是</div>
                                    <div class="il-item">2016-04-09</div>
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
                        <div class="list-container" id="monthList" data-type="2">
                            <ul class="c-list">
                                <!-- <li class="c-row">
                                    <div class="il-item">145****3333</div>
                                    <div class="il-item">是</div>
                                    <div class="il-item">2016-04-09</div>
                                </li>
                                <li class="c-row">
                                    <div class="il-item">145****3333</div>
                                    <div class="il-item">是</div>
                                    <div class="il-item">2016-04-09</div>
                                </li>
                                <li class="c-row">
                                    <div class="il-item">145****3333</div>
                                    <div class="il-item">是</div>
                                    <div class="il-item">2016-04-09</div>
                                </li> -->
                            </ul>
                            <!-- <div class="no-data" id="noMonth">
                                <i class="icon-nodata"></i>
                                <span>暂无数据</span>
                            </div> -->
                            <div class="no-data" id="noMonth">
                                <i class="icon-norecord"></i>
                                <span class="nt">暂无数据</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tip-cont">
            2016-02-19前邀请好友数据请在PC端查看
        </div>
    </div>
</body>
<script src="/pages/App/js/lib/fastclick-jquery.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script src="/pages/App/js/lib/vendor/jsbridge-3.0.0.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script src="/pages/App/js/lib/vendor/swiper/swiper.jquery.min.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script src="/pages/App/js/list.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
<script src="/pages/App/js/util.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
<script src="/pages/App/js/investList.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
</html>
