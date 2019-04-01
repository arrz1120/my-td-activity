(function() {
    FastClick.attach(document.body);


		//抽奖
		var rotateTimeOut = function() {
			$('#rotate').rotate({
				angle: 0,
				animateTo: 2160,
				duration: 5000,
				callback: function() {
					alert('网络超时，请检查您的网络设置！');
				}
			});
		};
		var bRotate = false;

		var rotateFn = function(awards, angles, txt) {
			bRotate = !bRotate;
			$('#rotate').stopRotate();
			$('#rotate').rotate({
				angle: 0,
				animateTo: angles + 1800,
				duration: 5000,
				callback: function() {
					$('#cover_gift').show();
					alert(txt);
					bRotate = !bRotate;
				}
			});
		};

		$('.lotteryBtn').click(function() {

			if (bRotate) return;
			var item = rnd(1, 6);

			switch (item) {
				case 1:
					rotateFn(1, 0, '车载空气净化器');
					break;
				case 2:
					rotateFn(2, 40, '10元投资红包');
					break;
				case 3:
					rotateFn(3, 80, '洗漱包');
					break;
				case 4:
					rotateFn(4, 120, '20元投资红包');
					break;
				case 5:
					rotateFn(5, 160, '无线鼠标');
					break;
				case 6:
					rotateFn(6, 200, '50元投资红包');
					break;
				case 7:
					rotateFn(6, 240, '50元投资红包');
					break;
				case 8:
					rotateFn(6, 280, '50元投资红包');
					break;
					break;
				case 9:
					rotateFn(6, 320, '50元投资红包');
					break;
				default:
					break;
			}

			console.log(item);
		});



		function rnd(n, m) {
			return Math.floor(Math.random() * (m - n + 1) + n)
		}
		



	//中奖纪录滚动

    var swiper_rank_1 = new Swiper('#swiper-rank', {
        paginationClickable: true,
        direction: 'vertical',
        autoplay : 3000,
		autoplayDisableOnInteraction: false
    });



      // 弹窗



    $('.close,.know').on('click',function(e){
        e.preventDefault();
        $(this).parents('.alert').hide();
    });


    $('.alert_notouchmove ,.mask').on('touchmove',function(e){
        e.preventDefault();
    });


        var toastDom = $('#toast');

    function toast(str){
            toastDom.find('p').html(str);
            toastDom.show();
            setTimeout(function(){
                toastDom.hide();
            },800);
    }


})();