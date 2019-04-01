(function() {
	FastClick.attach(document.body);
	//do your thing.
	
	[
		'../images/select/item2017.png',
		'../images/select/item2018.png',
		'../images/select/2018.png',
		'../images/select/wxShare.png',
		'../images/select/paper.png'
	].forEach(function(item) {
		var img = new Image();
		img.src = item;
	});
	
	//定义是否朋友打开该链接
	var isFriendOpen = false; 
	//定义自己是否已经总结过
	var mySummary = false;
	//定义朋友是否已经点评过
	var friendSummary = false;
	
	$(".close").click(function(){
		resetInput();
		$(this).parent().parent().hide();
	})
	
	//设置页面初始显示的状态
	if(isFriendOpen == false){
		if(mySummary == false){
			$("#page2017").show();
		}else{
			$("#sharePage").show();
		}
	}else{
		if(friendSummary == false){
			$("#commentPage").show();
			var swiper1 = new Swiper("#swiper", {
				pagination: '.paging',
				nextButton: '.next',
				prevButton: '.prev',
//				loop: true
			})
		}else{
			$("#sharePage").show();
			$(".giftBox").hide();
		}
	}

	var isInit2 = false;
	function initSwiper2() {
		if(isInit2 == false) {
			isInit2 = true;
				var cSwiper = new Swiper("#cSwiper", {
				speed:600,
				autoplay : 5000,
				autoplayDisableOnInteraction : false,
				loop: true
			})
		}
	}
	
	//定义2017输入的文字
	var txt2017 = '';
	//定义2018输入的文字
	var txt2018 = '';
	//定义给朋友评论的文字
	var txtComment = '';
	
	//文字选择
	function itemSelect(item,className){
		$('.'+className).removeClass(className);
		item.addClass(className);
	}
	
	//生成总结语
	function setEndText(){
		var $2017 = $("#txt2017");
		var $2018 = $("#txt2018");
		$("#page2018").hide();
		$("#sharePage").show();
		$2017.html(txt2017);
		$2018.html(txt2018);
		if(txt2017.length<10){
			$2017.addClass('text-center');
		}
		if(txt2018.length<10){
			$2018.addClass('text-center');
		}
		initSwiper2();
	}
	
	//重置输入框
	function resetInput(){
		$("textarea").val('');
		$(".number").find('span').html('0');
	}
	
	//发送评论
	function sendComment(){
		$("#sendSucMask").show();
	}
	
	//2017总结题目选择
	$("#page2017").find('.item').on('click',function(){
		itemSelect($(this),'item2017');
		txt2017 = '';
		txt2017 = $(this).find('p').text().replace(/\s+/g,"");
	})
	
	//2017-选好了
	$("#btn2017").on('click',function(){
		if(txt2017!=''){
			$("#page2017").hide();
			$("#page2018").show();
		}
	})
	
	//2018总结题目选择
	$("#page2018").find('.item').on('click',function(){
		itemSelect($(this),'item2018');
		txt2018 = '';
		txt2018 = $(this).find('p').text().replace(/\s+/g,"");
	})
	
	//2018-选好了
	$("#btn2018").on('click',function(){
		if(txt2018!=''){
			setEndText();
		}
	})
	
	//重新总结
	$("#reset").click(function(){
		txt2017 = '';
		txt2018 = '';
		$(".item2017").removeClass('item2017');
		$(".item2018").removeClass('item2018');
		$("#sharePage").hide();
		$("#page2017").show();
		resetInput();
	})
	
	//评论选择
	$("#commentPage").find('.item').on('click',function(){
		itemSelect($(this),'item2018');
		txtComment = '';
		txtComment = $(this).find('p').text().replace(/\s+/g,"");
	})
	
	//评论-选好了
	$("#btnComment").on('click',function(){
		if(txtComment!=''){
			//发表评论
			sendComment();
		}
	})
	
	/*******************弹窗交互*******************/
	
	var isClick1 = true;
	var isClick2 = true;
	var isClick3 = true;
	
	var focusTime = '';
	$('textarea').on('focus',function(){
		focusTime = new Date().getTime();
	})
	
	
	//2017-弹窗输入文字
	$("#page2017").find('.add').click(function(){
		txt2017 = '';
		$("#page2017").find('.item2017').removeClass('item2017');
		$("#mask2017").show();
	})
	
	
	//2017-确认输入
	$("#mask2017").find('.m-btn').click(function(){
		if(new Date().getTime() - focusTime < 200){
			return;
		}
		var val = $("#mask2017").find('textarea').val();
		if(val==''){
			showTips('输入内容不能为空');
		}else{
			txt2017 = val;
			$("#mask2017").hide();
			$("#page2017").hide();
			$("#page2018").show();
		}
	})
	
	//2018-弹窗输入文字
	$("#page2018").find('.add').click(function(){
		txt2018 = '';
		$("#page2018").find('.item2018').removeClass('item2018');
		$("#mask2018").show();
	})
	
	//2018-确认输入
	$("#mask2018").find('.m-btn').click(function(){
		var val = $("#mask2018").find('textarea').val();
		if(val!=''){
			txt2018 = val;
			$("#mask2018").hide();
			setEndText();
		}
	})
	
	//评论-弹窗输入文字
	$("#commentPage").find('.add').click(function(){
		txtComment = '';
		$("#commentPage").find('.item2018').removeClass('item2018');
		$("#commentMask").show();
	})
	
	//评论-确认输入
	$("#commentMask").find('.m-btn').click(function(){
		var val = $("#commentMask").find('textarea').val();
		if(val==''){
			showTips('输入内容不能为空');
		}else{
			txtComment = val;
			$("#commentMask").hide();
			sendComment();
		}
	})
	
	//显示礼包弹窗
	$(".giftBox").click(function(){
		$("#giftMask").show();
	})

})();