(function () {


  var sub_alert = $('#sub_alert');

  $('#sub_list').on('click', 'li', function () {

    if (!$(this).hasClass('answered')) {
      sub_alert.show();
    }

  });

  $('.close').on('click', function () {
    sub_alert.hide();
  });

  //答题选择

  $('#sub_list_1').on('click', 'li', function () {

    if (!$(this).hasClass('selected')) {
      $(this).addClass('selected');
      $(this).siblings().removeClass('selected');
    }
  });

})();