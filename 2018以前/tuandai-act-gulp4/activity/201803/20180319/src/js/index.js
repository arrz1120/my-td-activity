

(function () {
    FastClick.attach(document.body);



    var mySwiper = new Swiper('.swiper-container',{
        prevButton:'.swiper-button-prev',
        nextButton:'.swiper-button-next',
        })


    $('#btn_yy').on('click',function(e){
        e.preventDefault();
        $('#alert').show();
    });


    $('.mask').on('click',function(e){
        e.preventDefault();
        $('#alert').hide();
    });



    $('#shareBtn').on('click',function(){

        appShare.set({
            icon: '',
            title: '标题',
            content: '内容',
            shareUrl: 'tdw.cn',
            cover: {
                src: './images/wxShare.png',
                style: {
                    width: '12rem',
                    display: 'block',
                    margin: '0 0 0 1.5rem'

                }
            },
            custom: [{
                key: 5,
                val: "朋友圈",
                title: 'xxx'
            }],
            callback: function () {}
        })
    });








    var scrollTop;


    function to(scrollTop) {
        document.body.scrollTop = document.documentElement.scrollTop = scrollTop;
    }
    function getScrollTop() {
        return document.body.scrollTop || document.documentElement.scrollTop;
    }

    // 显示弹出层
    $('#btn_yy').on('click', function () {

        // 在弹出层显示之前，记录当前的滚动位置
        scrollTop = getScrollTop();

        console.log(1, scrollTop);

        // 使body脱离文档流
        document.body.classList.add('modal-open');

        console.log(2, scrollTop);


        // 把脱离文档流的body拉上去！否则页面会回到顶部！
        document.body.style.top = -scrollTop + 'px';



    })

    // 隐藏弹出层
    $('.mask').on('click', function () {



        document.body.classList.remove('modal-open');


        document.body.style.top = 0 + 'px';



        to(scrollTop);
    });

    var toastDom = $('#toast');

    function toast(str){
        toastDom.html(str);
        toastDom.show();
        setTimeout(function (params) {
            toastDom.hide(); 
        },800);
    }


    toast('请输入正确的姓名');


    // var  whRat

})();