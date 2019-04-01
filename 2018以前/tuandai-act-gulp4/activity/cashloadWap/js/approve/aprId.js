(function() {
    FastClick.attach(document.body);
    Util.initHeader({
        'header': 'header',
        'leftFun': back
    });
    var _history = ['form-ids'];
    var livenessEnum = {
        BLINK: 0,
        MOUTH: 1,
        YAW: 2
    };

    // var livenessAssets = {
    //     livenessEnum.BLINK: {
    //         key: 'BLINK',
    //         gif: _img_host+"/images/blink.gif",
    //         description: '眨眨眼'
    //     },
    //     livenessEnum.MOUTH: {
    //         key: 'MOUTH',
    //         gif:_img_host+"/images/mouth.gif",
    //         description: '张张嘴'
    //     },
    //     livenessEnum.YAW: {
    //         key: 'YAW',
    //         gif:_img_host+"/images/yaw.gif",
    //         description: '摇摇头'
    //     }
    // };
    var livenessAssets = {};
    livenessAssets[livenessEnum.BLINK] = {
        key: 'BLINK',
        gif: _img_host + "/images/blink.gif",
        description: '眨眨眼'
    };
    livenessAssets[livenessEnum.MOUTH] = {
        key: 'MOUTH',
        gif: _img_host + "/images/mouth.gif",
        description: '张张嘴'
    };
    livenessAssets[livenessEnum.YAW] = {
        key: 'YAW',
        gif: _img_host + "/images/yaw.gif",
        description: '摇摇头'
    };
    // 事件绑定
    $('.ai-content').on('change', 'input', function(e) {
        var _type = $(e.currentTarget).attr('id');
        upload(e, _type);
    });

    $('.pop-ids').on('click', '#video_vali', function(e) {
        showVideoDialog(e);
    });
    // 提交身份证信息
    $('.ai-content').on('click', '#submit', function(e) {
        submitInfo(e);
    });

    // 确认身份信息
    $('.pop-ids').on('click', '#btn_approve', function(e) {
        toApprove(e);
    });

    function upload(e, _type) {
        var target = e.currentTarget,
            $parent = $(target).parent();
        if (target.files.length <= 0) {
            return;
        }

        // todo 组装参数
        if (_type === 'id_front') {

        } else if (_type === 'id_back') {

        }
        var _file_url = target.value;
        // todo 发送
        lrz(target.files[0], {
                "fieldName": "Filedata" // fieldName 后端接收file的字段名，默认：file
            })
            .then(function(rst) {
                // that.imgList.push(_img)
                console.info('rst---', rst);

                var xhr = new XMLHttpRequest();
                // 显示loading
                $parent.addClass('id-loading');
                // todo 补全请求地址
                var _api = ''
                xhr.open('POST', _api);
                xhr.onload = function() {
                    if (xhr.status === 200) {
                        // 上传成功
                        // console.log(xhr.response)
                        var data = xhr.response ? JSON.parse(xhr.response) : {};
                        //  todo 处理业务逻辑， 比如记录上传后返回的图片信息


                    } else {
                        // 处理其他情况,失败情况
                        $(target).parent().addClass('fail');
                    }
                }

                xhr.onerror = function() {
                    // 处理错误
                    $(target).parent().addClass('fail');
                }

                xhr.onreadystatechange = function() {
                    // console.log(xhr.readyState)
                    // if(xmlhttp.readyState === XMLHttpRequest.DONE && xmlhttp.status === 200) console.log(xmlhttp.responseText)
                    if (xhr.readyState === xhr.DONE) {
                        // console.log("done==========",xhr.status)
                        $parent.removeClass('loading');

                    }
                }

                xhr.upload.onprogress = function(e) {
                    // 上传进度
                    var percentComplete = ((e.loaded / e.total) || 0) * 100
                    // console.log(percentComplete)
                }

                // 添加参数
                // rst.formData.append("version", 4)
                // rst.formData.append("Filedata",rst.file)
                console.log(rst.formData);
                console.log(rst.file)

                // 触发上传
                xhr.send(rst.formData)

                return rst

            })
            .catch(function(error) {
                console.log(error)
            })
            .always(function() {
                // target.value = ''
            })
    }

    function showVideoDialog(e) {
        var _arr = [livenessEnum.BLINK, livenessEnum.MOUTH, livenessEnum.YAW],
            _liveness = livenessAssets[_arr[Math.floor(Math.random() * 3)]];
        var _temp = '<div class="masker"></div>' +
            '<div class="dialog-wrapper">' +
            '<img src="' + _liveness.gif + '">' +
            '<p>录制不超过<font>10s</font>的视频</p>' +
            '<p>拍摄视频时请<font>' + _liveness.description + '</font></p>' +
            '<div class="btn-full-round">' +
            '开始录制' +
            '<input type="file" name="" value="" placeholder="" accept="video/*" id="upload_video">' +
            '</div>' +
            '</div>';
        var $poptip = $('<div/>').addClass('popup').addClass('component-dialog').addClass('pop-video-tip').html(_temp);
        $('body').append($poptip);
        $poptip.find('#upload_video').on('change', function(e) {
            uploadVideo(e, _liveness.key)
        });
        $poptip.find('.masker').on('click', function(e) {
            hideVideoDialog();
        });

    }
    function hideVideoDialog() {
        $('body').find('.pop-video-tip').remove();
    }
    // 上传视频， e -- event; type -- 活体类型： BLINK--眨眼 MOUTH--张嘴 YAW--摇头
    function uploadVideo(e, type) {
        var target = e.currentTarget,
            file = target.files[0];
        console.log(file);
        // todo 上传视频
        // 组装参数
        var formData = new FormData();
        formData.append('Filedata', file);
        var xhr = new XMLHttpRequest();
        // 显示loading
        hideVideoDialog();
        Util.showLoader();
        // todo 补全请求地址
        var _api = '';
        xhr.open('POST', _api);
        xhr.onload = function() {
            if (xhr.status === 200) {
                // 上传成功
                // console.log(xhr.response)
                var data = xhr.response ? JSON.parse(xhr.response) : {};
                //  todo 处理业务逻辑， 比如记录上传后返回的图片信息


            } else {
                // 处理其他情况,失败情况
                Util.toast('上传失败，请重新再试');
            }
        }

        xhr.onerror = function() {
            // 处理错误
             Util.toast('上传失败，请重新再试');
        }

        xhr.onreadystatechange = function() {
            // console.log(xhr.readyState)
            // if(xmlhttp.readyState === XMLHttpRequest.DONE && xmlhttp.status === 200) console.log(xmlhttp.responseText)
            if (xhr.readyState === xhr.DONE) {
                // console.log("done==========",xhr.status)
                Util.hideLoader();

            }
        }

        xhr.upload.onprogress = function(e) {
            // 上传进度
            var percentComplete = ((e.loaded / e.total) || 0) * 100
            // console.log(percentComplete)
        }

        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        // 触发上传
        xhr.send(formData)

    }

    function submitInfo(e) {
        pushHistory('pop-ids');
        var $ids = $('.pop-ids');
        // todo 获取组装数据
        var _data = {
            name: 'simona',
            id: '12234234',
            organization: '东莞市公安局',
            date: '2017-08-08'
        };
        // $ids.find('.list-info').html(compileInfo(_data));
        $ids.show();
    }

    function compileInfo(data) {
        var _temp = '<li><span>姓名</span><div>' + data.name + '</div></li>' +
            '<li><span>身份证</span><div>' + data.id + '</div></li>' +
            '<li><span>签发机关</span><div>' + data.organization + '</div></li>' +
            '<li><span>有效期</span><div> ' + data.date + '</div></li>';
        return _temp;
    }

    function toApprove(e) {
        // todo 如果没上传视频认证，那么不符合
        showLoading('认证中，请稍等...');
        setTimeout(function() {
            hideLoading();
            Util.showResult({
                result: 1,
                status: '认证成功',
                info: '恭喜您，身份认证已通过',
                btn: {
                    name: '返回',
                    cb: function(result) {
                        window.history.back();
                    }
                }
            })
        }, 1500)

    }

    /** 显示loading 认证中
     *  info: 信息
     */

    function showLoading(info) {
        $('body').append('<div class="popup pop-loading">' +
            '<section class="wrapper-approving">' +
            '<div class="wrapper-loading">' +
            '<i class="icon-inline icon-loading"></i><span>正在认证中</span>' +
            '</div>' +
            '<p>' + info + '</p>' +
            '</section>' +
            '</div>');
    }

    function hideLoading() {
        $('.pop-loading').remove();
    }

    function pushHistory(his) {
        _history.push(his);
        // console.log(_history);
    }

    function back() {
        var _his = _history.pop();
        if (_his === 'pop-ids') {
            $('.pop-ids').hide();
        } else {
            window.history.back();
        }
    }

})();