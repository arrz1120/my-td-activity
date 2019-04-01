(function() {
    FastClick.attach(document.body);
    var myScroll, $contentEl = $('.content'),
        $btnFilterEl = $contentEl.find('.btn-filter'),
        $filterWrapperEl = $('.filter-wrapper');
    var loadmore = true, //是否有更多的数据
        pullLoadMoreEl = $contentEl.find('.pull-loadmore'),
        deadLineEl = $contentEl.find('.deadline');

    var $wrapper = $contentEl.find('.data-wrapper'),
        $scroller = $wrapper.find('.scroller');

    var scrollHeight = $scroller.height(), //页面高度
        wrapperHeight = $wrapper.height(); //可视区域高度
    // 确定筛选
    function confirmFilter() {
        var area = $filterWrapperEl.find('.filter01 .act').text() || '全地区'; //地区
        var type = $filterWrapperEl.find('.filter02 .act').text() || '不限范围'; //招聘类型
        var job = $filterWrapperEl.find('.filter03 .act').text() || '所有职位'; //职位类型

        $btnFilterEl.find('.tag01').text(area);
        $btnFilterEl.find('.tag02').text(type);
        $btnFilterEl.find('.tag03').text(job);
        $filterWrapperEl.hide();

        // TODO:触发筛选接口
    }

    function showNoData() {
        $contentEl.find(".data-wrapper").hide();
        $contentEl.find(".nodata-wrapper").show();
    }
    // 事件绑定
    function bindEvent() {
        // 点击搜索
        $contentEl.on('click', '.btn-search', function() {
            console.log('点击搜索')
        });

        // 展开条件筛选
        $contentEl.on('click', '.btn-filter', function() {
            $filterWrapperEl.show();
        });

        // 收起条件筛选
        $filterWrapperEl.on('click', '.masker', function() {
            $filterWrapperEl.hide();
        });

        // 点击条件
        $filterWrapperEl.on('click', '.opt', function() {
            var $this = $(this);
            if (!$this.hasClass('act')) {
                $this.addClass('act').siblings().removeClass('act');
            }
        });

        // 重置条件
        $filterWrapperEl.on('click', '.btn-reset', function() {
            $filterWrapperEl.find(".opt:first-child").addClass('act').siblings().removeClass('act');
            confirmFilter();
        });

        // 确定筛选条件
        $filterWrapperEl.on('click', '.btn-confirm', function() {
            confirmFilter();
        });

        // 点击推荐类别项
        $contentEl.on('click', '.rmd-type', function() {
            var $this = $(this);
            var index = $contentEl.find('.rmd-content .rmd-type').index($this); //
            $filterWrapperEl.find('.filter03 .opt').eq(index).addClass('act').siblings().removeClass('act');

            confirmFilter();
        });

        // 点击职位项
        $contentEl.on('click', '.job-item', function() {
            console.log('点击了工作项')
        });
    }

    // 初始化分页的事件跟触发的条件
    function initPagination() {
        var distance = Util.pxToPx(80), //加载更多数据的距离判断
            isLoading = false; //数据是否加载中
           
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
        bindEvent();
        if ($contentEl.find('.job-item').length > 0) { //有列表才初始化
            initPagination();
        } else { //显示无数据
            showNoData();
        }
    }

    init();
})();