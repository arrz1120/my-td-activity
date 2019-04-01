(function() {
	FastClick.attach(document.body);
	//do your thing.

	var swiper1 = new Swiper("#swiper1", {
		pagination: '.page1',
		loop: true
	})
	var swiper2 = new Swiper("#swiper2", {
		pagination: '.page2',
		loop: true
	})

	$(".shareBtn").click(function(e) {
		e.preventDefault();
		if(GetQueryString('type') == 'mobileapp') {
			Jsbridge.toAppActivity(30);
		} else {
			if(isWeiXin()) {
				$("#wxAlert").show();
			} else {
				alert('打开app即可分享');
			}
		}

	});
	
	$(window).on('touchmove scroll',function(){
		if( $(document).scrollTop() + $(window).height() > $(document).height() - 20 ){
			$(".dropdown").hide();
		}else{
			$(".dropdown").show();
		}
	})
})();