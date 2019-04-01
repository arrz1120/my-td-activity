var SelfGodName = ""; //自已做的财神爷名称

function showPop(e) { $(e).fadeIn() }
function hidePop(e) { $(e).fadeOut() }

$(function () {
    //规则和正文内容的切换
    $(".ruleText").on("tap", function () {
        $("#main").addClass('visited');
        $("#rule").addClass('current');
    });
    $(".back").on("tap", function () {
        $("#main").removeClass('visited');
        $("#rule").removeClass('current');
    });
    //查看红包
    $("#lookPacket").on("tap", function () {
        GetSentRedPacket();
    });
    //传递财运
    $("#transmitPacket").on("tap", function () {
        showPop(".sec03");
        hidePop(".sec02");
    });
    //*上传图片*///////
    eidtor = new mo.ImageEditor({
        trigger: $('#fileupload'),
        container: $('#container'),
        width: 400,
        height: 400,
        stageX: $('#container')[0].offsetLeft,
        event: {
            beforechange: function () {
                $(".sec03 .tips1").fadeIn(function () {
                    setTimeout(function () {
                        hidePop(".sec03 .tips1");
                    }, 2000);
                });
            }
        }
    });
    //合成图片
    $(".sec03 .btnR").on("tap", function () {
        var strName = $("#txtName").val();
        if (strName.trim() == "") {
            alert("请输入您的姓名！");
            $("#txtName").focus();
            return;
        }
        //检测中文字
        if (!isChinese(strName)) {
            alert("只能录入中文姓名！");
            $("#txtName").val("");
            $("#txtName").focus();
            return;
        }
        if (eidtor.imgs == undefined || eidtor.imgs.length == 0) {
            alert("您还未选择图片哦!");
            return;
        }
        //为提高用户体验此处应加上合成等待提示
        window.overlay1 = new mo.Overlay('照片合成中，请稍候...');
        overlay1.on('open', function () {
            var self = this;
            eidtor.toDataURL(function (data) {
                var cvs = document.createElement('canvas');
                cvs.width = 640;
                cvs.height = 960;
                var ctx = cvs.getContext("2d");

                var img = new Image();
                img.onload = function () {
                    ctx.drawImage(this, 0, 0, img.width, img.height, 120, 225, img.width, img.height);
                    img = new Image();
                    img.onload = function () {
                        ctx.drawImage(this, 0, 0, img.width, img.height, 0, 0, img.width, img.height);
                        var base64Str = cvs.toDataURL("image/jpeg");
                        $(".sec04 .overPic").html('<img src="' + cvs.toDataURL("image/jpeg") + '"/>');
                        $(".sec04 .nameText").text($("#txtName").val());
                        $("#hideImgData").val(base64Str);
                        // self.close();

                        //上传图片
                        setTimeout(DoMakeWealthGod, 500);
                    }
                    img.src = "images/frame.png"; //自定义合成的图片
                }
                img.src = data; //相机拍摄或者相册的图片 
            });
        });
    });
    //点击上传照片按钮时清空原有的值
    $(".fileuploadBox").on("tap", function () {
        eidtor.clear();
        $(".tipText").hide();
        $("#hideImgData").val("");
        if (eidtor.imgs != undefined)
            eidtor.imgs = [];
    });
    //弹出分享
    $(".sec04 .btnR").on("tap", function () {
        showPop(".overshare");
    });
    //点击分享遮罩层的动作
    $(".overshare").on("tap", function () {
        hidePop(".sec04");
        showPop(".sec05");
    });

    //第二次进来我的财神
    $("#btnMyRedPacket").click(function () {
        $("#btnMyRedPacket").unbind("click");
        window.location.href = "/Activity/GodWealth/Gift.aspx"; 
    });

    //使用红包投资
    $("#btnGoInvest").click(function () {
        $("#btnGoInvest").unbind("click");
        window.location.href = "/Activity/GodWealth/Gift.aspx"; 
    });
});

//上传图片当财神
function DoMakeWealthGod() {
    var base64 = $("#hideImgData").val();
    var clearBase64 = base64.substr(base64.indexOf(',') + 1);
    $.ajax({
        type: "post",
        async: false,
        url: "/Activity/GodWealth/WealthPage.aspx?action=DoMakeWealthGod",
        data: { nickName: $("#txtName").val(), base64Img: clearBase64 },
        dataType: "json",
        timeout: 6000,
        success: function (json) { 
            window.overlay1.close();
            if (json.result == "1") {
                hidePop(".sec03");
                showPop(".sec04");
                SelfGodName = json.NickName;
                wxData.title = $("#txtName").val() + "财神给您送红包，快来领取吧！"; //设定分享时标题
                $(".sec05 .nameText").text($("#txtName").val());
                $("img[id$='imgGodPreview']").attr("src", json.GodImage + "?v=" + (new Date()).getTime());
            } else {
                alert(json.msg);
            }
        },
        error: function (xhr, errorType, error) {
            window.overlay1.close();
            alert("做财神失败，请重试！status:" + xhr.status + " errorType:" + errorType + " err:" + error);
        }
    });
}
//获取好友派发的红包
function GetSentRedPacket() {
    $.ajax({
        type: "post",
        async: false,
        url: "/Activity/GodWealth/WealthPage.aspx?action=GetGodSendRedPacket",
        data: { extendkey: ExtendKey },
        dataType: "json",
        success: function (json) {
            if (json.result == "1") {
                showPop(".sec02");
                hidePop(".sec01");
            } else {
                alert(json.msg);
            }
        },
        error: function (xhr, errorType, error) {
            alert("获取红包失败！");
        }
    });
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

//判断cookie是否有登录凭证
function isCookieLogin() {
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
//检测是否全中文
function isChinese(str) {
    var reg = /^[\u4E00-\u9FA5]+$/;
    if (!reg.test(str)) {
        return false;
    }
    return true;
}