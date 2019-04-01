<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GuidPage.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.SeekLover.GuidPage" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>速配我的梦中情人</title>
    <meta name="keywords" content="团贷网,你我金融,互联网金融,P2P网贷,P2P理财">
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。">
    <link rel="stylesheet" href="css/style.css?v=20150825002"/>
    <script type="text/javascript" src="js/zepto.min.js"></script>
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>     
    <script type="text/javascript" src="/scripts/weixinapi.js?v=3.4"></script>   
    <script type="text/javascript" src="js/image-editor.min.js"></script>

    <script type="text/javascript">
         wxData.isWxJsSDK = true;
         //wxData.debug = true;
         wxData.url = "http://m.tuandai.com/Activity/SeekLover/AuthorIndex.aspx";
         wxData.title = "拼颜值，速配你的梦中情人";
         wxData.desc = "我的梦中情人竟然是“凤姐”";
         wxData.img_url = "http://m.tuandai.com/Activity/SeekLover/imgs/share.png";
         wxData.ShareCallBack = function (ex) {
            alert(ex == "success" ? "分享成功" : "取消分享");
         }
    </script>
</head>
<body>
 <!--微信分享时图片-->
 <div style="display:none;"><img src="http://m.tuandai.com/Activity/SeekLover/imgs/share.png"></div> 

<section class="audio-btn" id="audio_btn">
    <div id="music" class="play"></div>
    <audio loop="" src="imgs/music.mp3" id="media" autoplay="" preload=""></audio>
</section>
<section class="wrapper">
    <!--首页-->
        <section class="section page1" id="section0">
        <div class="full-pos bg1"></div>
        <div class="pic-box p1_1"><img src="imgs/p1_1.png"/></div>
        <div class="pic-box p1_2 animated bounceIn"><img src="imgs/p1_2.png"/></div>
        <div class="pic-box p1_3 animated fadeIn"><img src="imgs/p1_3.png" class="animated bounce p1_3cn"/></div>
        <div class="pic-box p1_4"><img src="imgs/p1_4.png"/></div>
        <div class="pic-box p1_5 animated fadeIn"><img src="imgs/p1_5.png"/></div>
        <a href="javascript:void(0);" class="butbg seek-but pos-a" id="seek-but">即刻上传你的靓照</a>
        <!--<a href="javascript:void(0);" class="next"></a>-->
    </section>

    <!--内容页-->
       <section class="section page2" id="section1">

           <!--上传页面-->
           <div class="upload-wrap" >
               <div class="full-pos bg2"></div>
               <div class="pic-box p2_1"><img src="imgs/p2_1.png"></div>
               <div class="pic-box p2_2"><img src="imgs/p2_2.png"></div>
               <div class="">

                   <div class="image-editor upload-box pos-a">
                       <div class="upload-cn pos-r">
                           <div class="pos-a upload-bg"></div>
                           <div class="pos-a circle"></div>
                           <!--<img src="imgs/upload-bg.png" class="pos-a upload-bg">-->
                           <!--<img src="imgs/upload-but.png" class="pos-a circle">-->
                           <input type="file" class="cropit-image-input pos-a" id="myFile" style="display: none;">
                           <div class="shoushi-box pos-a" onclick="document.querySelector('#myFile').click()" id="upload_but">
                               <img src="imgs/shoushi.png" class="shoushi"/>
                           </div>
                           <div class="cropit-image-preview pos-a"></div>

                           <div class="zoom-box pos-a">
                               <a href="javascript:void(0);" class="fd pos-a" id="btnZoomMax"></a>
                               调整图片大小
                               <a href="javascript:void(0);" class="sx pos-a" id="btnZoomMin"></a>
                           </div>

                           <div class="control pos-a">
                               <a href="javascript:void(0);" class="confirm pos-a">确定</a>
                               <a href="javascript:void(0);" class="again pos-a">重新上传</a>
                           </div>
                       </div>
                   </div>
               </div>
           </div>


        <!--上传loding-->
        <div class="load-box" style="display: none;">
                  <div class="full-pos bg3 z-index30"></div>
                  <div class="pic-box p3_1 z-index30"><img src="imgs/p3_1.png"/></div>
                  <div class="pic-box p3_2 z-index30"><img src="imgs/p3_2.png"/></div>
                  <div class="pic-box p3_3 z-index30"><img src="imgs/p3_3.png"/></div>
                  <div id="loading" class="loading">
                      <div class="loadbox">
                          <div class="loadlogo"></div>
                          <div class="loadbg"></div>
                      </div>
                  </div>
              </div>

        <!--上传结果 修改-->
          <div class="result-box" id="resultbox" style="display: none;">
                 <div class="full-pos bg4 z-index31"></div>
                 <div class="pic-box p4_1 z-index31"><img src="imgs/p4_1.png"/></div>
                 <div class="pic-box p4_2 z-index31"><img src="imgs/p4_2.png"/></div>
                 <div class="result-cn pos-a z-index32">

                     <div class="character">
                         <div class="pic-box renwu-t"><img src="imgs/renwu/huangbo-t.png" class="renwu-t" id="imgLoverTitle" /></div>
                         <div class="pic-box renwu"><img src="imgs/renwu/huangbo.png" id="imgLover" /></div>
                         <div class="myself"><img src="imgs/me.png" class="" id="imgSelf"/></div>
                     </div>

                     <div class="index">
                     <div class="index-cn animated fadeIn">
                         <p class="p1" id="pBeautyMark">养颜指数<span class="xin1"></span><span class="xin1"></span><span class="xin1"></span><span class="xin2"></span><span class="xin3"></span></p>
                         <p class="p1" id="pMatchMark">般配指数<span class="xin1"></span><span class="xin1"></span><span class="xin1"></span><span class="xin1"></span><span class="xin3"></span></p>
                     </div>
                         <a href="javascript:void(0);" class="butbg share-but pos-a" id="share_but">立即叫好友来围观</a>
                         <p class="p2" id="pMarry">待你腰缠万贯，再娶我可好</p>
                         <a href="javascript:void(0);" class="link1" id="btnGoToWealth">点击这里，让梦想照进现实</a>
                         <p class="ico-jt"><img src="imgs/ico1.png"/></p>
                     </div>
                 </div>
             </div>

        <!--秘籍-->
        <div class="cheats-box" style="display: none;">
                <div class="full-pos bg5 z-index33"></div>
                <div class="pic-box p5_1 z-index33"><img src="imgs/p5_1.png?v=20150825"/></div>
                <div class="pic-box p5_2 z-index33"><img src="imgs/p5_2.png?v=20150825"/></div>
                <div class="pic-box p5_3 z-index33"><img src="imgs/p5_3.png?v=20150825"/></div>
                <div class="pic-box p5_4 z-index33"><img src="imgs/p5_4.png?v=20150825"/></div>
                <div class="pic-box p5_5 z-index33"><img src="imgs/p5_5.png?v=20150825"/></div>
                <div class="pic-box p5_6 z-index33"><img src="imgs/p5_6.png?v=20150825"/></div>
                <div class="pic-box p5_7 z-index33"><img src="imgs/p5_7.png?v=20150825"/></div>
                <a href="http://hd.tuandai.com/web/20150728/index.aspx?from=banner" class="but-bj link2 pos-a z-index34">立即点击让梦想照进现实</a>
            </div>
    </section>
</section>
  
<script type="text/javascript" src="js/seeklover.js?v=2015081901"></script>
<script type="text/javascript">
    window.ontouchmove=function(e){
        e.preventDefault && e.preventDefault();
        e.returnValue=false;
        e.stopPropagation && e.stopPropagation();
        return false;
    };

      var browser = {
            versions: function () {
                var u = navigator.userAgent, app = navigator.appVersion;
                return {
                    ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),
                    android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1,
                    iPhone: u.indexOf('iPhone') > -1,
                    iPad: u.indexOf('iPad') > -1
                };
            }()
        };

        if (browser.versions.android) {
            $('.upload-bg').addClass('upload-bg1');
            $('.circle').addClass('circle1');
        }


        //分享
            var bd = document.getElementById("resultbox");
            var shareBut = document.getElementById("share_but");

            var sharePopup = function(e) {
                if (!document.getElementById("shareTip")) {
                    window.scrollTo(0, 0);
                    var dom = document.createElement("div");
                    dom.className = "modal-backdrop";
                    dom.id = "shareTip";
                    dom.innerHTML = '<div class="shareTip-box"><div class="shareTip"></div></div>';
                    bd.appendChild(dom);
                    dom.addEventListener("touchstart", clearShareTip, false);
                }
                return false;
            };

            function clearShareTip() {
                var hintTip = document.getElementById("shareTip");
                hintTip.removeEventListener("touchstart", clearShareTip, false);
                bd.removeChild(hintTip);
            }
            shareBut.onclick = sharePopup;


    var eidtor;
    $(function () {

       // 页面滑动
//       $("#seek-but").tap(function () {
//            $('.page2').addClass('moveToTop');
//            $('.page1').addClass('moveFromBottom');
//        }); 

        //点击上传图片
        $("#upload_but").tap(function () {
            $(this).fadeOut(1500);
            $('.circle').fadeOut(1500);
        });

        eidtor = new mo.ImageEditor({
            trigger: $('.cropit-image-input'),
            container: $('.cropit-image-preview'),
            width: 150,
            height: 150,
            stageX: $('.cropit-image-preview')[0].offsetLeft,
            event: {
                change: function () {
                    curScale = 1;
                }
            }
        }); 
    });
</script>
</body>
</html>
