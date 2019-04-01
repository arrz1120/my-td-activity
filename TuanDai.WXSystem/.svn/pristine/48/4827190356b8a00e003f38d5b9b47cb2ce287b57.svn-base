//马上 分享
var bd = document.getElementById("swiper-container");
var shareBut = document.getElementById("share_but");

var sharePopup = function(e) {
    if (!document.getElementById("shareTip")) {
        window.scrollTo(0, 0);
        var dom = document.createElement("div");
        dom.className = "modal-backdrop";
        dom.id = "shareTip";
        dom.innerHTML = '<div class="shareTip-cn"></div>';
        bd.appendChild(dom);
        dom.addEventListener("touchstart", clearShareTip, false);
    }
    return false;
};

function clearShareTip() {
    var hintTip = document.getElementById("shareTip");
    hintTip.removeEventListener("touchstart", clearShareTip, false);
    bd.removeChild(hintTip);
}
shareBut.onclick = sharePopup;



//图片的预加载
function _PreLoadImg(b, e) {
    var c = 0,
        a = {},
        d = 0;
    for (src in b) {
        d++;
    }
    for (src in b) {
        a[src] = new Image();
        a[src].onload = function() {
            if (++c >= d) {
                e(a)
            }
        };
        a[src].src = b[src];
    }
}

_PreLoadImg([
    'images/p1.jpg',
    'images/p2.jpg',
    'images/p3.jpg',
    'images/p4.jpg',
    'images/p5.jpg',
    'images/p6.jpg',
    'images/p7.jpg',
    'images/p8.jpg',
    'images/p9.jpg',
    'images/p10.jpg',
    'images/p11.jpg'
], function() {
    setTimeout(function() {
        var loader = document.getElementById('loading'),
            container = document.getElementById('swiper-container');
        swiper.slideTo(0, 1000, false);
        document.body.removeChild(loader);
        container.style.display = 'block';
    }, 2000);
});
var swiper = new Swiper('.swiper-container', {
    loop: false,
    direction: 'vertical',
    effect: 'slide',
    setWrapperSize: true,
    nextButton: '.next'
});

//音乐播放
$(".music").click(function() {
    if ($(".icon-music").attr("num") == "1") {
        $(".icon-music").removeClass("open");
        $(".icon-music").attr("num", "2")
        $(".music-span").css("display", "none");
        document.getElementById("aud").pause();
        $(".music_text").html("关闭");
        $(".music_text").addClass("show_hide");
        setTimeout(musicHide, 2000);
    } else {
        $(".icon-music").attr("num", "1");
        $(".icon-music").addClass("open");
        $(".music-span").css("display", "block");
        document.getElementById("aud").play();
        $(".music_text").html("开启");
        $(".music_text").addClass("show_hide");
        setTimeout(musicHide, 2000);
    }
    function musicHide() {
        $(".music_text").removeClass("show_hide");
    }
});




