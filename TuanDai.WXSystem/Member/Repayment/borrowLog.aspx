﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="borrowLog.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.borrowLog" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>周转记录</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/loan.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>

<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>

    <div id="wrapper" style="top:0;">
        <div id="scroller">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <div id="list">
                <%--<div class="pl15 mt10 bt-e6e6e6 bb-e6e6e6 bg-fff">
                    <div class="load_t clearfix">
                        <div class="lf text-overflow f14px">[资]企业资金周转保证无逾期</div>
                        <div class="rf pr15 f12px loadState1"><i></i>还款中(1/12)</div>
                    </div>
                    <div class="load_c bt-e6e6e6">
                        <div class="clearfix">
                            <div class="lf c-ababab">借入金额<span class="ml20">5000.00</span></div>
                            <div class="rf c-ababab">发标时间<span class="ml20">2016.10.25</span></div>
                        </div>
                        <div class="clearfix mt3">
                            <div class="lf c-ababab">借入金额<span class="ml20">5000.00</span></div>
                            <div class="rf c-ababab">发标时间<span class="ml20">2016.10.25</span></div>
                        </div>
                    </div>
                </div>

                <div class="pl15 mt10 bt-e6e6e6 bb-e6e6e6 bg-fff">
                    <div class="load_t clearfix">
                        <div class="lf text-overflow f14px">[资]企业资金周转保证无逾期</div>
                        <div class="rf pr15 f12px loadState2"><i></i>逾期中(3/12)</div>
                    </div>
                    <div class="load_c bt-e6e6e6">
                        <div class="clearfix">
                            <div class="lf c-ababab">借入金额<span class="ml20">5000.00</span></div>
                            <div class="rf c-ababab">发标时间<span class="ml20">2016.10.25</span></div>
                        </div>
                        <div class="clearfix mt3">
                            <div class="lf c-ababab">借入金额<span class="ml20">5000.00</span></div>
                            <div class="rf c-ababab">发标时间<span class="ml20">2016.10.25</span></div>
                        </div>
                    </div>
                </div>

                <div class="pl15 mt10 bt-e6e6e6 bb-e6e6e6 bg-fff">
                    <div class="load_t clearfix">
                        <div class="lf text-overflow f14px">[资]企业资金周转保证无逾期</div>
                        <div class="rf pr15 f12px loadState3"><i></i>已完成(12/12)</div>
                    </div>
                    <div class="load_c bt-e6e6e6">
                        <div class="clearfix">
                            <div class="lf c-ababab">借入金额<span class="ml20">5000.00</span></div>
                            <div class="rf c-ababab">发标时间<span class="ml20">2016.10.25</span></div>
                        </div>
                        <div class="clearfix mt3">
                            <div class="lf c-ababab">借入金额<span class="ml20">5000.00</span></div>
                            <div class="rf c-ababab">发标时间<span class="ml20">2016.10.25</span></div>
                        </div>
                    </div>
                </div>

                <div class="pl15 mt10 bt-e6e6e6 bb-e6e6e6 bg-fff">
                    <div class="load_t clearfix">
                        <div class="lf text-overflow f14px">[资]企业资金周转保证无逾期</div>
                        <div class="rf pr15 f12px loadState4"><i></i>借入中(36%)</div>
                    </div>
                    <div class="load_c bt-e6e6e6">
                        <div class="clearfix">
                            <div class="lf c-ababab">借入金额<span class="ml20">5000.00</span></div>
                            <div class="rf c-ababab">发标时间<span class="ml20">2016.10.25</span></div>
                        </div>
                        <div class="clearfix mt3">
                            <div class="lf c-ababab">借入金额<span class="ml20">5000.00</span></div>
                            <div class="rf c-ababab">发标时间<span class="ml20">2016.10.25</span></div>
                        </div>
                    </div>
                </div>--%>
            </div>
            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div>

</body>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/iscroll.js?=1.0"></script>
<script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/borrowlist.js?=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">
    pageIndex = 1;
    var userId='<%= TuanDai.WXApiWeb.WebUserAuth.UserId.Value%>';
    //pageCount=<%=pageCount %>; 
    var queryStatus = "0";
    $(function () {
        LoadBorrowList("empty");
        iScroll.onLoadData = LoadBorrowList;
    });
</script>


</html>
