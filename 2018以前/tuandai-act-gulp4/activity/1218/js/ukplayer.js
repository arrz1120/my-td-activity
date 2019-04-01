/**
 * Created by xdanger.liu on 2017/3/14.
 */
var YK = {};
YK.https = location.protocol == "https:" ? "https:" : "http:";

var DEBUG__ = 0;

var console = window.console;
if (!console) {
    console = {};
    console.log = function() {};
}

var debug = {};
debug.log = function(log) {
    if (DEBUG__) {
        console.log(log);
    }
};
window.YKU = {};
var YKP = {
    playerType: "",

    playerState: {
        PLAYER_STATE_INIT: 'PLAYER_STATE_INIT',
        PLAYER_STATE_READY: 'PLAYER_STATE_READY',
        PLAYER_STATE_AD: 'PLAYER_STATE_AD',
        PLAYER_STATE_PLAYING: 'PLAYER_STATE_PLAYING',
        PLAYER_STATE_END: 'PLAYER_STATE_END',
        PLAYER_STATE_ERROR: 'PLAYER_STATE_ERROR'
    },

    playerCurrentState: 'PLAYER_STATE_INIT',
    isLoadFinishH5: false,
    isPC: true,
    videoList: [],
    isAndroidYouku:false
};

var StaticDomain = YK.https + "//player.youku.com";

function browserRedirect() {
    var sUserAgent = navigator.userAgent.toLowerCase();
    var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
    var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
    var bIsIphone = sUserAgent.match(/iphone/i) == "iphone";
    var bIsMidp = sUserAgent.match(/midp/i) == "midp";
    var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
    var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
    var bIsAndroid = sUserAgent.match(/android/i) == "android";
    var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
    var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
    if (bIsIpad || bIsIphoneOs || bIsIphone || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM) {
        // YKP.isPC = false;
        YKP.isSupportFlash = false;
    } else {
        // YKP.isPC = true;
        YKP.isSupportFlash = true;
    }
    var bIsYouku = sUserAgent.match(/youku/i) == "youku";
    if (bIsAndroid){
        if (bIsYouku){
            YKP.isAndroidYouku = true;
        }
    }

    if (bIsIphone){
        if (bIsYouku){
            YKP.isIphoneYouku = true;
        }
    }
}
browserRedirect();

function createViewport() {
    if (YKP.isSupportFlash == false) {
        var oMeta = document.createElement('meta');
        oMeta.name = "viewport";
        oMeta.content = "width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no";
        document.getElementsByTagName('head')[0].appendChild(oMeta);
    }
}
//createViewport();

var urlParameter = function(object) {
    var arr = [];
    for (var o in object) {
        arr.push(o + '=' + object[o]);
    }
    return arr.join('&');
};

window.QS = function() {
    var args = {};

    var result = window.location.search.match(new RegExp("[\?\&][^\?\&]+=[^\?\&]+", "g"));
    if (result != null) {
        for (var i = 0; i < result.length; i++) {
            var ele = result[i];
            var inx = ele.indexOf("=");
            //args[ele.substring(1, inx)] = ele.substring(inx + 1);
            var key = ele.substring(1, inx);
            var val = ele.substring(inx + 1);
            try {
                val = decodeURI(val);
            } catch (e) {

            }
            //è½¬æ¢val Boolean Number Object
            val == "true" ? val = true : (val == "false" ? val == false : isNaN(val) ? val = parseJsonStr(val) : val = +val);
            if ('undefined' == typeof args[key]) {
                args[key] = val;
            } else {
                if (args[key] instanceof Array) {
                    args[key].push(val);
                } else {
                    args[key] = [args[key], val];
                }
            }
        }
    }
    return args;
}

function parseJsonStr(str) {
    if ('string' != typeof str) {
        return str;
    }
    if (/{[^{^}]{0,}}/.test(str)) {
        try {
            str = JSON.parse(str);
        } catch (e) {

        }
    }
    return str;
}

var dynamicLoading = {
    css: function(path) {
        if (!path || path.length === 0) {
            throw new Error('argument "path" is required !');
        }
        var head = document.getElementsByTagName('head')[0];
        var link = document.createElement('link');
        link.href = path;
        link.rel = 'stylesheet';
        link.type = 'text/css';
        head.appendChild(link);
    },
    js: function(path, obj, attr) {
        if (!path || path.length === 0) {
            throw new Error('argument "path" is required !');
        }
        var head = document.getElementsByTagName('head')[0];
        var script = document.createElement('script');
        script.src = path;
        script.type = 'text/javascript';
        if (attr) {
            script["id"] = attr["id"];
            script.setAttribute('pageType', attr["pageType"]);
            script.setAttribute('isHidden', attr["isHidden"]);
        }
        head.appendChild(script);

        script.onload = function() {
            if (obj) {
                obj.selectH5();
                YKP.isLoadFinishH5 = true;
            }
        }
    }
}

dynamicLoading.css(YK.https + "//player.youku.com/unifull/css/unifull.min.css");

var YoukuPlayerSelect = function(params) {

    YK.initConfig = params;
    this._vid = params.vid;
    this._target = params.target;
    this._partnerId = params.partnerId;
	this._videoFlag = params.videoFlag;
    if (params.client_id) {
        //兼容openapi中的client_id的设置
        this._partnerId = params.client_id;
    }

    if (!(this._vid && this._target && this._partnerId)) {
        alert(
            "[Fail]The params of {vid,target,client_id} are necessary !"
        );
        return;
    }

    this._events = params.events;
    YK.playerEvents = params.events;

    this._id = params.id;
    if (this._id == null) this._id = "youku-player";
    YKP.playerId = this._id;
    this._width = params.width;
    this._height = params.height;
    this._expand = params.expand;
    if (params.width == null || params.height == null) {
        //宽高指定不全，默认为0
        if (params.expand == null) {
            this._expand = 0;
        }
    } else {
        //宽高都指定，默认为1
        if (params.expand == null) {
            this._expand = 1;
        }
    }

    // this._prefer = (params.prefer ? params.prefer.toLowerCase() : "flash");
    this._starttime = params.starttime;
    this._password = params.password;
    this._poster = params.poster;
    this._autoplay = !! params.autoplay; // 0 ,1 ,true ,false,'true','false'..
    this._canWide = params.canWide;
    if ('undefined' != typeof params.show_related) {
        this._showRelated = !! params.show_related;
    }

    this._embed_content = params.embed_content;
    this._embed_vid = params.embed_vid;
	this._cancelFullScreen = params.cancelFullScreen;
    this._source = params.source;
	this._newPlayer = params.newPlayer;
    this._winType = params.wintype;

    //播放页专门参数
    this._playlistconfig = params.playlistconfig;
    this._isMobile = YKP.isMobile;
    this._isMobileIOS = YKP.isMobileIOS;

    //this._weixin = params.weixin;
    YK.isWeixin = YKP.isWeixin; //false;
    //微信专用参数
    if ('undefined' != typeof params.weixin) {
        YK.isWeixin = !! params.weixin; //!!å¤–éƒ¨ä¼ å…¥ weixin=fasle ä¹Ÿå¯ä»¥ç”Ÿæ•ˆ
    }

    this._loop = !! params.loop || false;
    // more ..

    this._playerType = "";

};
YoukuPlayerSelect.prototype = {
    isSupportFlash: function() {
        return YKP.isSupportFlash;
    }, //todo
    playerType: function() {
        if (this._playerType != "") return this._playerType;
        if (this.isSupportFlash()) {
            this._playerType = "flash";
        } else {
            this._playerType = "h5";
        }
        return this._playerType;
    },
    select: function() {
        //debug.log('playerType = ' + this.playerType());
        /**
         if (this.isThirdParty()) {
            var self = this;
            this.processThirdParty(function(e) {
                self.selectHandler();
            });
            return;
        }
         */
        this.selectHandler();
    },
    selectHandler: function() {
        if (this.playerType() == "h5") {
            YKP.playerType = "h5";
            dynamicLoading.js(YK.https + "//static.youku.com/h5/html/sb/ykbannerLoader/ykbannerLoader.min.js", null, {"id":"ykbannerLoader", "pageType":"player", "isHidden":true});
            if (YKP.isLoadFinishH5) {
                this.selectH5();
            } else {
				dynamicLoading.js(YK.https + "//player.youku.com/unifull/js/unifull.min.js", this);
            }

        } else if (this.playerType() == "flash") {
            YKP.playerType = "flash";
            this.selectFlash();
        }

        if (this._events && this._events.onPlayerReady) {
            var callback = this._events.onPlayerReady;
            if (YKP.playerType == "h5") {
                var check = setInterval(function() {
                    // if ($(YKP.playerId)) {
                    //     YKP.playerCurrentState = YKP.playerState.PLAYER_STATE_READY;
                    //     debug.log(YKP.playerCurrentState);

                    try {
                        //    LocalStorage.appendItem('phase', 'playerready');
                        callback();
                    } catch (e) {}
                    clearInterval(check);
                    //}
                }, 500);
            } else if (YKP.playerType == 'flash') {
                var check = setInterval(function() {
                    //   if (YKU.swfLoaded == 1) {
                    //      YKP.playerCurrentState = YKP.playerState.PLAYER_STATE_READY;
                    //      debug.log(YKP.playerCurrentState);

                    try {
                        //   LocalStorage.appendItem('phase', 'playerready');
                        callback();
                    } catch (e) {

                    }
                    clearInterval(check);
                    //  }
                }, 500);
            } else {

            }
        }
    },
    selectH5: function() {
        var self = this;
        var playerDom = document.getElementById(this._target);
        if (this._width > 0 && this._height > 0)
        {
            playerDom.style.width = this._width + "px";
            playerDom.style.height = this._height  + "px";
        }
        else
        {
            //var cw = document.documentElement.clientWidth;
            //var ch = document.documentElement.clientHeight;
            var cw = playerDom.style.offsetWidth;
            var ch = playerDom.style.offsetHeight;
            function resize(playerDom) {
                //playerDom.style.width = cw + "px";
                //playerDom.style.height = 9 * cw / 16 + "px";

                playerDom.style.width = cw + "px";
                playerDom.style.height = ch + "px";
            }
            resize(playerDom);
        }
		
		var closeFullFullScreen = 0;
        if (self._cancelFullScreen == 1 && YKP.isAndroidYouku)
        {
            closeFullFullScreen = 1;
        }

        var config = {
            videoId: self._vid, //视频id
            ccode: "0590", //渠道id
            client_id: self._partnerId, //优酷视频云创建应用的client_id
            control: {
                laguange: "", //默认使用的语言类型
                hd: "mp4hd", //默认使用的码率
                //   hd:"m3u8",
                autoplay: false //是否自动播放
            },
            logconfig: {

            }, //统计扩展参数，包括aplus接口中的全局对象时数据，用于传递给统计接口
            adConfig: {

            }, //广告扩展参数
            password: self._password, //视频播放密码，用于加密视频（这个是否可以传入暂定）
            wintype: "", //每端固定的参数，多用于统计，不确定是否还需要
            type: "", //播放类型（pc,pad,mobile）暂定,
            events: self._events,

            embed_vid: self._embed_vid,
            embed_content: self._embed_content,
            source: self._source,
            closeFullFullScreen: closeFullFullScreen,
            isIphoneYouku : YKP.isIphoneYouku
        };
        this._h5player = YKPlayer.Player(this._target, config);
    },

    onorientationchange: function() {
        //var self = this;
        var playerDom = document.getElementById(this._target);
        setTimeout(function() {
            var cw = document.documentElement.clientWidth;
            var ch = document.documentElement.clientHeight;
            playerDom.style.width = cw + "px";
            playerDom.style.height = 9 * cw / 16 + "px";

        }, 300);
    },
    isThirdParty: function() {

        var cid = this._partnerId;
        if (cid != null && (cid + '').length == 16) {
            return true;
        };

        return false;
    },
    selectFlash: function() {

        // 嵌入以后会调用外部的那个 onYoukuPlayerReady()函数

        var flashvars = {
            imglogo: this._poster || '',
            //    isAutoPlay: this._autoplay||false,
            //    isShowRelatedVideo: this._showRelated===false?false:true,
            partnerId: this._partnerId
        };
        if (this._loop) {
            flashvars.isLoop = 'true';
        }
        if (YK.initConfig.firsttime != null) {
            flashvars.firsttime = YK.initConfig.firsttime;
        }
        //if (this._autoplay != null) {
        //    flashvars.isAutoPlay = this._autoplay;
        //}
        if (YK.initConfig.embsig != null) {
            flashvars.embsig = YK.initConfig.embsig;
        }

        if (YK.initConfig.password != null) {
            flashvars.passwordstr = YK.initConfig.password;
        }
        if (YK.initConfig.styleid != null) {
            flashvars.styleid = YK.initConfig.styleid;
        }
        if (YK.initConfig.vext != null) {
            flashvars.vext = YK.initConfig.vext;
        }
        ////360全景 接口来取不需要
        //if(YK.initConfig.panorama) {
        //    flashvars.panorama = YK.initConfig.panorama;
        //}
        for (var key in YK.initConfig.adconfig) {
            flashvars[key] = YK.initConfig.adconfig[key];
        }
        for (var key in YK.initConfig.flashconfig) {
            flashvars[key] = YK.initConfig.flashconfig[key];
        }

        var urlParam = {
            sid: this._vid,
            isAutoPlay: this._autoplay,
            isShowRelatedVideo: this._showRelated,
            winType: this._winType,
            newPlayer: this._newPlayer,
			videoFlag: this._videoFlag
        };
        //var partner = "";
        if (this.isThirdParty() && !flashvars['delayload']) {
            //16位 16进制的数字
            //partner = "/partnerid/" + this._partnerId;
            urlParam.partnerid = this._partnerId;
        }

        var src = StaticDomain + '/player.php/';
        for (var k in urlParam) {
            var value = urlParam[k];
            if ('undefined' != typeof value && '' !== value) {
                src += k + '/' + value + '/';
            }
        }
        src += 'v.swf';

        // if (YK.initConfig.flashsrc) {
        //    src = YK.initConfig.flashsrc;
        // }

        if (YK.initConfig.events) {
            /**
             var onPlayerReady = YK.initConfig.events.onPlayerReady;
             if ('function' == typeof onPlayerReady && 'undefined' == typeof window.onPlayerReady) {
                window.onPlayerReady = function(obj) {
                    onPlayerReady(obj);
                }
            }*/

            var onPlayStart = YK.initConfig.events.onPlayStart;
            if ('function' == typeof onPlayStart && 'undefined' == typeof window.onPlayerStart) {
                window.onPlayerStart = function(obj) {
                    onPlayStart(obj);
                }
            }

            var onPlayEnd = YK.initConfig.events.onPlayEnd;
            if ('function' == typeof onPlayEnd && 'undefined' == typeof window.onPlayerComplete) {
                window.onPlayerComplete = function(obj) {
                    onPlayEnd(obj);
                }
            }

            var onPlay = YK.initConfig.events.onPlay;
            if ('function' == typeof onPlay && 'undefined' == typeof window.onPlay) {
                window.onPlay = function(obj) {
                    onPlay(obj);
                }
            }

            var onPause = YK.initConfig.events.onPause;
            if ('function' == typeof onPause && 'undefined' == typeof window.onPause) {
                window.onPause = function(obj) {
                    onPause(obj);
                }
            }

            var onWaiting = YK.initConfig.events.onWaiting;
            if ('function' == typeof onWaiting && 'undefined' == typeof window.onWaiting) {
                window.onWaiting = function(obj) {
                    onWaiting(obj);
                }
            }

            var onFullScreen = YK.initConfig.events.onFullScreen;
            if ('function' == typeof onFullScreen && 'undefined' == typeof window.onFullScreen) {
                window.onFullScreen = function(obj) {
                    onFullScreen(obj);
                }
            }

            var onPlayError = YK.initConfig.events.onPlayError;
            if ('function' == typeof onPlayError && 'undefined' == typeof window.onPlayerError) {
                window.onPlayerError = function(obj) {
                    var _code = obj.code || '1000';
                    if (_code == '4000') { //需要密码
                        return
                    }
                    onPlayError(obj.message || '播放出错', obj);
                }
            }

        }

        var param = {
            allowFullScreen: true,
            allowScriptAccess: "always",
            movie: src,
            flashvars: flashvars
        };

        if (YK.initConfig.wmode) {
            param.wmode = YK.initConfig.wmode;
        }
        var flashparam = YK.initConfig.flashparam;
        if (flashparam && 'object' == typeof flashparam) {
            for (var k in flashparam) {
                param[k] = flashparam[k];
            }
        }
        var flashtxt = "";
        for (var key in param) {
            var value = param[key];
            if ("object" == typeof value) {
                value = urlParameter(value);
            }
            flashtxt += '<param name=' + key + ' value=' + value + '>';
        }

        flashtxt += decodeURI(YK.initConfig.flashext || '');

        //flashvars = urlParameter(flashvars);
        //$(this._target).innerHTML =  "<embed id="+this._id+" src=" + src + " allowFullScreen=\"true\" quality=\"high\" width=100% height=100% align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\" flashvars="+flashvars+">";
        document.getElementById(this._target).innerHTML =
            "<object type=application/x-shockwave-flash data= " + src + " width=100% height=100% id=" + this._id + ">" +
                //"<param name=allowFullScreen value=true><param name=allowScriptAccess value=always><param name=movie value=" +
                //src + "><param name=flashvars value=" + flashvars + ">" +
                //    decodeURI(YK.initConfig.flashext || '')
            flashtxt +
            "</object>";
        if (this._expand) {
            document.getElementById(this._target).style.width = this._width + "px";
            document.getElementById(this._target).style.height = this._height + "px";
        }
    }
};

/**
 * 以下是统一的接口，用于外部统一操作 Flash 和 H5播放器
 *   直接传入参数进行初始化
 *    -- api document --
 *   //open.youku.com/docs/api/player
 *   用户名：api
 *   密码：youkuopenapi
 *
 */
YKU.Player = function(target, config) {
    config.target = target;
    this.select = new YoukuPlayerSelect(config);
    this.select.select();
    this._player = "";
};
YKU.Player.prototype = {
    player: function() {
        if (this._player != "") {
            return this._player;
        }
        if (YKP.playerType == "h5") {
            this._player = new YKH5Player(this.select._h5player);
        } else if (YKP.playerType == "flash") {
            this._player = new YKFlashPlayer();
        } else {
            this._player = "error";
        }
        return this._player;
    },
    //@deprecated
    resize: function(width, height) {
        this.player().resize(width, height);
    },
    currentTime: function() {
        return this.player().currentTime();
    },
    totalTime: function() {
        return this.player().totalTime();
    },
    playVideo: function() {
        this.player().playVideo();
    },
    startPlayVideo: function() {
        this.player().startPlayVideo();
    },
    pauseVideo: function() {
        this.player().pauseVideo();
    },
    seekTo: function(timeoffset) {
        this.player().seekTo(timeoffset);
    },
    hideControls: function() {
        this.player().hideControls();
    },
    showControls: function() {
        this.player().showControls();
    },
    /** mute:function(){},
     unmute:function(){},
     setVolume:function(){},
     getVideoMetaData:function(){},*/
    playVideoById: function(vid) {
        this.player().playVideoById(vid);
    },
    //special api for youku h5,not open api
    switchFullScreen: function() {
        try {
            this.player().switchFullScreen();
        } catch (e) {

        }

    }

};

var YKFlashPlayer = function() {
    this._player = document.getElementById(YKP.playerId);
};
YKFlashPlayer.prototype = {
    resize: function(width, height) {
        this._player.style.width = width + 'px';
        this._player.style.height = height + 'px';
    },
    currentTime: function() {
        var arr = this._player.getPlayerState().split("|");
        if (arr.length >= 3)
            return arr[2];
        else
            return -1;
    },
    totalTime: function() {
        var arr = this._player.getPlayerState().split("|");
        if (arr.length >= 4)
            return arr[3];
        else
            return -1;
    },
    playVideo: function() {
        this._player.pauseVideo(false);
    },
    pauseVideo: function() {
        this._player.pauseVideo(true);
    },
    seekTo: function(timeoffset) {
        this._player.nsseek(timeoffset);
    },
    playVideoById: function(vid) { //encoded vid  å­—ç¬¦ä¸²å½¢å¼çš„vid
        this._player.playVideoByID(vid);
    },
    hideControls: function() {
        this._player.showControlBar(false);
    },
    showControls: function() {
        this._player.showControlBar(true);
    },
    state: function() {
        this._player.state();
    }
};

/**
 * @param player  YoukuHTML5Player
 */
var YKH5Player = function(player) {

    this._player = player;
};
YKH5Player.prototype = {
    currentTime: function() {
        return this._player.currentTime;
    },
    totalTime: function() {
        return this._player.totalTime;

    },
    playVideo: function() {
        this._player.play();
    },

    pauseVideo: function() {
        this._player.pause();
    },

    seekTo: function(timeoffset) {
        try {
            //  this._player.currentTime = timeoffset;
            this._player.seek(timeoffset);
        } catch (e) {}
    }
};

/**
 * 执行javascript标签中的代码
 */
function executeScript(){
    var _scripts = document.getElementsByTagName("script"),_len = _scripts.length;
    for(var i = 0 ; i < _len ;i++){
        if(_scripts[i].src.indexOf("//player.youku.com/jsapi") > -1){
            eval(_scripts[i].innerHTML);
            break;
        }
    }
}
executeScript();