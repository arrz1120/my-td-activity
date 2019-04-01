﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="push_switch.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.push_switch" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>消息设置</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/account2.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--账户中心-->
</head>
<body class="bg-f2f2f0">
    <%=GetNavStr() %>
<section class="pl15 bg-fff">
    <div class="pt15 pb15 bb-e6e6e6">
        <p class="c-333333 f15px">热标上线通知</p>
        <p class="c-999999 f12px line-h19">推荐热标上线推送</p>
        <%--<div class="states">
            <input type="checkbox" class="switch" name="time1" id="time1">
            <label for="time1"></label>
        </div>--%>
    </div>
    <div class="checkBox-wrap">
        <ul class="clearfix">
            <li>
                <div class="checkBox chk5_3" data="chk5_3"></div>
                <p>APP推送</p>
            </li>
            <li>
                <div class="checkBox chk5_4" data="chk5_4"></div>
                <p>微信服务号</p>
            </li>
        </ul>
    </div>
</section>
<section class="pl15 bg-fff mt15">
    <div class="pt15 pb15 bb-e6e6e6">
        <p class="c-333333 f15px">出借通知</p>
        <p class="c-999999 f12px line-h19 pr15">出借相关、自动投标、回款、债权转让、We计划提前退出/到期退出等消息提醒</p>
    </div>
    <div class="checkBox-wrap">
        <ul class="clearfix">
            <li>
                <div class="checkBox chk2_1" data="chk2_1"></div>
                <p>系统消息</p>
            </li>
            <li>
                <div class="checkBox chk2_2" data="chk2_2"></div>
                <p>短信</p>
            </li>
            <li>
                <div class="checkBox chk2_3" data="chk2_3"></div>
                <p>APP推送</p>
            </li>
            <li>
                <div class="checkBox chk2_4" data="chk2_4"></div>
                <p>微信服务号</p>
            </li>
            <li>
                <div class="checkBox chk2_5" data="chk2_5"></div>
                <p>邮件</p>
            </li>
        </ul>
    </div>
</section>

<section class="pl15 bg-fff mt15">
    <div class="pt15 pb15 bb-e6e6e6">
        <p class="c-333333 f15px">借款通知</p>
        <p class="c-999999 f12px line-h19">借款、还款相关提醒</p>
    </div>
    <div class="checkBox-wrap">
        <ul class="clearfix">
            <li>
                <div class="checkBox chk3_1" data="chk3_1"></div>
                <p>系统消息</p>
            </li>
            <li>
                <div class="checkBox chk3_2" data="chk3_2"></div>
                <p>短信</p>
            </li>
            <li>
                <div class="checkBox chk3_3" data="chk3_3"></div>
                <p>APP推送</p>
            </li>
            <li>
                <div class="checkBox chk3_4" data="chk3_4"></div>
                <p>微信服务号</p>
            </li>
            <li>
                <div class="checkBox chk3_5" data="chk3_5"></div>
                <p>邮件</p>
            </li>
        </ul>
    </div>
</section>

<section class="pl15 bg-fff mt15">
    <div class="pt15 pb15 bb-e6e6e6">
        <p class="c-333333 f15px">奖品通知</p>
        <p class="c-999999 f12px line-h19">邀请好友成功及奖品过期前消息提醒</p>
    </div>
    <div class="checkBox-wrap">
        <ul class="clearfix">
            <li>
                <div class="checkBox chk4_1" data="chk4_1"></div>
                <p>系统消息</p>
            </li>
            <li>
                <div class="checkBox chk4_2" data="chk4_2"></div>
                <p>短信</p>
            </li>
            <li>
                <div class="checkBox chk4_3" data="chk4_3"></div>
                <p>APP推送</p>
            </li>
            <%--<li>
                <div class="checkBox chk4_4" data="chk4_4"></div>
                <p>微信服务号</p>
            </li>--%>
            <li>
                <div class="checkBox chk4_5" data="chk4_5"></div>
                <p>邮件</p>
            </li>
        </ul>
    </div>
</section>

<section class="pl15 pr15 mt15 pb15">
    <a href="javascript:;" class="btn btnYellow">保存设置</a>
</section>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        $(".checkBox").click(function() {
            if ($(this).hasClass("active")) {
                $(this).removeClass("active");
            } else {
                $(this).addClass("active");
            }
        });
        $(function() {
            LoadDetail();
            //保存设置
            $(".btnYellow").click(function () {
                var notices = "";
                var boxs = $(".checkBox");
                $(boxs).each(function(index, item) {
                    if ($(item).hasClass("active")) {
                        if (notices == "") {
                            notices = $(item).attr("data");
                        } else {
                            notices += ","+$(item).attr("data");
                        }
                    }
                });
                //alert(notices);
                $.ajax({
                    async: false,
                    type: "post",
                    url: "/ajaxCross/NewsAjax.ashx",
                    dataType: "json",
                    data: { Cmd: "SaveMessageSetInfo", notices: notices },
                    success: function (jsonstr) {
                        if (jsonstr.result == "1") {
                            $("body").showMessage({ message: "保存成功！", showCancel: false });
                        } else {
                            $("body").showMessage({
                                message: "保存失败，请重试！", showCancel: false, okbtnEvent: function () {
                                    window.location.href = window.location.href;
                                }
                            });
                        }
                    },
                    error: function () {

                    }
                });
            });
        });
        //加载设置信息
        function LoadDetail() {
            $.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/NewsAjax.ashx",
                dataType: "json",
                data: { Cmd: "GetMessageSetInfo" },
                success: function (jsonstr) {
                    if (jsonstr.result != "0") {
                        var categoryNotices = JSON.parse(jsonstr.msg).CategoryNotices;
                        if (categoryNotices != null) {
                            var cnArray = new Array();
                            cnArray.push(categoryNotices.split(','));
                            //alert(categoryNotices);
                            $(cnArray[0]).each(function (index, item) {
                                $(".checkBox").each(function (ind, box) {
                                    if (item == $(box).attr("data")) {
                                        $(box).addClass("active");
                                    }
                                });
                            });
                        }
                        
                    }
                },
                error: function () {

                }
            });
        };
        
    </script>
</body>
</html>