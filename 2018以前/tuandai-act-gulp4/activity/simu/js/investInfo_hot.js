(function() {
    FastClick.attach(document.body);
    var $body = $('body');
	// 事件绑定
	function bindEvent() {
		$body.on('click', '#back_btn', function () {
			window.history.back();
		})
	}
	function init() {
		bindEvent();
	}
	init();
})();