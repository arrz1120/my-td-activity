(function() {
  FastClick.attach(document.body);
  //do your thing.



  var swiper = new Swiper('#swiper-container-1', {
    lazyLoading: true,
    onSlideChangeEnd: function() {

      if (swiper.activeIndex != 1) {


        $('#video1').empty();

        $('#v1').show()

        // player.pauseVideo();

        loadAudio.play();


      }



    }
  });


  var player;

  function showVideo(domid, vid) {
    player = new YKU.Player(domid, {
      client_id: '52b3fa57e9fe17cf',
      autoplay: true,
      vid: vid,
      show_related: false
    });
  }


  var player_1,
    player_2,
    player_3;

  // $('#v1').on('click', function() {
  //   // $('.video_img').show();
  //   $(this).hide();
  //   // $('.yk_video').empty();


  //   if (player_2) {
  //     player_2.pauseVideo();
  //   }


  //   player_1 = new YKU.Player('video1', {
  //     client_id: '52b3fa57e9fe17cf',
  //     autoplay: true,
  //     vid: 'XMzA1MDYzMzg4OA==',
  //     show_related: false
  //   });

  // });



  // $('#v2').on('click', function() {

  //   $(this).hide();


  //   if (player_1) {

  //     player_1.pauseVideo();

  //   }
  //   player_2 = new YKU.Player('video2', {
  //     client_id: '52b3fa57e9fe17cf',
  //     autoplay: true,
  //     vid: 'XMzA1MDYzMzg4OA==',
  //     show_related: false
  //   });

  // });



  // $('#v3').on('click', function() {

  //   $(this).hide();


  //   if (player_1) {

  //     player_1.pauseVideo();

  //   }
  //   player_3 = new YKU.Player('video3', {
  //     client_id: '52b3fa57e9fe17cf',
  //     autoplay: true,
  //     vid: 'XMzA1MDYzMzg4OA==',
  //     show_related: false
  //   });

  // });





    player_1 = new YKU.Player('video1', {
      client_id: '52b3fa57e9fe17cf',
      autoplay: true,
      vid: 'XMzA1MDYzMzg4OA==',
      show_related: false
    });





    player_2 = new YKU.Player('video2', {
      client_id: '52b3fa57e9fe17cf',
      autoplay: true,
      vid: 'XMzA1MDYzMzg4OA==',
      show_related: false
    });






    player_3 = new YKU.Player('video3', {
      client_id: '52b3fa57e9fe17cf',
      autoplay: true,
      vid: 'XMzA1MDYzMzg4OA==',
      show_related: false
    });




  $('#leave_word').on('click', function() {
    $('#alert_msg').show();
  });


  $('#msg_box').on('click', function() {
    $(this).find('.tips').hide();
    // $(this).find('.word_val').show();
    $(this).find('.word_val').focus();

  });



  var barrageComment = new Barrage('.comment-barrage', {
    data: [{
      key: 0,
      val: '萌妹子好漂亮漂亮1'
    }, {
      key: 1,
      val: '萌妹子好漂亮好漂亮2'
    }, {
      key: 2,
      val: '萌妹子好3'
    }, {
      key: 3,
      val: '萌妹子4'
    }, {
      key: 4,
      val: '萌妹子好漂亮好漂亮好漂亮好漂亮好漂亮5'
    }, {
      key: 5,
      val: '萌妹子好6'
    }, {
      key: 6,
      val: '萌妹子好漂7'
    }, {
      key: 7,
      val: '萌妹子好漂8'
    }, {
      key: 8,
      val: '萌妹子好漂9'
    }, {
      key: 9,
      val: '萌妹子好漂10'
    }, {
      key: 10,
      val: '萌妹子好漂11'
    }, {
      key: 11,
      val: '萌妹子好漂12'
    }],
    per: 4, //显示的行数
    styles: [ //样式列表,随机获取
      {
        color: '#fff',
        fontSize: '0.68rem',
        marginLeft: '1rem'
      }, {
        color: '#fff',
        fontSize: '0.48rem',
        marginLeft: '1.2rem'
      }, {
        color: '#fff',
        fontSize: '0.76rem',
        marginLeft: '1.5rem'
      }, {
        color: '#fff',
        fontSize: '0.6rem',
        marginLeft: '1.8rem'
      },
    ],
    speed: 1, //速度系数
  });
  barrageComment.move();


  //修复app软键盘功能


  $('#word_val').on('focus', function(e) {
    if (Jsbridge.isApp()) {
      $('#alert_msg').addClass('alert_fix');
    }
  })



  $('#word_val').on('blur', function(e) {
    if (Jsbridge.isApp()) {
      $('#alert_msg').removeClass('alert_fix');
    }
  })

  var toast = $('#toast');

  function toastShow(str) {
    toast.html(str);
    toast.show();
    setTimeout(function() {
      toast.hide();
    }, 600)
  }


  // toastShow('nihao');

})();