(function() {
	FastClick.attach(document.body);
	//do your thing.


	function showVideo(domid, vid) {
		player = new YKU.Player(domid, {
			client_id: '52b3fa57e9fe17cf',
			autoplay: true,
			vid: vid,
			show_related: false
		});
	}


    showVideo('video1', 'XMzEyMzkyOTc5Ng==');
	
	
})();