(function() {
    FastClick.attach(document.body);
    //do your thing.
    var $content = $('.content'),
	    $swiperWrapper = $content.find(".swiper-wrapper"), //页面滑动
        $navContainer = $content.find('.nav-container'), //导航栏
        $navWrapper = $navContainer.find('.nav-wrapper'),
        $navItem = $navWrapper.find(".nav-item"),
        navIndex = -1,
        swiper;

    // 隐藏导航栏
    function hideNavContainer() {
        $navWrapper.addClass('slideOutRight').removeClass('slideInRight');
        setTimeout(function() {
            $navContainer.hide();
            $navWrapper.removeClass('slideOutRight')
        }, 500)
    }

    // 轮播图划到第n页
    function slideTo(index) {
        var curSlide = swiper.slides.eq(index);
        swiper.slideTo(index, 0, false); //切换到第n个slide，速度为1秒
        hideNavContainer();
        // setTimeout(cb.call(this, curSlide),1000);
    }

    function bindEvent() {
    	// 分享按钮
    	$content.on('click', '.share-btn', function(e) {
        	e.preventDefault();
        	var iconUrl = '', //图片地址
        		title = '', //标题
        		shareContent = '', //分享文本内容
        		shareUrl = ''; //分享地址
        	if (Util.getParam('type') == 'mobileapp') {
        		Jsbridge.toAppWebViewShare({
        			// shareTypeList: [{
        			//     ShareToolType: 分享类型 1-微信分享 2-短信分享 3-微博分享 4-QQ分享 5-朋友圈分享 6-QQ空间分享 7-二维码
        			//     ShareToolName: 第三方的产品名称， 如微信
        			//     IconUrl: 图片地址
        			//     Title: 标题
        			//     ShareContent: 分享文本内容
        			//     ShareUrl: 分享地址
        			//     IsEnabled: 是否启用 true： 启用 False： 未启用
        			// }]
        			shareTypeList: [{
        			    ShareToolType: 1,
        			    ShareToolName: '微信',
        			    IconUrl: iconUrl,
        			    Title: title,
        			    ShareContent: shareContent,
        			    ShareUrl: shareUrl,
        			    IsEnabled: true
        			},{
        			    ShareToolType: 5,
        			    ShareToolName: '朋友圈',
        			    IconUrl: iconUrl,
        			    Title: title,
        			    ShareContent: title,
        			    ShareUrl: shareUrl,
        			    IsEnabled: true
        			},{
        			    ShareToolType: 4,
        			    ShareToolName: 'QQ',
        			    IconUrl: iconUrl,
        			    Title: title,
        			    ShareContent: shareContent,
        			    ShareUrl: shareUrl,
        			    IsEnabled: true
        			},{
        			    ShareToolType: 6,
        			    ShareToolName: 'QQ空间',
        			    IconUrl: iconUrl,
        			    Title: title,
        			    ShareContent: shareContent,
        			    ShareUrl: shareUrl,
        			    IsEnabled: true
        			},{
        			    ShareToolType: 3,
        			    ShareToolName: '微博',
        			    IconUrl: iconUrl,
        			    Title: title,
        			    ShareContent: title,
        			    ShareUrl: shareUrl,
        			    IsEnabled: true
        			},{
        			    ShareToolType: 8,
        			    ShareToolName: '复制链接',
        			    IconUrl: iconUrl,
        			    Title: title,
        			    ShareContent: shareContent,
        			    ShareUrl: shareUrl,
        			    IsEnabled: true
        			}]
        		},function () {
        			// 分享回调
        		});
        	} else {
        		if (Util.isWeiXin()) {
        			Util.popup({
        				"type": 'alert',
        				"conClassName": 'share-con',
	        			"content":  '<img src="../images/share.png">'
	        		});
        		} else {
        			alert('打开app即可分享');
        		}
        	}
        })

        // 导航按钮
        $content.on('click', '.nav-btn', function() {
            $navContainer.show();
            $navWrapper.addClass('slideInRight');
        })
        //导航栏返回按钮
        $navContainer.on('click', '.back-btn', function() {
            hideNavContainer();
        })
        //导航分类
        $navContainer.on('click', '.nav-item', function() {
            var $this = $(this);
        	navIndex = $this.index();
            $this.addClass('act').siblings().removeClass('act');
            switch (navIndex) {
                case 0: //运营数据
                    slideTo(1)
                    break;
                case 1: //投资人数据
                	slideTo(9)
                    break;
                case 2: //运营大事记
                	slideTo(14)
                    break;
                case 3: //团贷大事记
                	slideTo(15)
                    break;
                case 4: //团粉互动
                	slideTo(17)
                    break;
            }

        })
        // 关注我们返回首页
        $swiperWrapper.on('click', '.follow-back-btn', function() {
	        swiper.slideTo(0, 0, false);
            $navItem.removeClass('act');
            $content.find('.fix-btn').show();
        })
        // 关注我们二维码
        $swiperWrapper.on('click', '.follow-item', function() {
        	var $this = $(this),
        		codeIndex = $this.index();
	        console.log($this.index());
	        if($('.follow-alert-wrapper').length){
	        	$('.follow-alert-wrapper').hide();
	        }
	        switch(codeIndex) {
	        	case 0: //微信订阅号
	        		Util.popup({
	        			"content":  '<img src="../images/wx-subscribe-code.png">' + 
									'<p class="main-white-txt">团贷网微信订阅号（tuandaiwang）</p>' + 
									'<p class="grey-txt">长按并复制微信号查找添加<br/>' +
									'或截屏后在微信端打开识别二维码</p>'
	        		});
	        		break;
	        	case 1: //微信服务号
	        		Util.popup({
	        			"content":  '<img src="../images/wx-serve-code.png">' + 
									'<p class="main-white-txt">团贷网微信服务号（tuandaiservice）</p>' + 
									'<p class="grey-txt">长按并复制微信号查找添加<br/>' +
									'或截屏后在微信端打开识别二维码</p>'
	        		});
	        		break;
	        	case 2: //新浪微博
	        		Util.popup({
	        			"content":  '<img src="../images/sina-code.png">' + 
									'<p class="main-white-txt">新浪微博@团贷网</p>' + 
									'<p class="grey-txt">在新浪微博搜索“团贷网”添加关注<br/>' +
									'或截屏后在微信端打开识别二维码</p>'
	        		});
	        		break;
	        }

        })

    }

    function init() {
        swiper = new Swiper('.swiper-container', {
            direction: 'vertical',
            noSwiping: true,
            // effect : 'fade',
            // fade: {
            //   crossFade: true,
            // },
            onSlideChangeEnd: function(swiper) {
                var index = swiper.activeIndex;

                // 最后一页轮播图隐藏页面悬浮按钮
                index === swiper.slides.length - 1 ? $content.find('.fix-btn').hide() : $content.find('.fix-btn').show();
                // 划到第一页or最后一页 & 点击过导航隐藏导航高亮
                if(index === 0 && navIndex !== -1 || index === swiper.slides.length - 1) $navItem.removeClass('act');
                switch(index) {
                	case 1: //运营数据
                	case 8:
                		$navItem.eq(0).addClass('act').siblings().removeClass('act');
                		break;
                	case 9: //投资人数据
                	case 13:
                		$navItem.eq(1).addClass('act').siblings().removeClass('act');
                		
                		break;
                	case 14: //运营大事记
                		$navItem.eq(2).addClass('act').siblings().removeClass('act');
                	    break;
                	case 15: //团贷大事记
                	case 16:
                		$navItem.eq(3).addClass('act').siblings().removeClass('act');
                	    break;
                	case 17: //团粉互动
                	case 18:
                		$navItem.eq(4).addClass('act').siblings().removeClass('act');
                	    break;
                }
            }
        })
        bindEvent();
    }
    init();
})();