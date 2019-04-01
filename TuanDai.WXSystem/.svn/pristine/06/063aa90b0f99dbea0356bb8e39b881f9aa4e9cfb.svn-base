<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myzx_borrow_list.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.myzx_borrow_list" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no">
    <title>发起记录</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" href="/wap/css/zhixiang/start_record.css?v=<%=GlobalUtils.Version %>">
    <script>window.mobileUtils = function (e, t) { var i = navigator.userAgent, n = /android|adr/gi.test(i), a = /iphone|ipod|ipad/gi.test(i) && !n; return { isAndroid: n, isIos: a, isMobile: n || a, isWeixin: /MicroMessenger/gi.test(i), isQQ: /QQ\/\d/gi.test(i), dpr: a ? Math.min(e.devicePixelRatio, 3) : 1, rem: null, fixScreen: function () { var i = this, n = t.querySelector('meta[name="viewport"]'), r = n ? n.content : ""; if (r.match(/initial\-scale=([\d\.]+)/), r.match(/width=([^,\s]+)/), !n) { var o, s = t.documentElement, d = s.dataset.mw || 750, m = a ? Math.min(e.devicePixelRatio, 3) : 1; t.getElementsByTagName("body")[0], s.removeAttribute("data-mw"), s.dataset.dpr = m, n = t.createElement("meta"), n.name = "viewport", n.content = function (e) { return "initial-scale=" + e + ",maximum-scale=" + e + ",minimum-scale=" + e }(1), s.firstElementChild.appendChild(n); var c = function () { var e = s.getBoundingClientRect().width; e = e > d ? d : e; var t = e / 16; i.rem = t, s.style.fontSize = t + "px" }; e.addEventListener("resize", function () { clearTimeout(o), o = setTimeout(c, 300) }, !1), e.addEventListener("pageshow", function (e) { e.persisted && (clearTimeout(o), o = setTimeout(c, 300)) }, !1), c() } } } }(window, document), mobileUtils.fixScreen();</script>
    <style type="text/css">
        .re-tit span {
            font-size: 0.4rem;
        }
    </style>
</head>
<script type="text/javascript">
    var pStatus = "<%=CurTabName%>";
</script>
<body>
    <%= this.GetNavStr()%>
    <div style="display: none;"><%= this.GetNavIcon()%></div>
    <div class="record">
        <div class="top">
            <div class="top-tab <%=CurTabName=="Traning"?"top-tab-cur":"" %> " id="tabTraning">转让中</div>
            <div class="top-tab <%=CurTabName=="Finished"?"top-tab-cur":"" %>" id="tabFinished">已完成</div>
            <div class="top-line"></div>
        </div>

        <div id="wrapper" class="pr0" style="top: 46px;background: #f1f3f5;">
            <div id="scroller">
                <div id="pullDown" style="margin-bottom: 0; background: #f1f3f5;">
                    <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
                </div>
                <!--转让中-->
                <div class="record-list" id="thelist">
                    <div class="record-con">
                        <div class="re-tit">
                            <p>[智享计划]2017080852355</p>
                            <span>20%</span>
                            <canvas class="circular"></canvas>
                        </div>
                        <div class="re-content">
                            <div class="con-item">
                                <p class="recon-p1">已转让金额：</p>
                                <p class="recon-p2 c-fd6040">￥ 15,000.00</p>
                            </div>
                            <div class="con-item">
                                <p class="recon-p1">待结清金额：</p>
                                <p class="recon-p2">￥ 15,000.00</p>
                            </div>
                        </div>
                    </div>

                    <div class="record-con">
                        <div class="re-tit">
                            <p>[智享计划]2017080852355</p>
                            <span>30%</span>
                            <canvas class="circular"></canvas>
                        </div>
                        <div class="re-content">
                            <div class="con-item">
                                <p class="recon-p1">已转让金额：</p>
                                <p class="recon-p2 c-fd6040">￥ 15,000.00</p>
                            </div>
                            <div class="con-item">
                                <p class="recon-p1">待结清金额：</p>
                                <p class="recon-p2">￥ 15,000.00</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!--已完成-->
                <div class="record-list" style="display: none;">
                    <div class="record-con">
                        <div class="re-tit">
                            <p>[智享计划]2017080852355</p>
                            <span>100%</span>
                            <canvas class="circular"></canvas>
                        </div>
                        <div class="re-content">
                            <div class="con-item">
                                <p class="recon-p1">已转让金额：</p>
                                <p class="recon-p2 c-fd6040">￥ 15,000.00</p>
                            </div>
                            <div class="con-item">
                                <p class="recon-p1">待结清金额：</p>
                                <p class="recon-p2">￥ 15,000.00</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="pullUp" style="background: #f1f3f5;">
                    <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/wap/js/lib/fastclick-jquery.js?v=<%=GlobalUtils.Version %>"></script>
<script src="/wap/js/components/circularProcess.bundle.js?v=<%=GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="/scripts/iscroll.js"></script>
<script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=GlobalUtils.Version %>"></script>
<script src="/wap/js/zhixiang/start_record.js?v=<%=GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
</html>
