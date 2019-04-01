(function() {
    FastClick.attach(document.body);
    var _cur_page = 1; // 当前页码
    var _can_ajax = true; // 是否允许触发请求

    // 事件绑定
    $('.school-tabs>a').on('click', function (e) {
        initNav(e);
    });

    // 滚动加载第二页
    $('.scroll').on('scroll', function (e) {
        getNextPage(e);
    });

    // 点击跳转详情页
    $('.list-video').on('click', '.item-video', function (e) {
        goDetail(e);
    });

    // 具体实现
    // 初始化 tab
    function initNav(e) {
        var $target = $(e.currentTarget);
        var type = $(this).attr('data-type');
        if ($target.hasClass('active')) {
            return;
        }
        $('.school-tabs>a').removeClass('active');
        $(e.currentTarget).addClass('active');
        // 当前页码重置为1；
        _cur_page = 1;
        getData(type, _cur_page);
    }

    //go detail
    function goDetail(e) {
        var $target = $(e.currentTarget);
        window.location.href = './detail.html';
    }
    
    // 获取下一页数据
    function getNextPage(e) {
        var $target = $(e.currentTarget);
        if ($target[0].scrollHeight - $target.height() - $target[0].scrollTop <= 30) {
            if (_can_ajax) {
                _can_ajax = false;

                // setTImeout 只是前端模拟效果，实际开发请去掉， 放开setTimeout可以查看效果
                /*
                setTimeout(function () {
                    $list = $('.list-video');
                    $list.append(compileTemp());
                    _can_ajax = true;
                }, 3000);
                */

                // todo 请求数据
                _cur_page += 1;
                getData(type, _cur_page);
            }
        }
    }

    // 请求数据 
    // type-视频类型： 0-热门精选 1-产品解说 2-私募学堂 3-机构路演
    // page 请求页码
    function getData(type, page) {
        // todo 补全ajax请求
        Util.Ajax({
            url: 'request api',
            type: 'get',
            data: {
                'type': type,
                'page': page
            },
            dataType: 'json',
            cbOk: function(data, textStatus, jqXHR) {
                // todo 编译模版 补全
                var $list = $('.list-video');
                if (page == 1) {
                    $list.html(compileTemp());
                } else {
                    $list.append(compileTemp());
                }
            },
            cbErr: function(e, xhr, type) {
                Util.toast('请求出错，请稍后再试');
            },
            cbCp: function() {
                _can_ajax = true;
            }
        })
    }
    // 模版编译
    function compileTemp(data) {
        var temp = [];
        for (var i = 0; i < 20; i++) {
            // todo 结合数据
            temp.push('<li class="item-video">' +
                '<div class="left video-info">' +
                '<p>热门精选热门精选热门 ' + i + '</p>' +
                '<div><i class="icon-inline icon-clock"></i><span>2017-09-01</span><i class="icon-inline icon-eye"></i><span>999 +</span></div>' +
                '</div>' +
                '<div class="right pic-play">' +
                '<img src="../../images/cover.png" >' +
                '</div>' +
                '</li>');
        }

        return temp.join('');
    }


})();