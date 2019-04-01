<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lottery.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.UserPrize.lottery" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>彩票</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/giftBox.css" />
    <!--团宝箱-->
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">彩票</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>
    <section class="lotteryMain">
     <div id="wrapper" class="top115">
        <div id="scroller">
               <div id="pullDown">
                      <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
               </div>
                <ul id="thelist">

                </ul>
                <div id="pullUp">
                     <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
               </div>
        </div>
   </div>

       
    <%--  <%
          if (this.UserPrizeList.Count > 0)
          {
              foreach (TuanDai.PortalSystem.Model.WXUserPrizeListInfo model in this.UserPrizeList)
              {
    %>
    <!--begin-->
                   <div class="lotteryBox">
                    <div class="p-left">
                        <div class="num">
                            <span><%=model.Description %></span>
                        </div>
                        <p>来源：<%=model.PrizeName %></p>
                    </div>
                    <div class="p-right c-fa502e"></div>
                    <i class="line"></i>
                </div>  
    <!--end-->
    <%
        }
          }
    %>--%>
    <div class="clearfix">
        <p class="f12px c-ababab">请使用本账号到团贷彩票兑奖。</p>
        <p class="f12px c-ababab">如有疑问，请联系客服：<span class="c-ff7357 f14px">1010-1218</span></p>
    </div>
</section>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        $(function () {
            LoadLotteryList('empty');
            iScroll.onLoadData = LoadLotteryList;
            if (pageCount <= 1) {
                $("#pullUp").hide();
            }
        });

        function LoadLotteryList(flag) {
            if (flag == "empty") {
                $("#thelist").children().remove();
                // $("#thelist").append("<li>数据加载中...</li>");
            }
            jQuery.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/ajax_userPrize.ashx",
                dataType: "json",
                data: { Cmd: "GetLottery", pageIndex: pageIndex },
                success: function (jsonstr) {
                    if (flag == "empty") {
                        $("#thelist").children().remove();
                    }
                    var html = new Array();
                    var str = "";
                    if (jsonstr.result == "1") {
                        pageCount = jsonstr.totalcount; //
                        for (var i = 0; i < jsonstr.list.length; i++) {
                            str = "<li><div class='lotteryBox'><div class='p-left'><div class='num'><span>" + jsonstr.list[i].Description + "</span></div> <p>来源：" + jsonstr.list[i].PrizeName + "</p></div><div class='p-right c-fa502e'></div> <i class='line'></i></div></li>";
                            html.push(str);
                        }
                        $("#thelist").append(html.join(""));
                    }
                    else {
                        $("#thelist").html("无彩票记录...");
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
