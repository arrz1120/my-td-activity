//重置宽度
function dealOverflow() {
    $(".itemWrap").each(function (i) {
        var parent = $(".itemWrap").eq(i);
        var itemTipsBox = parent.find('.itemTipsBox');
        var itemTxtBox = parent.find('.itemTxtBox');
        if (itemTipsBox.length != 0) {
        	itemTxtBox.css('width',parent.width() - itemTipsBox.width()-1);
        } else {
        	itemTxtBox.css('width',parent.width()-1);
    	}
    });
}
dealOverflow();
$(window).resize(function(){
	dealOverflow();
})
iScroll.onLoadData = LoadWePlanList;
//加载We计划记录列表
function LoadWePlanList(flag) {
    window.location.href = '/pages/invest/WE/WE_list.aspx';
    //jQuery.ajax({
    //    async: false,
    //    type: "post",
    //    url: "/ajaxCross/InvestAjax.ashx",
    //    dataType: "json",
    //    data: { Cmd: "GetWePlanShowList", pageIndex: pageIndex },
    //    success: function (jsonstr) {　
    //        if (flag == "empty") {
    //            $("#thelist").children().remove();
    //        }
    //        var html = new Array();
    //        var str = "";
    //        if (jsonstr.result == "1") { 
    //            for (var i = 0; i < jsonstr.list.length; i++) {
    //                var item = jsonstr.list[i];
    //                var rateDesc = "到期本息";
    //                if (parseInt(item.Deadline) > 3)
    //                    rateDesc = "每月付息";
    //                var detailUrl = "/pages/invest/WE/WE_detail.aspx?id=" + item.ProductId;
    //                if (item.IsWeFQB == "1") { 
    //                    detailUrl = "/pages/invest/WE/WeFqb_detail.aspx?id=" + item.ProductId;
    //                }
    //                var jxDesc = '';
    //                if (item.IsWeQPR == "True" || item.IsWe4ZxJx == "True")
    //                    jxDesc = '<div class="item_r1">加息' + item.JxRate + '%</div>';
    //                str = '<div class="list-item bb-e6e6e6">' +
    //                    " <a href='" + detailUrl + "'>" +
    //                    jxDesc+
    //                    '<div class="item_r2 text-overflow">'+item.Title+'</div>'+
    //                    '<div class="item_r3">'+
    //                        '<div class="list-box-left">'+
    //                            '<p class="f12px c-ababab">预期年化利率</p>'+
    //                            '<p class="rate">' + item.YearRate + '</p>' +
    //                        '</div>'+
    //                        '<div class="list-box-center text-center">'+
    //                            '<p class="f12px c-ababab text-overflow">' + rateDesc + '</p>' +
    //                            '<p class="f15px c-212121 mt15">'+item.Deadline+'个月</p>'+
    //                        '</div>'+
    //                        '<div class="list-box-right">'+
    //                            '<p class="f12px c-ababab">剩余' + item.SurplusMoney + '</p>' +
    //                            '<p class="f14px c-212121">'+
    //                                item.JoinButton+
    //                            '</p>'+
    //                        '</div>'+
    //                    '</div>'+
    //                    '<div class="item_r4 mt8">'+
    //                        '<span class="span1"><i class="ico_Shield2"></i>安全保障计划</span>' +
    //                    (item.IsWeFQB == 1 ? '<span class="span2"><i class="ico_quitTips"></i>可提前退出</span>' : "") +
    //                    '</div>' +
    //                    '</a>'+
    //                '</div>';
    //                html.push(str);
    //            }
    //            $("#thelist").append(html.join("")); 
    //            //重置宽度
    //            dealOverflow();
    //            //刷新倒计时
    //            fnTimeCountDown();
    //            //重新调用按压事件
    //            clickRespond(".click-respond",'respond-style');
    //            clickRespond(".click-respond2", 'respond-style2');
    //            myScroll.refresh();
    //        }
    //        else {
    //            $("#thelist").append("<li>暂时没有We计划...</li>");
    //        }

    //    },
    //    error: function () {

    //    }
    //});
}


/*we计划开放倒计时  start*/
function zero(n) {
    var n = parseInt(n, 10);
    if (n > 0) {
        if (n <= 9) {
            n = "0" + n;
        }
        return String(n);
    } else {
        return "00";
    }
}
function dv(tcount) {
    var sec = zero(tcount % 60);
    var mini = Math.floor((tcount / 60)) > 0 ? zero(Math.floor((tcount / 60)) % 60) : "00";
    var hour = Math.floor((tcount / 3600)) > 0 ? parseInt(tcount / 3600) % 24 : "00";
    var day = Math.floor((tcount / 86400)) > 0 ? parseInt(Math.floor((tcount / 86400))) : "0";
    return "<span style='color: #ffffff;font-size:16px;'>" + hour + "</span>小时<span style='color: #ffffff;font-size:16px;'>" + mini
    + "</span>分<span style='color: #ffffff;font-size:16px;'>" + sec + "</span>秒";
}

function fnTimeCountDown() {
    $(".timeSet").each(function () {
        var timecount = parseInt($(this).attr("count"));
        if (timecount >= 0) {
            $(this).html(dv(timecount));
            if (timecount == 0) {
                var content = $(this).parent().html();
                if (content.indexOf("离开放还有") >= 0) {
                    $(this).parent().removeClass("buy-btn-time");
                    $(this).parent().html("马上加入");
                }
            }
            timecount = timecount - 1;
            $(this).attr("count", timecount);
        }
    });
    setTimeout("fnTimeCountDown()", 1000);
}
/*we计划开放倒计时  end*/