(function(){
    function showVideo(domid,vid){
        player = new YKU.Player(domid,{
            client_id: '52b3fa57e9fe17cf',
            autoplay: true,
            vid: vid,
            show_related: false
        });
    }
    showVideo('video_a','XMzQ1NzczMzg1Ng==');

    // var aqSwiper = new Swiper('#aqSwiper', {
    //     direction: 'vertical',
    //     freeMode: true,
    //     freeModeSticky : true,
    //     slidesPerView: 'auto',
    //     scrollbar: '.swiper-scrollbar',
    //     scrollbarHide:false,
    //     resistanceRatio : 0,
    //     roundLengths : true
    //  }) 

    var mySwiper = new Swiper('#mySwiper', {
        slidesPerView: 'auto',
        centeredSlides : true,
        loop:true,
        pagination: '.pagination'
     }) 
     
     var cmmentScroller = new CommentScroller('.comment-list', {
			showSlides: 3, //显示的条数
			autoplay: true, //autoplay:true 开启滚动
			delay: 4000, //轮播间隔时间
    })
    
    $(".text-input").find('textarea').on('input', function() {
		var val = $(this).val();
		if($(this).val() == '') {
			$("#inputTips").show();
		} else {
			$("#inputTips").hide();
		}
    })
    
    $(".qa-answer").find('li').on('click',function(){
        $(this).siblings().removeClass('checked').end().addClass('checked');
    })

    $("#ruleBtn").on('click',function(){
        $("#ruleAlert").show();
    })
    $(".btn-know,.close").on('click',function(){
        $(this).parent().parent().hide();
    })
    $(".alert-bg").on('click',function(){
        $(this).parent().hide();
    })
    
    var isCnInput = false;
    var txtLen = 0;
    $("textarea").on('compositionstart', function() {
        isCnInput = true;
    })
    $("textarea").on('compositionend', function() {
        isCnInput = false;

        txtLen = $(this).val().length;
        if(txtLen > 40) {
            txtLen = 40;
        }
        $(".errorTips").html('可输入'+ (40 - txtLen) +'个字');
    })
    $('textarea').on('input', function(e) {
        if(isCnInput) return;
        //        $(this).val(filter($(this).val()));

        txtLen = $(this).val().length;
        if(txtLen > 40) {
            txtLen = 40;
        } 
        $(".errorTips").html('可输入'+ (40 - txtLen) +'个字');
    })
    
})();