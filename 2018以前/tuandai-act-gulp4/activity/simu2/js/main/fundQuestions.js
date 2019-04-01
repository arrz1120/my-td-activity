(function() {
	FastClick.attach(document.body);
	$('.s-question-list').on('click', '.sq-row', function() {
		var $parent = $(this).parent();
		if($parent.hasClass('show')) {
			$parent.removeClass('show');
		}else{
			$parent.addClass('show');
		}
	});
})();