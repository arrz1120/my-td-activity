(function() {
	FastClick.attach(document.body);
	//do your thing.

	//禁止弹窗背景滑动
	$(".mask_bg").on('touchmove', function(e) {
		e.preventDefault();
	})

	//弹窗通用关闭事件
	$(".close").click(function() {
		$(this).parent().parent().hide();
	})
	$(".mask_bg").click(function() {
		$(this).parent().hide();
	})

})();

//输入提示
function showTips(tips) {
	$(".tips").html(tips);
	$("#tipsBox").fadeIn(function() {
		setTimeout(function() {
			$("#tipsBox").fadeOut();
		}, 1000);
	});
}

//输入表情过滤
function filter(val) {
	return val.replace(/\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g, "");
}

var focusTime = '';
$('textarea').on('focus', function() {
	focusTime = new Date().getTime();
})

//设置已输入文字个数
var isCnInput = false;
var txtLen = 0;
$("textarea").on('compositionstart', function() {
	isCnInput = true;
})
$("textarea").on('compositionend', function() {
	isCnInput = false;

	txtLen = $(this).val().length;
	if(txtLen > 30) {
		txtLen = 30;
	}
	$(this).next().find('span').html(txtLen);
})
$('textarea').on('input', function(e) {
	if(isCnInput) return;
	//		$(this).val(filter($(this).val()));

	txtLen = $(this).val().length;
	if(txtLen > 30) {
		txtLen = 30;
	} 
	$(this).next().find('span').html(txtLen);
})

function isAndroidPlatform() {
    if (navigator.userAgent.match(/(Android)/) && Jsbridge.isApp()) {
        return true;
    } else {
        return false;
    }
}

// 输入框聚焦失焦事件 解决Android bug
$('textarea').on('focus', function (e) {
    if(isAndroidPlatform()){
        $('.taMask').css('transform', 'translateY(-5rem)');
    }
})

$('textarea').on('blur',function (e) {
    if(isAndroidPlatform()){
        $('.taMask').css('transform', 'translateY(0)');
    }
})