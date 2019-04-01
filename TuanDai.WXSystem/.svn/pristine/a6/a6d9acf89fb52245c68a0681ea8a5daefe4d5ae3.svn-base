<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ftb_ZQDetail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.WE.Ftb_ZQDetail" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>债权明细</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>
<body>
    <%= this.GetNavStr()%>
    <div id="wrapper" style="background: none;">
        <div id="scroller" style="margin-top: 0px;">
            <div id="pullDown" style="background: #f1f3f5; margin-bottom: 0;">
                <div class="centerBox-wp">
                    <div class="pullDownTips">
                        <span class="pullDownIcon"></span>
                        <span class="pullDownLabel"></span>
                    </div>
                </div>
            </div>
            <div class="wrap-mx" id="thelist">
                <!--
                <div class="mx-con bb-e6e6e6">
                    <div class="title clearfix">
                        <p class="lf">正合普惠会员借款16020213-7</p>
                        <a href="javascript:;" class="rf">查看详情</a>
                    </div>
                    <div class="webkit-box mx-item">
                        <div class="box-flex1 mx-name">
                            <span>李**</span>
                            <span>借款人/企业</span>
                        </div>
                        <div class="box-flex1 mx-id">
                            <span>4405****0909</span>
                            <span>身份证号/机构代码</span>
                        </div>
                        <div class="box-flex1 mx-money">
                            <span>1,5000.00元</span>
                            <span>借款总额</span>
                        </div>
                    </div>
                </div>
                -->
            </div>
        <div id="pullUp">
            <span class="pullUpIcon"></span><span class="pullUpLabel"></span>
        </div>
    </div>
    </div>
</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">
    $(function () {
        LoadList("empty");
        iScroll.onLoadData = LoadList;
        function LoadList(flag) {
            if (flag == "empty") {
                $("#thelist").children().remove();
            }
            
            jQuery.ajax({
                type: "post",
                url: "/ajaxCross/ajax_wefqb.ashx",
                data: { Cmd: "GetWeFtbObligatoryList", pageIndex: pageIndex, projectid:"<%= Request.QueryString["productid"]%>"},
                dataType: "json",
                success: function (jsonstr) {
                    if (flag == "empty") {
                        $("#thelist").children().remove();
                    }
                    var html = new Array();
                    var str = "";
                    pageCount = parseInt(jsonstr.totalcount) % 15 == 0 ? parseInt(jsonstr.totalcount) / 15 : parseInt(parseInt(jsonstr.totalcount) / 15) + 1;
                    if (pageCount <= 1) {
                        $("#pullUp").hide();
                    } else {
                        $("#pullUp").show();
                    }

                    if (jsonstr.result == "1") {
                        $(jsonstr.msg).each(function(index, item) {
                            str = "<div class='mx-con bb-e6e6e6'>"+
                                        "<div class='title clearfix'>"+
                                            "<p class='lf'>" + item.ProjectTitle + "</p>" +
                                             "<a href='/pages/invest/detail.aspx?id=" + item.ProjectId + "' class='rf'>查看详情</a>" +
                                        "</div>"+
                                        "<div class='webkit-box mx-item'>"+
                                            "<div class='box-flex1 mx-name'>"+
                                                "<span>" + item.BorrowerName + "</span>" +
                                                "<span>借款人/企业</span>"+
                                            "</div>"+
                                            "<div class='box-flex1 mx-id'>"+
                                                "<span>" + item.IdentityCard + "</span>" +
                                                "<span>身份证号/机构代码</span>"+
                                            "</div>"+
                                            "<div class='box-flex1 mx-money'>"+
                                                "<span>" + fmoney(item.Amount,2) + "元</span>" +
                                                "<span>借款总额</span>"+
                                            "</div>"+
                                        "</div>" +
                                    "</div>";
                            html.push(str);
                        });
                        $("#thelist").append(html);
                    }
                    else {
                        $("#thelist").append("<div class='debt-empty mt50'><div class='img-debt-empty text-center'><img style='width: 60%;' src='/imgs/images/debt-empty.png'/></div><div class='text-center f14px c-212121 mt20'>暂无数据！</div></div></div>");
                    }
                    myScroll.refresh();
                },
                error: function (a, b, c) {
                    $("#thelist").append("<div class='debt-empty mt50'><div class='img-debt-empty text-center'><img style='width: 60%;' src='/imgs/images/debt-empty.png'/></div><div class='text-center f14px c-212121 mt20'>暂无数据！</div></div></div>");
                }
            });
        }
    });
</script>
</html>
