
var SJSAnimateSequence = function(cf) {
    var t = this,
        defaults = {
            data: null,
            parent: null,
            w: 100,
            h: 100,
            pos: [0, 0],
            autoplay: false,
            loop: true,
            fps: 1000 / 12,
            onKeyframe: null,
            onComplete: null
        };
    t.apply(t, cf, defaults);
    t.idx = 0;
    t.len = t.data.length;
    var n = (t.loop) ? 0 : t.len;
    t.timer = new SJSTimer({
        onTimer: function() {
            t.onTick()
        },
        onComplete: function() {
            t.onTicked()
        },
        delay: t.fps,
        count: n
    });
    t.dom = $('<div style="width:' + t.w + 'px;height:' + t.h + 'px;overflow:hidden;position: absolute;top:' + t.pos[1] + ';left:' + t.pos[0] + ';">');
    t.parent.append(t.dom);
    for (var i = 0; i < t.len; i++) {
        var url = "";
        if (typeof(t.data[i]) == "string") {
            url = t.data[i]
        } else {
            url = t.data[i].src
        };
        t.dom.append('<img style="position:absolute;top:0;left:0;display:none;" src="' + url + '" />')
    };
    if (t.autoplay) {
        t.start()
    }
};
SJSAnimateSequence.prototype = {
    start: function() {
        var t = this;
        t.idx = 0;
        t.dom.children().eq(t.idx).show().siblings().hide();
        t.play()
    },
    play: function() {
        var t = this;
        t.timer.start()
    },
    pause: function() {
        var t = this;
        t.timer.stop()
    },
    stop: function() {
        var t = this;
        t.timer.stop();
        t.timer.reset();
        t.idx = 0
    },
    onTick: function(e) {
        var t = this;
        t.idx++;
        if (t.loop) {
            if (t.idx >= t.len) {
                t.idx = 0
            }
        };
        if (t.idx < t.len) {
            t.dom.children().eq(t.idx).show().siblings().hide();
            if (t.onKeyframe != null) {
                t.onKeyframe({
                    currentFrame: t.idx,
                    totalFrames: t.len
                })
            }
        }
    },
    onTicked: function(e) {
        var t = this;
        if (t.onComplete != null) {
            t.onComplete()
        }
    },
    apply: function(o, c, defaults) {
        if (defaults) {
            this.apply(o, defaults)
        };
        if (o && c && typeof c == 'object') {
            for (var p in c) {
                o[p] = c[p]
            }
        };
        return o
    },
    constructor: SJSAnimateSequence
};
var SJSBGMusic = function(cf) {
    var t = this,
        defaults = {
            idclose: null,
            idopen: null,
            musicurl: null,
            loop: "loop",
            pos: null
        };
    t.apply(t, cf, defaults);
    t.both = $(t.idopen + ", " + t.idclose);
    t.btnopen = $(t.idopen);
    t.btnclose = $(t.idclose);
    t.both.hide();
    t.both.css("position", "absolute");
    for (var s in t.pos) {
        t.both.css(s, t.pos[s])
    };
    var loop = "";
    if (t.loop == "loop") {
        loop = 'loop="loop"'
    };
    $("body").append('<audio id="sjs_bgmusic" src="' + t.musicurl + '" ' + loop + '></audio>');
    t.bgmusic = document.getElementById("sjs_bgmusic");
    t.btnopen.click(function() {
        t.pause()
    });
    t.btnclose.click(function() {
        t.play()
    })
};
SJSBGMusic.prototype = {
    start: function() {
        var t = this;
        t.play();
        document.addEventListener("touchstart", playMusic);

        function playMusic() {
            document.removeEventListener("touchstart", playMusic);
            t.play()
        }
    },
    play: function() {
        var t = this;
        t.btnclose.hide();
        t.btnopen.show();
        t.bgmusic.play()
    },
    pause: function() {
        var t = this;
        t.btnclose.show();
        t.btnopen.hide();
        t.bgmusic.pause()
    },
    apply: function(o, c, defaults) {
        if (defaults) {
            this.apply(o, defaults)
        };
        if (o && c && typeof c == 'object') {
            for (var p in c) {
                o[p] = c[p]
            }
        };
        return o
    },
    constructor: SJSBGMusic
};

function SJSTimer(cf) {
    var t = this,
        defaults = {
            onTimer: function() {},
            onComplete: function() {},
            delay: 1000,
            count: 0
        };
    t.currentCount = 0;
    t.timer = null;
    t.apply(t, cf, defaults)
}
SJSTimer.prototype = {
    start: function() {
        var t = this;
        t.timer = setTimeout(onTimer, t.delay);

        function onTimer() {
            t.onTick()
        }
    },
    onTick: function() {
        var t = this;
        t.currentCount++;
        t.onTimer({
            currentCount: t.currentCount,
            count: t.count
        });
        if (t.count > 0 && t.currentCount >= t.count) {
            t.onTicked()
        } else {
            t.timer = setTimeout(onTimer, t.delay)
        };

        function onTimer() {
            t.onTick()
        }
    },
    onTicked: function() {
        var t = this;
        t.stop();
        t.onComplete()
    },
    reset: function() {
        this.currentCount = 0
    },
    stop: function() {
        if (this.timer) {
            clearTimeout(this.timer)
        }
    },
    getCurrentCount: function() {
        return this.currentCount
    },
    apply: function(o, c, defaults) {
        if (defaults) {
            this.apply(o, defaults)
        };
        if (o && c && typeof c == 'object') {
            for (var p in c) {
                o[p] = c[p]
            }
        };
        return o
    },
    constructor: SJSTimer
};

var SJSMath = function() {
    var t = this;
    t.getScale = function(w, h, ow, oh, isInArea) {
        if (isInArea) {
            if (w / ow > h / oh) {
                return ow / w
            };
            return oh / h
        } else {
            if (w / ow > h / oh) {
                return oh / h
            };
            return ow / w
        }
    };
    t.getNextNum = function(len, _idx, n) {
        if (!n) {
            n = 1
        };
        var next = _idx + n;
        if (next <= len) {
            return next
        };
        return next - len
    };
    t.getPreNum = function(len, _idx, n) {
        if (!n) {
            n = 1
        };
        var pre = _idx - n;
        if (pre > 0) {
            return pre
        };
        return len + pre
    };
    t.towPointAngle = function(x1, y1, x2, y2) {
        var t = (y1 - y2) / (x1 - x2);
        var a = Math.atan(t) * 180 / Math.PI;
        if (x1 < x2) {
            a = 180 + a
        } else if (y1 < y2) {
            a = 360 + a
        };
        return int(a)
    };
    t.deg2rad = function(degrees) {
        return degrees * Math.PI / 180
    };
    t.rad2deg = function(radians) {
        return radians * 180 / Math.PI
    }
};
SJSMath.prototype = {
    constructor: SJSMath
};
var SJSArray = function() {
    var t = this;
    t.orderSearch = function(arr, key) {
        var n;
        arr.forEach(callback);

        function callback(element, i, arr) {
            if (element == key) {
                n = i + 1;
                return
            }
        };
        return ((n > 0) ? n - 1 : -1)
    };
    t.binarySearch = function(arr, key) {
        var low = 0,
            mid, high = arr.length - 1;
        while (low <= high) {
            mid = low + (high - low) / 2;
            if (arr[mid] < key) {
                low = mid + 1
            } else if (arr[mid] > key) {
                high = mid - 1
            } else {
                return mid
            }
        };
        return -1
    };
    t.arrayRandSort = function(arr) {
        var tarr = arr.slice();
        var temp, indexA, indexB, i = tarr.length;
        while (i) {
            indexA = i - 1;
            indexB = Math.floor(Math.random() * i);
            i--;
            if (indexA == indexB) {
                continue
            }
            temp = tarr[indexA];
            tarr[indexA] = tarr[indexB];
            tarr[indexB] = temp
        };
        return tarr
    };
    t.delRepeat = function(arr) {
        for (var i = 0; i < arr.length - 1; i++) {
            for (var j = i + 1; j < arr.length; j++) {
                if (arr[i] == arr[j]) {
                    arr.splice(j, 1);
                    i = 0
                }
            }
        }
        return arr
    };
    t.compare = function(arr1, arr2) {
        if (arr1.length != arr2.length) return false;
        for (var i = 0; i < arr1.length; i++) {
            if (arr1[i] != arr2[i]) return false
        };
        return true
    };
    t.searchMax = function(arr) {
        var low = 0,
            tnum = 0,
            getNum;
        while (low < arr.length) {
            getNum = Number(arr[low]);
            if (getNum * 0 == 0) {
                if (getNum > tnum) tnum = getNum
            };
            low++
        };
        return tnum
    };
    t.searchMin = function(arr) {
        var low = 0,
            tnum = 0,
            getNum;
        while (low < arr.length) {
            getNum = Number(arr[low]);
            if (getNum * 0 == 0) {
                if (getNum < tnum) tnum = getNum
            }
            low++
        };
        return tnum
    };
    t.delByIndex = function(n) {
        if (n < 0) {
            return this
        } else {
            return this.slice(0, n).concat(this.slice(n + 1, this.length))
        }
    }
};
SJSArray.prototype = {
    constructor: SJSArray
};
var SJSBrowser = function() {
    var u = navigator.userAgent,
        app = navigator.appVersion;
    return {
        isPC: chkPC(),
        isIOS: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),
        isAndroid: u.indexOf('Android') > -1,
        isWX: u.toLowerCase().indexOf('micromessenger') > -1,
        isYX: u.toLowerCase().indexOf('yixin') > -1,
        isPhone: u.indexOf('iPhone') > -1,
        isPad: u.indexOf('iPad') > -1,
        isWP: u.indexOf("Windows Phone") > -1,
        isSB: u.indexOf('SymbianOS') > -1,
        isPod: u.indexOf('iPod') > -1,
    };

    function chkPC() {
        var Agents = ["Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"];
        var flag = true;
        for (var v = 0; v < Agents.length; v++) {
            if (u.indexOf(Agents[v]) > 0) {
                flag = false;
                break
            }
        };
        return flag
    }
};
var SJSShake = function(cf) {
    var t = this,
        defaults = {
            callback: null,
            shake_threshold: 800,
            rateTime: 150
        };
    t.lastTime = 0;
    t.la = {
        x: 0,
        y: 0,
        z: 0
    };
    t.ca = {
        x: 0,
        y: 0,
        z: 0
    };
    t.pc = null;
    t.apply(t, cf, defaults)
};
SJSShake.prototype = {
    start: function() {
        var t = this;
        if (window.DeviceMotionEvent && !t.isPC()) {
            window.ondevicemotion = function(e) {
                t.onMotion(e)
            }
        } else {
            t.pc = setInterval(function(e) {
                t.onMotion({
                    accelerationIncludingGravity: {
                        x: Math.random() * 5000,
                        y: Math.random() * 5000,
                        z: Math.random() * 2500
                    }
                })
            }, 500)
        }
    },
    onMotion: function(eventData) {
        var t = this;
        var acceleration = eventData.accelerationIncludingGravity;
        var curTime = new Date().getTime();
        if (t.lastTime == 0) {
            t.lastTime = curTime;
            return false
        };
        var diffTime = (curTime - t.lastTime);
        if (diffTime > t.rateTime) {
            t.lastTime = curTime;
            t.ca.x = acceleration.x;
            t.ca.y = acceleration.y;
            t.ca.z = acceleration.z;
            if ((t.la.x == 0 && t.la.y == 0 && t.la.z == 0)) {
                t.la.x = t.ca.x;
                t.la.y = t.ca.y;
                t.la.z = t.ca.z;
                return
            }
            var speed = Math.abs(t.ca.x + t.ca.y + t.ca.z - t.la.x - t.la.y - t.la.z) / diffTime * 10000;
            if (speed > t.shake_threshold) {
                t.callback(speed)
            };
            t.la.x = t.ca.x;
            t.la.y = t.ca.y;
            t.la.z = t.ca.z
        }
    },
    stop: function() {
        if (window.DeviceMotionEvent) {
            window.ondevicemotion = function() {}
        };
        if (this.pc) {
            clearInterval(this.pc)
        }
    },
    isPC: function() {
        var userAgentInfo = navigator.userAgent;
        var Agents = ["Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"];
        var flag = true;
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) {
                flag = false;
                break
            }
        };
        return flag
    },
    apply: function(o, c, defaults) {
        if (defaults) {
            this.apply(o, defaults)
        };
        if (o && c && typeof c == 'object') {
            for (var p in c) {
                o[p] = c[p]
            }
        };
        return o
    },
    constructor: SJSShake
};

var SJSPreloadImg = function(obj) {
    var arr = obj.list;
    var onprogress = obj.progress;
    var onend = obj.end;
    var idx = 0,
        len = arr.length;
    var data = new Array();
    loadimg();

    function loadimg() {
        var img = new Image();
        img.onload = function() {
            data.push({
                img: img,
                path: arr[idx]
            });
            idx++;
            if (onprogress) onprogress({
                precent: Math.floor(idx / len * 100),
                idx: idx,
                total: len
            });
            if (idx >= len) {
                if (onend) {
                    onend(data)
                }
            } else {
                loadimg()
            }
        };
        img.src = (typeof(arr[idx]) == "string") ? arr[idx] : arr[idx].src
    }
};
SJSPreloadImg.prototype = {
    constructor: SJSPreloadImg
};

var SurtoJS = function() {
    var t = this;
    t.mousedown = "touchstart";
    t.mouseup = "touchend";
    t.mousemove = "touchmove";
    t.init = function(tw, th, serverURL) {
        if ((document.ontouchstart == null && _s.browser.isPC) || (!('ontouchstart' in window) && !_s.browser.isPC)) {
            mousedown = "mousedown";
            mouseup = "mouseup";
            mousemove = "mousemove"
        };
        t.tw = tw, t.th = th, t.serverURL = serverURL;
        t.sw = $(window).width();
        t.sh = $(window).height();
        t.ssmin = _s.gmath.getScale(t.tw, t.th, t.sw, t.sh, true);
        t.ssmax = _s.gmath.getScale(t.tw, t.th, t.sw, t.sh, false);
        t.ssh = _s.sh / _s.th;
        t.ssw = _s.sw / _s.tw;
        if (location.href.indexOf("localhost") > -1 || location.href.indexOf("192.168.") > -1) {
            t.isTest = true
        } else {
            t.isTest = false
        }
    };
    t.trace = function() {
        if (window.console && console.log) {
            console.log(arguments)
        }
    };
    t.traceObj = function(obj) {
        if (window.console && console.log) {
            console.log(JSON.stringify(obj))
        }
    };
    t.getYMHasDay = function(y, m) {
        var mday = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
        if ((y % 40 == 0 && y % 100 != 0) || y % 400 == 0) {
            mday[1] = 29
        };
        return mday[m - 1]
    };
    t.getAges = function(str) {
        var r = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
        if (r == null) return false;
        var birth = new Date(r[1], r[3] - 1, r[4]);
        if (birth.getFullYear() == r[1] && (birth.getMonth() + 1) == r[3] && birth.getDate() == r[4]) {
            var today = new Date();
            var age = today.getFullYear() - r[1];
            if (today.getMonth() > birth.getMonth()) {
                return age
            };
            if (today.getMonth() == birth.getMonth()) {
                if (today.getDate() >= birth.getDate()) {
                    return age
                } else {
                    return age - 1
                }
            };
            if (today.getMonth() < birth.getMonth()) {
                return age - 1
            }
        }
        return false
    };
    t.zoomDom = function(dom, s, origin) {
        if (!origin) origin = "center center";
        dom.css({
            "-webkit-transform": "scale(" + s + ")",
            "-moz-transform": "scale(" + s + ")",
            "-ms-transform": "scale(" + s + ")",
            "-transform": "scale(" + s + ")",
            "-webkit-transform-origin": origin,
            "-moz-transform-origin": origin,
            "-ms-transform-origin": origin,
            "-transform-origin": origin
        })
    };
    t.browser = t.chkBrowser();
    t.garray = new SJSArray();
    t.gmath = new SJSMath();
};
SurtoJS.prototype = {
    Shake: SJSShake,
    PreloadImg: SJSPreloadImg,
    BGMusic: SJSBGMusic,
    JTimer: SJSTimer,
    AnimateSequence: SJSAnimateSequence,
    chkBrowser: function() {
        var t = this;
        if (!t.browser) {
            t.browser = SJSBrowser()
        };
        return t.browser
    },
    constructor: SurtoJS
};
var _s = new SurtoJS();