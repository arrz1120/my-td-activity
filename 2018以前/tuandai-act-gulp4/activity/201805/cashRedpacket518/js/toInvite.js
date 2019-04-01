(function() {

    var vtitle = '【' + RealName + '】邀请你一起瓜分现金红包！';
    var vcontent = RealName + '说“瓜分到的现金红包可以提现哦，名额有限，速来！”';
    var icoUrl = Globals.HDActivityWebsiteUrl+"/201804/20180425gfhb/weixin/images/shareLogo.jpg";    
    var shareUrl = Globals.HDActivityWebsiteUrl + "/201804/20180425gfhb/weixin/landing.aspx?extendKey=" + ExtendKey;

    appShare.set({
        icon: icoUrl,
        title: vtitle,
        content: vcontent,
        shareUrl: shareUrl,
        cover: {
            src: './images/wxShare.png',
            style: {
                width: '12rem',
                display: 'block',
                margin: '0 0 0 1.5rem'
            }
        },
        callback: function () {}
    })
    $(".to-invite").on("click", function () {
        appShare.show()
    })
})();