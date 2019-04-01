(function(para) {
  var p = para.sdk_url, n = para.name, w = window, d = document, s = 'script',x = null,y = null;
  w['sensorsDataAnalytic201505'] = n;
  w[n] = w[n] || function(a) {return function() {(w[n]._q = w[n]._q || []).push([a, arguments]);}};
  var ifs = ['track','quick','register','registerPage','registerOnce','clearAllRegister','trackSignup', 'trackAbtest', 'setProfile','setOnceProfile','appendProfile', 'incrementProfile', 'deleteProfile', 'unsetProfile', 'identify','login','logout','trackLink','clearAllRegister','getAppStatus'];
  for (var i = 0; i < ifs.length; i++) {
    w[n][ifs[i]] = w[n].call(null, ifs[i]);
  }
  if (!w[n]._t) {
    x = d.createElement(s), y = d.getElementsByTagName(s)[0];
    x.async = 1;
    x.src = p;
    y.parentNode.insertBefore(x, y);
    w[n].para = para;
  }
})({
  // SDK 文件的存放地址
  sdk_url: 'https://sensordata.tdw.cn/sensorsdata.min.js',
  name: 'sa',
  // 数据上报地址
  web_url: 'https://sensordata.tdw.cn/?project=default',
  // 配置分发地址
  server_url: 'https://sensorslog.tdw.cn/sa?project=default',
  heatmap:{},
//debug_mode:true,
//show_log:true
});
//var user_id = Util.getCookie('TDWUserName');
var user_id = 'ps_13711883344';
if (user_id) {
    sa.login(user_id);
}
//启动自动跟踪
sa.quick('autoTrack');

function track(name,param){
	sa.track(name, param);
}

function loadPEDetail(id, callback){
		alert(id);
    $.ajax({
        url: '/buried/info/' + id,
        dataType: 'JSON',
        success: function(data, textStatus, jqXHR){
            if (data.code === '1'){
                callback(data['data']);
            }
        }
    });
}
