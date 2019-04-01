(function() {
	FastClick.attach(document.body);
	//do your thing.



    // 获得列表滚动
    setInterval(listScroll, 3000);
    function listScroll(obj) {
        $(".scroll-list").find("ul:first").animate({
            marginTop: "-0.96rem"
        }, 500, function() {
            $(this).css({
                marginTop: "0"
            }).find("li:first").appendTo(this);
        });
    }



})();