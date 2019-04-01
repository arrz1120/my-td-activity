//修改样式版本号
//$(function () {
//    var links = document.getElementsByTagName('head')[0].getElementsByTagName('link');
//    for (var i = 0; i < links.length; i++) {
//        if (links[i].getAttribute("rel") == "stylesheet") {
//            var csshref = links[i].getAttribute('href');
//            if (csshref.indexOf("base.css") != -1) {
//                links[i].setAttribute("href", "/css/base.css?v=20150909001");
//            }
//        }
//    }
//});   

function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
    return currentdate;
}

function getCookie(c_name) {
    if (document.cookie.length > 0) {
        c_start = document.cookie.indexOf(c_name + "="); //这里因为传进来的的参数就是带引号的字符串，所以c_name可以不用加引号
        if (c_start != -1) {
            c_start = c_start + c_name.length + 1;
            c_end = document.cookie.indexOf(";", c_start); //当indexOf()带2个参数时，第二个代表其实位置，参数是数字，这个数字可以加引号也可以不加（最好还是别加吧）
            if (c_end == -1) c_end = document.cookie.length;
            return unescape(document.cookie.substring(c_start, c_end));
        }
    }
    return null;
}
var CookieHelper = {
    //写cookies
    setCookie: function (name, value, days, domain) {
        var Days =days==null? 30:days;
        var exp = new Date();
        exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
        var cookieSet = name + "=" + encodeURIComponent(value) + ";expires=" + exp.toGMTString() + ";path=/";
        if (domain != "" && domain != undefined && domain != null)
            cookieSet += ";domain=" + domain;
        document.cookie = cookieSet; 
    },

    //获取Cookie
    getCookie: function (name) {
        var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");

        if (arr = document.cookie.match(reg))

            return unescape(arr[2]);
        else
            return "";
    },
    //删除cookies 
    delCookie: function (name) {
        var exp = new Date();
        exp.setTime(exp.getTime() - 1);
        var cval = getCookie(name);
        if (cval != null)
            document.cookie = name + "=" + encodeURIComponent(cval) + ";expires=" + exp.toGMTString() + ";path=/";
    }
}
 
//判断cookie是否有登录凭证
function base_isCookieLogin() {
    var cookieValue = getCookie(".MTUANDAIAUTH");
    if (cookieValue != "" && cookieValue != null)
        return true;
    else {
        cookieValue = getCookie("tuandaiwexin"); 
        if (cookieValue != "" && cookieValue != null)
            return true;
        else
            return false;
    }
}

//返回时间间隔的天数 两个参数均为时间字符串格式
function GetDateDiff(startDate, endDate) {
    var startTime = new Date(Date.parse(startDate.replace(/-/g, "/"))).getTime();
    var endTime = new Date(Date.parse(endDate.replace(/-/g, "/"))).getTime();
    var dates = Math.abs((startTime - endTime)) / (1000 * 60 * 60 * 24);
    return dates;
}

function isWeiXin() {
    var ua = window.navigator.userAgent.toLowerCase();
    if (ua.match(/MicroMessenger/i) == 'micromessenger') {
        return true;
    } else {
        return false;
    }
}
//导航菜单菜单 
$(function () { 
    $(".header-list-icon").click(function () {
        $(".list-nav").toggleClass("nav-height");
        $(".layer").toggleClass("block").bind("touchmove", function (e) {
            e.preventDefault();
        });
    });

    $('.layer').click(function () {
        $(".list-nav").toggleClass("nav-height");
        $(this).toggleClass("block");
    });

    $(".list-nav a").click(function () {
        $(".list-nav").toggleClass("nav-height");
        $(".layer").toggleClass("block");
    });
    //隐藏顶部导航条  
    var header = $(".headerMain");
    if (header.find('.list_nav').html() == undefined && header.find('.header-tab').html() == undefined) {
        header.hide();
    };
    //控制侧边导航底部距离
    var detailDialog = $("#bigDiv");
    if (detailDialog.html()!= undefined) {
        var newInvestBtn = $(".btn-joinNow"); 
        if (newInvestBtn.html() != undefined) {
            $(".float-jump").css({ bottom: "43px" });
        } else {
            $(".float-jump").css({ bottom: "57px" });
        }
    } 
});

var nwbi_userName = "";
var nwbi_sysNo = "";
if (isWeiXin()) {
    nwbi_sysNo = "TDW_WX";
}
else {
    nwbi_sysNo = "TDW_WAP";
}
var IsLogin = base_isCookieLogin();
if (IsLogin) {
    var nickname = getCookie("TDW_WapUserName");
    nwbi_userName = nickname;
}
(function () {
    var ta = document.createElement('script'); ta.type = 'text/javascript'; ta.async = true;
    ta.src = ((("https:") == document.location.protocol) ? "https://" : "http://") + 'bilog.niiwoo.com/js/webaccess.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ta, s);
})();

var _hmt = _hmt || [];
(function () {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?6dff67da4e4ef03cccffced8222419de";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();

(function () {
    var ta = document.createElement('script'); 
    ta.type = 'text/javascript';
    ta.async = true;
    ta.src =  'https://pingjs.qq.com/h5/stats.js';  
    ta.setAttribute("name","MTAH5");
    ta.setAttribute("sid","500289179");
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(ta, s);
})(); 

//按压反馈
function clickRespond(ele,style){
	$(ele).on('touchstart',function(){
		$(this).addClass(style);
	}).on('touchend',function(){
		$(this).removeClass(style);
	}).on('touchmove',function(){
		$(this).removeClass(style);
	})
}
clickRespond(".click-respond",'respond-style');
clickRespond(".click-respond2", 'respond-style2');

$(function () {
    //隐藏页面加载时进度条
    setTimeout(function () { $("#cMloading").fadeOut(100); }, 500);
});

//以用动画效果显示弹框
function showAniFadeIn(ele) {  //参数ele可以为jQuery选择器如$("#commalert")或Dom字符串标识符如"#commalert"
    var divPopTips = null;
    if (ele.constructor === String) {
        divPopTips = $(ele);
    } else {
        divPopTips = ele;
    }
        
    if ($(divPopTips.find("#alertCon")).length <= 0 && $(divPopTips.find(".comonAni")).length <= 0) {//当前divPopTips下
        divPopTips.fadeIn(300);
    } else {     
        divPopTips.show();
        divPopTips.find('.alert').removeClass('aniFadeOut').addClass('aniFadeIn');
        if ($(divPopTips.find("#alertCon")).length > 0) {
            $(divPopTips.find("#alertCon")).removeClass('aniHide').addClass('aniShow');
        }
        if ($(divPopTips.find(".comonAni")).length > 0)
        {
            $(divPopTips.find(".comonAni")).removeClass('aniHide').addClass('aniShow');
        }    
    }
}
//以动画效果关闭弹框
function hideAniFadeOut(ele) { //参数ele可以为jQuery选择器如$("#commalert")或Dom字符串标识符如"#commalert"
    var divPopTips = null;
    if (ele.constructor === String) {
        divPopTips = $(ele);
    } else {
        divPopTips = ele;
    }
    if ($(divPopTips.find("#alertCon")).length <= 0 && $(divPopTips.find(".comonAni")).length <= 0) {
        divPopTips.fadeOut(300);
    } else {
        divPopTips.find('.alert').removeClass('aniFadeIn').addClass('aniFadeOut');
        if ($(divPopTips.find("#alertCon")).length > 0)
            $(divPopTips.find("#alertCon")).removeClass('aniShow').addClass('aniHide');
        if ($(divPopTips.find(".comonAni")).length > 0)
            $(divPopTips.find(".comonAni")).removeClass('aniShow').addClass('aniHide');
        setTimeout(function () {
            divPopTips.hide();
        }, 400);
    }
}
