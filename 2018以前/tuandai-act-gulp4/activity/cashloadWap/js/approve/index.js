(function() {
    FastClick.attach(document.body);
    // 初始化header
    Util.initHeader({
        'header': 'header'
    });

    // 去掉往返缓存
    Util.pageShowReload();
    // 绑定事件
    // 跳转到下载页面
    $('.approve-content').on('click', '#download', function(e) {
        download(e);
    });
    // 点击认证项
    $('.list-approve').on('click', 'li', function(e) {
        toApprove(e);
    });


    // 具体实现方法
    function download(e) {
        if (Util.isIosPlatform()) {
            // todo 补充地址，跳转到appstore
            window.location.href = '#';
        } else {
            // todo 补充地址，下载android app
            window.location.href = '#';
        }
    }

    function toApprove(e) {
        var $li = $(e.currentTarget);
        var _type = $li.attr('data-type');
        console.log(_type)
        switch (_type) {
            case '1':
                window.location.href = './aprId.html';
                break;
            case '2':
                window.location.href = './aprMb.html';
                break;
            case '3':
                window.location.href = './aprLink.html';
                break;
            case '4':
            	console.log(111)
                window.location.href = './aprZc.html';
                break;

        }
    }
})();