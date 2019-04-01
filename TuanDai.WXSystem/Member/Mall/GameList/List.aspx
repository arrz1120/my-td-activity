﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Mall.GameList.List" %>

<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>游戏专区</title>
	<meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财">
	<meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。">
	<script type="text/javascript" src="js/rem.js"></script>
	<link rel="stylesheet" href="css/style.css?v=0517001" />
</head>
<body>
<section class="wrap pos-r scroll scroll-active">
	<header class="bg-size"></header>
	<!--分页下拉刷新上拉加载-->
	<div id="wrapper">
		<div id="scroller">
			<p class="page-title"><i class="bg-size"></i><span>团币游戏专区</span></p>
			<div id="pullDown" style="display: none!important;">
				<span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
			</div>
			<div id="list">
                <%foreach (var item in GameList) 
                  {%>
                <a href="javascript:;" v="<%=item.Url %>" id="<%=item.Id %>">
					<div class="list-con">
						<div class="img-box">
							<img src=<%=item.ImageUrl %> alt="">
						</div>
						<div class="con-b">
							<p class="title"><%=item.ShortDesc.Split('|')[0] %></p>
							<p class="s-title"><%=item.ShortDesc.Split('|')[1] %></p>
						</div>                       
					</div>
				</a>
                  <%} %>				
			</div>
			<div id="pullUp">
				<span class="pullUpIcon"></span><span class="pullUpLabel">下拉加载更多...</span>
			</div>
		</div>
	</div>

	<!--<div class="list-con">-->
	<!--<div class="img-box webkit-box box-center bg-e6e6e6">-->
	<!--<p><i class="bg-size"></i>敬请期待</p>-->
	<!--</div>-->
	<!--<div class="con-b">-->
	<!--<p class="title">团币云宝</p>-->
	<!--<p class="s-title">梦想再渺小，机会不会少</p>-->
	<!--</div>-->
	<!--</div>-->
	<div class="footer">
		<a id="tuanbiTask" href="javascript:;" v="https://m.tuandai.com/pages/app/appvipcenter/mytask.aspx<%=IsInApp?"?type=mobileapp":"" %>">做任务  赚团币&gt;</a>
	</div>
</section>
    <script type="text/javascript" src="/scripts/statistics.tencent.js"></script>
<script type="text/javascript" src="js/fastclick-jquery-1.8.3.js"></script>
<script src="js/jsbridge-3.1.3.js"></script>
<script type="text/javascript" src="/scripts/iscroll.js"></script>
<script src="js/jquery.cookies.2.2.0.js"></script>
<script src="/scripts/jquery.min.js"></script>
<script>
    $(function () {        
        FastClick.attach(document.body);
        resetDom();
        $("#tuanbiTask").click(function () {
            if ('<%=Islogin%>'.toUpperCase() == "FALSE") {
                if ('<%=IsInApp%>') {
                    Jsbridge.toAppLogin();
                }
                else {
                    
                }
            }
            else {                
                window.location.href = "https://m.tuandai.com/pages/app/appvipcenter/mytask.aspx";
            }
        });
        $("#list a").click(function () {            
            if ($(this).attr("v").indexOf("/Member/Mall/lottery.aspx") > -1) {                
                if ('<%=Islogin%>'.toUpperCase() == "FALSE") {
                    if ('<%=IsInApp%>') {
                        Jsbridge.toAppLogin();
                    }
                    else {

                    }
                }
                else {                    
                    window.location.href = $(this).attr("v");
                }
            }
            else {
                window.location.href = $(this).attr("v");
            }
        });
    });

    //    下拉刷新上拉加载
    var myScroll,
        pullDownEl, pullDownOffset,
        pullUpEl, pullUpOffset;
    var pageIndex = 1;
    var pageCount = 1;

    function resetDom() {
        var downHtml = '<div class="centerBox-wp">' +
            '<div class="pullDownTips">' +
            '<span class="pullDownIcon"></span>' +
            '<div class="pullLoading">' +
            '<div class="loading-circle"></div>' +
            '<div class="loading-logo"></div>' +
            '</div>' +
            '</div>' +
            '</div>';
        var upHtml = '<div class="centerBox-wp">' +
            '<div class="pullDownTips">' +
            '<div class="pullLoading">' +
            '<div class="loading-circle"></div>' +
            '<div class="loading-logo"></div>' +
            '</div>' +
            '</div>' +
            '</div>';

        $('#pullDown').html('').html(downHtml);
        $('#pullUp').html('').html(upHtml);
    }


    /**
     * 下拉刷新 （自定义实现此方法）
     * myScroll.refresh();  // 数据加载完成后，调用界面更新方法
     */

    var scrollCon = '<a>'
        + '<div class="list-con">'
        + '<div class="img-box">'
        + '<img src="images/1.png">'
        + '</div>'
        + '<div class="con-b">'
        + '<p class="title">团币云宝</p>'
        + '<p class="s-title">梦想再渺小，机会不会少</p>'
        + '</div>'
        + '</div>'
        + '</a>';

    function pullDownAction() {
        setTimeout(function () { // <-- Simulate network congestion, remove setTimeout from production!
            myScroll.refresh();  // 数据加载完成后，调用界面更新方法 Remember to refresh when contents are loaded (ie: on ajax completion)
        }, 1000); // <-- Simulate network congestion, remove setTimeout from production!
    }
    var flag = true;
    /**
     * 滚动翻页 （自定义实现此方法）
     * myScroll.refresh();  // 数据加载完成后，调用界面更新方法
     */
    function pullUpAction() {
        
        var l = $("#list a").length;
        var pageIndex = Math.ceil(l / 5) + 1;        
        setTimeout(function () { // <-- Simulate network congestion, remove setTimeout from production!   
            if (pageIndex <= 1) {
                //alert(pageIndex);                
            }
            else {
                if (!flag) {                    
                    return;
                }
                $.ajax({
                    url: "/ajaxCross/ajax_mall.ashx",
                    dataType: "json",
                    type: "get",
                    data: {
                        Cmd: "GetTuanBiGameList",
                        pageIndex: pageIndex,
                        pageSize: 5
                    },
                    beforeSend: function () {
                                               
                    },
                    success: function (data) {
                        var html = "";
                        $.each(data, function (i, o) {
                            if ($("#list a[id='" + o.Id + "']").length < 1) {
                                html += "<a href='" + o.Url + "' id='" + o.Id + "'>";
                                html += '<div class="list-con">';
                                html += '<div class="img-box">';
                                html += "<img src='" + o.ImageUrl + "' alt=''>";
                                html += '</div>';
                                html += '<div class="con-b">';
                                html += '<p class="title">' + o.ShortDesc.toString().split('|')[0] + '</p>';
                                html += '<p class="s-title">' + o.ShortDesc.toString().split('|')[1] + '</p>';
                                html += '</div>';
                                html += '</div>';
                                html += "</a>";
                            }                            
                        });
                        $("#list").append($(html));
                    }
                });
            }
            myScroll.refresh();  //数据加载完成后，调用界面更新方法 Remember to refresh when contents are loaded (ie: on ajax completion)
        }, 1000); // <-- Simulate network congestion, remove setTimeout from production!
    }

    /**
     * 初始化iScroll控件
     */
    function loaded() {
        pullDownEl = document.getElementById('pullDown');
        pullDownOffset = pullDownEl.offsetHeight;
        pullUpEl = document.getElementById('pullUp');
        pullUpOffset = pullUpEl.offsetHeight;

        myScroll = new iScroll('wrapper', {
            scrollbarClass: 'myScrollbar', /* 重要样式 */
            useTransition: false, /* 此属性不知用意，本人从true改为false */
            topOffset: pullDownOffset,
            onRefresh: function () {
                if (pullDownEl.className.match('loading')) {
                    pullDownEl.className = '';
                    //                    pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
                } else if (pullUpEl.className.match('loading')) {
                    pullUpEl.className = '';
                    //                    pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
                    //有翻页到底时不显示
                    //                    if (pageIndex == pageCount) {
                    //                        $("#pullUp").hide();
                    //                    }
                }
            },
            onScrollMove: function () {
                if (this.y > 10 && !pullDownEl.className.match('pulling')) {
                    pullDownEl.className = 'pulling';
                    pullDownEl.querySelector('.pullDownIcon').style.transform = 'rotateZ(-180deg)';
                    pullDownEl.querySelector('.pullDownIcon').style.webkitTransform = 'rotateZ(-180deg)';
                    this.minScrollY = 0;
                }
                if (this.y < 10 && pullDownEl.className.match('pulling')) {
                    pullDownEl.className = '';
                    pullDownEl.querySelector('.pullDownIcon').style.transform = 'rotateZ(0)';
                    pullDownEl.querySelector('.pullDownIcon').style.webkitTransform = 'rotateZ(0)';
                    this.minScrollY = -pullDownOffset;
                }
            },
            onScrollEnd: function () {
                if (pullDownEl.className.match('pulling')) {
                    pullDownEl.className = 'loading';
                    pullDownEl.querySelector('.pullDownIcon').style.transform = 'rotateZ(0)';
                    pullDownEl.querySelector('.pullDownIcon').style.webkitTransform = 'rotateZ(0)';
                    pullDownAction();   // Execute custom function (ajax call?)
                }
                if (this.y == this.maxScrollY) {
                    pullUpEl.className = 'loading';
                    pullUpAction();
                }
            }
        });

        setTimeout(function () { document.getElementById('wrapper').style.left = '0'; }, 800);
    }

    //初始化绑定iScroll控件
    document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
    document.addEventListener('DOMContentLoaded', loaded, false);

</script>    
    
<script>
    //腾讯统计代码
    var _mtac = { "performanceMonitor": 1 };
    (function () {
        var mta = document.createElement("script");
        mta.src = "http://pingjs.qq.com/h5/stats.js?v2.0.4";
        mta.setAttribute("name", "MTAH5");
        mta.setAttribute("sid", "500289179");
        mta.setAttribute("cid", "500290527");
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(mta, s);
    })();
    var nwbi_userName = "";
    var nwbi_sysNo = "TDW_WX";
    var IsLogin = isCookieLogin();
    if (IsLogin) {
        var nickname = jaaulde.utils.cookies.get("TDWUserName");
        nwbi_userName = nickname;
    }
    (function () {
        var ta = document.createElement('script'); ta.type = 'text/javascript'; ta.async = true;
        ta.src = ((("https:") == document.location.protocol) ? "https://" : "http://") + 'bilog.niiwoo.com/js/webaccess.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ta, s);
    })();

    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?6dff67da4e4ef03cccffced8222419de";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
    function isCookieLogin() {
        var cookieValue = jaaulde.utils.cookies.get("tuandaiw");
        if (cookieValue != "" && cookieValue != null)
            return true;
        else
            return false;
    }
</script>
</body>
</html>