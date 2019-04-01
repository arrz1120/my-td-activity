/*20150520weizi添加*************/
var tdObj = new Object();
tdObj.key = '#@zstuandaijjmzfc!#';

//限制只能输入数字(不可以含有小数)
function limitInt(fn) {
    jQuery(fn).keydown(function (e) {
        // 注意此处不要用keypress方法，否则不能禁用　Ctrl+V 与　Ctrl+V,具体原因请自行查找keyPress与keyDown区分，十分重要，请细查
        if (((e.keyCode > 47) && (e.keyCode < 58)) || (e.keyCode == 9) || (e.keyCode == 8) || ((e.keyCode >= 96) && (e.keyCode <= 105))) {// 判断键值  
            return true;
        } else {
            return false;
        }

    }).focus(function () {
        this.style.imeMode = 'disabled';   // 禁用输入法,禁止输入中文字符
    });
}
//ios6以下加载后隐藏地址栏
window.onload = function () {
    if (document.documentElement.scrollHeight <= document.documentElement.clientHeight) {
        bodyTag = document.getElementsByTagName('body')[0];
        bodyTag.style.height = document.documentElement.clientWidth / screen.width * screen.height + 'px';
    }
    setTimeout(function () {
        window.scrollTo(0, 1)
    }, 0);
};

//获取2位小数，不四舍五入
function Round2(temp) {
    temp = temp.toString();
    if (temp.indexOf(".") > -1) {
        return temp.substring(0, temp.indexOf(".") + 3);
    }
    else {
        return temp;
    }
}

String.prototype.trim = function () {
    return this.replace(/(^\s*)|(\s*$)/g, "");
} 
String.prototype.replaceAll = function (AFindText, ARepText) {
    raRegExp = new RegExp(AFindText, "g");
    return this.replace(raRegExp, ARepText)
}


//验证整数（非负）
function checkInteger(obj)  //是非负整数返回：true,不是返回：false
{
    var reg = RegExp("^\\d+$");
    return reg.test(obj);
}

//验证浮点数(非负)
function checkFloat(obj) {//是非负浮点数返回：true,不是返回：false
    var reg = RegExp("^\\d+(\\.\\d+)?$");
    return reg.test(obj);
}

//金额格式化并保留指定的小数位
function fmoney(s, n) {
    n = n > 0 && n <= 20 ? n : 2;
    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
    var l = s.split(".")[0].split("").reverse(),
            r = s.split(".")[1];
    t = "";
    for (i = 0; i < l.length; i++) {
        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
    }
    return t.split("").reverse().join("") + "." + r;
} 

//判断cookie是否有登录凭证
function isCookieLogin() {
    var cookieValue = jaaulde.utils.cookies.get(".MTUANDAIAUTH");
    if (cookieValue != "" && cookieValue != null)
        return true;
    else {
        cookieValue = jaaulde.utils.cookies.get("tuandaiwexin");
        if (cookieValue != "" && cookieValue != null)
            return true;
        else
            return false;
    }
}
//用于数据传输加密
function fnStringJM2(s) {
    return des(tdObj.key, HexTostring(s), 0, 0);
}
function fnStringJM(s) {
    return stringToHex(des(tdObj.key, s, 1, 0));
} 
function stringToHex(s) { var r = ''; var hexes = new Array('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'); for (var i = 0; i < (s.length) ; i++) { r += hexes[s.charCodeAt(i) >> 4] + hexes[s.charCodeAt(i) & 0xf] } return r }
function HexTostring(s) { var r = ''; for (var i = 0; i < s.length; i += 2) { var sxx = parseInt(s.substring(i, i + 2), 16); r += String.fromCharCode(sxx) } return r }

$.isMobile = function (number) {
    var patTel = new RegExp("^(13|14|15|17|18)[0-9]{9}$", "i");
    return patTel.test(number);
}

$.isEmail = function (email) {
    var exp = /\w@\w*\.\w/
    return exp.test(email);
}
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}
//写cookies
function setCookie(name, value) {
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
}
//读取cookies 
function getCookie(name) {
    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");

    if (arr = document.cookie.match(reg))

        return unescape(arr[2]);
    else
        return null;
}
//删除cookies 
function delCookie(name) {
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval = getCookie(name);
    if (cval != null)
        document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
}