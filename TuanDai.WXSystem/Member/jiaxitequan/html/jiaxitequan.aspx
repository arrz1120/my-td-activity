﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jiaxitequan.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.jiaxitequan.html.jiaxitequan" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="initial-scale=1, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no" />
		<meta name="format-detection" content="telephone=no">
		<title>个人专属特权</title>
		<link rel="stylesheet" type="text/css" href="/Member/jiaxitequan/css/swiper-3.4.2.min.css"/>
		<link rel="stylesheet" type="text/css" href="/Member/jiaxitequan/css/jiaxitequan.css"/>
		<script>
		    //动态算rem
		    (function (doc, win) {
		        var docEl = doc.documentElement,
					resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
					recalc = function () {
					    // if (docEl.style.fontSize) return;
					    clientWidth = docEl.clientWidth;
					    if (!clientWidth) return;
					    docEl.style.fontSize = 20 * (clientWidth / 320) + "px";
					    if (document.body) {
					        document.body.style.fontSize = docEl.style.fontSize;
					    }
					};
		        recalc();
		        if (!doc.addEventListener) return;
		        win.addEventListener(resizeEvt, recalc, false);
		        doc.addEventListener("DOMContentLoaded", recalc, false);
		    })(document, window);
		</script>

	</head>

	<body>
		<div class="bg">
			<div class="jiaxi-con" <%=List!=null && List.Count >0?"":"style='display:none;'" %> >
				<div class="total">
					<p class="t-p1">已累计获得加息特权</p>
					<p class="t-p2"><%=totalRate %><span>%</span></p>
				</div>
				<div class="swiper-container" id="swiper">
					<div class="swiper-wrapper">
						<%--<div class="swiper-slide slide-1">
							<div class="lable">瓜分红包<i></i>11-12</div>
							<div class="icon-box">
								<div class="s-icon"></div>
							</div>
							<div class="txt-box">
								<p class="txt-p1">加息1.0%</p>
								<p class="txt-p2">有效期限: <br />2017-11-25 至 2017-01-02</p>
								<div class="txt-p3">
									<p>1、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>2、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>3、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>4、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>5、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
								</div>
								<div class="cover"></div>
							</div>
						</div>
						<div class="swiper-slide slide-2">
							<div class="lable">签到奖励<i></i>11-12</div>
							<div class="icon-box">
								<div class="s-icon"></div>
							</div>
							<div class="txt-box">
								<p class="txt-p1">加息1.0%</p>
								<p class="txt-p2">有效期限: <br />2017-11-25 至 2017-01-02</p>
								<div class="txt-p3">
									<p>1、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>2、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>3、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>4、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>5、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
								</div>
								<div class="cover"></div>
							</div>
						</div>
						<div class="swiper-slide slide-3">
							<div class="lable">团币兑换<i></i>11-12</div>
							<div class="icon-box">
								<div class="s-icon"></div>
							</div>
							<div class="txt-box">
								<p class="txt-p1">加息1.0%</p>
								<p class="txt-p2">有效期限: <br />2017-11-25 至 2017-01-02</p>
								<div class="txt-p3">
									<p>1、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>2、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>3、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>4、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>5、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
								</div>
								<div class="cover"></div>
							</div>
						</div>
						<div class="swiper-slide slide-4">
							<div class="lable">全场加息<i></i>11-12</div>
							<div class="icon-box">
								<div class="s-icon"></div>
							</div>
							<div class="txt-box">
								<p class="txt-p1">加息1.0%</p>
								<p class="txt-p2">有效期限: <br />2017-11-25 至 2017-01-02</p>
								<div class="txt-p3">
									<p>1、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>2、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>3、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>4、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>5、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
								</div>
								<div class="cover"></div>
							</div>
						</div>
						<div class="swiper-slide slide-5">
							<div class="lable">私募xxxx<i></i>11-12</div>
							<div class="icon-box">
								<div class="s-icon"></div>
							</div>
							<div class="txt-box">
								<p class="txt-p1">加息1.0%</p>
								<p class="txt-p2">有效期限: <br />2017-11-25 至 2017-01-02</p>
								<div class="txt-p3">
									<p>1、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>2、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>3、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>4、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>5、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
								</div>
								<div class="cover"></div>
							</div>
						</div>--%>
                        <% if (List != null && List.Count > 0)
                           {
                               foreach (var item in List)
                               {
                                   %>
                        <div class="swiper-slide <%=item.SubTypeId==1?"slide-2":item.SubTypeId==2?"slide-1":"slide-3" %>">
							<div class="lable"><%=item.TypeDesc %><i></i><%=DateTime.Parse(item.AddDate).ToString("MM-dd") %></div>
							<div class="icon-box">
								<div class="s-icon"></div>
							</div>
							<div class="txt-box">
								<p class="txt-p1">加息<%=item.RedRate %>%</p>
								<p class="txt-p2"><%=item.ExpirationDateDesc.Replace(":",":<br />").Replace("：","：<br />") %></p>
								<div class="txt-p3">
									<%--<p>1、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>2、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>3、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>4、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>
									<p>5、说明性文案，有很多很多很多很多字有很多很多很多很多字 </p>--%>
                                    <%="<p>"+item.Desc.Replace("\r\n","</p><p>")+"</p>" %>
								</div>
								<div class="cover"></div>
							</div>
						</div>
                        <%
                               }
                           } %>
					</div>
				</div>
			</div>
			<div class="jiaxi-none" <%=List!=null && List.Count >0?"style='display:none;'":"" %>>
				<div class="pic-none"></div>
				<p class="p-none">加息特权已过期...</p>
			</div>
		</div>
	</body>
	<script src="../js/lib/fastclick-jquery.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/lib/swiper-3.4.2.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
	    var mySwiper = new Swiper('#swiper', {
	        effect: 'coverflow',
	        centeredSlides: true,
	        slidesPerView: 'auto',
	        coverflow: {
	            rotate: 0,
	            // //每个item间隔
	            // //非active item 缩放比例
	            stretch: -10,
	            depth: 110,
	            modifier: 1,
	            slideShadows: false
	        },
	        pagination: '#cp-page',
	        onTransitionEnd: function (swiper) {

	        }
	    })
	</script>

</html>