function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}
var isLogin = false;
function appLogin(loginToken) {
    $.ajax({
        url: '/Activity/WXAuthor.aspx?type=appajaxlogin',
        data: {
            appActivityToken: loginToken
        },
        dataType: 'json',
        type: 'post',
        success: function (result) {
            //console.info("result-------", result);
            result = JSON.parse(result);
            if (result.result == "1") {
                isLogin = true;
            }
        }
    });
}

if (GetQueryString('type') == 'mobileapp') {
    //app 判断是否为新版本
    if (Jsbridge.isNewVersion()) {
        /*
            initCallback：初始化回调
            loginTokenCallback：获取loginToken用于登录
            webonResumeCallback：打开活动页回调
            webonPauseCallback：离开活动页回调
            webonPauseCallback：销毁进程回调
        **/
        Jsbridge.appLifeHook(function (message) {
            console.info("app-page-init--"); 
        }, function (data) {
            /*        {
                        "Token": "",
                        "ReturnCode": 4,
                        "ReturnMessage": "登录已失效，请重新登录",
                        "Data": ""
                    } {
                        "Token": "",
                        "ReturnCode": 1,
                        "ReturnMessage": "成功",
                        "Data": {
                            "LoginToken": "5AF81C2720EA40AB776CCA120EC98BFC"
                        }
                    }*/
            // $("#show").html("getLoginCallback---" + data);
            data = JSON.parse(data);
            if (data.ReturnCode == 1) {
                var loginToken = data.Data.LoginToken;
                //调用后台接口登录
                appLogin(loginToken);

            } else {
                //没有获得到loginToken，跳转到登录页面
                Jsbridge.toAppLogin();
                // $("#show3").html(data.ReturnMessage);

            }

        }, function (data) {
            // $("#show2").html("playMusic---------callback--");
            // if ($(".musicbtn").attr("data-status") !== "stopped") {
            //     playMusic();

            // }
        }, function (data) {
            // $("#show2").html("test---", new Date().getTime());
            // pauseMusic();
        }, function (data) {
            // pauseMusic();

        });
    } else {
        //旧版本app 按照原来的方式登录
    }
} else {
    //微信或者浏览器 按照原来的方式登录
    // var isWeiXin = navigator.userAgent.toLowerCase().indexOf("micromessenger") != -1;
}