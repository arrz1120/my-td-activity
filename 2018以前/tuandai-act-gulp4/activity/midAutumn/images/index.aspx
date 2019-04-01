<%@ Page Title="加班的荣耀" Language="C#" MasterPageFile="~/Site.Mobile.Master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="TuanDai.ActivityHD.Web._201709.OverTimeDog.weixin.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no" />
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="css/main.css?v=201709260002">
    <script src="js/lib/adapt.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div id="container" class="bg1">
        <div class="logo"></div>
        <a class="musicBtn"></a>
        <a class="shareBtn"></a>
        <div class="word word1">
            <img src="images/word1.png">
        </div>
        <div class="animaWrap">
            <div class="loop">
                <img src="images/animat.png">
            </div>
        </div>
        <!-- 两个按钮状态-> btn1:告诉我,你的加班时间; btn2:查看加班排行榜; -->
        <% if (IsPartake)
           { %>
        <a class="ftBtn btn1"></a>
        <%}
           else
           { %>
        <a class="ftBtn btn2"></a>
        <%} %>
    </div>
    
    <!-- 音乐播放 -->
    <audio id="media" loop="loop" src="<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl%>/201709/OverTimeDog/weixin/music/music.mp3"></audio>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <!-- 埋点js -->
    <!-- <script type="text/javascript" src="http://pingjs.qq.com/h5/stats.js" name="MTAH5" sid="500506576" cid="500522642"></script> --> 
    <script src="js/lib/fastclick-jquery.js"></script>
    <script src="js/jsbridge-3.1.4.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/appShare.bundle.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" charset="utf-8">
        // 统计代码
        var _mtac = {};
        (function () {
            var mta = document.createElement("script");
            mta.src =((("https:") == document.location.protocol) ? "https://" : "http://") +"pingjs.qq.com/h5/stats.js?v2.0.4";
            mta.setAttribute("name", "MTAH5");
            mta.setAttribute("sid", "500506576");
            mta.setAttribute("cid", "500522642");
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(mta, s);
        })();
        var isLogin = <%=IsLogin.ToString().ToLower()%>;   //是否登录
        var IsTDAccount = <%=IsTDAccount.ToString().ToLower()%>;   //是否团贷账号或微信IP关联团贷账号
        var IsPartake = <%=IsPartake.ToString().ToLower() %>;   //是否参与
        var OpenId = '<%=openId%>';
        var NickName = '<%=WXNickName%>';
        var HeadImg = '<%=WXHeadImage%>';
        var TakeCount = parseInt(<%=TakeCount%>);
        //app需要放音乐的绝对路径
        var vHdUrl = "<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl%>";
        
        if(""==OpenId&&!isLogin){
            if (Jsbridge.isApp()) {
                alert(3242);
                Jsbridge.toAppLogin();
            }
            else {
                location.href = '<%=TuanDai.ActivityHD.Common.Globals.MobileWebsiteUrl%>' + '/user/login.aspx?ReturnUrl=' + '<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl%>' + "/201709/OverTimeDog/weixin/index.aspx" + location.search;
            }
        }

        // 工作动态图
        (function(){
            var oLoop = document.querySelector(".loop"),
                i = 0;
            var timer = setInterval(function () {
                oLoop.style.left = -(i * 100) + "%";
                i++;
                if (i == 5) {
                    i = 0;
                };
            }, 250);            
        }());

        // 按钮跳转
        if(!!document.querySelector('.btn1')){
            $(".btn1").click(function(){
                window.location = "page2.aspx"+location.search;
            });            
        };      
        if(!!document.querySelector('.btn2')){
            $(".btn2").click(function(){
                if(IsTDAccount&&TakeCount==1){
                    window.location = "page5.aspx" + location.search;
                }else{
                    window.location = "page4.aspx" + location.search;
                }
            });            
        };

        var ShareUrl ='<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl%>/201709/OverTimeDog/weixin/index.aspx?ExtenderKey=<%=ExtenderKey%>&PreExtenderKey=<%=PreExtenderKey%>';
        var ShareImgUrl ="<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl %>/201709/OverTimeDog/weixin/images/Share100.jpg";
        var ShareTitle = "你的好友在加班，并向你抛了个问题。";
        var ShareDesc="你有计算过自己每周加班的时间吗？如果加班分段位的话，上王者会不会容易些？";
        //微信分享
        wxData.isWxJsSDK = true;
        wxData.debug = false;
        wxData.url = ShareUrl;
        wxData.title = ShareTitle;
        wxData.desc = ShareDesc;
        wxData.img_url = ShareImgUrl;
        wxData.ShareCallBack = function (ex) {
            if (ex == 'success') {
                //shareAjax();
            }
        };
        // 分享按钮弹窗
        $(".shareBtn").click(function(){
            // MtaH5.clickStat("jiaban1a02");
            window.appShare.set({
                iconUrl:'<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl%>/201709/OverTimeDog/weixin/images/Share100.jpg',
                title:'你的好友在加班，并向你抛了个问题。',
                content:'你有计算过自己每周加班的时间吗？如果加班分段位的话，上王者会不会容易些？',
                wxShareImg:{
                    url:'images/shareBg.png',
                    style:{
                        width:'12rem',
                    }
                },
                custom:[
                {key:1,val:'微信',shareUrl:'<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl%>/201709/OverTimeDog/weixin/index.aspx?ExtenderKey=<%=ExtenderKey%>&PreExtenderKey=<%=PreExtenderKey%>&ShareToolType=1'},
                {key:5,val:'朋友圈',shareUrl:'<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl%>/201709/OverTimeDog/weixin/index.aspx?ExtenderKey=<%=ExtenderKey%>&PreExtenderKey=<%=PreExtenderKey%>&ShareToolType=5'},
                {key:4,val:'QQ',shareUrl:'<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl%>/201709/OverTimeDog/weixin/index.aspx?ExtenderKey=<%=ExtenderKey%>&PreExtenderKey=<%=PreExtenderKey%>&ShareToolType=4'},
                {key:6,val:'QQ空间',shareUrl:'<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl%>/201709/OverTimeDog/weixin/index.aspx?ExtenderKey=<%=ExtenderKey%>&PreExtenderKey=<%=PreExtenderKey%>&ShareToolType=6'},
                {key:3,val:'微博',shareUrl:'<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl%>/201709/OverTimeDog/weixin/index.aspx?ExtenderKey=<%=ExtenderKey%>&PreExtenderKey=<%=PreExtenderKey%>&ShareToolType=3'},
                {key:8,val:'复制链接',shareUrl:'<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl%>/201709/OverTimeDog/weixin/index.aspx?ExtenderKey=<%=ExtenderKey%>&PreExtenderKey=<%=PreExtenderKey%>&ShareToolType=8'}
                ]
            });
        });
    </script>
    <script src="js/index.js?v=201709260010" type="text/javascript" charset="utf-8"></script>
</asp:Content>




