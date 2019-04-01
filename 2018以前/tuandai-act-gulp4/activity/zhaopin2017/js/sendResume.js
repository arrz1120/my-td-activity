(function() {
    FastClick.attach(document.body);
    var $contentEl = $('.content'),
        $alertWrapperEl = $contentEl.find('.alert-wrapper');

    function bindEvent() {
        // 点击显示选择最高学历
        $contentEl.on('click', '.btn-dg', function() {
            $alertWrapperEl.find('.highest-education-select').show().siblings('div').hide();
            $alertWrapperEl.addClass('maskClickable').show();
        });

        var isFirstPosition = true;
        // 点击显示选择职位意愿
        $contentEl.on('click', '.btn-first-position, .btn-second-position', function() {
            var $this = $(this);
            $alertWrapperEl.find('.job-select').show().siblings('div').hide();
            $alertWrapperEl.addClass('maskClickable').show();
            isFirstPosition = $this.hasClass('btn-first-position'); //设置是否为职位第一个志愿
        });

        // 点击选择学历
        $alertWrapperEl.on('click', '.opt-dg', function() {
            var $this = $(this);
            $contentEl.find('.btn-dg .selected-txt').text($this.text());
            $alertWrapperEl.removeClass('maskClickable').hide();
        });

        // 点击取消选择学历
        $alertWrapperEl.on('click', '.cancel-btn', function() {
            $alertWrapperEl.removeClass('maskClickable').hide();
        });


        // 选择岗位类型
        $alertWrapperEl.on('click', '.job-select-left p', function() {
            var $this = $(this);
            $this.addClass('selected').siblings().removeClass('selected');

            // TODO:更换岗位
        });

        // 选择岗位
        $alertWrapperEl.on('click', '.job-select-right p', function() {
            var $this = $(this);
            $this.addClass('selected').siblings().removeClass('selected');
            var target = isFirstPosition ? '.btn-first-position' : $contentEl.find('.btn-second-position .grey-txt').hide() && '.btn-second-position';

            $contentEl.find(target + ' .selected-txt').text($this.text());
            $alertWrapperEl.removeClass('maskClickable').hide();
        });

        // 点击遮罩层关闭
        $alertWrapperEl.on('click', '.mask', function() {   //maskClickable表示mask可点击
           $alertWrapperEl.hasClass('maskClickable') &&  $alertWrapperEl.removeClass('maskClickable').hide();
        });

        // 填写工作经验
        var expInpEl = $contentEl.find('.experience textarea'),
            expInpTipsEl = $contentEl.find('.experience .grey-txt'),
            experience = '';

        $contentEl.on('input', '.experience textarea', function() {
        	experience = expInpEl.val();
            expInpTipsEl.text(experience.length + '/300');
        });

        $contentEl.on('focus', '.experience textarea', function() {
            if (!Util.isIOS()) {
                setTimeout(function() {
                    // 滑动到输入框处
                    $contentEl.find('.scroll-content').scrollTop(expInpEl.offset().top)
                }, 200)
            }
        });

        // 上传图片
        var $photoErrorMsgEl = $contentEl.find(".red-txt"), //上传照片错误提示
        	$uploadPhotoBtn = $contentEl.find(".upload-photo-btn"); //上传头像按钮
        $contentEl.on('change', '.photo input', function(e) {
            var arr = $(this).val().split('.');
            var fileType = arr[arr.length -1].toLowerCase();
            switch(fileType) {
                case 'jpg':
                case 'png':
                case 'jpeg':
                    break;
                default:
                    $photoErrorMsgEl.html('图片格式有误，上传失败！');
                    return;
            }

            var target = e.target;
            var file = typeof target === 'undefined' ? e[0] : target.files[0];
            lrz(file, {
                width: 800
            }).then(function(rst) {
                var photoInfo = rst.origin,
                	photoSize = photoInfo.size,
                	// photoType = photoInfo.type,
                	photoSrc = rst.base64;
                // 图片大于2m
                if(photoSize/1024/1024 > 2){
                	$photoErrorMsgEl.html('图片超出2M，上传失败！');
                	return;
                }
                // 获取了错误格式
                // switch(photoType) {
                //     case 'image/jpg':
                //     case 'image/png':
                //     case 'image/jpeg':
                //         break;
                //     default:
                //         $photoErrorMsgEl.html('图片格式有误，上传失败！');
                //         return;

                // }

                $photoErrorMsgEl.html() && $photoErrorMsgEl.html('');

                // 显示上传图片缩略图
                if($uploadPhotoBtn.hasClass('img')){
                	$uploadPhotoBtn.find('img').attr('src', photoSrc)
                }else{
	                $uploadPhotoBtn.append('<img src="'+ photoSrc +'" alt="" />').addClass('img');
                }
            });
        });

        // 提交简历
        var $nameInputEl = $contentEl.find(".name input"), //姓名
            $phoneInputEl = $contentEl.find(".phone input"), //手机
            $emailInputEl = $contentEl.find(".email input"), //电子邮箱
            $schoolInputEl = $contentEl.find(".school input"), //毕业院校
            $proInputEl = $contentEl.find(".profession input"), //专业
            $eduEl = $contentEl.find(".btn-dg .selected-txt"), //学历
            $firstPositionEl = $contentEl.find(".btn-first-position .selected-txt"), //职位第一意愿
            $secondPositionEl = $contentEl.find(".btn-second-position .selected-txt"), //职位第二意愿
            name = phone = email = school = profession = '';

        $contentEl.on('input', 'input', function() {
        	var $this = $(this),
        		inputName = $this.attr('name');
        	switch(inputName) {
        		case 'name':
        			name = $this.val();
        			break;
        		case 'phone':
        			phone = $this.val();
        			break;
        		case 'email':
        			email = $this.val();
        			break;
        		case 'school':
        			school = $this.val();
        			break;
        		case 'profession':
        			profession = $this.val();
        			break;
        	}	
        })
        $contentEl.on('click', '.submit-btn', function() {
        	// 姓名为空
        	if(!name){
        		Util.toast('请正确填写名字');
        		return;
        	}

        	// 手机号为空或格式不对
        	var phoneReg = /^1[3|4|5|7|8]\d{9}$/;
        	if(!phone || !phoneReg.test(phone)){
        		Util.toast('请正确填写手机号码');
	        	return;
        	}

        	//电子邮箱为空或格式不对
        	var emailReg = /\w+((-w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+/;
        	if(!email || !emailReg.test(email)){
        		Util.toast('请正确填写电子邮箱');
	        	return;
        	}
        	//毕业院校为空
        	if(!school){
        		Util.toast('请正确填写毕业院校');
	        	return;
        	}

        	//专业为空
        	if(!profession){
        		Util.toast('请正确填写所学专业');
	        	return;
        	}

        	//学历为空
        	if(!$eduEl.html()){
        		Util.toast('请选择您的学历');
	        	return;
        	}

        	//职位第一意愿为空
        	if(!$firstPositionEl.html()){
        		Util.toast('请选择应聘岗位');
	        	return;
        	}
        	//经验或者经历为空
        	if(!experience){
        		Util.toast('请填写工作经验');
        		return;
        	}
        	//照片为空
        	if(!$contentEl.find("img").length){
        		$photoErrorMsgEl.html('请上传图片');
        		return;
        	}

        	//请求接口提交简历
        	$alertWrapperEl.find('.success-content').show().siblings('div').hide();
        	$alertWrapperEl.show();
        });
        // 点击提交成功关闭按钮跳转至上一页
        $alertWrapperEl.on('click', '.success-content .cls-btn', function() {
            window.history.back();
        });
        // 点击提交失败关闭按钮
        $alertWrapperEl.on('click', '.fail-content .cls-btn', function() {
        	$alertWrapperEl.hide();
        });

    }

    function init() {	
        bindEvent();
    }
    init();
})();