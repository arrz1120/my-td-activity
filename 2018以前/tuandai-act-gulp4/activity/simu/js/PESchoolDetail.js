(function() {
    FastClick.attach(document.body);
    var $body = $('body');
	// 事件绑定
	function bindEvent() {
		$body.on('click', '.school-item', function () {
			var $this = $(this),
				$rightOptBtn = $this.find('.right-opt-btn'),
				$schoolCon = $this.find('.school-con');
			if($rightOptBtn.hasClass('rotate')){
				$rightOptBtn.removeClass('rotate');
				$schoolCon.hide();
			}else{
				$rightOptBtn.addClass('rotate');
				$schoolCon.show();
				$this.siblings().find('.school-con').hide();
				$this.siblings().find('.right-opt-btn').removeClass('rotate');
			}
		})
		
		$body.on('click', '#back_btn', function () {
			window.history.back();
		})
	}
	function init() {
		bindEvent();
	}
	init();
})();