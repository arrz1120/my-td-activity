<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signCard.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.UserPrize.signCard" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>补签卡</title>
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
        <h1 class="title">签到卡</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>
    <section class="signMain">
        <div id="wrapper">
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

    <%-- <%
         if (this.UserPrizeList.Count > 0)
         {
             foreach (TuanDai.PortalSystem.Model.WXUserPrizeListInfo model in this.UserPrizeList)
             {
    %>
    <!--begin-->
             <%if (model.TypeId == 6)
               {%>
                        <div class="signBox blue">
                            <h3 class="tit">补签卡</h3>
                            <div class="signCont">
                                <p>来源：签到奖品</p>
                                <p>说明：补签卡只可补签近2日的签到</p>
                                <div class="num">X&nbsp;2</div>
                                <i class="icoSign"></i>
                            </div>
                        </div>
            <%}
               else
               {%>
                       <div class="signBox orange">
                            <h3 class="tit">签到加1卡</h3>
                            <div class="signCont">
                                <p>来源：签到奖品</p>
                                <p>说明：签到天数立刻加1，会员天数不增加</p>
                                <div class="num">X&nbsp;2</div>
                                <i class="icoSign"></i>
                            </div>
                        </div>
            <%}
                
               %> 
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
            LoadCardList('empty');
            iScroll.onLoadData = LoadCardList;
            if (pageCount <= 1) {
                $("#pullUp").hide();
            }
        });

        function LoadCardList(flag) {
            if (flag == "empty") {
                $("#thelist").children().remove();
                // $("#thelist").append("<li>数据加载中...</li>");
            }
            jQuery.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/ajax_userPrize.ashx",
                dataType: "json",
                data: { Cmd: "GetSignCard", pageIndex: pageIndex },
                success: function (jsonstr) {
                    if (flag == "empty") {
                        $("#thelist").children().remove();
                    }
                    var html = new Array();
                    var str = "";
                    if (jsonstr.result == "1") {
                        pageCount = jsonstr.totalcount; //
                        for (var i = 0; i < jsonstr.list.length; i++) {
                            if (jsonstr.list[i].TypeId == "6")
                                str = "<li><div class='signBox blue'><h3 class='tit'>补签卡</h3><div class='signCont'><p>来源：签到奖品</p><p>说明：补签卡只可补签近2日的签到</p><div class='num'>X&nbsp;2</div> <i class='icoSign'></i></div></div></li>";
                            else
                                str = "<li><div class='signBox orange'><h3 class='tit'>签到加1卡</h3><div class='signCont'><p>来源：签到奖品</p><p>说明：签到天数立刻加1，会员天数不增加</p><div class='num'>X&nbsp;2</div> <i class='icoSign'></i></div></div></li>";
                            html.push(str);
                        }
                        $("#thelist").append(html.join(""));
                    }
                    else {
                        $("#thelist").html("无签到卡记录...");
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
