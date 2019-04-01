(function() {
	FastClick.attach(document.body);
	//do your thing.
	
	var tag = 'Traning';
	
    //页面头部切换
	$('#tabTraning').bind('click', function () {
	    tabSwithHeader(this, "Traning");
	});
	$('#tabFinished').bind('click', function () {
	    tabSwithHeader(this, "Finished");
	});

	iScroll.onLoadData = drawItemData;
	//LoadDataList('empty');
    
	function tabSwithHeader(obj, tag) {
	    $("body").showLoading("加载中...");
	    var tabArry = ["tabTraning", "tabFinished"];
	    $.each(tabArry, function (i, n) {
	        $("#" + n).removeClass("top-tab-cur");
	    });
	    $(obj).addClass("top-tab-cur");
	    pStatus = tag;
	    setTimeout(function () {
	        //重新加载数据
	        LoadDataList('empty');
	        myScroll.refresh();
	        $("body").hideLoading();
	    }, 500);
	}
    
    //加载数据
	function LoadDataList(flag) {
	    if (flag == "empty") {
	        $("#thelist").children().remove();
	    }
	    jQuery.ajax({
	        async: false,
	        type: "post",
	        url: "/ajaxCross/BorrowAjax.ashx",
	        dataType: "json",
	        data: { Cmd: "GetMyBorrowRecord", pageIndex: pageIndex, status: pStatus },
	        success: function (jsonstr) {
	            pageCount = JSON.parse(jsonstr.msg).pageCount;
	            if (isNaN(pageCount) || pageCount <= 1)
	                $("#pullUp").hide();
	            else
	                $("#pullUp").show();
	            if (jsonstr.result == "1") {
	                drawItemData(pStatus, jsonstr);
	            } else {
	                $("#dvEmptyText").html("暂无记录");
	                $(".debt-empty").show();
	            }
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	            $("#dvPopmsg").hide();
	            $("#pullUp").hide();
	            $("#dvEmptyText").html("数据加载失败!");
	            $(".debt-empty").show();
	        }
	    });
	}

	function drawItemData() {
	    var html = new Array();
	    var str = "";
	   // var list = JSON.parse(jsonstr.msg);
	    if (1==1) {
	        for (var i = 0; i < 10; i++) {
	            //var item = list.borrowList[i];
	            if (tag == "Traning") {
	                str = '<div class="record-con">'+
                                '<div class="re-tit">'+
                                    '<p>标题</p>'+
                                    '<span>12%</span>' +
                                    '<canvas class="circular"></canvas>'+
                                '</div>'+
                                '<div class="re-content">'+
                                    '<div class="con-item">'+
                                        '<p class="recon-p1">已转让金额：</p>'+
                                        '<p class="recon-p2 c-fd6040">￥ 456</p>' +
                                    '</div>'+
                                    '<div class="con-item">'+
                                        '<p class="recon-p1">待结清金额：</p>'+
                                        '<p class="recon-p2">￥789</p>' +
                                    '</div>'+
                                '</div>' +
                            '</div>';
	            } else {
	                str = '<div class="record-con">' +
                                '<div class="re-tit">' +
                                    '<p>标题</p>' +
                                    '<span>22%</span>' +
                                    '<canvas class="circular"></canvas>' +
                                '</div>' +
                                '<div class="re-content">' +
                                    '<div class="con-item">' +
                                        '<p class="recon-p1">已转让金额：</p>' +
                                        '<p class="recon-p2 c-fd6040">￥123</p>' +
                                    '</div>' +
                                    '<div class="con-item">' +
                                        '<p class="recon-p1">待结清金额：</p>' +
                                        '<p class="recon-p2">￥ 456</p>' +
                                    '</div>' +
                                '</div>' +
                            '</div>';
	            }
	            html.push(str);
	        }
	        $("#thelist").append(html.join(""));
	    }
	    else {
	        //无数据
	    }
	}

	//头部切换
    //$(".top-tab").click(function() {
    //    var index = $(this).index();
    //    $(".top-tab-cur").removeClass('top-tab-cur');
    //    $(this).addClass('top-tab-cur');
    //    $(".record-list").hide();
    //    $(".record-list").eq(index).show();
    //});

    //环形进度条(canvas)
    $('.circular').each(function(i, item) {
        var percent = $(item).parent().find('span').html().replace('%', '') / 100;
        var circular = new CircularProcess(item, {
            anticlockwise: false,
            bgColor: '#e6e6e6',
            animate: false,
//			animateSpeed: 15,
            startDeg: 0,
            maxDeg: 360,
            dpr: 2,
            lineWidth: 2,
            circles: [{
                color: '#fab600',
                radius: 6,
                percent: percent,
            }]
        });
        circular.render();
    });
})();