(function() {
    FastClick.attach(document.body);
	    //do your thing.
	//头部切换
	$(".top-tab").click(function(){
		var index = $(this).index();
		$(".top-tab-cur").removeClass('top-tab-cur');
		$(this).addClass('top-tab-cur');
		$(".my-con").hide();
		$(".my-con").eq(index).show();
	})
	
})();