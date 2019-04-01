$(function(){
	
	$(".ruleBtn").click(function(){
		$(".ruleAlert").show();
	})
	
	$(".alertClose").click(function(){
		$(this).parent().parent().hide();
	})
	
})
