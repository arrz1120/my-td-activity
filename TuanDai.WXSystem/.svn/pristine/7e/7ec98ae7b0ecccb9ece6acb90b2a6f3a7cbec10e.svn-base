<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="noticelist.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.news.noticelist" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>团贷网公告</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/helpCenter.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/baikedaohang.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>

<body class="bg-fff">
	<div id="bigDiv">
    <%= this.GetNavStr()%>
    <div id="wrapper" style="top: <%=IsInApp || TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser ? 0:44 %>px;background-color: #fff !important;">
        <div id="scroller" style="background-color: #fff !important;">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <div class="newsMain" id="thelist">
                <% if (newsList != null && newsList.Count > 0)
                   {
                       foreach (var news in newsList)
                       {
                           %>
                <div class="pt15 pb12 pb12 ml15 pr15 bb-e6e6e6" onclick="javascript:window.location.href='/pages/news/noticedetails.aspx?id=<%=news.Id %>';">
                    <p class="f15px text-overflow"><%=news.Title %></p>
                    <p class="c-ababab line-h16 2016-06-15 mt3"><%=news.AddDate %></p>
                </div>
                <%
                       }
                   } %>
            </div>
            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div>
		
	</div>
    
    
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/seo.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        pageIndex = 1; 
        pageCount=<%=pageCount %>; 
        $(function () {
            iScroll.onLoadData=LoadNoticeList; 
        });
        function LoadNoticeList(flag) {
            $("body").showLoading("加载中...");
            if (flag == "empty") {
                $("#thelist").children().remove(); 
            }
            jQuery.ajax({ 
                type: "post",
                url: "/ajaxCross/NewsAjax.ashx",
                dataType: "json",
                data: { Cmd: "GetNoticeShowList", pageIndex: pageIndex },
                success: function (jsonstr) {
                    $("body").hideLoading();
                    if (flag == "empty") {
                        $("#thelist").children().remove();
                    }
                    var html = new Array();
                    var str = "";
                    if (jsonstr.result == "1") {
                        if(pageCount<=1){ 
                            $("#pullUp").hide();
                        }
                        for (var i = 0; i < jsonstr.list.length; i++) {
                            str = '<div class="pt15 pb12 ml15 pr15 bb-e6e6e6" onclick="javascript:window.location.href='+"\'/pages/news/noticedetails.aspx?id="+jsonstr.list[i].NewsId+'\'">'+
                                        '<p class="f15px text-overflow">'+jsonstr.list[i].Title +'</p>'+
                                        '<p class="c-ababab line-h16 2016-06-15 mt3">'+jsonstr.list[i].AddDate +'</p>'+
                                  '</div>';
                            html.push(str); 
                        }
                        $("#thelist").append(html.join(""));
                        myScroll.refresh();
                    }
                    else {
                        $("#thelist").append("<div>暂时没有公告...</div>");
                    }
                },
                error: function () {
                    $("body").hideLoading();
                }
            });
        }
    </script>
</body>
</html>
