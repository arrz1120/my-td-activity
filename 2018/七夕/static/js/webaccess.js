/**
 * Created by wangyan on 2018/5/8.
 */

(function () {
    var ta = document.createElement('script');
    ta.type = 'text/javascript';
    ta.async = true;
    ta.src = ((("https:") == document.location.protocol) ? "https://" : "http://") + 'bilog.niiwoo.com/js/webaccess.js';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(ta, s);
})();

function maidian(userName, eventType, eventTag, event, status, statusType, statusMsg) {
    var from = /Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent) ? "TDW_WAP" : "TDW";
    /* 注意和需求沟通，那些是可以赋值为空*/
    nwbi_api.nwbi_logWebEvent(
        userName,      // string, 团贷网账户的用户名
        new Date(),   // string, 时间
        eventType,     // string, 事件类别，自定义,click,slide
        eventTag,     // string, 事件标签，自定义,神策事件标签
        event,       // string, 事件值，自定义，中文 页面-按钮名称
        status,        // int, 事件达成状态，1：成功；0：失败，没集满五福不能领红包之类的
        statusType,     // string, 失败原因类型
        statusMsg,       // string, 失败原因
        from        //  string, "TDW"-团贷网PC端；"TDW_WAP"-团贷网wap端
    )
}