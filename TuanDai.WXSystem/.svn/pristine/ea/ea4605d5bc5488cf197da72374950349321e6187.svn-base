<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrizeLog.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.UserPrize.PrizeLog" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>获奖记录</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/giftBox.css" /><!--团宝箱-->

</head>
<body>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">获奖记录</h1>
    </div>
    <div class="none"></div>
</header>

<section class="logBox">
  
  <div id="wrapper" class="pr0">
        <div id="scroller">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <ul class="logList" id="thelist">
            
            </ul>
            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div>
   <%--    <%
             if (this.UserPrizeList.Count > 0)
             {
                 foreach (TuanDai.PortalSystem.Model.WXUserPrizeListInfo model in this.UserPrizeList)
                 {
    %>
    <!--begin-->
            <li class="clearfix">
               <span class="t1"><%=model.PrizeName %></span>
               <span class="t2"><%=model.Description %></span>
               <span class="t3"><%=model.CreateDate.ToString("yyyy-MM-dd HH:mm:ss") %></span>
            </li>
    <!--end-->
    <%
        }
             }
    %>--%>

  
</section>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        $(function () {
            LoadPrizeLogList('empty');
            iScroll.onLoadData = LoadPrizeLogList;
            if (pageCount <= 1) {
                $("#pullUp").hide();
            }
        });

        function LoadPrizeLogList(flag) {
            if (flag == "empty") {
                $("#thelist").children().remove();
               // $("#thelist").append("<li>数据加载中...</li>");
            }
            jQuery.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/ajax_userPrize.ashx",
                dataType: "json",
                data: { Cmd: "GetPrizeLog", pageIndex: pageIndex },
                success: function (jsonstr) {
                    if (flag == "empty") {
                        $("#thelist").children().remove();
                    }
                    var html = new Array();
                    var str = "";
                    if (jsonstr.result == "1") {
                        pageCount = jsonstr.totalcount; //
                        for (var i = 0; i < jsonstr.list.length; i++) {
                            str = "<li><p class='f14px c-212121'>" + jsonstr.list[i].PrizeName + "</p><p class='clearfix'><span class='lf c-ababab f12px'>" + jsonstr.list[i].Description + "</span><span class='rf c-ababab f12px pr15'>" + jsonstr.list[i].CreateDate + "</span></p></li>";
                            html.push(str);
                        }
                        $("#thelist").append(html.join(""));
                    }
                    else {
                        $("#thelist").html("无获奖记录...");
                    }
                },
                error: function (a, b, c) {
                    $("#thelist").html("加载有误...");
                }
            });
        }
        
    </script>
</body>
</html>
