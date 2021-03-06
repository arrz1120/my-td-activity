﻿//显示统计圈
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
          //非流标项目时
            if (!$(this).hasClass("circle5") && !$(this).hasClass("circle6"))
                $(this).addClass("finish");
        };
    });
}

function LoadBorrowList(flag) {
    
    if (flag == "empty") {
        $("#list").html("");
    }
    jQuery.ajax({
        type: "post",
        url: "/ajaxCross/BorrowAjax.ashx",
        dataType: "json",
        data: { Cmd: "GetMyLoanShowList", statusStr: queryStatus, pageIndex: pageIndex },
        success: function (jsonstr) {
            if (flag == "empty") {
                $("#list").html("");
            }
            var html = new Array();
            var str = "";
            if (jsonstr.result == "1") {
                pageCount = jsonstr.pagecount;
                for (var i = 0; i < jsonstr.list.length; i++) {
                    str = '<div class="pl15 mt10 bt-e6e6e6 bb-e6e6e6 bg-fff" onclick="javascript:window.location.href=\'' + jsonstr.list[i].LinkUrl + '\'">' +
                    '<div class="load_t clearfix">'+
                       '<div class="lf text-overflow f14px">[' + jsonstr.list[i].ProjectType + ']' + jsonstr.list[i].Title + '</div>' +
                        jsonstr.list[i].MonthsStr +
                    '</div>'+
                    '<div class="load_c bt-e6e6e6">'+
                        '<div class="clearfix">'+
                            '<div class="lf w50p c-ababab">周转金额<span class="ml20">' + jsonstr.list[i].HaveBorrowedAmount + '</span></div>' +
                            '<div class="lf w50p p15 c-ababab">发标时间<span class="ml20">' + jsonstr.list[i].AddDate + '</span></div>' +
                        '</div>'+
                        '<div class="clearfix mt3">'+
                            '<div class="lf w50p c-ababab">周转期限<span class="ml20">' + jsonstr.list[i].DeadlineStr + '</span></div>' +
                            '<div class="lf w50p p15 c-ababab">年化利率<span class="ml20">' + jsonstr.list[i].InterestRate + '%</span></div>' +
                        '</div>'+
                    '</div>'+
                '</div>';

                    html.push(str);
                }

                $("#list").append(html);
                //刷新百分比统计
                //formatCircle();
                if (jsonstr.list.length > 0)
                    $("#dvInterest").html("￥" + jsonstr.list[0].PrincipalInterest);
                else
                    $("#dvInterest").html("￥0.0");

                if (pageCount <= 1) {
                    $("#pullUp").hide();
                } else {
                    $("#pullUp").show();
                }
            }
            else {
                $("#list").html("");
                pageCount = 0;
                $("#pullUp").before('<div id="thelist" style="margin:0;padding:0;"><div class="debt-empty mt50"><div class="img-debt-empty text-center"><img style="width: 60%;" src="/imgs/images/debt-empty.png"></div><div class="text-center f14px c-212121 mt20">暂无周转记录！</div></div></div>');
                $("#pullUp").hide(); 
            }
            myScroll.refresh();
        },
        error: function () {
            $("#list").html("");
            pageCount = 0;
            $("#pullUp").before('<div id="thelist" style="margin:0;padding:0;"><div class="debt-empty mt50"><div class="img-debt-empty text-center"><img style="width: 60%;" src="/imgs/images/debt-empty.png"></div><div class="text-center f14px c-212121 mt20">暂无周转记录！</div></div></div>');
            $("#pullUp").hide();
        }
    });
}