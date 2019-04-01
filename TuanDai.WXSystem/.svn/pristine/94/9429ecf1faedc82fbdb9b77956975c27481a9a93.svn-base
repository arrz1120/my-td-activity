var curScale = 1;
$(function () {
    $('#seek-but').click(function (e) {
        $(".page1").hide();
        $(".upload-wrap").show();
    });
    //播放音乐控制
    var audio = $("#media");
    document.addEventListener('touchstart', function () {
        if ($("#music").hasClass("pause")) {
            return;
        }
        audio.get(0).play();
    });

    $(".audio-btn").on('click', function (e) {
        if (!audio) {
            audio = $("#media");
        }
        if ($("#music").hasClass("play")) {
            $("#music").removeClass("play").addClass("pause");
            audio.get(0).pause();
        } else {
            $("#music").removeClass("pause").addClass("play");
            audio.get(0).play();
        }
    });
    //点击领取圆梦秘藉
    $("#btnGoToWealth").click(function () {
        $(".result-box").hide();
        $(".cheats-box").show();
    });

    //重新上传
    $(".again").click(function () {
        eidtor.clear();
        if (eidtor.imgs != undefined)
            eidtor.imgs = [];
        curScale = 1;
        $("#myFile").click();
    });

    //保存头像
    $(".confirm").on('click', function (e) {
        StartSeekLover();
    });
    //放大图片
    $("#btnZoomMax").click(function () {
        if (eidtor.imgs != undefined && eidtor.imgs.length > 0) {
            curScale += 0.2;
            eidtor.imgs[0].scaleX = curScale;
            eidtor.imgs[0].scaleY = curScale;
        }
    });
    //缩小图片
    $("#btnZoomMin").click(function () {
        if (eidtor.imgs != undefined && eidtor.imgs.length > 0) {
            if (curScale > 0)
                curScale -= 0.2;
            else
                curScale = 0;
            eidtor.imgs[0].scaleX = curScale;
            eidtor.imgs[0].scaleY = curScale;
        }
    });
});

//上传头像,配速情人
function StartSeekLover() { 
    if (eidtor.imgs==undefined|| eidtor.imgs.length == 0) {
        alert("您还未选择图片哦!");
        return;
    } 
    $(".page1").hide();
    $(".upload-wrap").hide();
    $(".load-box").show();
    setTimeout(uploadFile, 2000);
}
//Save Image
function uploadFile() {
    eidtor.toDataURL(function (base64) {
        var clearBase64 = base64.substr(base64.indexOf(',') + 1);
        $.ajax({
            type: 'POST',
            url: "GuidPage.aspx/SeekMyLover",
            contentType: "application/json; charset=utf-8",
            data: "{'base64Img':'" + clearBase64 + "'}",
            dataType: 'json',
            error: function (data, status, e) {
                alert("您好，上传失败，请重试！");
                $(".upload-wrap").show();
                $(".load-box").hide();
            },
            success: function (data) {
                var json = $.parseJSON(data.d);
                if (json.result == "1") {
                    $(".load-box").hide();
                    wxData.desc = "我的梦中情人竟然是“" + json.LoverName + "”";
                    $("img[id$='imgLoverTitle']").attr("src", "imgs/renwu/" + json.LoverImage + "-t.png?v=" + (new Date()).getTime());
                    $("img[id$='imgLover']").attr("src", "imgs/renwu/" + json.LoverImage + ".png?v=" + (new Date()).getTime());
                    $("img[id$='imgSelf']").attr("src", json.HeadImage + "?v=" + (new Date()).getTime());
                    $("#pBeautyMark").html("养颜指数" + getStarHtml(json.BeautyMark));
                    $("#pMatchMark").html("般配指数" + getStarHtml(json.MatchMark));
                    if ("波多野结衣,赵雅芝,朱茵,苍井空,林志玲,范冰冰,凤姐".indexOf(json.LoverName) != -1)
                        $("#pMarry").html("待你腰缠万贯，再娶我可好");
                    else
                        $("#pMarry").html("待你腰缠万贯，再嫁我可好");
                    $(".result-box").show();
                } else {
                    alert(json.msg);
                    $(".upload-wrap").show();
                    $(".load-box").hide();
                }
            }
        });
    });
}
//获取星星数
function getStarHtml(num) {
    if (num == 0) {
        return '<span class="xin3"></span><span class="xin3"></span><span class="xin3"></span><span class="xin3"></span><span class="xin3"></span>';
    } 
    var vHtml = "";
    for (var i = 1; i <= 5; i++) { 
        if (getStarIndex(num) == i) {
            if (num % 2 == 0)
                vHtml += '<span class="xin1"></span>';
            else
                vHtml += '<span class="xin2"></span>';
        } else {
            if (getStarIndex(num) > i)
                vHtml += '<span class="xin1"></span>';
            else
                vHtml += '<span class="xin3"></span>';
        }
    }
    return vHtml;
}
function getStarIndex(num) {
    if (num % 2 == 0)
        return num / 2;
    else
        return parseInt(num / 2) + 1
}


//====================================
/**
* 获得base64
* @param {Object} obj
* @param {Number} [obj.width] 图片需要压缩的宽度，高度会跟随调整
* @param {Number} [obj.quality=0.8] 压缩质量，不压缩为1
* @param {Function} [obj.before(this, blob, file)] 处理前函数,this指向的是input:file
* @param {Function} obj.success(obj) 处理后函数
* @example
*
*/
$.fn.localResizeIMG = function (obj) { 
    
    /**
    * 生成base64
    * @param blob 通过file获得的二进制
    */
    function _create(blob) {
        var img = new Image();
        img.src = blob; 
        img.onload = function () {
            var that = this; 

            //生成比例
            var w = that.width,
                    h = that.height,
                    scale = w / h;
            w = obj.width || w;
            h = w / scale;

            //生成canvas
            var canvas = document.createElement('canvas');
            var ctx = canvas.getContext('2d');
            $(canvas).attr({
                width: w,
                height: h
            });
            ctx.drawImage(that, 0, 0, w, h);

            /**
            * 生成base64
            * 兼容修复移动设备需要引入mobileBUGFix.js
            */
            var base64 = canvas.toDataURL('image/jpeg', obj.quality || 0.8);

            // 修复IOS
            if (navigator.userAgent.match(/iphone/i)) {
                var mpImg = new MegaPixImage(img);
                mpImg.render(canvas, {
                    maxWidth: w,
                    maxHeight: h,
                    quality: obj.quality || 0.8
                });
                base64 = canvas.toDataURL('image/jpeg', obj.quality || 0.8);
            }

            // 修复android
            if (navigator.userAgent.match(/Android/i)) {
                var encoder = new JPEGEncoder();
                base64 = encoder.encode(ctx.getImageData(0, 0, w, h), obj.quality * 100 || 80);
            }

            // 生成结果
            var result = {
                base64: base64,
                clearBase64: base64.substr(base64.indexOf(',') + 1)
            };

            // 执行后函数
            obj.success(result);
        };
    }
    _create($('.hidden-image-data').val());
};