(function() {
    FastClick.attach(document.body);
    var $body = $('body');

    // 事件绑定
    function submitEvent() {

        // 事项勾选
        $body.on('click', '.txt', function () {
            if($(this).hasClass('cur')){
                $(this).removeClass('cur');
                $(this).attr('data-check', 'checkbox');
            }else {
                $(this).addClass('cur');
                $(this).attr('data-check', 'checked');
            }
        })
        bindSubmitEvent();
    }


    // 勾选校验
    function matterCheck() {
        var shixiang1 = $('#shixiang1').attr('data-check'),
            shixiang2 = $('#shixiang2').attr('data-check');
        if (shixiang1 != 'checked' && shixiang2 != 'checked') {
            Util.toast('请勾选声明!');
            return false;
        }
        if (shixiang1 != 'checked') {
            Util.toast('请勾选声明!');
            return false;
        }
        if (shixiang2 != 'checked') {
            Util.toast('请勾选声明!');
            return false;
        }
        return true;
    }
    function bindSubmitEvent(){

        $(".btn-hs").click(function(){
            if($("#realName").val()==""){
                Util.toast('真实姓名不能为空！');
                return ;
            }else if($("#Id").val()==""){
                Util.toast('证件号码不能为空！');
                return ;
            }else if(!matterCheck()){
                return;
            }


            // var config={
            //     url: "/wap/auth/submit",
            //     type: "POST",
            //     data:{
            //         realName:$("#realName").val(),
            //         idcard:$("#Id").val()
            //     },
            //     dataType: "JSON",
            //     success: function(data){
            //         if(data.code!="1"){
            //             Util.toast(data.message);
            //         }else{
            //             location="/wap/risk/testing";
            //         }
            //     },
            //     error:function(data){
            //
            //         Util.toast('实名认证失败！');
            //     }
            // }
            // Util.Ajax(config);
        })
    }
    submitEvent();
})();