<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LotteryDraw.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.HighSpeedGame.LotteryDraw" %>

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
        var starNum = "<%=StarNum %>"; 
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
            <div class="a-box"><a href="javascript:void();"></a></div>
            <div class="a-box"><a href="javascript:void();"></a></div>
            <div class="a-box"><a href="javascript:void();"></a></div>
        </div>
    </div>
   <% if (IsLogin == false)
      {  %>
    <!--弹出层 提示登录注册-->
    <div class="full-pos popup-box">
        <div class="popup-cn">
            <div class="login-box clearfix">
                <a href="/user/Login.aspx?ReturnUrl=<%=returnUrl %>" class="login"></a>
                <a href="/user/Register.aspx?ReturnUrl=<%=returnUrl %>" class="reg"></a>
            </div>
        </div>
        <div class="mask"></div>
    </div>
  <%} %>
</section>

<!--弹窗-->
 <section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
  <div class="hbody clearfix" style="margin-bottom: 9px;">
    <i class="ico-exclamation40 lf mr10"></i>
    <span id="msg" style="  font-size: 14px;line-height: 39px;"></span>
  </div>
  <div class="completeBox clearfix">
    <span style="float: right;max-width: 40%;">
        <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>  
    </span>
    <span style="float: right;max-width: 60%;padding-right: 20px;">
        <input type="button" class="btn btnGreen h40" value="取消" id="btnCancel" onclick="Done()" style="font-size: 14px;padding: 0 10px;min-width: 90px;"/> 
    </span>
  </div>
</section>
<!--遮罩层-->
<div class="maskLayer hide"></div>

<script src="js/jquery-2.1.1.min.js" type="text/javascript"></script> 
<script src="js/lottery.js?v=1.0" type="text/javascript"></script> 
<script src="js/weixinapi.js?v=2.3" type="text/javascript"></script> 
<script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
</body>
</html>