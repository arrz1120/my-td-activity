(function() {

  //屏蔽ios下上下弹性
  $(window).on('scroll.elasticity', function(e) {
    e.preventDefault();
  }).on('touchmove.elasticity', function(e) {
    e.preventDefault();
  });



  var timer,
    isStartTimer = true,
    flipbook = $('.flipbook');

  $(function progressbar() {
    var w = $(".graph").width();
    $(".flipbook-viewport").show();
  });



  function loadApp() {
    var w = $(window).width();
    var h = $(window).height();
    $('.flipboox').width(w).height(h);
    $(window).resize(function() {
      w = $(window).width();
      h = $(window).height();
      $('.flipboox').width(w).height(h);
    });
    flipbook.turn({
      // Width
      width: w,
      // Height
      height: h,
      // Elevation
      elevation: 50,
      display: 'single',
      // Enable gradients
      gradients: true
        // Auto center this flipbook
        // autoCenter: true

    });
  }
  yepnope({
    test: Modernizr.csstransforms,
    yep: ['../js/turn.js'],
    complete: loadApp
  });



  function autoTurn() {
    isStartTimer = true;

    timer = setInterval(function() {
      var pageCount = flipbook.turn("pages"); //总页数
      var currentPage = flipbook.turn("page"); //当前页
      if (currentPage <= pageCount - 1) {
        flipbook.turn('page', currentPage + 1);
      } else {}
    }, 3000);
  }

  autoTurn();



  flipbook.bind("start", function(event, pageObject, corner) {

    // event.preventDefault();



    var pageCount = flipbook.turn("pages"); //总页数
    var currentPage = flipbook.turn("page"); //当前页



    if (corner == "tl" || corner == "tr") {
      event.preventDefault();


    }

    if ((corner == "tl" || corner == "tr" || corner == 'br' || corner == 'bl') && isStartTimer) {
      isStartTimer = false;
      clearTimeout(timer);
      autoTurn();
    }


    if ((corner == "tl" || corner == 'bl') && (currentPage == pageCount)) {
      console.log(1);
      flipbook.turn('page', pageCount - 1);
      $('.flipbook-viewport').show();
      clearTimeout(timer);
      autoTurn();
    }
  });


  flipbook.bind("turning", function(event, page, pageObject) {
    $('#txt').find('.txt_wraper').removeClass('cur');
    $('#txt').find('.txt_wraper').eq(page - 1).addClass('cur');

    if (finalPage) {
      clearTimeout(finalPage);
    }
  });



  var finalPage;

  flipbook.bind("last", function(event) {
    // console.log("You are at the end of the flipbook");

    finalPage = setTimeout(function() {
      window.location = 'final.html';
    }, 3000);
  });



  //延迟加载

  setTimeout(function() {
    $('.lazyload_1').each(function() {
        var src_val = $(this).attr('data-src');
        $(this).attr('src',src_val);
    });

  }, 1500)


  setTimeout(function() {
    $('.lazyload_2').each(function() {
        var src_val_2 = $(this).attr('data-src');
        $(this).attr('src',src_val_2);
    });

  }, 3000)

})();