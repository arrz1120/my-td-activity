(function(win) {

  function isIOS() {
    return navigator.userAgent.match(/(iPad|iPhone)/);
  }

  function connectWebViewJavascriptBridge(callback) {

    if (window.WebViewJavascriptBridge) {
      typeof callback === 'function' && callback.call(this, WebViewJavascriptBridge);
    } else {
      document.addEventListener(
        'WebViewJavascriptBridgeReady',
        function() {
          typeof callback === 'function' && callback.call(this, WebViewJavascriptBridge);
        },
        false
      );
    }
  }

  function setupWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) {
      return callback(WebViewJavascriptBridge);
    }
    if (window.WVJBCallbacks) {
      return window.WVJBCallbacks.push(callback);
    }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'https://__bridge_loaded__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function() {
      document.documentElement.removeChild(WVJBIframe)
    }, 0)
  }

  /*
      @params:
          method: function 原生方法
          param: 参数
          callback: 回调
  */

  function iosHandler(method, param, cb) {
    setupWebViewJavascriptBridge(function(bridge) {
      bridge.callHandler(method, param, function responseCallback(responseData) {
        typeof cb === 'function' && cb.apply(this, arguments);
      });
    });

  }

  function androidHandler(method, param, cb) {

    win.WebViewJavascriptBridge.callHandler(
      method, param,
      function(responseData) {
        typeof cb === 'function' && cb.apply(this, arguments);
      }
    );
  }

  function caller(method, param, cb) {
    try {
      if (isIOS()) {
        iosHandler(method, param, cb);
      } else {
        androidHandler(method, param, cb);
      }
    } catch (e) {
      console.info("不支持jsbridge", e);
    }
  }

  function registeAndroidEvent(method, cb) {
    connectWebViewJavascriptBridge(function(bridge) {
      try {
        if (!window.WebViewJavascriptBridge._messageHandler) {
          bridge.init(function(message, responseCallback) {
            responseCallback(data);
          });
        }
      } catch (e) {
        console.error("jsbridge-----error--", e);
      }

      bridge.registerHandler(method, function(data, responseCallback) {
        var responseData = "Javascript Says Right back aka!";
        responseCallback(responseData);
        typeof cb === 'function' && cb.apply(this, arguments);
      });

    });
  }



  var Jsbridge = function() {};
  Jsbridge.prototype = {

    //非固定插件调用
    /*
    --参数 （json），
    methodName: 方法名,
    params: 请求参数,
    cb：回调函数
    */
    exec: function(methodName, cb, params) {
      params = params || {};
      caller(methodName, params, cb);
    },

    // 生命周期
    /*
        readyCb：打开活动页回调（只执行一次）
        webonPauseCb：离开活动页回调
        webonDestroyCb：销毁进程回调
        webonResumeHomeCb: 离开后回到页面时回调
     **/
    appLifeHook: function(readyCb, webonPauseCb, webonDestroyCb, webonResumeHomeCb) {
      if (isIOS()) {

        /*
        step:
        1： h5界面加载完毕 注册h5调用原生的方法， 此时原生调用h5 传参数1
        2： 当前的h5界面 将进入了下一个界面或者上一个界面。 此时传参2
        3: 用户按home键 将程序退至后台， 此时传参3
        4: 用户重新启动程序(程序由后台切换至前台), 此时传数4
        */
        setupWebViewJavascriptBridge(function(bridge) {
          bridge.registerHandler('ToAppLifeCycle', function(data, responseCallback) {
            // document.getElementById("show").innerHTML = 'ToAppLifeCycle-----' + JSON.stringify(data);
            switch (+data) {
              case 1:
                typeof readyCb === 'function' && readyCb.apply(this, arguments);
                break;
              case 2:
                typeof webonPauseCb === 'function' && webonPauseCb.apply(this, arguments);
                break;
              case 3:
                typeof webonPauseCb === 'function' && webonPauseCb.apply(this, arguments);
                break;
              case 4:
                typeof webonResumeHomeCb === 'function' && webonResumeHomeCb.apply(this, arguments);
                break;
            }
            responseCallback(data)
          });
        })
      } else {
        registeAndroidEvent('WebonResume', readyCb);
        registeAndroidEvent('WebonResumeHome', webonResumeHomeCb);
        registeAndroidEvent('WebonPause', webonPauseCb);
        registeAndroidEvent('WebonDestroy', webonDestroyCb);
      }

    }
  }
  var jsbridge = new Jsbridge();
  win.Jsbridge = jsbridge;
})(window);