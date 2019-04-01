(function() {
	FastClick.attach(document.body);
	//do your thing.

	function checkPhone(phone) {
		if(!(/^1[34578]\d{9}$/.test(phone))) {
			return false;
		}else{
			return true;
		}
	}

	var investSwiper = new Swiper('#investSwiper', {
		loop: true,
		nextButton: '.next',
		prevButton: '.prev'
	})

	$(".agree").click(function(e) {
		if(e.target.nodeName != 'A') {
			var span = $(this).find('span');
			if(span.hasClass('checked')) {
				span.removeClass('checked');
			} else {
				span.addClass('checked');
			}
		}
	})
	
	$("#phone").on('input',function(){
		var val = $(this).val();
		if(val.length == 11){
			$(".inputWrap").show();
		}
	})
	
	$(".toTop").click(function(){
		$('body').animate({'scrollTop':284},600);
	})
})();