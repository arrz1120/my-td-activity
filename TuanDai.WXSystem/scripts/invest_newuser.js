(function() {
	var $videoContainer = $('.video-container');
	// 播放视频
	function showVideo(dom_id, vid, client_id){
	    player = new YKU.Player(dom_id, {
	        styleid: '0',
	        client_id: client_id,
	        vid: vid, //优酷视频id
	        show_related: false,
	        newPlayer: true
	    });
	}
	// 绑定事件
	function bindEvent() {
		$videoContainer.on('click', '#video_play_btn', function () {
			showVideo("video", 'XMzAwNTUzOTkyMA', '52b3fa57e9fe17cf');
			$videoContainer.find('.video-bg').hide();
		})
	}
	function init() {
		bindEvent();
	}
	init();
})();