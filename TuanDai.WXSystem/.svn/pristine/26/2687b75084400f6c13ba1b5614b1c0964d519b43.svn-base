<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="TuanDai.WXApiWeb.Index" %>

<%@ Import Namespace="Tool" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no">
    <meta name="applicable-device" content="mobile">
    <meta name="keywords" content="投资理财,互联网金融,P2P网站,P2P网贷,P2P理财" />
    <meta name="description" content="团贷网是安全可靠的P2P理财投资网贷平台,专注为投资理财和贷款用户提供优质的互联网金融服务,为投资者带来稳定收益,解决中小微企业资金需求." />
    <title>团贷网</title>
    <link rel="canonical" href="https://www.tuandai.com/">
    <link rel="stylesheet" type="text/css" href="/wap/css/lib/swiper-3.4.2.min.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/wap/css/index/index.css?v=<%=GlobalUtils.Version %>" />
    <script>window.mobileUtils = function (e, t) { var i = navigator.userAgent, n = /android|adr/gi.test(i), a = /iphone|ipod|ipad/gi.test(i) && !n; return { isAndroid: n, isIos: a, isMobile: n || a, isWeixin: /MicroMessenger/gi.test(i), isQQ: /QQ\/\d/gi.test(i), dpr: a ? Math.min(e.devicePixelRatio, 3) : 1, rem: null, fixScreen: function () { var i = this, n = t.querySelector('meta[name="viewport"]'), r = n ? n.content : ""; if (r.match(/initial\-scale=([\d\.]+)/), r.match(/width=([^,\s]+)/), !n) { var o, s = t.documentElement, d = s.dataset.mw || 750, m = a ? Math.min(e.devicePixelRatio, 3) : 1; t.getElementsByTagName("body")[0], s.removeAttribute("data-mw"), s.dataset.dpr = m, n = t.createElement("meta"), n.name = "viewport", n.content = function (e) { return "initial-scale=" + e + ",maximum-scale=" + e + ",minimum-scale=" + e }(1), s.firstElementChild.appendChild(n); var c = function () { var e = s.getBoundingClientRect().width; e = e > d ? d : e; var t = e / 16; i.rem = t, s.style.fontSize = t + "px" }; e.addEventListener("resize", function () { clearTimeout(o), o = setTimeout(c, 300) }, !1), e.addEventListener("pageshow", function (e) { e.persisted && (clearTimeout(o), o = setTimeout(c, 300)) }, !1), c() } } } }(window, document), mobileUtils.fixScreen();</script>

<script type="text/javascript">
    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?6dff67da4e4ef03cccffced8222419de";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
<script type="text/javascript" src="/wap/js/lib/fastclick-jquery.js?v=<%=GlobalUtils.Version %>"></script>
<script src="/wap/js/lib/swiper-3.4.2.jquery.min.js?v=<%=GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
<script src="/wap/js/components/comment.bundle.js?v=<%=GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
<script src="/wap/js/index/index.js?v=<%=GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
</head>
<body>
    <div class="index" id="bigDiv">
        <header>
            <h1 class="logo"></h1>
            <a href="https://www.tuandai.com/default.aspx?devicetype=tuandaicp" class="ico-pc"></a>
        </header>
        <div class="banner">
            <div class="ad-tips">【广告】市场有风险，投资需谨慎</div>
            <div class="swiper-container" id="swiper-banner">
                <div class="swiper-wrapper">
                    <% if (BannerList != null && BannerList.Count > 0)
                       {
                           var imgIndex = 0;
                           foreach (var imageInfo in BannerList)
                           {
                               imgIndex++;
	                        
                    %>
                    <a href="<%=imageInfo.Link %>" class="swiper-slide">
                        <img src="<%=imageInfo.ImageUrl %>" alt="团贷网专题"/>
                    </a>
                    <%}
                       } %>
                    
                    <%--<a href="javascript:void(0);" class="swiper-slide">
                        <img src="/wap/images/index/img2.jpg" />
                    </a>--%>
                </div>
                <!-- 如果需要分页器 -->
                <div class="swiper-pagination" id="nav-mark"></div>
            </div>
        </div>
        <div class="notice">
            <div class="comment-list" id="notice-list">
                <% if (nrr != null)
	                       {
	                           %>
                <div class="comment comment-list-item">
                    <a href="<%=nrr.data.detailUrl %>" class="n-link" rel="nofollow">（<%=nrr.data.publicTime%>）<%= Tool.StrObj.CutString(nrr.data.title, 10)%></a>
                    <a href="<%=nrr.data.listUrl %>" class="n-more" rel="nofollow">更多</a>
                </div>
                <%
	                       } %>
            </div>
        </div>

        <div class="nav">
            <a href="https://info.tuandai.com/touch/about/index.html" class="nav-item" rel="nofollow">
                <img src="<%=imgUrl1 %>" />
                <p>了解团贷</p>
            </a>
            <a href="https://info.tuandai.com/about/operational-touch-data.html" class="nav-item" rel="nofollow">
                <img src="<%=imgUrl2 %>" />
                <p>团贷数据</p>
            </a>
            <a href="/pages/downopenapp.aspx?type=weixinapp" class="nav-item" rel="nofollow">
                <img src="<%=imgUrl3 %>" />
                <p>下载APP</p>
            </a>
            <a href="/pages/concernWeChat.aspx" class="nav-item" rel="nofollow">
                <img src="<%=imgUrl4 %>" />
                <p>微信公众号</p>
            </a>
        </div>

        <div class="con">
            <div class="ad">
                <img src="/wap/images/index/pic-ad.png?v20180326001" alt="自动投标服务"/>
                <a href="/pages/downopenapp.aspx?type=weixinapp" class="btn-download" rel="nofollow">下载APP</a>
            </div>
            <a href="https://hd.tuandai.com/weixin/newhand/welfarenew.aspx?tdsource=wxindex" class="pic-con1" rel="nofollow">
                <img src="/wap/images/index/pic-con1.png" alt="新手福利"/>
            </a>
            <a href="https://at.tuandai.com/201708/invite/weixin/index.aspx" class="pic-con2" rel="nofollow">
                <img src="/wap/images/index/pic-con2.png" alt="邀请好友享大礼"/>
            </a>
        </div>

        <div class="bot">
            <p class="bot-p1">超<span><%=totalPeople %></span>聪明投资者选择</p>
            <p class="bot-p2">
                自动投标服务，退出灵活，无需满额，<br />
                加入即可开启优先投标特权 !
            </p>
            <div class="footer">
                <div class="f-link">
                    <a href="//passport.tuandai.com/2login?From=wxIndex" rel="nofollow">登录</a>
                    <a href="http://wap.tuandai.com/">资讯</a>
                    <a href="http://bk.tuandai.com/">百科</a>
                    <a href="http://ask.tuandai.com/">问答</a>
                </div>
                <p class="cp">
                    2010-2018 版权所有 © 团贷网 粤ICP备12043601号-1
                    <br />
                    东莞团贷网互联网科技服务有限公司
                    <br />
                    服务热线：1010 1218
                </p>
                <div class="ad-tips">市场有风险，投资需谨慎</div>
            </div>
        </div>
    </div>

    <a href="https://hd.tuandai.com/weixin/newhand/welfarenew.aspx?tdsource=wxindex" class="newuser-hb" rel="nofollow"></a>

    <div class="pageBottom">
        <a class="bottom-item bottom-index-cur">首页</a>
        <a <%=WebUserAuth.IsAuthenticated?"href='/Member/my_account.aspx'":"href='//passport.tuandai.com/2login?From=wxIndex'" %> class="bottom-item bottom-my" rel="nofollow">我</a>
    </div>
</body>

</html>
