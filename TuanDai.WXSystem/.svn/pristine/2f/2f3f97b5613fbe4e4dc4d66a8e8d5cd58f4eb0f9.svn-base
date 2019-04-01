<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GuidePage.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.ThreeYearCeleb.GuidePage" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title><%=ExtendKey == "" ? "共庆团贷三周年 齐做蛋糕赢大礼！" : "快来帮我做蛋糕赢团贷三周年大礼!"%></title>  
    <link rel="stylesheet" type="text/css" href="css/style.css?v=1.7">
    <link rel="stylesheet" type="text/css" href="css/leaves.css?v=1.2">
    <link rel="stylesheet" type="text/css" href="css/celeb.css?v=1.3">
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>  
    <style type="text/css">
      .disabled{ height: 40px; line-height: 40px; width: 260px; color: #ffffff; background-color: #ababab; margin-top: 10px;}
    </style>
    <script type="text/javascript">
        var code = "<%=code %>";
        var ExtendKey = "<%=ExtendKey %>";
        var isLogin = "<%=IsLogin %>";
        var hostOpenId = "<%=HostOpenId %>";
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
<!--弹窗-->
 <section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
  <div class="hbody clearfix" style="margin-bottom: 9px;">
    <i class="ico-exclamation40 lf mr10"></i>
    <span id="msg" style="  font-size: 14px;line-height: 39px;"></span>
  </div>
  <div class="completeBox clearfix">
    <span style="float: right;max-width: 40%;">
        <a href="javascript:;" class="btnstyle btnYellow h40" id="btnOk" style="font-size: 1.4rem;padding: 0 10px;min-width: 90px;">确定</a>  
    </span>
    <span style="float: right;max-width: 60%;padding-right: 20px;">
        <input type="button" class="btnstyle btnGreen h40" value="取消" id="btnCancel" onclick="Done()" style="font-size: 1.4rem;padding: 0 10px;min-width: 90px;"/> 
    </span>
  </div>
</section>
<!--遮罩层-->
<div class="maskLayer hide"></div>

<!--二维码弹层-->
<div class="codeMain" id="codeMain">
    <div class="codeCont">
        <img src="images/code.png" width="92" height="92" class="codeImg">
        <div class="textCont">
            <p>方式1：长按二维码-关注“团贷服务平台”</p>
            <p>方式2：添加好友-查找公众号-关注“团贷服务平台”</p>
        </div>
    </div>
    <div class="close" onclick="closeLayer(codeMain)"></div>
    <div class="mask"></div>
</div> 
 

<img src="images/wx.jpg" class="hidden">
    <section class="nav">
        <ul>
            <li class="current">活动专区</li>
            <li>我的排行榜</li>
            <li>我的奖品</li>
        </ul>
    </section>
    <section class="main clearfix">
        <!--第一页面-->
        <div class="contentBox clearfix tabA" style="display:block;">
            <div class="imgBox light"></div>
            <div class="imgBox light2"></div>
            <div id="leafContainer"></div>
            <div class="tabAcont">
                <div class="goto ruleBtnBox"><a href="javascript:;" class="ruleBtn" rel="#tabArule">活动规则</a></div>
                <!-- <div class="imgBox flags"><img src="images/flags.png"></div> -->
                <div class="imgBox t1-text mt25"><img src="images/text.png"></div>
                <div class="cake">
                    <div class="packet"></div>
                    <div class="velas v1">
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                    </div>
                    <div class="velas v2">
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                    </div>
                    <div class="velas v3">
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                      <div class="fuego"></div>
                    </div>
                </div>
                 <div class="c-fff f12px textC mt10">
                  <% if (ExtendKey == "")
                     { %>
                       已经有<label id="lblCakeNum">0</label>位好友和你一起做蛋糕了！
                   <%}
                     else
                     { %>
                      已经有<label id="lblCakeNum">0</label>位用户为他做蛋糕了！
                   <%} %>
                  </div>
                <div class="clearfix">
                   <a href="javascript:void(0);" class="btn disabled"  id="btnStartCacke">
                     <%=(ExtendKey != "" ? "活动已结束" : "活动已结束")%></a>
                </div>
                <div class="clearfix">
                    <a href="javascript:void(0);" class="btn disabled" id="btnInvest">感谢您的关注！</a></div>
                    <div class="tapArule mb100" id="tabArule">
                        <p><span>好礼1</span>自己做蛋糕，赢投资红包；</p>
                        <p><span>好礼2</span>召集好友做蛋糕，攒人气赢苹果电脑；</p>
                        <p><span>好礼3</span>到“团贷微信服务号”投资，抢iPhone6;</p> 
                        <p><span>时间</span>2015年7月14日~7月31日</p> 
                        <a href="javascript:void();" class="btnAbout1" onclick="goToAboutMe()">了解团贷网>></a>
                    </div>
            </div> 
            <!--弹出层-->
            <div class="layer">
                <div class="layerCont">
                    <div class="Cont">
                        <div class="text1" id="divCakePrize">
                            <p>恭喜你，成功做蛋糕！</p>
                            <p>获得<span class="c-ffde00">10元</span>投资红包！</p>
                        </div>
                        <div class="text2" id="divYaoFriend"> 
                            <p>马上邀请好友帮忙一起做蛋糕，</p>
                            <p>赢苹果系大奖</p> 
                        </div>
                        <div class="mt10 clearfix"><a href="javascript:;" class="btn b2" id="shareBtn">分享好友</a></div>
                    </div>
                    <div class="redPackt"></div>
                    <div class="ribbon"></div>
                    <div class="close" onclick="closeLayer2()"></div>
                </div> 
                <div class="sharepop">
                    <a href="javascript:void(0);" class="sharepop-close animated slideInRight"></a>
                </div>
                <div class="mask"></div>
            </div>
        </div>

        <!--第二页面-->
        <div class="contentBox tabB clearfix">
             <div class="goto clearfix">
                   <a href="javascript:void();" class="btnAbout2" onclick="goToAboutMe()">了解团贷</a>
             </div>
            <div class="Cont clearfix"> 
                <div class="btnBox goto clearfix">
                    <div><a href="javascript:;" rel="#NO1" class="first">查看1号榜单</a></div>
                    <div><a href="javascript:;" rel="#NO2" class="last">查看2号榜单</a></div>
                </div>
                <div class="c-ff4f4e f12px textC" id="NO1">1号榜单：邀请朋友人气榜</div>
                <div class="textSm">上榜条件：点击“马上做蛋糕 · 赢苹果电脑”，邀请越多好友帮忙，上榜机会越大，前50名用户可得苹果系等奖品，赶紧分享邀请朋友来参加吧，同时可参与2号榜单活动哦！</div>
                <div class="imgBox flags"><img src="images/line.png"></div>
                <div class="tbody clearfix">
                    <ul>
                        <li>排名</li>
                        <li>用户名</li>
                        <li>做蛋糕次数</li>
                    </ul>
                </div>
                <div class="slideBox" id="slideNo1">
                     <!--蛋糕次数排行榜 Start-->
                    <div class="items" > 
                        <ul id="cakeList" class="slide">
                            <li style="text-align: center;color:#ff4f4e">
                                暂无数据!
                            </li> 
                        </ul> 
                    </div> 
                     <!--蛋糕次数排行榜 End-->
                    <div class="bar">
                        <ul id="slideBar1">
                            <li class="on">1</li> 
                        </ul>
                    </div> 
                </div>
            </div>
            <div class="Cont mt60 clearfix">
                <div class="c-ff4f4e f12px textC pt15" id="NO2">2号榜单：微信服务号投资排行榜</div>
                <div class="textSm">上榜条件：点击“马上投资 · 抢iPhone6”，活动期间在“团贷网微信服务号”上投资越多，上榜机会越大，累计投资前50名用户可获得苹果系等奖品，赶紧关注微信服务号-“团贷网服务平台”投资吧，同时可参与第1榜单活动哦！</div>
                <div class="imgBox flags"><img src="images/line.png"></div>
                <div class="tbody clearfix">
                    <ul>
                        <li>排名</li>
                        <li>用户名</li>
                        <li>投资金额</li>
                    </ul>
                </div>
                <div class="slideBox" id="slideNo2">
                  <!--投资排行榜 Start-->
                    <div class="items">
                        <ul class="slide" id="investList">
                            <li style="text-align: center;color:#ff4f4e">
                                暂无数据!
                            </li>
                        </ul>
                    </div>
                  <!--投资排行榜 End-->
                   <div class="bar">
                        <ul id="slideBar2">
                            <li class="on">1</li> 
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!--第三页面-->
        <div class="contentBox tabC">
            <div class="Cont clearfix">
                <div class="tbody">
                    <div class="tCont">
                        <div class="tb">我的奖品</div>
                        <div class="bd">
                            <p >
                               <ul id="prizeList">
                                  <li  style='text-align:center'>暂无获奖数据</li> 
                               </ul> 
                            </p> 
                            <br />
                            <p>赶快邀请好友帮忙做蛋糕</p>
                            <p>8月1日揭晓大奖</p>
                        </div>
                        <div class="fb">
                            <a href="javascript:void();" class="btn" id="btnGetPrize">马上领取</a>
                        </div>
                    </div>
                </div>
                <div class="body">
                    <div class="ruleBox">
                        <div class="tit"><span>活动规则</span></div>
                        <div class="c-ffde00 f12px mb10">1号排行榜规则：</div>
                        <p class="text"><b class="num">1</b>活动期间，每位用户可获得1次给自已做蛋糕机会，同时可帮其它多位好友做蛋糕，但不能重复帮同一位好友做蛋糕；</p>
                        <p class="text"><b class="num">2</b>首次点击给团贷三周年做蛋糕，即可获得1个投资红包，100%中奖；</p>
                        <p class="text"><b class="num">3</b>分享活动，邀请好友一起来参与，攒人气排行，抢苹果大礼；</p>
                        <p class="text"><b class="num">4</b>活动结束后，根据邀请好友做蛋糕的排名（同一团贷ID只能参与1次排名，如果出现多个微信排名对应同1个团贷ID，则按最高排名参与评奖，其余排名无效，并顺延至下一合格排名），前50名用户可分别获得苹果电脑（第1-3名）、苹果6手机（第4-10名）、IPAD Air（第11-25名）、UP MOVE 智能手环（第26-50名）。</p>
                        <div class="c-ffde00 f12px mb10">2号排行榜规则：</div>
                        <p class="text"><b class="num">1</b>活动期间7月14~31日，在团贷网微信服务号累计投资金额排行前50名的用户，可获得对应奖品；</p>
                        <p class="text"><b class="num">2</b>活动结束后，前50名用户可分别获得苹果电脑（第1-3名）、苹果6手机（第4-10名）、IPAD Air（第11-25名）、UP MOVE 智能手环（第26-50名）。</p>
                        <p class="text"><b class="star"></b>以上两个榜单的排名，如果出现数量一样多的情况，则排名按照时间先后顺序进行顺延。单用户可同时参与2个排行榜。一旦发现恶意违规刷票等行为，中奖用户将取消资格，顺延下一位合格用户。</p>
                    </div>
                    <div class="line"></div>
                    <div class="ruleBox">
                        <div class="tit mb15"><span>奖品发放与规则</span></div>
                        <p class="text"><b class="num">1</b>所有奖品须通过活动页面，开通/登陆团贷账户完成后，方可成功发送至个人团宝箱，其中，投资红包将马上到账，实物奖品将于您在“团宝箱”内完成奖品下单兑换后，7个工作日内发货；</p>
                        <p class="text"><b class="num">2</b>实物奖品有效领取时间截止至8月20日24:00；</p>
                        <p class="text"><b class="num">3</b>投资红包有效使用期截至做蛋糕取得红包后的一个月；</p>
                        <p class="text"><b class="num">4</b>所有奖品过期无效，不支持退换货、兑现、不提供发票等；</p>
                        <p class="text"><b class="num">5</b>中奖用户若不在有效期内登录账号并领取奖品，将视为自动放弃奖品；</p>
                        <p class="text"><b class="num">6</b>团贷网保留对此次活动的最终解释权。</p>
                    </div>
                </div> 
            </div>
           <div class="mt10 clearfix textC">
                <a href="javascript:void();" class="btnAbout1" onclick="goToAboutMe()">了解团贷网>></a>    
           </div>
        </div>
   </section> 
<!--音乐-->
<div class="music">
    <i class="icon-music open" num="1"></i><i class="music-span"></i>
    <audio id="aud" src="images/birthday.mp3" loop="loop" autoplay="autoplay"></audio>
    <div class="music_text">开启</div>
</div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="js/leaves.js"></script>  
<script type="text/javascript" src="js/weixinapi.js?v=3.3"></script>  
<script type="text/javascript" src="js/threeyearceleb.js?v=3.3"></script>
<script type="text/javascript" src="/scripts/base.js?v=1.0"></script>

 <script type="text/javascript">
     $(function () {
         $(".nav li").bind("click", function () {
             var index = $(this).index();
             var lis = $(".main > .contentBox");
             $("html, body").animate({ scrollTop: 0 }, 500);
             $(this).parent().children("li").attr("class", ""); //将所有选项置为未选中
             $(this).attr("class", "current"); //设置当前选中项为选中样式
             lis.hide(); //隐藏所有选中项内容
             lis.eq(index).show(); //显示选中项对应内容
         });
         $(".goto a").click(function () {
             var rel = $(this).attr("rel");
             var pos = $(rel).offset().top;
             $("html, body").animate({ scrollTop: pos }, 500);
         });

         //关闭分享
         $(".sharepop").find(".sharepop-close").click(function () {
             $(".sharepop").fadeOut();
             $(".layerCont").fadeIn();
             $(".layer").fadeOut(500);
         });
         //获取蛋糕数
         getSelfCakeNum();

//         $('#btnStartCacke').click(function () {
//             $("#btnStartCacke").unbind("click");
//             startDoCake();
//         });
//         //投资列表
//         $("#btnInvest").click(function () {
//             window.location.href = "/pages/invest/invest_list.aspx";
//         });

         //登录领取奖品
         $("#btnGetPrize").click(function () {
             $("#btnGetPrize").unbind("click");
             if (isCookieLogin())
                 window.location.href = "/Activity/ThreeYearCeleb/AwardPrize.aspx?code=" + code;
             else
                 window.location.href = "/user/Login.aspx?ReturnUrl=/Activity/ThreeYearCeleb/AwardPrize.aspx?code=" + code;
         });
         setSlideBarEvent();
         //预先加载一次
         getTopDoCakeUserRank(1);
         getTopInvestUserRank(1);
         //得到我的奖品
         getMyPrizeList();
     }); 
     
 </script> 
</body>
</html>
