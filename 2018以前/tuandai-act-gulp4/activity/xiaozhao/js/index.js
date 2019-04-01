(function() {
	FastClick.attach(document.body);
	function showVideo(domid, vid) {
		player = new YKU.Player(domid, {
			client_id: '52b3fa57e9fe17cf',
			vid: vid,
			show_related: false,
			autoplay: true,
			events: {
				onPlayEnd: function() {
					location.href = 'https://m-zhaopin.tdw.cn';
				}
			}
		});
	}
	showVideo('video_a', 'XMzAxOTQyNzY4NA==');
})();