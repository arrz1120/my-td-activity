<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="knowus.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.aboutus.knowus" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>了解团贷</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/aboutus.css" />
    <!--关于我们-->
    <script src="/scripts/youku.jsapi.js" type="text/javascript"></script>
    <style type="text/css">
        .video-box
        {
            height: 220px;
            padding: 3px 0;
            background: #FFFFFF;
            top: 75px;
        }
        #v2
        {
            display: none;
        }
        .video_img img
        {
            cursor: pointer;
        }
        .video-box #video
        {
            z-index: 100;
            height: 220px;
            width: 100%;
            float: left;
            position: relative;
        }
    </style>
</head>
<body>
    <header class="headerMain">
	    <div class="header">
	    <div class="back" onclick="javascript:history.go(-1);">返回</div>
	    <h1 class="title">了解团贷</h1>
	    </div>
	    <div class="none"></div>
	</header>
    <section class="knowtitle mt30 knowtitle01"><span class="text-center c-161312 f15px">3分钟了解团贷网</span></section>
    <section class="pd13 clearfix">
        <div class="imgBox" id="v1"><img src="/imgs/images/knowtd_01.jpg"></div>
        <div class="video-box" id="v2" style="width: 305px;">
            <div id="video">
                <script type="text/javascript">
                    player = new YKU.Player('video', {
                        styleid: '0',
                        client_id: '52b3fa57e9fe17cf',
                        vid: 'XMTI2MDEwOTg2MA==',
                        autoplay: false,
                        show_related: false
                    });
                </script>
            </div>
         </div>
    </section>

    <section class="knowtitle mt10">
		<span class="text-center c-161312 f15px">关于我们</span>
	</section>
	<section class="pd13 clearfix">
		<div class="imgBox"><a href="/pages/aboutus/introduce.aspx"><img src="/imgs/images/knowtd_02_1.jpg"></a></div>
	</section>
	<section class="knowtitle mt10">
		<span class="text-center c-161312 f15px">安全保障</span>
	</section>
	<section class="pd13 clearfix">
		<div class="imgBox"><a  href="/pages/aboutus/insurance.aspx"><img src="/imgs/images/knowtd_03.jpg"></a></div>
	</section>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            $('#v1').click(function () {
                $("#v1").hide();
                $('#v2').fadeIn(1000);
                $(".video-box").width($(document.body).width() - 20);
            });
        });
    </script>
</body>
</html>
