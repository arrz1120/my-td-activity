(function() {
	FastClick.attach(document.body);
	//do your thing.
	
	//定义是否选择了题目，默认为false
	var isSelect = false;
	
	//选择题目
	
	function selectAns(item){
		isSelect = true;
		var parent = item.parent();
		parent.siblings().removeClass('selected');
		parent.addClass('selected');
	}
	
	$(".ans-con").find('span').click(function(){
		selectAns($(this));
	})
	
	$(".ans-con").find('p').click(function(){
		selectAns($(this));
	})
	
	//提交
	$("#submit").click(function(){
		if(isSelect){
			location.href = "getGift.html";
		}
	})
	

})();