(function() {
	FastClick.attach(document.body);

	$('#star').on('click',function(e){
		$('.priez_wraper').addClass('prize_list_move');
		setTimeout(function(){
				$('#win_alert').show();
		},4500);
	});


	$('.close').on('click',function(){
		$(this).parents('.alert').hide();
	});


	$('.rule_btn').on('click',function(){
		$('#rule_alert').show();
	});

})();