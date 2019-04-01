<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="automatic_rules.aspx.cs"
    Inherits="TuanDai.WXApiWeb.Member.setAuto.automatic_rules" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>自动投标规则</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <style type="text/css">
        .rulesBox
        {
            padding: 15px;
        }
        .rulesBox p
        {
            font-size: 1.2rem;
            line-height: 150%;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:history.go(-1);">返回</div>
            <h1 class="title">自动投标规则</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <section class="rulesBox clearfix">
    <p>1、新标上线即会启动自动投标功能；</p>
    <p>2、单笔投标金额若超过所投标借款总额的<%=limitPercent%>%，则以总标额的<%=limitPercent%>%为上限向下取该标最小出借单位的整数倍进行投标。</p>
    <p>3、投标排序规则如下：</p>
    <p>a ) 投标顺序按照开启自动投标的时间先后进行排序；</p>
    <p>b ) 每个用户投标后，重新回到队尾，依次循环进行投标；</p>
    <p>c ) 轮到用户进行投标时，若没有标符合用户设置的自动投标条件，视为自动放弃此次投标机会，重新排队；</p>
    <p>d ) 轮到用户投标时，若同时有多个标符合自动投标设置，则按照优先级根据用户第一条设置进行投标；</p>
    <p>温馨提示：</p>
    <p>a ) 自动投标功能设置中若没有设置预留金额，系统将默认用户账户内全部资金用于自动投标。</p>
    <p>b ) 自动投标设定之后，系统将严格按照用户预先设定执行，请谨慎操作。</p>
    </section>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1"></script>
</body>
</html>
