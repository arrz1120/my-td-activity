<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="xmb_progress.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.xmb_progress" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>项目宝项目进展</title>
	<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
	<link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/progress.css?v=20151221001" /><!--借款--> 
	</head>
	<body> 
   <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:window.location.href='/pages/invest/xmb_detail.aspx?projectid=<%=projectId %>';">返回</div>
            <h1 class="title">项目进展</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>

		<div class="progress">
            <% if(xmbProgress!=null && xmbProgress.Any()){
                   var pIndex = 0;
                   foreach (TuanDai.PortalSystem.Model.ProjectProgress_Info item in xmbProgress) {
                       pIndex++; 
                   %>
			<section>
				<div class="date-wp <%=pIndex==1?"date-active":"" %>">
					<div class="date">
						<%=item.Desc %>
					</div>
				</div>
				<div class="con <%=pIndex!=xmbProgress.Count?"bl-ababab":"" %> <%= xmbProgressImg.Any(p=>p.ProgressId==item.Id)?"":"pb50"%>">
                    <% if(xmbProgressImg.Any(p=>p.ProgressId==item.Id)){ %>
					<div class="swiper-container1 mt10" id="swiper<%=pIndex%>">
						<div class="swiper-wrapper">
                            <% foreach(TuanDai.PortalSystem.Model.ProjectProgressImage_Info imgInfo in xmbProgressImg.Where(p=>p.ProgressId==item.Id)){ %>
							<div class="swiper-slide">
								<div class="pics">
									<img src="<%=imgInfo.MinImageUrl %>"  alt="" class="img tc"/>
								</div>
							</div> 
                            <%} %>
						</div>
					</div>
                    <%} %>
                    <div class="c-ababab pt10 pb20 bb-e6e6e6 f12px">
						<%=item.ProgressDate.ToString("yyyy-MM-dd") %>
					</div>
				</div>
			</section> 
            <% } 
              } %>
		</div>

		<div class="slide2 hide">
			<div class="slide-close" style="top:5px!important;">				
			</div>
			<div class="slide-big">
				<div class="swiper-container2" id="swiperPreview">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<div class="pics">
								<img src="/imgs/images/img1.png"  alt="" class="img tc"/>
							</div>
						</div> 
					</div>
				</div>
			</div>
			<div class="mark"></div>
		</div>

	</body>
	<script type="text/javascript" src="/scripts/jquery.min.js?v=20151120"></script>
    <script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js?v=20151120"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20151116001"></script>
    <script type="text/javascript">
        var pIndex = 0;
        $(function () {
            var swiperPreview = {};
            $('.slide-close').click(function() {
                $('.slide2').addClass('hide');
            });

            <% var jIndex=0;
            foreach (TuanDai.PortalSystem.Model.ProjectProgress_Info item in xmbProgress){
                if (!xmbProgressImg.Any(p => p.ProgressId == item.Id)) continue;
                jIndex++; %>
            var swiper<%=jIndex%> = new Swiper('#swiper<%=jIndex%>', {
                direction: 'horizontal',
                slidesPerView: 'auto',
                spaceBetween: 5,
                preventLinksPropagation: false
            });
            swiper<%=jIndex%>.on('tap', function () {
                $("#swiperPreview").find(".swiper-slide").remove();
                var sHtml = $("#swiper<%=jIndex%>").find(".swiper-wrapper").html();
                //转化成大图
                sHtml = sHtml.replace(new RegExp("_S.", 'g'), ".");
                $("#swiperPreview").find(".swiper-wrapper").append(sHtml);
                var len = $("#swiperPreview").find('.swiper-slide').length;
                $(".slide2").removeClass('hide');
                pIndex = swiper<%=jIndex%>.clickedIndex;
                $("#nowMark").html((pIndex + 1) + "/" + len);

                swiperPreview = new Swiper('#swiperPreview', {
                    initialSlide: pIndex,
                    direction: 'horizontal',
                    slidesPerView: '1',
                    spaceBetween: 1,
                    onSlideChangeStart: function (swiperPreview) {
                        var len = $("#swiperPreview").find('.swiper-slide').length;
                        var curPos=swiperPreview.activeIndex + 1;
                        if(curPos>len)
                            curPos=len;
                        $("#nowMark").html(curPos + '/' + len);
                    }
                });
            });
            <%} %>
            $(".mark").html("<p><span id='nowMark'>1/1</span></p>");  
          
        });
    </script>
</html>