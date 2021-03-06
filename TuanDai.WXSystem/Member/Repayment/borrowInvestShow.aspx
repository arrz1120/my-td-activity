﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="borrowInvestShow.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.borrowInvestShow" %>

<%@ Import Namespace="TuanDai.WXApiWeb.Member.Repayment" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>借款详情</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/account.css?v=2015090701" />
    <!--账户中心-->
    <link rel="stylesheet" type="text/css" href="/css/borrowshow.css?v=2.0" />
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/loan.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <style type="text/css">
        #pullUp {
            padding-bottom: 80px !important;
        }
        .loaningS3 {
            border-color: #fd6040;
            color: #fd6040;
        }
    </style>
</head>
<body class="bg-f1f3f5">
    <%=GetNavStr() %>
    <% if ((!model.IsOverDueRecord && (model.Status == 3)) || (model.IsOverDueRecord))//3还款中 逾期中
       { %>
    <div id="wrapper" style="top: 0;" class="bg-fff">
        <div id="scroller" class="bg-fff">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <div class="detail_t bg-fff">
                <%=ToolStatus.ConvertProjectType(model.Type)%> <%=model.Title%>
                <a><%=TuanDai.WXApiWeb.Member.Repayment.borrowShow.GetBillStatus(model)%></a>
                <p class="line-h16 f12px c-ababab mt4"><%=model.AddDate.ToString("yyyy-MM-dd")%>&nbsp;&nbsp;&nbsp;&nbsp;<%=model.AddDate.ToString("HH:mm:ss")%> </p>
                <%--<span class="<%=TuanDai.WXApiWeb.Member.Repayment.borrowShow.GetTipBoxCss(model)%>"><%=TuanDai.WXApiWeb.Member.Repayment.borrowShow.GetBillStatus(model)%></span>--%>
            </div>
            <div class="detail_b bt-f8ebcd ">
                <div class="clearfix pt10">
                    <div class="lf w50p c-666666 f13px">周转金额<span class="ml20 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.HaveBorrowedAmount)%></span></div>
                    <div class="lf w50p pl15 c-666666 f13px">已结清本息<span class="ml20 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(repayedAmount) %></span></div>
                </div>
                <div class="clearfix pt10 pb15">
                    <div class="lf w50p c-666666 f13px">总利息<span class="ml32 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.TotalInterest)%></span></div>
                    <div class="lf w50p pl15 c-666666 f13px">待结清本息<span class="ml20 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(duerepayAmount)%></span></div>
                </div>
                <div class="bt-d1-dash">
                    <div class="clearfix pt13 pb13">
                        <div class="lf w50p c-666666 f13px">周转金额<span class="ml20 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.Amount)%></span></div>
                        <div class="lf w50p pl15 c-666666 f13px">服务费<span class="ml32 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.BorrowPayoutCommission)%></span></div>
                    </div>
                </div>
            </div>
            <!--还款中-->

            <div class="bg-f1f3f5">
            	<div class="pt10 bg-f1f3f5 bt-e6e6e6"></div>
                <div class="clearfix loaning_tit bt-e6e6e6">
                    <%--<div class="lf c-808080 f12px"><%=TuanDai.WXApiWeb.Member.Repayment.borrowShow.GetBillStatus(model)%></div>--%>
                    <div class="rf c-808080 f12px">待结清本金&nbsp;&nbsp;+&nbsp;&nbsp;利息</div>
                </div>

                <div id="list"></div>

                <%--<div id="divDetailPagination<%=model.Status %>" totalcount="<%=subscribeCount %>">
                </div>--%>
            </div>

            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div>
    <%}
       else if ((!model.IsOverDueRecord && model.Status == 2)) //借入中
       { %>
    <div id="wrapper" style="top: 0;" class="bg-fff">
        <div id="scroller" class="bg-fff">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <div class="detail_t bg-fff">
                <%=ToolStatus.ConvertProjectType(model.Type)%> <%=model.Title%>
                <a >借入中</a>
                <p class="line-h16 f12px c-ababab mt4"><%=model.AddDate.ToString("yyyy-MM-dd")%>&nbsp;&nbsp;&nbsp;&nbsp;<%=model.AddDate.ToString("HH:mm:ss")%> </p>
                <%--<span class="<%=TuanDai.WXApiWeb.Member.Repayment.borrowShow.GetTipBoxCss(model)%>"><%=TuanDai.WXApiWeb.Member.Repayment.borrowShow.GetBillStatus(model)%></span>--%>
            </div>
            <div class="detail_b bt-f8ebcd ">
                <div class="clearfix pt10">
                    <div class="lf w50p c-666666 f13px">周转金额<span class="ml20 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.HaveBorrowedAmount)%></span></div>
                    <div class="lf w50p w50p c-666666 f13px">已结清本息<span class="ml20 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(repayedAmount) %></span></div>
                </div>
                <div class="clearfix pt10 pb15">
                    <div class="lf w50p c-666666 f13px">总利息<span class="ml32 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.TotalInterest)%></span></div>
                    <div class="lf w50p c-666666 f13px">待结清本息<span class="ml20 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(duerepayAmount)%></span></div>
                </div>
                <div class="bt-d1-dash">
                    <div class="clearfix pt13 pb13">
                        <div class="lf w50p w50p c-666666 f13px">周转金额<span class="ml20 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.Amount)%></span></div>
                        <div class="lf w50p c-666666 f13px">服务费<span class="ml32 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.BorrowPayoutCommission)%></span></div>
                    </div>
                </div>
            </div>
            <!--借入中-->
            <div class="bg-fff pos-r" id="loading">
                <div class="pl15 pr15">
                    <div class="loanBar">
                        <div class="loaningBar" style="width: <%=TuanDai.WXApiWeb.Member.Repayment.borrowShow.GetProcessStr(model)%>;"></div>
                    </div>
                    <p class="c-ababab mt8 f13px">截止日期:&nbsp;&nbsp;<%=model.TenderDate.ToString("yyyy.MM.dd")%></p>
                    <p class="c-ababab mt3 f13px">(截止日期前未满标，项目将自动下架)</p>
                </div>
            </div>
            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div>
    <div class="loan_btn loan_btn_bottom">
        <a href="javascript:void(0);" class="btn btnYellow" id="btnStop">结束发标</a>
    </div>
    <%}
       else if (!model.IsOverDueRecord && (model.Status == 0 || model.Status == 7 || model.Status == 6))//0申请中  7已流标 6已完成
       {
    %>
    <div id="wrapper" style="top: 0;" class="bg-fff">
        <div id="scroller" class="bg-fff">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <div class="detail_t bg-fff">
                <%=ToolStatus.ConvertProjectType(model.Type)%> <%=model.Title%>
                <a><%=model.Status==0?"申请中":model.Status==7?"已流标":"已完成" %></a>
                <p class="line-h16 f12px c-ababab mt4"><%=model.AddDate.ToString("yyyy-MM-dd")%>&nbsp;&nbsp;&nbsp;&nbsp;<%=model.AddDate.ToString("HH:mm:ss")%> </p>
                <%--<span class="<%=TuanDai.WXApiWeb.Member.Repayment.borrowShow.GetTipBoxCss(model)%>"><%=TuanDai.WXApiWeb.Member.Repayment.borrowShow.GetBillStatus(model)%></span>--%>
            </div>
            <div class="detail_b bt-f8ebcd ">
                <div class="clearfix pt10">
                    <div class="lf w50p c-666666 f13px">周转金额<span class="ml20 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.HaveBorrowedAmount)%></span></div>
                    <div class="lf w50p w50p c-666666 f13px">已结清本息<span class="ml20 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(repayedAmount) %></span></div>
                </div>
                <div class="clearfix pt10 pb15">
                    <div class="lf w50p c-666666 f13px">总利息<span class="ml32 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.TotalInterest)%></span></div>
                    <div class="lf w50p c-666666 f13px">待结清本息<span class="ml20 c-fab600 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(duerepayAmount)%></span></div>
                </div>
                <div class="bt-d1-dash">
                    <div class="clearfix pt13 pb13">
                        <div class="lf w50p w50p c-666666 f13px">周转金额<span class="ml20 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.Amount)%></span></div>
                        <div class="lf w50p c-666666 f13px">服务费<span class="ml32 f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(model.BorrowPayoutCommission)%></span></div>
                    </div>
                </div>
            </div>
            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div>
    <%
       }
    %>



    <!--提前还款的三个上滑弹窗 start-->
    <div class="mask" style="display: none;" id="maskLayer"></div>
    <!--提前还款-->
    <div class="payback-popup" style="display: none;" id="dvShowMoney">
        <div class="payback-d pl15">
            <div class="clearfix bor1 pr15">
                <div class="lf">
                    <p class="f13px">可用资金：</p>
                </div>
                <div class="rf">
                    <p class="f13px"><%=Tool.MoneyHelper.ConvertDetailWanMoney(AviMoney)%>元<a href="/Member/Bank/Recharge.aspx">充值</a></p>
                </div>
            </div>
            <div class="clearfix pr15">
                <div class="lf">
                    <p class="f13px mt5">待结清本息：</p>
                </div>
                <div class="rf">
                    <p class="f15px mt5 c-fd6040"><%=Tool.MoneyHelper.ConvertDetailWanMoney(actualAmount)%>元</p>
                </div>
            </div>
        </div>
        <div class="popup-cn pl15 pr15 mt15">
            <a href="/pages/downOpenApp.aspx" class="mt15 confirm f15px c-fff">提前结清请下载团贷网APP</a>
        </div>
    </div>


    <!--输入交易密码-->
    <div class="payback-popup" style="display: none;" id="dvPayPwd">
        <div class="popup-cn pl15 pr15 mt10">
            <p class="text-center f14px c-212121">请输入交易密码</p>
            <input type="password" placeholder="请输入交易密码" class="f14px" id="txtPayPwd" />
            <div class="control-cn">
                <a href="javascript:void(0);" class="f15px c-ababab cancel-but">取消</a>
                <a href="javascript:void(0);" class="f15px c-fff confirm-but" onclick="inputPaypwdClick()">确定</a>
            </div>
        </div>
    </div>
    <!--输入交易密码-->
    <div class="payback-popup" style="display: none;" id="dvPayPwd1">
        <div class="popup-cn pl15 pr15 mt10">
            <p class="text-center f14px c-212121">请输入交易密码</p>
            <input type="password" placeholder="请输入交易密码" class="f14px" id="txtPayPwd1" />
            <div class="control-cn">
                <a href="javascript:void(0);" class="f15px c-ababab cancel-but">取消</a>
                <a href="javascript:void(0);" class="f15px c-fff confirm-but" id="btnStopInvest">确定</a>
            </div>
        </div>
    </div>


    <!--提前还款成功-->
    <div class="payback-popup" style="display: none;" id="dvPaySuccess">
        <div class="popup-cn pl15 pr15 mt30">
            <p class="text-center f14px c-212121">
                <img src="/imgs/images/ico_suc_ro.png" alt="" />
                提前结清成功!
            </p>
            <a href="javascript:void(0);" class="mt15 confirm f15px c-fff" id="divSuccessOK">确定</a>
        </div>
    </div>

    <!--提前还款的三个上滑弹窗 end-->
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?=1.0"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        //申购页面函数
        var pagesize = "10";
        var pageIndex = "1";
        var pId = "<%=projectId %>";
        var tempStatus = "<%=model.Status%>";

        $(function () {

            //计算高度
            $("#loading").height($(window).height() - 230);


            iScroll.onLoadData = SubscribeDetailList;
            SubscribeDetailList("empty");
            
            //结束发标
            $("#btnStop").click(function () {
                try {
                    //--------存管通验证----2016-12-21------
                    if (isOpenCGT == "1" && !checkIsOpen())
                        return false;
                    //--------存管通验证结束------------
                } catch (e) {

                }

                if (isOpenCGT=="0") {
                    $("#dvPayPwd1").show();
                    $("#maskLayer").show();
                } else {
                    $.ajax({
                    url: "/ajaxCross/InvestAjax.ashx",
                    type: "post",
                    dataType: "json",
                    data: { Cmd: "updateprojectstatus", ProjectId: "<%=projectId%>", tranPwd: "" },
                    success: function (json) {
                        var status = parseInt(json.result);
                        if (status == 8888) {
                            location.href = unescape(json.msg);
                        } else {
                            $("body").showMessage({ message: json.msg, showCancel: false });
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        $("body").showMessage({ message: "结束发标失败,请重试!", showCancel: false });
                    }
                });
                }
            });
            $("#btnStopInvest").click(function () {
                var tranPwd = $("#txtPayPwd1").val().trim();
                if (tranPwd.length <= 0) {
                    $("#txtPayPwd1").val("");
                    $("#txtPayPwd1").focus();
                    return false;
                }
                $.ajax({
                    url: "/ajaxCross/InvestAjax.ashx",
                    type: "post",
                    dataType: "json",
                    data: { Cmd: "updateprojectstatus", ProjectId: "<%=projectId%>", tranPwd: $("#txtPayPwd1").val() },
                    success: function (json) {
                        var status = parseInt(json.result);
                        if (status == 1) {
                            $("#dvPayPwd1").hide();
                            $("#maskLayer").hide();
                            $("body").showMessage({
                                message: json.msg,
                                showCancel: false,
                                okbtnEvent: function() {
                                    window.location.href = "/Member/Repayment/borrowInvestShow.aspx?id=<%=projectId %>";
                                }
                            });
                        } else {
                            $("body").showMessage({ message: json.msg, showCancel: false });
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        $("body").showMessage({ message: "结束发标失败,请重试!", showCancel: false });
                    }
                });
            });

            $(".cancel-but").click(function () {
                $("#maskLayer").hide();
                $("#dvPayPwd").hide();
                $("#dvPayPwd1").hide();
            });
            $("#divSuccessOK").click(function () {
                $("#maskLayer").hide();
                $("#dvPaySuccess").hide();
                //刷新界面
                window.location.href = "/Member/Repayment/borrowInvestShow.aspx?id=<%=projectId %>";
            });
        });
        //加载还款记录列表
        function SubscribeDetailList(flag) {
            if (flag == "empty") {
                $("#list").html("");
            }
            jQuery.ajax({
                async: true,
                type: "post",
                url: "/ajaxCross/InvestAjax.ashx",
                dataType: "json",
                data: { Cmd: "GetSubscribeDetailList", projectid: pId, pagesize: pagesize, pageindex: pageIndex },
                success: function (jsonstr) {
                    var html = new Array();
                    var str = "";
                    if (jsonstr.result == "1") {
                        var temp1 = pagesize * (pageIndex - 1);
                        var autoDesc = "";
                        pageCount = parseInt(jsonstr.totalcount) % parseInt(pagesize) == 0 ? parseInt(jsonstr.totalcount) / parseInt(pagesize) : parseInt((parseInt(jsonstr.totalcount) / parseInt(pagesize)) + 1);
                        if (pageCount > 1) {
                            $("#pullUp").show();
                        } else {
                            $("#pullUp").hide();
                        }
                        for (var i = 0; i < jsonstr.list.length; i++) {
                            if (jsonstr.list[i].Status == 1) { //已还款
                                str = "<div class=\"loaning_project bt-e6e6e6\">" +
                                    "<div class=\"clearfix loaning_item\"><div class=\"lf f15px line-h32 c-ababab\">" + jsonstr.list[i].CycDate +
                                    "<span class=\"loaningS loaningS1\">" + jsonstr.list[i].StrStatus + "</span></div>" +
                                    "<div class=\"rf f15px line-h32 c-ababab\">￥" + jsonstr.list[i].AmountInterest +
                                    "<span class=\"c-ababab f16px txt_add\">+</span><span class=\"f15px  c-ababab\">" + jsonstr.list[i].RealInterestAmount +
                                    "</span></div></div>";
                                str += "</div>";
                                html.push(str);
                            }
                            else if (jsonstr.list[i].Status == 3) {//待还款
                                var islast = "";
                                if (i == (jsonstr.list.length - 1))
                                    islast = "";

                                str = " <div class=\"loaning_project bt-e6e6e6 " + islast + "\">" +
                                    "<div class=\"clearfix loaning_item\"><div class=\"lf f15px line-h32\">" + jsonstr.list[i].CycDate +
                                    "<span class=\"loaningS loaningS2\">" + jsonstr.list[i].StrStatus + "</span></div>" +
                                    "<div class=\"rf f15px line-h32\">￥" + jsonstr.list[i].AmountInterest +
                                    "<span class=\"c-ababab f16px txt_add\">+</span><span class=\"f15px c-fab600\">" + jsonstr.list[i].RealInterestAmount +
                                    "</span></div></div>";
                                if (jsonstr.list[i].DueDay > 0) {
                                    str += " <div class=\"loanDelay clearfix\">" +
                                            "<div class=\"lf c-fd6040\">逾期" + jsonstr.list[i].DueDay + "天</div>" +
                                            "<div class=\"rf c-fd6040\"><span class=\"c-fd6040 mr15\">(逾期利息+滞纳金)</span>￥" + jsonstr.list[i].OverDueInterest + "&nbsp;+&nbsp;" + jsonstr.list[i].PenaltyAmount + "</div></div>";
                                }
                                str += "</div>";
                                html.push(str);
                            }
                            else if (jsonstr.list[i].Status == 2) {//已逾期
                                var islast = "";
                                if (i == (jsonstr.list.length - 1))
                                    islast = "";

                                str = " <div class=\"loaning_project bt-e6e6e6 " + islast + "\">" +
                                    "<div class=\"clearfix loaning_item\"><div class=\"lf f15px line-h32\">" + jsonstr.list[i].CycDate +
                                    "<span class=\"loaningS loaningS3\">" + jsonstr.list[i].StrStatus + "</span></div>" +
                                    "<div class=\"rf f15px line-h32\">￥" + jsonstr.list[i].AmountInterest +
                                    "<span class=\"c-ababab f16px txt_add\">+</span><span class=\"f15px c-fd6040\">" + jsonstr.list[i].RealInterestAmount +
                                    "</span></div></div>";
                                if (jsonstr.list[i].DueDay > 0) {
                                    str += " <div class=\"loanDelay clearfix\">" +
                                            "<div class=\"lf c-fd6040\">逾期" + jsonstr.list[i].DueDay + "天</div>" +
                                            "<div class=\"rf c-fd6040\"><span class=\"c-fd6040 mr15\">(逾期利息+滞纳金)</span>￥" + jsonstr.list[i].OverDueInterest + "&nbsp;+&nbsp;" + jsonstr.list[i].PenaltyAmount + "</div></div>";
                                }
                                str += "</div>";
                                html.push(str);
                            }
                        }
                        if ("<%=model.IsPrepayment%>" == "True" && flag == "empty") {
                            var tiqian = " <div class=\"loan_btn pt25\"><a href=\"/pages/downopenapp.aspx\"  class=\"btn btnYellow\">提前结清请下载团贷网App</a></div>";

                            $("#wrapper").after(tiqian);
                        }

                        $("#list").append(html);

                        myScroll.refresh();
                    }
                    else {
                        $("<tr><td colspan=\"7\" align=\"center\">暂没有结清记录...</td></tr>").insertAfter('#subscribedetaillist' + tempStatus);
                    }
                }
            });
        }
         
        //提前还款
        function advanceRepayment() {
            try {
                //--------存管通验证----2016-12-21------
                if (isOpenCGT == "1" && !checkIsOpen())
                    return false;
                //--------存管通验证结束------------
            } catch (e) {

            }
            $("#maskLayer").show();
            $("#dvShowMoney").show();
        }

        $("#maskLayer").click(function () {
            $("#maskLayer").hide();
            $("#dvShowMoney").hide();
            $("#dvPayPwd").hide();
            $("#dvPayPwd1").hide();
        });
        //提前还款弹出显示密码框
        function showPayPwdWin() {
            try {
                //-------存管通验证---2016-12-21----
                if (isOpenCGT == "1" && !checkIsOpen())
                    return false;
                //-------存管通验证结束----------
            } catch (e) {

            }
            if (isOpenCGT == "1") {
                $.ajax({
                    url: "/ajaxCross/BorrowAjax.ashx",
                    type: "post",
                    dataType: "json",
                    data: { Cmd: "PrepaymentSubmit", ProjectId: "<%=projectId%>", TranPwd: "" },
                    success: function (json) {
                        if (json.result == "8888") {
                            location.href = unescape(json.msg);
                        } else {
                            $("body").showMessage({ message: json.msg, showCancel: false });
                            //alert(json.msg);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //alert("提前还款失败,请重试!");
                        $("body").showMessage({ message: "提前结清失败,请重试!", showCancel: false });
                    }
                });
            } else {
                $("#dvShowMoney").hide();
                $("#dvPayPwd").show();
            }
            
        }
        //输入交易密码后事件
        function inputPaypwdClick() {
            var pwd = $("#txtPayPwd").val().trim();
            if (pwd == "") {
                $("#txtPayPwd").focus();
                return false;
            }
            else {
                $("#maskLayer").hide();
                $("#dvPayPwd").hide();
                $.ajax({
                    url: "/ajaxCross/BorrowAjax.ashx",
                    type: "post",
                    dataType: "json",
                    data: { Cmd: "PrepaymentSubmit", ProjectId: "<%=projectId%>", TranPwd: pwd },
                    success: function (json) {
                        if (json.result == "1") {
                            //还款成功
                            $("#maskLayer").show();
                            $("#dvPaySuccess").show();
                        } else {
                            $("body").showMessage({ message: json.msg, showCancel: false });
                            //alert(json.msg);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //alert("提前还款失败,请重试!");
                        $("body").showMessage({ message: "提前结清失败,请重试!", showCancel: false });
                    }
                });
            }
        }
    </script>

</body>
</html>
