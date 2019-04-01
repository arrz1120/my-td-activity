<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MinionsPage.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.Minions.MinionsPage" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,target-densitydpi=device-dpi,user-scalable=no">
    <link rel="stylesheet" type="text/css" href="css/style.css?v=20150915001">
    <link rel="stylesheet" type="text/css" href="css/animate.css">
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/hammer.min.js"></script>
    <script src="js/plugin.js"></script>
    <script src="js/main.js?v20150914"></script>
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>     
    <script type="text/javascript" src="/scripts/weixinapi.js?v=3.4"></script>  
    <title>我的朋友圈里有个小黄人</title>
    <script type="text/javascript">
        var HeadImg = "<%=HeadImg %>";
        var NickName = "<%=NickName %>"; 
        wxData.isWxJsSDK = true;
        //wxData.debug = true;
        wxData.url = "http://m.tuandai.com/Activity/Minions/Index.aspx";
        wxData.title = "呦！我的朋友圈里有个小黄人？！";
        wxData.desc = "TA竟然干出这种事了！";
        wxData.img_url = "http://m.tuandai.com/Activity/Minions/images/share.jpg";
        wxData.ShareCallBack = function (ex) {
             
        }
    </script> 
</head>
<body>
<div class="ab body">
    <div class="loading ab">
    </div>
    <div class="ab box">
        <div id="p1" class="ab full00 p1"><div class="ab btn_wx dd_act"></div></div>
        <div id="p2" class="ab full00 p2 no"></div>
        <div id="p3" class="ab full00 p3 no">
            <div class="ab btn_recive dd_act3"></div>
            <div class="ab p3_quan"></div>
        </div>
        <div id="p4" class="ab full00 p4 no">
            <div class="shaxiao ab no"></div>
            <div class="ab footer"></div>
        </div>
        <div id="p5" class="ab full00 p5 no">
            <div class="ab load"></div>
            <div class="ab btn_answer no"></div>
            <div class="ab ani_dot">...</div>
        </div>
        <div id="p6" class="ab full00 p6 no">
            <img src="images/video.gif" />
        </div>
        <div id="p7" class="ab full00 p7 no">
            <div class="ab p7_tonghua"></div>
            <div class="ab p7_bottom"></div>
            <div class="ab p7_quan"></div>
        </div>

        <div id="p9" class="ab full00 p9 no">
            <div class="p9_anwse ab">
                <div class="head ab"><img src="<%=HeadImg %>"></div>
            </div>
            <div class="p9_huida1 ab no">
            </div>
        </div>
    </div>
</div>
<audio id="SendMessage" class="no" src="music/SendMessage.mp3" preload="true"></audio>
<audio id="VideoChat" class="no" src="music/VideoChat.mp3" preload="true" loop=""></audio>
<audio id="paopao" class="no" src="music/paopao.mp3" preload="true"></audio>
<audio id="talk" class="no" src="music/talk.mp3" preload="true"></audio>
<audio id="info" class="no" src="music/info.mp3" preload="true"></audio>
<script type="text/javascript" src="/scripts/base.js?v=20150915"></script>  
</body>
</html>