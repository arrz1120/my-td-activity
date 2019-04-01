$(function(){

    var winH = $(window).height();
    var indexH = $(".index").outerHeight();
    if(indexH>winH){
        var sca = winH/indexH - 0.05;
        $(".index").css({
            "height":"100%",
            "background-position":"left bottom"
        })
        $(".logo,.index-tit").css({
            "-webkit-transform":"scale("+ sca + "," + sca +")",
            "transform":"scale("+ sca + "," + sca +")",
            "-webkit-transform-origin":"left top",
            "transform-origin":"left top",
            "padding-top":"5px"
        })
        $(".hb-box,.dec").css({
            "-webkit-transform":"scale("+ sca + "," + sca +")",
            "transform":"scale("+ sca + "," + sca +")",
            "-webkit-transform-origin":"center top",
            "transform-origin":"center top"
        })
    }

    //预先请求图片资源
    [
        './images/mask_con.png',
        './images/btn.png',
        './images/error.png',
        './images/mask_btnr.png',
        './images/mask_btnl.png'
    ].forEach(function(item) {
        var img = new Image();
        img.src = item;
    });

    function isAndroidPlatform() {
        if (navigator.userAgent.match(/(Android)/)) {
            return true;
        } else {
            return false;
        }
    }
    
    $('input').on('focus', function (e) {
        if(isAndroidPlatform()){
            $('.index').css('transform', 'translateY(-5rem)');
        }
    })
    
    $('input').on('blur',function (e) {
        if(isAndroidPlatform()){
            $('.index').css('transform', 'translateY(0)');
        }
    })

    $(".open").on("click",function(){
        //请求背景图资源，等待背景图加载完成后再进行下一步操作
        var oImg = new Image();
        oImg.src = "./images/hb_isopen.png";
        oImg.onload = function(){
            $(".hb-onopen").hide();
            $(".hb-isopen").show();
        }
    })

    $(".close").on("click",function(){
        $(this).parent().parent().hide();
    })
    $(".mask-bg").on("click",function(){
        $(this).parent().hide();
    })

    function inputFn(){
        this.time = 180;
        this.isSend = false;
        this.telInput = $("#telInput");
        this.codeInput = $("#codeInput");
    }

    inputFn.prototype = {
        init:function(){
            this.telOnInput();
            this.runInterval();
            this.submit();
        },
        checkPhone: function(tel){
            var reg = /^((\+?[0-9]{1,4})|(\(\+86\)))?(13[0-9]|14[057]|16[6]|19[9]|15[012356789]|17[03678]|18[0-9])\d{8}$/;
            if(reg.test(tel)) {
                return true;
            } else {
                return false;
            }
        },
        showTips: function(err,txt){
            $(err).html(txt).fadeIn();
            setTimeout(function() {
                $(err).fadeOut();
            }, 2000);
        },
        telOnInput:function(){
            var _this = this;
            _this.telInput.on('input', function() {
                var val = $(this).val();
                if(val.length == 11) {
                    if(_this.checkPhone(val)) {
                        $("#inpSpread").show();
                    } else {
                        _this.showTips("#inpError",'您输入的手机号码格式有误');
                    }
                }
            })
        },
        runInterval:function(){
            var _this = this;
            $("#getCode").on("click",function(){
                if(_this.isSend) return;
                _this.isSend = true;
                var $this = $(this);
                $this.html("180s");
                var timer = setInterval(function(){
                    _this.time--;
                    if(_this.time<0){
                        clearInterval(timer);
                        $this.html("重新获取");
                        _this.isSend = false;
                        _this.time = 180;
                    }else{
                        $this.html(_this.time + "S");
                    }
                },1000);
            })
        },
        submit:function(){
            var _this = this;
            $("#submit").on("click",function(){
                var telVal = _this.telInput.val(),
                    codeVal = _this.codeInput.val();
                if(telVal == ""){
                    _this.showTips("#telError",'手机号码不能为空');
                    return;
                }
                else if(codeVal == ""){
                    _this.showTips("#codeError",'手机验证码不能为空');
                    return;
                }
                else{
                    $('#successMask').show();
                }
            })
        }
    }

    var inpFn = new inputFn().init();
    
})