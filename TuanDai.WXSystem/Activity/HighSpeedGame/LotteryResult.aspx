<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LotteryResult.aspx.cs" 
Inherits="TuanDai.WXApiWeb.Activity.HighSpeedGame.LotteryResult" ValidateRequest="false" %>

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
    <div class="full-pos prize-box">
        <!--老用户-->
         <%  if (model.IsPrized == 1)
             {
                 if (model.IsNewUser == 0)
                 {   
                 %>
         <div class="prize-cn1 prize-des">
             <p><span class="title"><%=model.Title%></span><%=model.PrizeName%></p>
        </div>
        <%}
                 else
                 { %>

        <!--新用户-->
        <div class="prize-cn1 prize-des mt">
            <p><span class="title"><%=model.Title%></span><%=model.PrizeName %></br><span class="prize2">以及388元新手现金红包</span></p> 
        </div>
        <%}
             } %>

       <%  if (model.IsPrized == 0)
           {
               if (model.IsNewUser == 0)
               {   
                 %>
            <!--老用户没中奖-->
            <div class="prize-cn2 prize-des"> 
                <p><span class="title">很遗憾！</span>谢谢您的参与</br>传递力量分享吧</p> 
            </div>
        <%}
               else
               { %>
           <div class="prize-cn1 prize-des mt">
                <p><span class="title">恭喜您！</span>获得团贷网</br><span class="prize1">388元新手现金红包</span></p>
              </div>
        <%}
           } %>

        <!--按钮区域 -->
        <div class="link-box clearfix">
            <%  if (model.IsNewUser == 1|| model.IsPrized==1)
                { %>
            <a href="javascript:;" class="share3 left share-but"></a>
            <a href="<%=PrizeURL%>" class="prize right"></a>
            <%}
                else
                { %>
            <!--老用没有中奖-->
            <a href="javascript:void();" class="share3 middle share-but"></a>
            <%} %>
        </div>
        <div class="sharepop">
               <a href="javascript:void(0);" class="sharepop-close animated slideInRight"></a>
        </div>
   </div>


</section>
<script src="js/jquery-2.1.1.min.js"></script>
<script src="js/weixinapi.js?v=2.3" type="text/javascript"></script>
<script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
<script type="text/javascript">

    $(".link-box").find(".share-but").click(function(){
        $(".sharepop").fadeIn(500);
        $(this).parent().next().find("a").addClass("show-close");
    });

    $(".sharepop").find(".sharepop-close").click(function(){
        $(this).parent().fadeOut(500);
    });

</script>
</body>
</html>