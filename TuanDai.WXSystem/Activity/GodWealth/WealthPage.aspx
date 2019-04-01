<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WealthPage.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.GodWealth.WealthPage" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"  content="width=640,target-densitydpi=device-dpi,user-scalable=no"/> 
    <title>快乐领红包，任性当财神</title>
    <meta name="author" content="kevin" />
    <meta name="Copyright" content="东莞团贷网互联网科技服务有限公司"/>
    <meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财" />
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。" /> 
    <link rel="stylesheet" type="text/css" href="css/style.css?v=20150901001">
    <script type="text/javascript" src="js/motion.js?v=1.0"></script>
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>     
    <script type="text/javascript" src="/scripts/weixinapi.js?v=3.4"></script>  

    <script type="text/javascript">
        var ExtendKey = "<%=ExtendKey %>"; 
        wxData.isWxJsSDK = true;
        //wxData.debug = true;
        wxData.url = "http://m.tuandai.com/Activity/GodWealth/Index.aspx?ExtendKey=<%=SelfOpenId %>";
        wxData.title = "<%=GodShowName %>财神给您派红包了，快来领取吧！";
        wxData.desc = "快乐领红包，任性当财神！  百万红包随我派！";
        wxData.img_url = "http://m.tuandai.com/Activity/GodWealth/images/share.png";
        wxData.ShareCallBack = function (ex) {
            if (ex == "success" && $(".sec04").css('display') != "none") {
                hidePop(".sec04");
                showPop(".sec05");
            }
        }
    </script> 
</head>
<body> 
 <!--微信分享时图片-->
<div style="display:none;"><img src="http://m.tuandai.com/Activity/GodWealth/images/share.png"></div>  

 <div id="wraper"> 

    <div id="main">
       <!--分享给好友进来时-->
        <section class="sec sec01" style="display:<%=this.UserStatus == "4"?"block":"none" %>">
            <div class="bgBox top-text1"><span><%=GodShowName%></span></div>
            <div class="imgBox overPic"><img src="<%=GodHeadImage %>"></div>
            <div class="btn" id="lookPacket">查看红包</div>
        </section>
        <section class="sec sec02" style="display:none" >
            <div class="bgBox smallPacket"></div>
            <div class="bgBox bgPacket">
                <div class="text1">恭喜您获得来自<br><%=GodShowName%>财神的红包</div>
                <div class="num">10<span class="f30px">元</span></div>
                <div class="bgBox curve"></div>
                <div class="bigBtn-Y" id="transmitPacket">传递财运·享用红包</div>
            </div>
        </section>

        <section class="sec sec03" style="display:<%=this.UserStatus == "2"?"block":"none" %>">
            <div class="imgBox frame"><img src="images/frame.png"></div>
            <div class="tipText">点击右侧按钮上传图片</div>
            <div id="container" class="editor"></div>
             <% if(!string.IsNullOrEmpty(ExtendKey)){ %>
               <div class="bgBox top-text-fx"></div><!--分享进来显示-->
            <%}else{ %>
              <div class="bgBox top-text-sm"></div><!--扫码进来显示-->
            <%} %>
            <div class="fileuploadBox">
                <input id="fileupload" class="bgBox" type="file" accept="image/*" capture="camera">
            </div>
            <div class="hand-sm"></div>
            <div class="fdCont">
                <input type="text" name="txtName" id="txtName" placeholder="输入您的姓名" maxlength="4" onpaste="return false" oncontextmenu="return false" oncopy="return false" oncut="return false" >
                <input type="hidden" id="hideImgData"  name="hideImgData" />
                <div class="textC c-666 mt10 mb10"><span class="c-cd3232">*</span>只能输入汉字，且字数不能超4个</div>
                <div class="btnR" style="width:240px;">马上当财神</div>
            </div>
            <div class="bgBox tips1"></div>
        </section>

        <section class="sec sec04" style="display:none;">
            <div class="bgBox top-text1"><span class="nameText">XXX</span></div>
            <div class="imgBox overPic"><img src="images/imgdone.jpg" id="imgGodPreview"></div>
            <div class="fdCont" style="top:70%">
                <div class="textC c-666 mt10 mb10 f18px">恭喜您已成功当上财神<br>赶紧给小伙伴传递财运</div>
                <div class="btnR" style="width:320px;"><b class="hand"></b><span class="btnR-t">传递财运·派送红包</span></div>
            </div>
            <div class="bgBox overshare"></div>
        </section>
        <section class="sec sec05" style="display:none;">
            <div class="bgBox bgPacket">
                <div class="text2"><span class="nameText">XXX</span>财神<br>感谢您成功将财运传给大家<br>赶紧享用之前领取的红包吧</div>
            </div>
            <div class="fdCont" style="top:78%">
                <a href="javascript:void(0);" class="btnR" style="width:320px;" id="btnGoInvest">马上使用红包赚钱</a>
            </div>
        </section>

        <!--第二次进来时-->
        <section class="sec sec06" style="display:<%=(this.UserStatus=="3"||this.UserStatus=="5")?"block":"none"%>">
            <div class="bgBox top-text2"><span><%=GodShowName%></span></div>
            <div class="imgBox overPic"><img src="<%=GodHeadImage %>"></div>
            <div class="fdCont" style="top:70%">
                <% if (RedPackedStatus == "3")
                   { %>
                   <div class="btnR" style="width:390px;">对不起，您的红包已过期！</div>
                <%}
                   else
                   { %>
                        <div class="textC c-666 mt10 mb10 f18px"><%=GodShowName%>财神<br>已有<span class="c-cd3232"><%=FriendNum%></span>人领取了您派发的红包</div>
                
                        <div class="btnR" style="width:390px;"><b class="hand"></b>
                        <% if (RedPackedStatus == "1" || RedPackedStatus=="0")
                           { %>
                        <a href="javascript:void(0);"  class="btnR" dataval="<%=RedPackedStatus %>"  id="btnMyRedPacket">马上使用红包赚钱</a>
                        <%}
                           else
                           { %>
                           <a href="javascript:void(0);"  class="btnR">您已使用过自己领取的红包</a>
                        <%} %>
                        </div>
                <%} %>
            </div>
        </section>

        <section class="sec sec07" style="display:<%=(this.UserStatus=="6"||this.UserStatus=="1")?"block":"none"%>">
            <div class="bgBox top-text2"><span><%=GodShowName%></span></div>
            <div class="imgBox overPic"><img src="<%=GodHeadImage %>"></div>
            <div class="fdCont" style="top:75%"> 
                <% if (UserStatus == "1")
                   { %>
                  <div class="textC c-666 mt10 mb10 f18px">对不起，活动已结束!</div>
                <%}
                   else
                   { %>
                   <div class="textC c-666 mt10 mb10 f18px"><%=GodShowName%>的红包已被抢光!</div> 
                   <div class="btnR" style="width:380px;"><b class="hand"></b><a href="http://www.tuandai.com/user/phonerRegister/index.html"  class="btnR"  id="btnGoTundai">移步团贷网领取新手红包</a></div>
                <%} %>
            </div>
        </section>

        <div class="ruleText">活动规则</div>
        <div class="bg-footer"></div>
    </div>
    <!--规则 S-->
    <div id="rule">
        <div class="btnBig">活动规则</div>
        <ul class="ruleCont">
            <li><b>1</b>开始时间：9月12日；</li>
            <li><b>2</b>每人仅可以领取1份红包，派发红包份数无限；</li>
            <li><b>3</b>本次活动共设红包10000份,派完即止；</li>
            <li><b>4</b>红包使用规则详见团宝箱奖品来源说明；</li>
            <li><b>5</b>获得红包后，需于1个月内在微信服务号中登陆团贷账号并进行关联方可使用；</li>
            <li><b>6</b>完成关联后，1个月内红包有效，过期即作废；</li>
            <li><b>7</b>本次活动解释权归团贷网所有。</li>
        </ul>
        <div class="back">返回</div>
        <div class="bg-footer"></div>
    </div>
    <!--规则 E-->
</div>  
  
<script type="text/javascript" src="js/godwealth.js?v=2015082701"></script>  
<script type="text/javascript" src="js/index.js?v=20150822"></script>  
 
</body>
</html>
