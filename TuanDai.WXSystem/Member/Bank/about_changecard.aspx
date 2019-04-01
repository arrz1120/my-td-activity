﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="about_changecard.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Bank.about_changecard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>换卡须知</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=20150907" /><!--base-->
    <style type="text/css">
        /*换卡须知*/
        .c-282828{color: #282828;}
        .about-change-card .item{border-bottom: 1px solid #d9d9d9;}
        .about-change-card .item p{line-height: 170%;}
    </style>
</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">换卡须知</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>
<div class="about-change-card">
    <div class="item ml15 pr15 pt10">
        <h3 class="c-282828 f15px mb10">尊敬的团贷网用户：</h3>
        <p class="c-545454 f13px pb10">为了减少恶意套现行为，保障用户的资金安全，团贷网对换绑银行卡流程做了以下调整，对您造成的不便，请谅解。</p>
    </div>
    <div class="item ml15 pr15 pt10">
        <h3 class="c-282828 f15px mb10">1、添加服务号</h3>
        <p class="c-545454 f13px pb10">用户如需换卡，请添加服务QQ号：2880761023（工作时间：工作日早上9:00-12:00，下午13:30-18:00）。</p>
    </div>
    <div class="item ml15 pr15 pt10">
        <h3 class="c-282828 f15px mb10">2、提交材料</h3>
        <p class="c-545454 f13px pb10">添加服务QQ后，请提交以下换卡材料：身份证、旧银行卡、新银行卡扫描件或照片。如遇旧银行卡销户、挂失或其他无法提供扫描件或照片的情况，须提供该银行卡业务回执单扫描件或照片。</p>
    </div>
    <div class="item  ml15 pr15 pt10">
        <h3 class="c-282828 f15px mb10">3、审核材料</h3>
        <p class="c-545454 f13px pb10">根据客服引导进行视频认证，并准备好身份证、旧银行卡和新银行卡配合验证。</p>
    </div>
    <div class="item ml15 pr15 pt10">
        <h3 class="c-282828 f15px mb10">4、视频认证</h3>
        <p class="c-545454 f13px pb10">视频认证后，平台将在30分钟内完成银行卡修改；材料不齐全或视频认证不通过，则视为申请失败。</p>
    </div>

</div>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
</body>
</html>
