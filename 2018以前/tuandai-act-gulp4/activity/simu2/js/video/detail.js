(function() {
    FastClick.attach(document.body);

    // 初始化video
    var player = new YKU.Player('youkuplayer', {
        styleid: '0',
        client_id: '52b3fa57e9fe17cf',
        vid: 'XMTQ5NDgwNDAyOA==',
        newPlayer: true,
        autoplay: false
    });
    // 事件绑定
    // 获取视频密码
    $('.v-detail-content').on('click', '#get_psw', function(e) {
    	getPsw(e);
    });

    // 具体实现
    function getPsw(e) {
    	// todo 补全ajax请求
    	Util.Ajax({
    		url: 'request api',
    		type: 'get',
    		data: {},
    		dataType: 'json',
    		cbOk: function(data, textStatus, jqXHR) {
                    console.log(data);
            },
            cbErr: function (e, xhr, type) {
            	Util.toast('请求出错，请稍后再试');
            }
    	})
    }
    
    var _play = false;
    $('#youkuplayer').on('click', function (e) {
        if (!_play) {
            _play = true;
            // todo ajax 更新播放次数
            alert('更新播放次数');
        }
    })
})();