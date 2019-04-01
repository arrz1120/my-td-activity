<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gift.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.GodWealth.Gift" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"  content="width=640,target-densitydpi=device-dpi,user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="css/style.css?v=20150912">
<title>快乐领红包，任性当财神</title>
<meta name="author" content="kevin" />
<meta name="Copyright" content="东莞团贷网互联网科技服务有限公司"/>
<meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财" />
<meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。" />
 <script type="text/javascript" src="/scripts/jquery.min.js"></script>
 <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>     
 <script type="text/javascript" src="/scripts/weixinapi.js?v=3.4"></script>  
 <script type="text/javascript"> 
     wxData.isWxJsSDK = true;
     //wxData.debug = true;
     wxData.url = "http://m.tuandai.com/Activity/GodWealth/Index.aspx?ExtendKey=<%=SelfOpenId %>";
     wxData.title = "<%=GodShowName %>财神给您派红包了，快来领取吧！";
     wxData.desc = "快乐领红包，任性当财神！  百万红包随我派！";
     wxData.img_url = "http://m.tuandai.com/Activity/GodWealth/images/share.png";
     wxData.ShareCallBack = function (ex) { 
        
     }
    </script> 
</head>
<body>
<div id="wraper">
    <div id="main">
        <section class="sec giftBox" style="display:block">
            <div class="imgBox"><img src="images/pg2_img01.png"></div>
            <div class="imgBox pg-img2"><img src="images/pg2_img02.png"></div>
            <div class="imgBox pg-img3"><img src="images/pg2_img03.png"></div>
            <div class="imgBox"><img src="images/pg2_img04.png"></div>

          
            <div class="imgBox" id="div1"><img src="images/pg2_img05.png"></div>
            <a href="javascript:void(0);" class="hbBtn"  dataval="<%=RedPackedStatus %>" ></a>
            <a href="javascript:void(0);" class="pgBtn"  dataval="<%=RedPackedStatus %>" >立即使用红包赚钱</a>
            

            <div class="phone-box" style="display:none;">
                <!--输入手机号码-->
                    <input type="text" placeholder="请输入你的手机号码" class="phone" id="txtPhone"  maxlength="11" onpaste="return false" oncontextmenu="return false" oncopy="return false" oncut="return false"/>
                <div class="code-cn pos-r" id="dvImgCode">
                    <input type="text" placeholder="请输入右侧验证码" id="txtImgCode"  maxlength="4"/>
                    <img src="/Activity/ExperienceGold/ImageCode.ashx" title="点击换一个校验码" alt="点击换一个校验码" id="imVcode" onclick="reloadCode('/Activity/ExperienceGold/ImageCode.ashx')" />
                </div>
                   
                <a href="javascript:void(0);" class="get-money" id="btnGetMoney">立即领钱</a>
             
                     

                <!--填写验证密码-->
                <div class="code-cn pos-r" style="display:none;" id="dvCode">
                    <input type="text" placeholder="请输入手机验证码" id="txtCode"  maxlength="6" /> 
                    <input type="button" value="180秒后重新获取" id="btnSendCode" class="disabled">
                </div>
                <a href="javascript:void(0);" class="get-money" style="display:none;" id="btnConfirm">确认</a>
                <p>已有账号？<a href="javascript:void(0);" id="btnExistLogin" >立即登录</a></p>
            </div>
        </section>
    </div>

    <div class="bg-footer"></div>
</div> 
 <script type="text/javascript" src="js/gift.js?v=20150918001"></script> 
</body>
</html>