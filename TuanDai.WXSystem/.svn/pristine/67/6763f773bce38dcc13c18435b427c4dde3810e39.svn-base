<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.XinXingFansMeetAndGreet.Index" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>粉丝见面会</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=2015110701" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
<link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css" />
<link rel="stylesheet" type="text/css" href="css/activity.css?v=2015110701" /><!--会员活动-->

</head>
<body>
   <%= this.GetNavStr()%>
	<header class="headerMain">
		<div class="header">
			<div class="back" onclick="javascript:window.location.href='/Member/MemberCenter/memberCenter.aspx'">返回</div>
			<h1 class="title">粉丝见面会</h1>
		</div>
		<%= this.GetNavIcon()%>
		<div class="none"></div>
	</header>

    <div class="activity">
    	<div class="bg-box"><img src="/imgs/member/banner.png"/></div>
    	<div class="bg-box">
    		<img src="/imgs/member/con02.png"/>
    		<a class="act_btn" href="yuyue_address.aspx">
    			一分钟填写预约信息
    		</a>
    	</div>
    	<div class="bg-box">
    		<img src="/imgs/member/con03.png"/>
    		<div class="con03">
    			<p>别样江南，秋日胜春朝</p>
    			<p>沉吟巷陌，马蹄达达，千里共团贷</p>
    			<p>一手风控，玩赚社交金融圈</p>
    			<p>三两分享，畅叙互联网金融</p>
    			<p>品苏式闲情，纵观团贷新发展</p>
    			<p>趁金色驰聘，挥霍一场十月天光</p>
    		</div>
    		<a class="act_btn" href="http://hd.tuandai.com/web/20150705XinXingFansMeetAndGreet/Station.aspx">
    			马上报名
    		</a>
    	</div>
    	<div class="bg-box">
    		<img src="/imgs/member/con03_bottom.png"/>
    		<a class="yuyue" href="yuyue_address.aspx">
    			预约
    		</a>
    	</div>
    	<div class="bg-box bg-box04">
    		<img src="/imgs/member/con04_top.png"/>
    		<div class="con04Wrap">
    			<div class="con04">
					<div class="notice">
						<div class="userN">
							用户名：<span><%= (NickName == string.Empty ? "游客" : NickName) %></span>
						</div>
						<div class="lessChance">
							<span class="chance"><%=count %></span>次机会
						</div>
					</div>
                    <div class="choujiang" id="lottery">
                         <table border="0" cellpadding="3" cellspacing="5">
                            <tr>
                                <td class="lottery-unit lottery-unit-0">
                                    <img src="/imgs/member/cj01.png"></td>
                                <td class="lottery-unit lottery-unit-1">
                                    <img src="/imgs/member/cj02.png"></td>
                                <td class="lottery-unit lottery-unit-2">
                                    <img src="/imgs/member/cj03.png"></td>
                            </tr>
                            <tr>
                                <td class="lottery-unit lottery-unit-7">
                                    <img src="/imgs/member/cj04.png"></td>
                                <td class="lottery-unit Lucky_draw"><a href="javascript:void(0);"><img src="/imgs/member/cj_btn.png"/></a></td>
                                <td class="lottery-unit lottery-unit-3">
                                    <img src="/imgs/member/cj05.png"></td>
                            </tr>
                            <tr>
                                <td class="lottery-unit lottery-unit-6">
                                    <img src="/imgs/member/cj06.png"></td>
                                <td class="lottery-unit lottery-unit-5">
                                    <img src="/imgs/member/cj07.png"></td>
                                <td class="lottery-unit lottery-unit-4">
                                    <img src="/imgs/member/cj08.png"></td>
                            </tr>
                        </table>
                    </div> 
		    		<div class="activity_rule">
		    			<p>登录并完成问卷调查，您将获得一次幸运抽奖机会（同一个ID用户，仅限参与一次）</p>
		    			<p>中奖礼品请前往团贷网-个人中心-团宝箱领取；</p>
		    			<p>红包使用说明：</p>
		    			<p>5元-需单笔投资满50元及以上使用；10元-需单笔投资满100及以上使用；50元-需单笔投资满500元及以上使用；100元-需单笔投资满1000元及以上使用。</p>
		    			<p>红包使用期限为一个月</p>
		    			<p>本次活动最终解释权归团贷网所有。</p> 
		    		</div>
		    		<a class="con04_btn" href="javascript:void(0);" id="btnAnswer">
		    			答题获抽奖机会
		    		</a>
		    	</div>
	    	</div>
		</div>
    	<div class="bg-box">
    		<img src="/imgs/member/con05.png"/>
    	</div>
    	<div class="slide">
			<div class="swiper-container">
			    <div class="swiper-wrapper">
                    <div class="swiper-slide">
			         <a href="#" target="_blank">
                        <img src="http://hd.tuandai.com/web/20150705XinXingFansMeetAndGreet/images/tmjmimg11.jpg?v=20151028001" /></a>
			        </div>
                    <div class="swiper-slide">
			        	<a href="http://bbs.tuandai.com/forum.php?mod=viewthread&tid=5634&extra=page%3D1&page=1" target="_blank">
                           <img src="http://hd.tuandai.com/web/20150705XinXingFansMeetAndGreet/images/tmjmimg10.jpg?v=20150914001" /></a>
			        </div>
                    <div class="swiper-slide">
			        	 <a href="http://bbs.tuandai.com/thread-5834-1-1.html" target="_blank">
                           <img src="http://hd.tuandai.com/web/20150705XinXingFansMeetAndGreet/images/tmjmimg09.jpg?v=20150902001" /></a>
			        </div>
                    <div class="swiper-slide">
			        	 <a href="http://bbs.tuandai.com/forum.php?mod=viewthread&tid=5634&extra=page%3D1&page=1" target="_blank">
                           <img src="http://hd.tuandai.com/web/20150705XinXingFansMeetAndGreet/images/tmjmimg08.jpg?v=20150828001" /></a>
			        </div>
                    <div class="swiper-slide">
			        	 <a href="http://bbs.tuandai.com/forum.php?mod=viewthread&tid=5360&extra=page%3D1&page=1" target="_blank">
                                        <img src="http://hd.tuandai.com/web/20150705XinXingFansMeetAndGreet/images/tmjmimg07.jpg?v=20150828001" /></a>
			        </div>  
			       <%--  
			        <div class="swiper-slide">
			        	<img src="/imgs/member/slide01.png"/>
			        	<div class="slideTxt">
			        		团粉见面会·深圳站3
			        	</div>
			        </div>--%>
			    </div>
			</div>
			<div class="mark clearfix"></div>
			<div class="con04_btn" style="margin-top: 0; cursor:pointer;" onclick="window.location.href='http://bbs.tuandai.com/forum.php?mod=forumdisplay&fid=46'">
				 查看更多活动
			</div>
		</div>
	</div> 
      
    <!--start-->
    <section  id="xiaochuangZhong" class="popup-wrap" style="display: none;">
        <div class="popup-box pb15">
            <span style="display:block;float:right;margin-right:5px;font-size:25px;color:#ccc;">×</span>
            <div class="popup-content clearfix text-center mt15">
                <p class="c-212121 f15px">谢谢参与！</p>
            </div>
            <div class="control-but pb15"> 
                <a href="javascript:;" class="f14px check"  id="btnchakanzhong" style="margin-left:50px; margin-right:50px;">确定</a>
            </div>
        </div>
        <div class="mask"></div>
    </section>
    <!--end-->


	<script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>  
    <script type="text/javascript" src="/scripts/base.js?v=2015110701"></script>
    <script type="text/javascript" src="js/millions.js?v=2015110701"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var mySwiper = new Swiper('.swiper-container', {
                direction: 'horizontal',
                height: 150,//你的slide高度
                loop: true,
                // 如果需要分页器
                pagination: '.mark',
            });
            $("#btnAnswer").click(function () {
                if (!base_isCookieLogin()) {
                    alert("您还未登录不能答题！");
                    window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href;
                    return;
                } else {
                    window.location.href = "survey.aspx";
                }
            });

            $(".popup-box span").click(function() {
                $("#xiaochuangZhong").hide();
            });
        })
    </script>
</body>
</html>
