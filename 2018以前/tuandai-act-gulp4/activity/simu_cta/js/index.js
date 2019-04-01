(function() {
//	alert($(window).width());
	FastClick.attach(document.body);
	//do your thing.
	var pageSwiper = new Swiper('#pageSwiper', {
		initialSlide: 0,
		direction : 'vertical',
		lazyLoading : true,
		lazyLoadingInPrevNextAmount : 2,
		resistanceRatio: 0
	}) 
	var txtSwiper = new Swiper('#txtSwiper', {
		onSlideChangeStart:function(swiper){
			var index = swiper.activeIndex;
			$(".tab-item-cur").removeClass('tab-item-cur');
			$(".tab-item").eq(index).addClass('tab-item-cur');
		}
	})  
	
	
	$(".tab-item").each(function(i,item){
		$(item).click(function(){
			txtSwiper.slideTo(i,300,true);
		})
	})
	
	
	var roundSwiper = new Swiper("#roundSwiper",{
		effect: 'coverflow',
		centeredSlides: true,
		slidesPerView: 'auto',
//		autoplay: 2000,
		loop: true,
		speed: 300,
		coverflow: {
			rotate: 0,
			// //每个item间隔
			// //非active item 缩放比例
			stretch: 25,
			depth: 200,
			modifier: 1,
			slideShadows: false
		},
		onTransitionEnd:function(swiper){
			var index = swiper.realIndex;
			$(".txtFrame").hide();
			$(".txtFrame").eq(index).show();
		}
	})
	
	function vsTab(parent){
		$(parent).find(".vs-tit").each(function(i,item){
			$(item).click(function(){
				var con = $(item).next();
				if(con.css('display') == 'none'){
					$(parent).find('.vs-con').slideUp();
					$(parent).find('i').removeClass('rotateZ90');
					$(item).next().slideDown();
					$(item).find('i').addClass('rotateZ90');
				}
			})
		})
	}
	
	vsTab(".fengxian");
	vsTab(".fengkong");
	
	$(".text-bot").click(function(){
		if($(this).hasClass('text-hide')){
			$(this).removeClass('text-hide');
			$(this).find('i').css('-webkit-transform','rotateZ(180deg)');
		}else{
			$(this).addClass('text-hide');
			$(this).find('i').css('-webkit-transform','rotateZ(0)');
		}
	})
	
})();