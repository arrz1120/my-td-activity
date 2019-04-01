//文档首次加载
$(function () { 
    //页面头部切换
    $('#tabCanTran').bind('click', function () {
        tabSwithHeader(this,"CanTran");
    });
    $('#tabTraning').bind('click', function () {
        tabSwithHeader(this,"Traning");
    });
    $('#tabFinished').bind('click', function () {
        tabSwithHeader(this,"Finished");
    });  

    iScroll.onLoadData = LoadDataList;
    LoadDataList('empty'); 
   
});
function bindDynamicEvent() {
    //申请转让
    $(".apply-btn").click(function (e) {
        try {
            //--------存管通验证----2016-12-21------
            if (isOpenCGT == "1" && !checkIsOpen())
                return false;
            //--------存管通验证结束------------
        } catch (e) {

        }
        var subscribeid = $(this).attr("subscribeid");
        window.location.href = "/Member/Repayment/my_debt_apply.aspx?id=" + subscribeid;
        e.stopPropagation();
    });
} 


function tabSwithHeader(obj,tag) {
    $("body").showLoading("加载中...");
    var tabArry = ["tabCanTran", "tabTraning", "tabFinished"];
    $.each(tabArry, function (i, n) { 
        $("#" + n).removeClass("tab-nav-active");
    }); 
    $(obj).addClass("tab-nav-active");
    pStatus = tag;
    setTimeout(function () {
        //重新加载数据
        LoadDataList('empty');
        myScroll.refresh();
        $("body").hideLoading();
    }, 500);
}

//点击遮罩层，隐藏筛选下拉
$(".alert").click(function () {
    $(".selectBox .ico-sj").removeClass("block");
    $(".ico-arrow-search").removeClass("hover");
    $(".selectList").slideUp();
    $(this).hide();
});

//加载数据
function LoadDataList(flag) {
    $(".debt-on").show();
    $(".debt-empty").hide();
    $("#dvLastTime").hide(); 

    if (flag == "empty") {
        $("#thelist").children().remove(); 
    } 
    jQuery.ajax({
        async: false,
        type: "post",
        url: "/ajaxCross/ZQZRAjax.ashx",
        dataType: "json",
        data: { Cmd: "GetZQZRCanTransferList", pageIndex: pageIndex, status: pStatus },
        success: function (jsonstr) { 
            $(".debt-on").show();
            pageCount = jsonstr.pageCount;
            if (isNaN(pageCount) || pageCount <= 1)
                $("#pullUp").hide();
            else
                $("#pullUp").show();
            if (jsonstr.result == "1") { 
                drawItemData(pStatus, jsonstr);
                if (pStatus == "Traning") {
                    $("#dvLastTime").show();
                    //刷新百分比统计
                    formatCircle(); 
                    //转站中结束倒计时
                    fnTimeCountDown();
                } else if (pStatus == "CanTran") {
                    bindDynamicEvent();
                }
            } else {
                $(".debt-on").hide();
                if (pStatus == "CanTran") {
                    $("#dvEmptyText").html("暂无可转让标的");
                } else if (pStatus == "Finished") {
                    $("#dvEmptyText").html("您还没有进行过债权转让哦！");
                } else if (pStatus == "Traning") {
                    $("#dvEmptyText").html("暂无转让中标的");
                }
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

function drawItemData(tag,jsonstr) {
    var html = new Array();
    var str = "";
    for (var i = 0; i < jsonstr.list.length; i++) { 
        var item = jsonstr.list[i];
        if (tag == "CanTran") {
            str = "<section class='mt10 bt-e6e6e6 bb-e6e6e6 pl15 bg-fff debt-list' onclick=\"javascript:window.location.href='/Member/Repayment/my_return_details.aspx?SubscribeId="+item.Id+"&ProjectId=" + item.ProjectId + "&backurl=" + curPageUrl + "';\">" +
                  " <div class='bb-e6e6e6 debt-list-title'>" +
                  "     <p class='f13px c-212121'>" + item.TypeName + "<span class='f13px c-808080 ml15'>" + item.Title + "</span></p>" +
                  "    <div class='apply-btn f13px c-ffffff pos-a' subscribeid='" + item.Id + "'>申请转让</div>" +
                  "  </div>" +
                  " <div class='debt-list-body pt10 pb10 pos-r'>" +
                  "     <p class='f12px c-ababab line-h16'><i class='ico ico-money1'></i>待收本息：<span class='f21px c-ffcf1f ml20'>￥" + item.DueInAmount + "</span></p>" +
                  "     <p class='f12px c-ababab mt10 line-h16'><i class='ico ico-income'></i>年化利率：<span class='f12px c-ababab ml20'>" + item.InterestRate + "%</span></p>" +
                  "     <p class='f12px c-ababab mt10 line-h16'><i class='ico ico-date1'></i>下次回款：<span class='f12px c-ababab ml20'>" + item.PreCycDateStr + "（第" + item.RefundedMonths + "/" + item.TotalRefundMonths + "期）</span></p>" +
                  "     <div class='pos-a c-ababab f12px debtWay line-h16'>" + item.RepaymentType + "</div>" +
                  " </div>" +
                 "</section>"; 
        } else if (tag == "Traning") {
            str = "<section class='"+(i==0?"":"mt10")+" bt-e6e6e6 bb-e6e6e6 pl15 bg-fff debt-list'>" + 
	              " <a href='/Member/Repayment/my_debt_detail.aspx?tab=Traning&subid=" + item.Id + "'><div class='bb-e6e6e6 debt-list-title'>" +
		          "     <p class='f13px c-212121'>" + item.Title + "</p>" +
	              "  </div>" +
	              " <div class='debt-list-body'>" +
	              "	    <p class='f12px c-ababab'><i class='ico ico-money1'></i>转让价：<span class='f21px c-ffcf1f ml20'>￥" + item.SumTransferAmount + "</span></p>" +
                  "<p class='f12px c-ababab mt10'><i class='ico ico-debt1'></i>转让本金<span class='f12px c-ababab ml20'>¥" + item.TotalAmountStr + "</span></p>" +
                  "    <div class='circle'>" +
                  "     <div class='pie_left'><div class='left'></div></div>" +
                  "     <div class='pie_right'><div class='right' style='transform: rotate(0deg);'></div></div>" +
                  "     <div class='mask'><span>" + item.ProgressStr + "</span>%</div>" +
                  "     </div>" +
                  " </div></a>" +
                 "</section> ";
             $(".timeSet").attr("count",item.LastSecond);
        } else {
            str = " <section class='mt10 bt-e6e6e6 bb-e6e6e6 pl15 bg-fff debt-list'>"+
	            " <a href='/Member/Repayment/my_debt_detail.aspx?tab=Finished&subid=" + item.Id + "'><div class='bb-e6e6e6 debt-list-title'>" +
	            "	<p class='f13px c-212121'>" + item.Title + "</p>" +
	            "</div>"+
	            "<div class='debt-list-body'>"+
	            "	<p class='f12px c-ababab'><i class='ico ico-money1'></i>转让价格<span class='f21px c-ffcf1f ml20'>￥" + item.SumTransferAmount + "</span></p>" +
	            "	<p class='f12px c-ababab mt10'><i class='ico ico-schedule'></i>转让进度<span class='f11px c-ababab ml20'>" + item.ProgressStr + "%（已完成）</span></p>" +
                "</div></a>"+
                "</section> ";
        }
        html.push(str);
    }
    $("#thelist").append(html.join(""));
}

//格式化百分比圆圈
function formatCircle() {
    $('.circle').each(function (index, el) {
        var num = $(this).find('span').text() * 3.6;
        if (num <= 180) {
            $(this).find('.right').css('transform', 'rotate(' + num + 'deg)');
        }
        else {
            $(this).find('.right').css('transform', 'rotate(180deg)');
            $(this).find('.left').css('transform', 'rotate(' + (num - 180) + 'deg)');
        };
        if (num == 360) {
            $(this).addClass("finish");
        };
    });
}
/*转让结束倒计时  start*/
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
    var hour = Math.floor((tcount / 3600)) > 0 ? zero(parseInt(tcount / 3600) % 24) : "00";
    var day = Math.floor((tcount / 86400)) > 0 ? parseInt(Math.floor((tcount / 86400))) : "0"; 
    return "<span style='color: #FA7256;'>" + hour + "</span>时<span style='color: #FA7256;'>" + mini+ "</span>分<span style='color: #FA7256;'>" + sec + "</span>秒";
}

function fnTimeCountDown() {
    $(".timeSet").each(function () {
        var timecount = parseInt($(this).attr("count"));
        if (timecount >= 0) {
            $(this).html(dv(timecount));
            if (timecount == 0) { 
                $(this).html("已结束");
            }
            timecount = timecount - 1;
            $(this).attr("count", timecount);
        }
    });
    setTimeout("fnTimeCountDown()", 1000);
}
/*转让结束倒计时  end*/

