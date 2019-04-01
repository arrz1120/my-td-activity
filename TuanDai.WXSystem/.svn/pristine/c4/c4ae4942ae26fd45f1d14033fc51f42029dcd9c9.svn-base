(function(win) {
	// console.info("Jsbridge--------");

	function isIOS() {
		var flag = false;
		if (navigator.userAgent.match(/(iPad|iPhone)/)) {
			flag = true;
		} else if (navigator.userAgent.match(/(Android)/)) {
			flag = false;
		}
		return flag;
	}

	function getParams(str, key) {
		str = str.replace(/\s+/g, "");
		var reg = new RegExp(key + "=([^;]+);");
		var subStr = str.match(reg);
		if (subStr) {
			return subStr[1];
		} else {
			return "";
		}
	}

	function connectWebViewJavascriptBridge(callback) {

		if (window.WebViewJavascriptBridge) {
			callback(WebViewJavascriptBridge);
		} else {
			document.addEventListener(
				'WebViewJavascriptBridgeReady',
				function() {
					callback(WebViewJavascriptBridge)
				},
				false
			);
		}
	}

	function iosHandler(method, param, callback) {
		window[method](param, function(respones) {
			if (callback) {
				callback(respones);
			}
		});
	}

	function androidHandler(method, param, callback) {
		/*if (param) {
			param = JSON.parse(param);
		}*/
		win.WebViewJavascriptBridge.callHandler(
			method, param,
			function(responseData) {
				// document.getElementById("show").innerHTML = "send get responseData from java, data = " + responseData
				if (callback && typeof callback == "function") {
					callback(responseData);
				}
			}
		);
	}

	var Jsbridge = function() {
		var me = this;
		me.appLifeHook();
	};
	Jsbridge.prototype = {
		constructor: Jsbridge,

		toAppInfoDetails: function(Id, TypeId) {
			try {
				if (isIOS()) {
					if (typeof InfoDetails == "function") {
						// console.info("11111");
						ToAppIosProjectDetail(Id, TypeId);
					}

				} else {
					var investParam = {
						'Id': Id,
						'TypeId': TypeId,
					};
					// investParam = JSON.stringify(investParam);
					androidHandler('InfoDetails', investParam);
				}

			} catch (e) {
				console.info("不支持jsbridge", e);
			}
		},

		//非固定插件调用
		/*
		params,--参数 （json），
		iosName：ios方法名
		androidName：android方法名
		callback：回调函数

		*/
		exec: function(methodName, params, callback) {
			try {
				if (isIOS()) {
					console.log("ios-func", methodName);
					iosHandler(methodName, params, callback);

				} else {
					console.log("android-func");
					androidHandler(methodName, params, callback);
				}
			} catch (e) {
				console.info("不支持jsbridge", e);
			}
		},


		// 生命周期
		appLifeHook: function() {
			if (isIOS()) {

			} else {
				connectWebViewJavascriptBridge(function(bridge) {
					try {
						if (!window.WebViewJavascriptBridge._messageHandler) {

							bridge.init(function(message, responseCallback) {
								console.log('JS got a message', message);
								var data = {
									'Javascript Responds': '测试中文!'
								};
								console.log('JS responding with', data);

								responseCallback(data);
							});
						}
					} catch (e) {
						console.error("jsbridge-----error--", e);
					}

					bridge.registerHandler("WebonResume", function(data, responseCallback) {
						var responseData = "Javascript Says Right back aka!";
						responseCallback(responseData);
					});

					bridge.registerHandler("WebonPause", function(data, responseCallback) {
						var responseData = "Javascript Says Right back aka!";
						responseCallback(responseData);
					});
					bridge.registerHandler("WebonDestroy", function(data, responseCallback) {
						var responseData = "Javascript Says Right back aka!";
						responseCallback(responseData);
					});
				});
			}

		}

	}
	var jsbridge = new Jsbridge();
	win.Jsbridge = jsbridge;
})(window);