<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LotteryNone.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.HighSpeedGame.LotteryNone" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>脑洞全开 - 测你财“经”有多大？</title>
    <meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财">
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。">
    <meta name="viewport" content="width=device-width initial-scale=1.0 user-scalable=no" />
    <meta content="telephone=no" name="format-detection" />
    <link rel="stylesheet" href="css/question.css?v=001" />
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>  
    <script type="text/javascript"> 
        wx.config({
            debug: false,
            appId: '<%=AppId %>',
            timestamp: <%=TimeStamp%>,
            nonceStr: '<%=NonceStr %>',
            signature: '<%=Signature %>',
            jsApiList: [
                'checkJsApi',
                'onMenuShareTimeline',
                'onMenuShareAppMessage',
                'onMenuShareQQ',
                'onMenuShareWeibo',
                'hideMenuItems',
                'showMenuItems' 
                ]
            });
    </script>
</head>
<body>
<section class="wrapper">
    <div class="full-pos draw-box">
        <div class="draw-cn">
            <div class="a-box"><a href="javascript:;"></a></div>
            <div class="a-box"><a href="javascript:;"></a></div>
            <div class="a-box"><a href="javascript:;"></a></div>
        </div>
    </div> 

    <div class="full-pos popup-box"> 
      
        <!--弹出层 以抽奖过一次-->
        <div class="popup-cn">
            <div class="drawed-box clearfix">
                <a href="/Activity/HighSpeedGame/GameIndex.aspx" class="drawed"></a>
            </div>
        </div>

        <div class="mask"></div>
    </div> 

</section>
<script src="js/jquery-2.1.1.min.js"></script> 
<script src="js/weixinapi.js?v=2.3" type="text/javascript"></script>
<script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
</body>
</html>
