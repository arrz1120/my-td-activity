(function() {
	FastClick.attach(document.body);



	//弹窗


	//规则弹窗

	var alert = $('.alert')

	alert.on('touchmove', function(e) {
		e.preventDefault();
	});

	alert.find('.close,.mark,.close_left').on('click', function() {
		alert.hide();
	});


	
	$('.stop_help').on('click',function(e){
		e.preventDefault();
			$('#stop_alert').show();
	});



	
	$('.share').on('click', function() {
		window.appShare.set({
			iconUrl: '',
			title: '',
			content: '',
			shareUrl: '',
			wxShareImg: {
				url: '../images/share_img.png',
				style: {
					width: '100%',
				}
			},
			callback: function(result) {
				var status;
				//status:
				//成功:'onComplete'，失败:'onError'，取消:'onCancel'
				if (isIOS()) {
					status = result;
				} else {
					status = JSON.parse(result).ShareResult;
				}
			}
		})
	});




})();