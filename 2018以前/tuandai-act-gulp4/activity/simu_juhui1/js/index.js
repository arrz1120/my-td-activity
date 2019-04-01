(function() {
    FastClick.attach(document.body);
//  alert('宽度:'+ $(window).width() +','+'高度：'+$(window).height());
    
	var u = navigator.userAgent;
	if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {
		//安卓手机
    	$(".mask-div").find('input').on('focus',function(){
    		$(".mask-div .pop-container").css({
    			'top':'10px',
    			'-webkit-transform':'translate(-50%,0)'
    		});
    	})
	}
	
	//toast调用示例: toast('手机号码不能为空！');
    function toast(msg, duration) {
        duration = duration || 1500;
        var _toast = $("<div/>").addClass('toast').html(msg);
        $('body').append(_toast);
        setTimeout(function() {
            _toast.remove();
        }, duration);
    }
	    
	var pageSwiper = new Swiper("#pageSwiper",{
		initialSlide : 0,
		direction : 'vertical',
		lazyLoading : true
	})
	
	var cpText = [
		'违约时发布违约公告<br />向法院申请查封资产、足额抵押物拍卖 ',
		'足额车辆资产进行抵押反担保<br />第三方担保公司担保 ',
		'投资标的为车抵贷优质债权资产',
		'专业基金经理、团队管理经验丰富，<br />投资有道'
	]
	    
	var cpSwiper = new Swiper("#cpSwiper",{
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
			stretch: $(window).width()*163/750,
			depth:190,
			modifier: 1,
			slideShadows: false
		},
		pagination : '#cp-page',
		onTransitionEnd:function(swiper){
			var ind = swiper.realIndex;
			$(".cp-text").html(cpText[ind]);
		}
	})
	
	var arrTemp = [1,2,3,4,5];
	var imgArr = [];
	    
	var roundSwiper = new Swiper("#roundSwiper",{
		loop:true,
		onTransitionEnd:function(swiper){
			var ind = swiper.realIndex + 1;
			resetImg(ind);
			showText(ind);
		},
		pagination : '#info-page'
	})
	
	$(".round-small").each(function(i,item){
		$(item).click(function(){
			roundSwiper.slideTo($(item).attr('index'),500,true);
		})
	})
	
	function resetImg(index){
		imgArr = arrTemp.join('').replace(index,'').split('');
		$(".round-small").each(function(i,item){
			$(item).fadeOut(100,function(){
				$(item).attr('index',imgArr[i]);
				$(item).find('img').attr('src','../images/info'+ imgArr[i] +'.png');
			});
			$(item).fadeIn(500);
		})
	}
	
	function showText(index){
		$(".info-text").hide();
		$(".info-text").eq(index-1).show();
	}
	
	var powerText = [
		'15年CPA掌舵风控，金杜律师监事运营， <br />北大发硕顾问指导，风控委员会严控项目。  ',
		'平均7年以上金融行业从业经验，60%以上硕士学历，<br />70%以上北大校友。',
		'团队成员累计管理规模超300亿，燕园基金发行产品<br />超10支，存续管理规模超20亿。 '
	]
	
	var powerSwiper = new Swiper("#powerSwiper",{
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
			stretch: $(window).width()*126/750,
			depth:100,
			modifier: 1,
			slideShadows: false
		},
		pagination : '#power-page',
		onTransitionEnd:function(swiper){
			var ind = swiper.realIndex;
			$(".power-text").html(powerText[ind]);
		}
	})
	
	$(".zhengshu").click(function(){
		$('.alert').show();
	})
	
	$(".close").click(function(){
		$('.alert').hide();
	})
	
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