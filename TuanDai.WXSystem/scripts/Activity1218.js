var TheActivityUrl = "http://hd.tuandai.com/weixin/20151218s/Index.aspx";

var isShowPop = false;
//返回时间格式为2015-12-18
function FormatDate(date) {
    return date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
}

$(function () { 
    TheActivityUrl = Activity1218Url;
    if (TheActivityUrl == undefined || TheActivityUrl == "") {
        var theDay = FormatDate(new Date());
        if (theDay < "2015-12-18") {
            TheActivityUrl = "http://hd.tuandai.com/weixin/20151218s/DreamIndex.aspx";
        } 
        if (theDay == "2015-12-18") {
            TheActivityUrl = "http://hd.tuandai.com/weixin/20151218s/Index.aspx";
        }
    }
    getPopDivHtml();
    $(".alert").click(function () { 
        if ($(this).attr('btn') != "1") {
            $(this).hide();
            isShowPop = false;
        }
    });
    $(".alert-btn").click(function () {
        $("#popFriendJiaXi").hide();
        isShowPop = false;
    });
    if (chkIsHomePage()) {
        //1218提示活动
        showDay1218Tips();
    }
    //加息提示
    showJiaXiTips();
});
function chkIsHomePage() {
    var url = document.location.href.toLowerCase();
    url = url.replace("http://", "");
    url = url.replace("https://", ""); 
    if (url == "m.tuandai.com" || url == "weixin.hao8dai.com" || url == "weixin.hao8dai.com/" || url == "m.tuandai.com/")
        return true;
    if (url.indexOf("m.tuandai.com/index.aspx") >= 0 || url.indexOf("weixin.hao8dai.com/index.aspx") >= 0)
        return true;
    if (url.indexOf("m.tuandai.com/weixinindex.aspx") >= 0 || url.indexOf("weixin.hao8dai.com/weixinindex.aspx") >= 0)
        return true;
    if (url.indexOf("m.tuandai.com/member/my_account.aspx") >= 0 || url.indexOf("weixin.hao8dai.com/member/my_account.aspx") >= 0)
        return true;
    return false;
}

function getPopDivHtml() {
    var html = "";
    //邀请成功加息券弹框
    html = '<div class="alert bg-opacity03 hide" id="popFriendJiaXi" btn="0">' +
           '<div class="alert-wp">' +
           '<div class="alert-txt mt145">' +
           '    <p>您邀请的好友<span id="spFriendName">某某某</span>已成功</p>' +
           '    <p>投资满<span>300</span>元，<span id="spFriendRate">2%</span>加息奖励已为您发放。</p>' +
           '    <p>12.18，一起来加息吧！</p>' +
           '   </div>' +
           '    <div class="alert-btn">确定</div>' +
           '   </div>' +
           '   </div>';
    //加息弹框 
    html += ' <div class="alert bg-opacity03 hide" btn="0" id="popV3JiaXi">' +
            ' <div class="alert-wp">' +
            '   <div class="alert-txt mt120">' +
            '       <div class="jxTips">' +
            '           <h2>恭喜亲！</h2>' +
            '           <p class="mt5">您已获得团贷VIP<span>1%</span>加息特权</p>' +
            '       </div>' +
            '   </div>' +
            '   <div class="text-center f10px mt10 c-fd522f">' +
            '       12月18日当天投资指定项目，加息不停！' +
            '   </div>' +
            '   <div class="alert-btn" onclick="window.location.href=\'/Member/UserPrize/Index.aspx\'">去团宝箱查看</div>' +
            ' </div>' +
            ' </div>';

    //活动预热弹框
    html += ' <div class="alert bg-opacity07 hide" id="popPreActivity"  btn="0">' +
            ' <div class="go t65">' +
            '       <img class="w75p" src="/imgs/images/go.png" alt="">' +
            '       <a href="' + TheActivityUrl + '" class="go_btn"></a>' +
            '   </div>' +
            '</div>';

    //当天活动弹框
    html += '<div class="alert bg-opacity07 hide" id="popCurActivity"  btn="0">' +
            '<div class="alert_box">' +
            '       <div class="go">' +
            '           <img class="w90p ml30" src="/imgs/images/mscj.png?v=20151218001" alt="">' +
            '           <a href="' + TheActivityUrl + '" class="go_btn"></a>' +
            '       </div>' +
            '   </div>' +
            '</div>';
    $(document.body).append(html);
}



function setPopIsShowed(popType) {
    $.ajax({
        type: "post",
        async: true,
        url: "/ajaxCross/ajax_Acticity.ashx",
        data: { cmd: "Set1218PopIsShowed", PopType: popType },
        dataType: "json",
        timeout: 3000,
        success: function (json) { 
        },
        error: function () {
        }
    });
}
//1218前及当天活动弹框
function showDay1218Tips() {
    var myDate2 = new Date(); 
    if (new Date('2015/12/11 00:00:00') <= myDate2 && myDate2 <new Date('2015/12/18 00:00:00')) {
        var today = myDate2.toLocaleDateString();
        var td1218InfoActivityTip = jaaulde.utils.cookies.get("td1218InfoActivityTip");
        if (td1218InfoActivityTip == "" || td1218InfoActivityTip == null) {//每天记录弹框   
            jaaulde.utils.cookies.set("td1218InfoActivityTip", today, { hoursToLive: 8760 });
            $("#popPreActivity").show();
            isShowPop = true;
        }
        else if (td1218InfoActivityTip != today) {//有记录，不等于当天,弹框 
            jaaulde.utils.cookies.set("td1218InfoActivityTip", today, { hoursToLive: 8760 });
            $("#popPreActivity").show();
            isShowPop = true;
        }
    }
    var theDay = FormatDate(new Date());
    if (theDay=="2015-12-18") {
        var isCur1218Day = jaaulde.utils.cookies.get("td1218CurrentActivityTip");
        if (isCur1218Day == "" || isCur1218Day == null) { 
            jaaulde.utils.cookies.set("td1218CurrentActivityTip", "1", { hoursToLive: 8760 });
            $("#popCurActivity").show();
            isShowPop = true;
        }
    }
}
function showJiaXiTips() { 
    //判断是否领取银级奖品或者推荐好友开始
    var myDate = new Date();
    if (isShowPop==false && myDate <= new Date('2015/12/18 23:59:59')) {
        //判断是否有V3等级
        var cookietd1218InfoV3Tips = jaaulde.utils.cookies.get("td1218InfoV3Tips");
        if (cookietd1218InfoV3Tips != "" && cookietd1218InfoV3Tips != null) {
            //判断是否显示过
            var hadShowed = jaaulde.utils.cookies.get("td1218InfoV3TipsHadShowed");
            var tipsUserName = jaaulde.utils.cookies.get("TDWUserName");
            if ((hadShowed == "" || hadShowed == null) && hadShowed != tipsUserName) {
                jaaulde.utils.cookies.set("td1218InfoV3TipsHadShowed", tipsUserName, { hoursToLive: 8760 });
                $("#popV3JiaXi").show();
                isShowPop = true;
                setPopIsShowed(1);
            }
        }
        //是否需要显示推荐好友得到加息券
        var cookietd1218InfoPromotionTips = jaaulde.utils.cookies.get("td1218InfoPromotionTips");
        if (cookietd1218InfoPromotionTips != "" && cookietd1218InfoPromotionTips != null) {
            //判断是否显示过
            var promotionhadShowed = jaaulde.utils.cookies.get("td1218InfoPromotionTipsHadShowed");
            var tipsUserName = jaaulde.utils.cookies.get("TDWUserName");
            if ((promotionhadShowed == "" || promotionhadShowed == null) && promotionhadShowed != tipsUserName) {
                jaaulde.utils.cookies.set("td1218InfoPromotionTipsHadShowed", tipsUserName, { hoursToLive: 8760 });

                var objTips = cookietd1218InfoPromotionTips.toString().split('_');
                var friendName = objTips[1];
                var ratePercent = objTips[2];
                $("#spFriendName").html(friendName);
                $("#spFriendRate").html(ratePercent + "%");
                $("#popFriendJiaXi").show();
                isShowPop = true;
                setPopIsShowed(3);
            }
        }
    }
}