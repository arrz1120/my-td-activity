var ShareObj = {
    projecttitle: "项目标题",
    projectrate: "12.4",
    projectdeadline: "3",
    projectdeadtype:"1",
    wxsharetitle: "微信分享标题",
    wxsharedesc: "微信分享描述",
    shareurl:"http://m.tuandai.com"
}

wxData.isWxJsSDK = true;
wxData.debug = false;
wxData.img_url = "http://m.tuandai.com/imgs/sharelogo.png?v=20160407";
wxData.ShareCallBack = function (res) {
    if (res == "success") {
        clearShareTip();
    }
};
wxData.BeforeShareCall = function (res) {
    wxData.title = ShareObj.wxsharetitle;
    wxData.desc = ShareObj.wxsharedesc; 
    try {
        if (res == "wxfriend") { 
            nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'DetailWX', 'wx分享', '160331', 1, '', '', 'TDW_WX');
        } else if (res == "wxtimeline") {  
            nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'DetailWXFriendster', 'wx朋友圈', '160331', 1, '', '', 'TDW_WX');
        } else if (res == "qq") { 
            nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'Detailqq', 'QQ分享', '160331', 1, '', '', 'TDW_WX');
        } else if (res == "qqzone") { 
            nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'DetailQzone', 'QQ空间分享', '160331', 1, '', '', 'TDW_WX');
        }
    } catch (ex) { }
    wxData.url = ShareObj.shareurl;
}

var isWeiXin = navigator.userAgent.toLowerCase().indexOf("micromessenger") != -1;
var bd = document.body;

/*标详情页分享*/
$(function () { 
    loadHtml();  
    //	分享层交互
    $(".btn-share").click(function () {
        $("#dvsharetitle").html(ShareObj.projecttitle);
        var rateStr = getFloatDivideStr(ShareObj.projectrate, 1) + "<span>" + getFloatDivideStr(ShareObj.projectrate, 2) + "%</span>";
        $("#dvsharerate").html(rateStr);
        $("#dvsharedeadline").html(ShareObj.projectdeadline + (ShareObj.projectdeadtype == "1" ? "个月" : "天")); 


        $('.share-popup').addClass('current').bind("touchmove", function (e) {
            e.preventDefault();
        });
        $('.share-links a').addClass('bounceInUp');
        $('.close-share').addClass('bounceInUp');
    });
    $('.close-share').click(function () {
        $('.share-popup').removeClass('current');
        $('.share-links a').removeClass('bounceInUp');
        $('.close-share').removeClass('bounceInUp');
    });

    $('.wxShare').click(function () {
        sharePopup();
    });

    //	点击分享按钮 
    if (isWeiXin) {
        $(".wxShare").show();
        $(".webShare").hide();
    }
});
function getFloatDivideStr(rate, flag) {
    if (flag == 1) {
        if ((rate % 1) == 0)
            return  parseFloat(rate).toFixed(0);
        else
            return rate.substring(0, rate.indexOf("."));
    }
    if ((rate % 1) == 0) {
        return "";
    }
    return ("." + parseFloat(rate).toFixed(2).substr(rate.indexOf(".")+1,10) );
}

function sharePopup() {
    if (isWeiXin) {
        if (!document.getElementById("shareTip")) {
            window.scrollTo(0, 0);
            var dom = document.createElement("div");
            dom.className = "modal-backdrop";
            dom.id = "shareTip";
            dom.innerHTML = '<div class="shareTip-box"><div class="shareTip"></div></div>';
            bd.appendChild(dom);
            dom.addEventListener("touchstart", clearShareTip, false);
        }
        return false;
    }
}
function clearShareTip() {
    var hintTip = document.getElementById("shareTip");
    hintTip.removeEventListener("touchstart", clearShareTip, false);
    bd.removeChild(hintTip);
}

function share(t) {
    var p = {
        url:ShareObj.shareurl,
        showcount: '0',/*是否显示分享总数,显示：'1'，不显示：'0' */
        desc: ShareObj.wxsharedesc,/*默认分享理由(可选)*/
        summary: '团贷网（tuandai.com）,中国领先的互联网理财平台，超低门槛，期限7天-24个月任选，现在注册就送388元红包',/*分享摘要(可选)*/
        title: ShareObj.wxsharetitle,/*分享标题(可选)*/
        site: '团贷网',/*分享来源 如：腾讯网(可选)*/
        pics: 'http://m.tuandai.com/imgs/sharelogo.png?v=20160407' /*分享图片的路径(可选)*/
    };
    var s = [];
    for (var i in p) {
        s.push(i + '=' + encodeURIComponent(p[i] || ''));
    }
    var params = s.join('&');
    if (t == 1) {
        nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'DetailQzone', 'QQ空间分享', '160331', 1, '', '', 'TDW_WX');
        window.open("http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?" + params);
    }
    else {
        nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'Detailqq', 'QQ分享', '160331', 1, '', '', 'TDW_WX');
        window.open("http://connect.qq.com/widget/shareqq/index.html?" + params);
    }
};

function shareSina() {
    var p = {
        url: ShareObj.shareurl,
        title: ShareObj.wxsharetitle,
        appkey: '1343713053',
        pic: 'http://m.tuandai.com/imgs/sharelogo.png?v=20160407',
        searchPic: "true"
    };
    var s = [];
    for (var i in p) {
        s.push(i + '=' + encodeURIComponent(p[i] || ''));
    }
    var params = s.join('&');
    params += "#_loginLayer_" + (new Date()).valueOf();
    nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'Detailsina', '新浪分享', '160331', 1, '', '', 'TDW_WX');
    window.open("http://service.weibo.com/share/share.php?" + params);
}

function loadHtml() {
    var html =
        "<!--分享滑出层-->" +
        "<div class='share-popup pos-f'>" +
        "	<div class='ml15 mr15 top bg-fff mt40 pos-r'>" +
        "		<span class='by-l pos-a'></span>" +
        "		<span class='by-r pos-a'></span>" +
        "		<h3 class='text-center pos-r f17px' id='dvsharetitle'>xxxxxx</h3>" +
        "		<div class='webkit-box pt13 pb15'>" +
        "			<div class='box-flex1 text-center'>" +
        "				<p class='c-fd6040 f27px'  id='dvsharerate'>xxxxxx</p>" +
        "				<p class='c-ababab f12px'>参考年回报率</p>" +
        "			</div>" +
        "			<div class='box-flex1 text-center'>" +
        "				<p class='c-212121 f14px'  id='dvsharedeadline'>xxxxxx个月</p>" +
        "				<p class='c-ababab f12px'>计划期限</p>" +
        "			</div>" +
        "		</div>" +
        "	</div>" +
        "	<div class='mid text-center'>" +
        "		<span class='bb-d1d1d1'></span>" +
        "		<span class='c-212121 f15px'>分享到</span>" +
        "		<span class='bb-d1d1d1'></span>" +
        "	</div>" +
        "	<div class='share-links webkit-box ml15 mr15'>" +
        "		<a href='javascript:void(0);' class='wechat box-flex1 wxShare animated' style='display: none'><span><i></i></span>微信好友</a>  " +
        "		<a href='javascript:void(0);' class='moments box-flex1 wxShare animated' style='display: none'><span><i></i></span>朋友圈</a> " +
        "		<a href='javascript:shareSina();' class='weibo box-flex1 webShare animated' ><span><i></i></span>新浪微博</a>" +
        "		<a href='javascript:share(2);' class='qq box-flex1 animated'><span><i></i></span>QQ</a>" +
        "		<a href='javascript:share(1);' class='qzone box-flex1 animated'><span><i></i></span>QQ空间</a>" +
        "	</div>" +
        "	<a href='javascript:void(0);' class='close-share animated'><i></i></a>" +
        "</div>";

    $('#bigDiv').append(html);
}

