(function() {
    FastClick.attach(document.body);
    Util.initHeader({
        'header': 'header'
    });

    // 绑定事件
    $('.al-content').on('click', '#get_gps', function(e) {
        getGPS_BD(e);
    });

    // 显示关系选择
    // $('.al-content').on('click', '.relation', function(e) {
    //     chooseRelation(e);
    // });

    // 关闭关系弹窗
    $('.pop-relation').on('click', '.masker', function(e) {
        closePopRelation();
    });
    // 具体实现
    function getGPS_BD (e) {
        var geolocation = new BMap.Geolocation();
        Util.showLoader();
        geolocation.getCurrentPosition(function(r) {
            if (this.getStatus() == BMAP_STATUS_SUCCESS) {
            	var point = r.point,
            		addr = r.address;
                console.log(r)
                console.log(addr.city)
                console.log(addr.province)
                $('#gps').html(addr.province + addr.city).addClass('inputed');
                Util.hideLoader();
            } else {
                alert('failed' + this.getStatus());
            }
        }, { enableHighAccuracy: true });
        
    }

    // 高德js 
    function getGPS_GD(e) {
        var map, geolocation;
        //加载地图，调用浏览器定位服务
        // map = new AMap.Map();
        Util.showLoader();
        AMap.service('AMap.Geolocation', function() {
            geolocation = new AMap.Geolocation({
                enableHighAccuracy: true, //是否使用高精度定位，默认:true
                timeout: 10000, //超过10秒后停止定位，默认：无穷大
                buttonOffset: new AMap.Pixel(10, 20), //定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
                zoomToAccuracy: true, //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
                buttonPosition: 'RB'
            });
            // map.addControl(geolocation);
            geolocation.getCurrentPosition();
            AMap.event.addListener(geolocation, 'complete', onComplete); //返回定位信息
            AMap.event.addListener(geolocation, 'error', onError); //返回定位出错信息
        });
        //解析定位结果
        function onComplete(data) {
        	console.log(data);
        	$('#gps').html(data.addressComponent.province + data.addressComponent.city).addClass('inputed');
            Util.hideLoader();
            // var str = ['定位成功'];
            // str.push('经度：' + data.position.getLng());
            // str.push('纬度：' + data.position.getLat());
            // if (data.accuracy) {
            //     str.push('精度：' + data.accuracy + ' 米');
            // } //如为IP精确定位结果则没有精度信息
            // str.push('是否经过偏移：' + (data.isConverted ? '是' : '否'));
            // console.log(str)
            // document.getElementById('tip').innerHTML = str.join('<br>');
        }
        //解析定位错误信息
        function onError(data) {
           Util.hideLoader();
           Util.toast('定位失败');
        }
    }

    // 高德web 服务
    function getGPS_GD2(e) {
    	Util.Ajax({
            url: 'http://restapi.amap.com/v3/ip',
            type: 'get',
            dataType: 'json',
            data: {
                key: 'ec1471fa3c999c30b1bbf035e105593e'
            },
            cbOk: function(data) {
                console.log(data);
                $('#gps').html(data.province + data.city).addClass('inputed')
            },
            cbErr: function(e) {
                console.log(e);
            },
            cbCp: null
        });
    }

    function chooseRelation(e) {
        var $target = $(e.currentTarget),
            no = $target.attr('data-no');
        console.log(no);
        $('.pop-relation').show();
    }

    function closePopRelation() {
        $('.pop-relation').hide();
    }

})();