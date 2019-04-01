var isWePlan = false;
//投资弹框
function moveToTopNew(ele) {
    $(ele).removeClass('moveToBottom').removeClass('hide').addClass('moveToTop');
}
function moveToBottomNew(ele) {
    $(ele).removeClass('moveToTop').addClass('moveToBottom');
    setTimeout(function () {
        $(ele).addClass('hide');
    }, 500);
}

//	选择投资红包弹窗调用
var scrollT="";
function rpmoveToTop(open,target){
    $(open).click(function(){
        scrollT = $(window).scrollTop();
        $(target).removeClass('hide').removeClass('moveToBottom').addClass('moveToTop');
        $('.rp-ways').stop().animate({ scrollTop: 0 }, 10);
        setTimeout(function(){
//                $("#bigDiv").hide();
        },400);
    });
}

function rpmoveToBottom(close,target){
    $(close).click(function(){
//            $("#bigDiv").show();
        $(window).scrollTop(scrollT);
        $(target).removeClass('moveToTop').addClass('moveToBottom');
        setTimeout(function(){
            $(target).addClass('hide');
        },400);
    })
}


function formatNewDate(date) {
    return date.substr(0, date.indexOf(" ")); 
}
/*======================投资红包处理  allen 2017-06-03======================*/

$(function () {
    if (RedPacketObj == null) {
        return;
    }
    /*投资使用红包 allen 2017-06-03*/
	  $("#ues_rp").click(function () {
	    $("#invest_alert").addClass("hide");
	  });

    rpmoveToTop("#ues_rp", '#rp_ways');

    //申购框
    $('#InvestMinus,#InvestAdd').on('click', function () {
        $('#InvestShares').change();
    });
    $('#InvestShares').change(function () { 
        calcPrizeStatus();
    }); 
});

//份数变化时重新计算红包状态
function calcPrizeStatus() {
    var txtAmount = getInputAmount();
    var curItemName = $("#redValue").text();
    var curprizeid = $("#redValue").attr("prizeid");
    if (curprizeid == undefined)
        curprizeid = "";

    if (curItemName != "不使用优惠券") {
        $("#rpList").html(getShowRedPacketList());
        var firstPrize = calcFirstPrize(txtAmount);
        $(".ticket-con").find(".icon-used").remove();
        if (firstPrize.PrizeId != "") {
            //判断之前有无选择，有选择判断是否符合规则，不符合则替换，否则保持不变
            if (curprizeid != "") {
                //不使用优惠券
                var findObj = null;
                $.each(RedPacketObj.PrizeList, function (i, item) {
                    if (item.PrizeId == curprizeid) {
                        findObj = item;
                        return false;
                    }
                });
                if (findObj != null && findObj.InvestAmount > txtAmount) {
                    //
                } else {
                    firstPrize.PrizeId = findObj.PrizeId;
                    firstPrize.ItemName = findObj.ItemName;
                    firstPrize.PrizeType = findObj.PrizeType;
                    firstPrize.PrizeValue = findObj.PrizeValue;
                }
            }
            PrizeAddRate = 0;
            $(".ticket-con[prizeid=" + firstPrize.PrizeId + "]").append('<span class="icon-used"></span>')
            $("#redValue").attr("prizeid", firstPrize.PrizeId);
            var itemName = "";
            if (firstPrize.PrizeType == 1)
                itemName = firstPrize.PrizeValue + "%加息券";
            else
                itemName = firstPrize.PrizeValue + "元投资红包";
            $("#redValue").html(itemName);
            if (firstPrize.PrizeType == 1) {
                PrizeAddRate = firstPrize.PrizeValue;
            }
        } else {
            $("#redValue").attr("prizeid", "");
            $("#redValue").html("无适用优惠券");
            PrizeAddRate = 0;
        }

        //注册红包选择事件
        initRedFormEvent();
        //计算加息
        calcAddRateInterest();
    }
}
//录入金额后计算一个最优的红包
function calcFirstPrize(tenderAmount) {
    var prizeId = "";
    var itemName = "";
    var prizeType = 2;
    var prizeValue = 0;

    RedPacketObj.PrizeList = sortPrize(RedPacketObj.PrizeList);

    $.each(RedPacketObj.PrizeList, function (i, item) {
        if (item.IsAllowUsed && item.InvestAmount <= tenderAmount) {
            prizeId = item.PrizeId;
            itemName = item.ItemName;
            prizeType = item.PrizeType;
            prizeValue = item.PrizeValue;
            return false;
        }
    });
    return { PrizeId: prizeId, ItemName: itemName, PrizeType: prizeType, PrizeValue: prizeValue };
}

function getInputAmount() {
    var shares = $("#InvestShares").val();
    if (shares.indexOf("投资") > -1) {
        shares = $("#InvestShares").val();
        shares = shares.replace("投资 ", "").replace(" 份", "");
    }
    return parseInt(shares) * LowerUnit;
}
//组装红包显示列表
function getShowRedPacketList() {
    var curPrizeId = $("#redValue").val();
    if (curPrizeId == undefined || curPrizeId == null)
        curPrizeId = "";
    var txtAmount = getInputAmount();
    $.each(RedPacketObj.PrizeList, function (i, item) {
        if (item.IsAllowUsed) {
            item.IsCalcNoUsed = 0;
            item.NoUseDesc = "";
            if (item.InvestAmount > txtAmount) {
                item.IsCalcNoUsed = 1;
                item.NoUseDesc = "单笔投资金额不满" + item.InvestAmount + "元";
            }
        } else {
            item.IsCalcNoUsed = 1;
        }
    });
    //排序
    RedPacketObj.PrizeList = sortPrize(RedPacketObj.PrizeList);

    var redpacketHtml = "";
                      
    if (RedPacketObj.PrizeList == null || RedPacketObj.PrizeList.length == 0) {
        redpacketHtml += '<div class="tips-box1">' +
                         '<img src="/imgs/invest/no-record.png" alt="">' +
                         '<p class="p1">暂时没有优惠券哦~</p>' +
                         ' </div>';
    } else {
        redpacketHtml += '<div class="ticket-con red pos-r bg-fff" prizetype="0" prizeid="">' +
			            '  <div class="ticket-d-wrap rp-pt">' +
				        '    <div class="tx-ticket-details pos-r">' +
					    '        <p class="p1">不使用优惠券</p>' +
				        '    </div>' +
			            '  </div>' +
		                '</div>';
    }
    $.each(RedPacketObj.PrizeList, function (i, item) {
        var attrHtml = 'prizeid="' + item.PrizeId + '" prizetype="' + item.PrizeType + '" prizevalue="' + item.PrizeValue + '"';
        var prizeName = "";
        if (item.PrizeType == 1)
            prizeName = "<span>" + item.PrizeValue + "%</span>加息券";
        else
            prizeName = "<span>" + item.PrizeValue + "元</span>投资红包";
        var prizeDateStr = "";
        if (item.UseBeginDate != null) { 
            prizeDateStr = formatNewDate(item.UseBeginDate);
        }
        if (item.ExpireDate != null)
            prizeDateStr += " - " + formatNewDate(item.ExpireDate);
        if (prizeDateStr == "") {
            prizeDateStr = "永不过期";
        }
        if (item.IsAllowUsed && item.IsCalcNoUsed == 0) {
            redpacketHtml += '<div class="ticket-con red pos-r bg-fff" ' + attrHtml + ' >' +
                           ' <div class="ticket-d-wrap rp-pt">' +
                           '     <div class="tx-ticket-details pos-r">' +
                           '         <p class="p1">' + prizeName + '</p>' +
			               '		<p class="use">满' + item.InvestAmount + '元使用</p>' +
			               '		<p class="date">有效期：' + prizeDateStr + '</p>' +
			               '	</div>' +
			               '</div>' +
		   	              (curPrizeId==item.PrizeId? '<span class="icon-used"></span>':"") +
                          '</div>';
        } else {
            redpacketHtml += '<div class="ticket-con gray pos-r bg-fff" ' + attrHtml + '>' +
                            '  <div class="ticket-d-wrap rp-pt">' +
                            '     <div class="tx-ticket-details pos-r">' +
                            '         <p class="p1">' + prizeName + '</p>' +
                            '		<p class="use">满' + item.InvestAmount + '元使用</p>' +
                            '		<p class="date">有效期：' + prizeDateStr + '</p>' +
                            '		<p class="no-use pos-r"><span>不可用原因：</span>' + item.NoUseDesc + '</p>' +
                            '	</div>' +
                            ' </div>' + 
                            '</div> ';
        }
    });
   
    return redpacketHtml;
}
/**
 * 红包列表排序
 * @param {} list 
 * @returns {} 
 */
function sortPrize(list) { 
    var newList = [];
    $.each(list,function (i,j) {
        if (newList.length == 0) newList.push(j);
        else {
            var isAllowUsedJ = j.IsAllowUsed ? 1 : 0;//是否可用     && (j.IsCalcNoUsed || 0) == 0
            var index = 0;

            $.each(newList,function (k,h) {
                var isAllowUsedH = h.IsAllowUsed ? 1 : 0;//是否可用
                if (isAllowUsedJ > isAllowUsedH) {//0.按默认可用状态排
                    index = k;
                    return false;
                }

                if (j.IsCalcNoUsed < h.IsCalcNoUsed) {//1.按金额调整后可用状态排
                    index = k;
                    return false;
                }

                if (isAllowUsedJ == isAllowUsedH && j.IsCalcNoUsed == h.IsCalcNoUsed && j.PrizeType < h.PrizeType) {//2.再按类型排
                    index = k;
                    return false;
                }

                if (isAllowUsedJ == isAllowUsedH && j.IsCalcNoUsed == h.IsCalcNoUsed && j.PrizeType == h.PrizeType && j.ExpireDate < h.ExpireDate) {//3.再按过期时间排
                    index = k;
                    return false;
                }

                if (isAllowUsedJ == isAllowUsedH && j.IsCalcNoUsed == h.IsCalcNoUsed && j.PrizeType == h.PrizeType && j.ExpireDate == h.ExpireDate && j.PrizeValue > h.PrizeValue) {//4.再按红包金额排
                    index = k;
                    return false;
                }

                index = k + 1;
            });
            if (index == newList.length) newList.push(j);
            else newList.splice(index,0,j);
        } 
    });
    return newList;
}

function initRedFormEvent() {
	  $("#rpways_close").click(function () {
	     $("#invest_alert").removeClass("hide");
	  });
	
    rpmoveToBottom('#rpways_close', '#rp_ways');

    //	获取投资红包的的值
    $(".ticket-con").on("click", function () {
    	 $("#invest_alert").removeClass("hide");
        var rpValue = $(this).find(".p1").text();
        $("#redValue").html(rpValue);
        $(".ticket-con").find(".icon-used").remove();
        $(this).append('<span class="icon-used"></span>');
        $("#redValue").attr('prizeid', $(this).attr("prizeid"));

        if ($(this).attr('prizetype') == "1") {
            PrizeAddRate = parseFloat($(this).attr('prizevalue'));
            $("#spPrizeInterest").show();
            calcAddRateInterest();
        } else {
            $("#spPrizeInterest").hide();
        }
        moveToBottomNew("#rp_ways");
    });
    //解除绑定事件
    $("#rpList").find('.gray').off('click');
}

function calcAddRateInterest() {
    if (PrizeAddRate <= 0 || !isWePlan) {
        $("#spPrizeInterest").hide();
        return;
    } else { 
        $("#spPrizeInterest").show(); 
    }
    var RepaymentType = 1;
    var shares = $("#InvestShares").val();
    if (shares.indexOf("投资") > -1) {
        shares = $("#InvestShares").val();
        shares = shares.replace("投资 ", "").replace(" 份", "");
    }
    if (shares == "") {
        shares = 0;
    }
    var addProfit = GetInterestAmount((parseInt(shares) * parseFloat(LowerUnit)), RepaymentType, deadLine, PrizeAddRate);
    $("#spPrizeInterest").text("+￥" + fmoney((Math.floor(Number(addProfit) * 100) / 100).toString()));
}