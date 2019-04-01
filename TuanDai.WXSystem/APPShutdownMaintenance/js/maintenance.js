(function () {
    FastClick.attach(document.body);

    function getStatus() {
        $.ajax({
            url: '/ajaxCross/ajax_AppFind.ashx',
            type: 'post',
            dataType: 'json',
            data: {
                Cmd: 'ShutdownMaintenance',
            },
            success: function (data) {
                console.info("data---charts-", data);
                if (data && data.result == "1") {
                    (data && data.isStop == 1 ) || Jsbridge.closeWeb();
                }
            }
        }); 
    }

    function getVersion() {
        var str = navigator.userAgent;
        var arr = str.match(/\[([^\[\]]*)\]/);
        if (arr && arr[1]) {
            var vst = arr[1].split('_');
            var vstr = vst[0] + vst[1];
            if (vst && (vstr == "tuandaiappandroid" || vstr == "tuandaiappIOS")) {
                return vst[vst.length - 1];
            } else {
                return '';
            }
        } else {
            return '';
        }
    }
    Jsbridge.appLifeHook(null, null, getStatus, null, null, getStatus);

})();