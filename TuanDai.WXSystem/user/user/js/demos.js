$(function () {
  'use strict';


  $(document).on("pageInit", "#page-city-picker", function(e) {
    $("#city-picker").cityPicker({
        // value: ['天津', '河东区']
        value: ['广东', '东莞']
    });
  });

  $.init();
});
