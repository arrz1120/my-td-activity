(function() {
	FastClick.attach(document.body);
	var pswpElement = document.querySelectorAll('.pswp')[0];

	$(".noticeDetail").on('click', 'img', openPhotoSwipe);

	function openPhotoSwipe(e) { //显示图片大图
		if (this.width > 0 && this.height > 0) { //图片加载完成

			let curImgUrl = this.src;
			let pswpItem = {
				src: curImgUrl,
				w: this.width * 3,
				h: this.height * 3
			}

			var photoSwipe = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, [pswpItem]);
			photoSwipe.init();
		}
	}
})();