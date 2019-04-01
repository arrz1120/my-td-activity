﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DailyCommission.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.App.find.DailyCommission" %>

<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no" />
    <meta name="format-detection" content="telephone=no">
    <title>每日佣金详情</title>
      <link rel="stylesheet" href="../css/charges.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>">
        <link rel="stylesheet" href="../css/common.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>">
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
        <div class="c-detail" style="background-image: url(/imgs/App/find/cbg.jpg);">
            <span class="cd-title">累计赚取佣金</span>
            <span class="cd-num"><%=ToolStatus.ConvertLowerMoney(TotalEranMoney)  %></span>
            <div class="btn-border-white btn-charges">如何赚取更多佣金</div>
        </div>
        <div class="list-container" id="chargesWrapper">
            <ul class="list-scroller c-list" id="chargesList">
                <!-- <div class="cl-month">2016年8月</div>
                <li class="c-row">
                    <div class="c-date">
                        昨日佣金
                    </div>
                    <div class="c-num">
                        9.10
                    </div>
                </li>
                <li class="c-row">
                    <div class="c-date">
                        08-25
                    </div>
                    <div class="c-num">
                        9.10
                    </div>
                </li>
                <div class="cl-month">2016年7月</div>
                <li class="c-row">
                    <div class="c-date">
                        07-08
                    </div>
                    <div class="c-num">
                        9.10
                    </div>
                </li>
                <li class="c-row">
                    <div class="c-date">
                        07-0/5
                    </div>
                    <div class="c-num">
                        9.10
                    </div>
                </li> -->
            </ul>
            <!-- <div class="list-tips">
                <i class="icon-loading"></i>
            </div> -->
             <div class="no-data">
                <i class="icon-norecord"></i>
                <span class="nt">暂无数据</span>
            </div>
        </div>
        <!-- <div class="icon-loader"><i class="icon-loading"></i></div> -->
    </div>
</body>
<script src="../js/lib/fastclick-jquery.js"></script>
<script src="../js/lib/vendor/jsbridge-3.0.0.js"></script>
<script src="../js/list.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
<script src="../js/util.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
<script src="../js/charges.js?v=20160922156211" type="text/javascript" charset="utf-8"></script>
</html>
