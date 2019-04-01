(function() {
	//slide
TouchSlide({ slideCell:"#slideBox", mainCell:".bd ul", effect:"leftLoop",autoPlay:true });


//slide-btn
$('#hd_xuni .prev').on('click',function  () {
	$('.hd .prev').click();
});

$('#hd_xuni .next').on('click',function  () {
	$('.hd .next').click();
});

//alert
$('.alert_box .close').on('click',function  () {
	$(this).parents('.alert_box').hide();
});

$('.alert_box .mark').on('click',function  () {
	$(this).parent('.alert_box').hide();
});

$('#r_btn_1').on('click',function  (e) {
	e.preventDefault();
	$('#rule_1').show();
});


$('#r_btn_2').on('click',function  (e) {
	e.preventDefault();
	$('#rule_2').show();
});


$('#r_btn_3').on('click',function  (e) {
	e.preventDefault();
	$('#rule_3').show();
});

$('#r_btn_4').on('click',function  (e) {
	e.preventDefault();
	$('#rule_4').show();
});

$('#close-fix').on('click',function  (e) {
	e.preventDefault();
	$('.fix-md').hide();
	isFixShow = false;
});

function isBoxBlock(className){
	var  arr=[];
	$('.'+className).forEach(function(item, index){
		arr[index]=$(item).css('display');
	}) 

	if(arr.indexOf('block')!=-1){
		return true;
	}else{
		return false;
	}
}

// console.log(isBoxBlock('alert_box'));
$(document).on('touchmove',function(e){
	if(isBoxBlock('alert_box')){
		e.preventDefault();
	}
})


//计算佣金
var inputTimer,
    fromNotice = $('.cal_from .notice'),
    moneyDay = $('#money-day'),
    moneyMonth = $('#money-month');
$('#money').on('focus',function(){
	var _this = $(this);
	inputTimer = setInterval(function(){
		var moneyVal = +_this.val();
		if(moneyVal!=''&& !isNaN(moneyVal) && moneyVal>0){
			fromNotice.css('visibility','hidden');
			moneyDay.val((moneyVal*0.5/100/365*30).toFixed(2));
			moneyMonth.val((moneyVal*0.5/100).toFixed(2));
		}else{
			fromNotice.css('visibility','visible');
			moneyDay.val('');
			$('#money').val('');
			moneyMonth.val('');
		}
	},100);


});

$('#money').on('blur',function(){
	clearInterval(inputTimer);

});

var  isFixShow = true;
//判断页面是否到底部
     $(window).scroll(function(){
       if($(window).scrollTop()+$(window).height()+100>$('body').height()&&isFixShow) {
        	$('.fix-md').show();
        }
     });

//判断是否在app打开
/*function GetQueryString(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}



var isOpenApp = GetQueryString("type"),
	butShare = $('#butShare')
	btnApp = $('#btnApp');
	if(isOpenApp=='mobileapp'){
		btnApp.show();
		butShare.hide();
	}else{
		btnApp.hide();
		butShare.show();
	}*/

	
})();
