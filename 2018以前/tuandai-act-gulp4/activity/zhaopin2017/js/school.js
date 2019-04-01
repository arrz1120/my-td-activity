(function() {
    FastClick.attach(document.body);
	    //do your thing.
	var $body = $('body'),
		$contentEl = $body.find('.content'),
		$jobContainer = $('#job_container'), //职位类别
		$quesAnsContent = $("#ques_ans_content"); //Q&A
	// 轮播图
	var initSwiper = function() {
	    var bannerSwiper = new Swiper('.swiper-container', {
	        autoplay: 2000, //可选选项，自动滑动
	        slidesPerView: 'auto',
	        spaceBeteewn: 0,
	        autoplayDisableOnInteraction: false,
	        pagination: '.swiper-pagination',
	        loop: true
      	});
    }
	
    // 事件绑定
	function bindEvent() {
		// 切换tab
		$body.on('click', '.tab', function(){
			var $this = $(this),
				index = $('.tab').index($this);
			index === 0 ? $jobContainer.show() : $jobContainer.hide();
			$this.addClass('act').siblings().removeClass('act');
			$(".tab-content").eq(index).show().siblings(".tab-content").hide();
		})
		// 切换职位类别
		$body.on('click', '#job_container span', function(){
			var $this = $(this),
				index = $jobContainer.find('span').index($this), //职位类别索引值
				jobItem = '';
			$this.addClass('act').siblings().removeClass('act');
			//职位数据
			for (var i = 0; i < 4; i++) {
				jobItem +=  '<a class="job-item" href="jobDetails.html">' +
									'<p class="job-name">【东莞】用户运营主管</p>' +
									'<div class="job-detail">' +
										'<span>1-3年</span>' +
										'<span>本科</span>' +
										'<span>校园招聘</span>' +
										'<span>资深运营</span>' +
									'</div>' +
								'</a>';
			}
			$("#job_list").html(jobItem);
			$contentEl.find('.job-tab-content').scrollTop(0);
		})
		// Q&A切换
		$body.on('click', '#ques_ans_content .tab-content-box', function () {
			var $this = $(this),
				$other = $this.siblings(),
				$arrowDown = $this.find('.icon-arrow-down'),
				$answer = $this.find('.answer'),
				$quesAnsBox = $('.ques-ans-box'),
				index = $quesAnsBox.index($this), //当前点击问题索引值
				height = $quesAnsContent.find('.ques-ans-scroll').height();//Q&A滚动高度
			if($arrowDown.hasClass('rotate')){
				$arrowDown.removeClass('rotate');
				$answer.hide();
			}else{
				$arrowDown.addClass('rotate');
				$answer.show();
				$other.find('.answer').hide();
				$other.find('.icon-arrow-down').removeClass('rotate');
				if($quesAnsBox.length - 1 === index){
					$quesAnsContent.scrollTop(height);
				}
			}
		})
		/*$body.on('click', '#ques_ans_content .question', function () {
			var $this = $(this),
				$tabContentBox = $this.parent(),
				$arrowDown = $this.find('.icon-arrow-down'),
				$answer = $tabContentBox.find('.answer');
				console.log($this);
			if($arrowDown.hasClass('rotate')){
				$arrowDown.removeClass('rotate');
				$answer.hide();
			}else{
				$arrowDown.addClass('rotate');
				$answer.show();
				$tabContentBox.siblings().find('.answer').hide();
				$tabContentBox.siblings().find('.icon-arrow-down').removeClass('rotate');
			}
		})*/
	}

	 // 初始化分页的事件跟触发的条件
    function initPagination() {
        var distance = Util.pxToPx(80), //加载更多数据的距离判断
            isLoading = false, //数据是否加载中
            loadmore = true, //是否有更多的数据
            pullLoadMoreEl = $contentEl.find('.pull-loadmore'),
            deadLineEl = $contentEl.find('.deadline');

        var $wrapper = $contentEl.find('.wrapper'),
            $scroller = $wrapper.find('.scroller');

        var scrollHeight = $scroller.height(), //页面高度
            wrapperHeight = $wrapper.height(); //可视区域高度
        // if (wrapperHeight < scrollHeight) { //如果容器的高度小于内容的高度
        //     pullLoadMoreEl.show();
        // }

        // 分页触发的条件
        $wrapper.scroll(function() {
            if (!isLoading && loadmore) {
                //已经滚动到上面的页面高度
                var scrollTop = $wrapper.scrollTop();
                //此处是滚动条到底部时候触发的事件，在这里写要加载的数据，或者是拉动滚动条的操作
                if (scrollTop + wrapperHeight >= scrollHeight - distance) {

                    console.log(1);
                    // 设置数据为加载状态
                    isLoading = true;
                    // TODO:加载数据，加完成之后，设置isLoading为false
                    // 如果无更多数据，设置loadmore为false，并显示end-line,隐藏loading
                    // 最后刷新myScroll
                    console.log('加载数据');

                    // 模拟6s之后数据加载完成
                    setTimeout(function() {
                        isLoading = false;

                        var hasMore = true; //模拟有更多数据
                        if (hasMore) { // 有更多数据
                            loadmore = true;
                            pullLoadMoreEl.show();
                            deadLineEl.hide();
                        } else { // 无更多数据
                            loadmore = false;
                            pullLoadMoreEl.hide();
                            deadLineEl.show();
                        }
                        // 分页加载时重新获取页面高度
                        scrollHeight = $scroller.height();
                    }, 6000);
                }
            }
        })
    }

	function init() {
		// 轮播图
        // initSwiper();
        initPagination();
		bindEvent();
	}
	init();
})();