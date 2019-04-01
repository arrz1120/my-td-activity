<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="invest_success.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.invest_success" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>投资成功</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/pay.css?v=20160604001" />
</head>
<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
    <%--  <header class="headerMain">
        <div class="header bb-c2c2c2">
            <h1 class="title">投资成功</h1>
            <a class="j-finish" href="<%=FinishUrl %>">完成</a>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>--%>

    <div class="webkit-box box-center suc_box">
        <p><i class="ico_suc02"></i>投资成功</p>
    </div>
    
    <%-- if (product != null && (product.TypeWord.ToLower().Contains("p") || product.TypeWord.ToLower().Contains("q") || product.TypeWord.ToLower().Contains("r")))
       {
           %>
    <div class="webkit-box box-center whiteArea" style="padding-bottom: 50px;text-align: center;font-size: 14px;">
        We计划匹配标的成功后，即获加息1%！
    </div>
    <%
       } --%> 
    <div class="whiteArea bb-e6e6e6"></div>
    <div class="suc_frame">
        <% if (!(!string.IsNullOrEmpty(activityUrl) && product != null && (product.TypeWord.ToLower().Contains("p") || product.TypeWord.ToLower().Contains("q") || product.TypeWord.ToLower().Contains("r"))))
           {
        %>
        <div class="frame_line"></div>
        <div class="frame_bg" style="">
            <p class="f24px text-center">￥<%= ToolStatus.ConvertLowerMoney(PayMoney) %></p>
            <p class="f12px text-center pt8 pb15 c-ababab">
                <% if (!string.IsNullOrEmpty(ProfitMoney) && ProfitMoney.Contains("~"))
                   {
                %>
                参考年回报率:
                <%
                   }
                   else
                   {
                %>
                参考回报:
                <%
                   } %>
                <span class="c-fd6040 f12px ml7">
                    <%= !string.IsNullOrEmpty(ProfitMoney) && ProfitMoney.Contains("~") ? "" : "￥" %><%= ToolStatus.ConvertLowerMoney(ProfitMoney) %> 
                </span>
                <% if(PrizeAddInterest>0){ %>
                   <span class="c-fd6040 f12px ml7">+￥<%=ToolStatus.ConvertLowerMoney(PrizeAddInterest) %></span>
                <%} %>
            </p>
            <% if (InvestType == "project" || InvestType == "weplan")
               { %>
            <ul class="bb-d1-dash">
            	
                <%if(PrizeId.HasValue && PrizeId!=Guid.Empty){ %>
            	<!--0525新增-->
            	<li class="clearfix bt-d1-dash">
					<div class="lf"><%=PrizeDesc %></div>
					<div class="rf c-fd6040"><%=PrizeStatus==1?"使用成功":"使用失败" %></div>
				</li>
                <%} %>
            	
                <li class="clearfix bt-d1-dash">
                    <div class="lf">到期时间</div>
                    <div class="rf" id="endDate">2016-12-10</div>
                </li>
                
                <% if (InvestType != "weplan")
                   { %>
                <li class="clearfix bt-d1-dash">
                    <div class="lf">回款方式</div>
                    <div class="rf" id="desc">每月付息</div>
                </li>
                <% }%>
                <% if (int.Parse(TuanBi) > 0)
                   {
                       %>
                <li class="clearfix bt-d1-dash">
                    <div class="lf">获得团币</div>
                    <div class="rf" id="tuanbi"><%= TuanBi %>个</div>
                </li>
                <%
                   } %>
                  <% //We返现红包
                   if (InvestType == "weplan" && FXAmount > 0)
                    { %>
                <li class="clearfix bt-d1-dash">
                    <div class="lf">返现奖励</div>
                    <div class="rf">￥<%=ToolStatus.ConvertLowerMoney(FXAmount) %>元现金奖励</div>
                   <%-- <div class="rf"><a href="/Member/UserPrize/RedPacket.aspx?type=1"><%=ToolStatus.ConvertLowerMoney(FXAmount) %>元现金红包</a><i class="ico-arrow-r"></i></div>--%>
                </li>
                <% } %>
            </ul>
            <% } %>
        </div>
        <%
           }
               %>
        
        
        <% if (!string.IsNullOrEmpty(activityUrl) && product!= null && (product.TypeWord.ToLower().Contains("p") || product.TypeWord.ToLower().Contains("q") || product.TypeWord.ToLower().Contains("r")))
           {
        %>
        <div style="margin-top: 50px;">
        <a href="/Member/Bank/Recharge.aspx" class="btn btnYellow mt20 moveFromBottom moveDelay1">马上充值</a>
        <a class="btn btnYellow mt20 moveFromBottom moveDelay1" href="<%=activityUrl %>" id="returnActivity">返回活动页面</a>
        </div>
        <%
           }
           else
           {
               %>
        <a href="<%= GoOnUrl%>" class="btn btnYellow mt20 moveFromBottom moveDelay1">完成</a>
        <p class="f13px c-ababab text-center mt10 moveFromBottom moveDelay2">微信关注<a href="/pages/concernWeChat.aspx"  class="c-fab600 f13px" id="showCode">“团贷网服务平台”</a>可收取回款通知</p>
        <%
           }%>
        <%--<p class="f13px c-ababab text-center mt10 moveFromBottom moveDelay2"><a href="/pages/concernWeChat.aspx" class="c-fab600 f13px">关注微信公众号</a>，可收取回款通知</p>--%>
    </div>

    <!--弹框-->
    <div class="alert webkit-box box-center hide">
        <div class="bg-fff code-popup text-center pos-r">
            <a href="javascript:;" class="close pos-a" id="close"><i></i></a>
            <p class="c-212121 f17px">关注“团贷网服务平台”</p>
            <img src="/imgs/images/pic/code1.png" class="code mt10">
            <p class="c-ababab f13px">（长按或扫描识别）</p>
            <%--<p class="c-212121 f15px mt25">团贷首席体验官“王宝强”强力推荐</p>--%>
            <img src="/imgs/images/pic/pic1.png" class="pic mt20">
        </div>
    </div>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20160430001"></script>
    <script type="text/javascript" src="/scripts/Common.js"></script>
    <script>
        $(function () {
            //关注团贷网弹窗
            //$("#showCode").click(function () {
            //    $(".alert").removeClass('hide').bind("touchmove", function (e) {
            //        e.preventDefault();
            //    });
            //});

            $("#close").click(function () {
                $(".alert").addClass('hide');
            });

            var projectid = "<%= projectId%>";
            var investType = "<%= InvestType%>";
            var jsonData = {};
            if (investType == "project") {
                $.ajax({
                    type: "post",
                    async: false,
                    url: "/ajaxCross/InvestAjax.ashx",
                    data: { cmd: "GetInvestFinishInfo", projectId: projectid, investtype: "project" },
                    dataType: "json",
                    timeout: 3000,
                    success: function (json) {
                        var result = json.result;
                        if (result == "1") {
                            eval("jsonData =" + json.msg);
                            $("#desc").html(jsonData.RepaymentTypeDesc);
                            $("#endDate").html(jsonData.EndDate);
                        } else {
                            alert(json.msg);
                        }
                    },
                    error: function () {
                    }
                });
            } else {
                $.ajax({
                    type: "post",
                    async: false,
                    url: "/ajaxCross/InvestAjax.ashx",
                    data: { cmd: "GetInvestFinishInfo", projectId: projectid, investtype: "weplan" },
                    dataType: "json",
                    timeout: 3000,
                    success: function (json) {
                        var result = json.result;
                        if (result == "1") {
                            eval("jsonData =" + json.msg); 
                            $("#endDate").html(jsonData.EndDate);
                        } else {
                            alert(json.msg);
                        }
                    },
                    error: function () {
                    }
                });
            }
            //setCookie("Anniversary4", "http://10.100.1.11:8005/Index.aspx?from=ceshi");
            //返回活动页
            var returnurl = "<%=activityUrl%>";
            $("#returnActivity").bind("click", function () {
                //delCookie("Anniversary4");
                window.location.href = returnurl;
            });
        });
    </script>
</body>
</html>
