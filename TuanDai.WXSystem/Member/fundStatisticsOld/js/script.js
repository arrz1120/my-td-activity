//图表高度计算
function heiCal(ele,baseHeight){
	var ele = $(ele);
	
	var heiArr = [];
	
	var tempArr = [];
	
	ele.find('.iData_p2').each(function(i,item){
		heiArr.push(parseInt((NumFormat($(item).html()))));
		tempArr.push(parseInt((NumFormat($(item).html()))));
	})
	var heiMax = heiArr[0];
	
	var sortArr = heiArr;
	
	//数值从大到小排序
	for(var i=0;i<sortArr.length;i++){
	    for(var j = i + 1;j<sortArr.length;j++){
	        if(sortArr[i]<sortArr[j]){
	            var tmp = sortArr[i];
	            sortArr[i] = sortArr[j];
	            sortArr[j] = tmp;
	        }
	    }
	}
	
	//获取最大值
	for(var i=1;i<=tempArr.length;i++){
		if(tempArr[i]>heiMax){
			heiMax = tempArr[i];
		}
	}
	
	//构造从大到小排序的数组的索引
	var indexArr = [];
	for(var i=0;i<sortArr.length;i++){
		for(var j=0;j<=tempArr.length;j++){
			if(sortArr[i] == tempArr[j]){
				indexArr.push({
					index:j,
					num: tempArr[j]
				});
			}
		}
	}
	
	//处理每一个高度的最小值
	var heightArr = [];
	for(var i=0;i<indexArr.length;i++){
		var tempHeight =  indexArr[i].num/heiMax * baseHeight /100 ;
		if(tempHeight>0&&tempHeight<0.1){
			tempHeight = 0.1
		}
		heightArr.push(tempHeight + 'rem');
	}
	
	//设置每一个高度以及层级
	
	for(var j=0;j<indexArr.length;j++){
		ele.find('.chartImg').eq(indexArr[j].index).css({
			'height' : heightArr[j],
			'z-index':j+1
		})
	}
	
	//设置坐标轴数值
	var y_num = ele.find('.y_num');
	var y_len = y_num.length;
	for(var i=y_len;i>=1;i--){
		var num = parseInt((heiMax)/y_len*i);
		y_num.eq(y_len-i).html(num);
	}
}


//其他收益进度条计算
function otherIncome() {
    var b1 = parseFloat(NumFormat($('#hbIncome').html())),
		b3 = parseFloat(NumFormat($('#inviteIncome').html())),
		b123 = b1  + b3,
		bar1 = $('#bar1'),
		bar3 = $('#bar3'),
		w1 = 0,
		w3 = 100;
	if(b123 == 0) {
		$(".oiBar").addClass('oiBarNone');
	} else {
	    if (b3 == 0) {
	        w1 = 100;
	        w3 = 0;
	    } else {
	        w1 = b1 / b123 * 100;
	        w3 = 100;
	    }
		bar1.width(w1 + '%');
		bar3.width(w3 + '%');
	}
}

function NumFormat(num) {
    if (num != undefined)
        return num.replace(",", "").replace(",", "").replace(",", "");
    else
        return num;
}

function aniShow(ele,toShow){
    var toShow = $(toShow);
    $(ele).on('click',function(){
        toShow.removeClass('hide');
        toShow.removeClass('aniFadeOut').addClass('aniFadeIn');
        toShow.find('.alert_con').removeClass('aniHide').addClass('aniShow');
    })
}
function aniHide(parent){
    parent.removeClass('aniFadeIn').addClass('aniFadeOut');
    parent.find('.alert_con').removeClass('aniShow').addClass('aniHide');
    setTimeout(function(){
        parent.addClass('hide');
    },400);
}



$(function() {
	heiCal('#iChartBox1',200);
	heiCal('#iChartBox2',200);
	heiCal('#iChart-zhixiang',200);
	heiCal('#iChartBox3',358);
	
	$(".incomeTab").find('.lf').each(function(i,item){
		$(item).click(function(){
			incomeSwiper.slideTo(i,300,true);
		})
	})
	
	var swiper1 = new Swiper('#swiper1', {
		onSlideChangeStart:function(swiper){
			var index = swiper.activeIndex;
			var item = $('#swiper-tab1').find(".lq-item");
			item.removeClass('lq-item-cur');
			item.eq(index).addClass('lq-item-cur');
		}
	});
	
	$('#swiper-tab1').find(".lq-item").each(function(i,item){
		$(item).click(function(){
			swiper1.slideTo(i,300,true)
		})
	})
	
	var incomeSwiper = new Swiper('#incomeSwiper',{
		onSlideChangeStart:function(swiper){
			var index = swiper.activeIndex;
			var item = $('#swiper-tab2').find(".lq-item");
			item.removeClass('lq-item-cur');
			item.eq(index).addClass('lq-item-cur');
		}
	});
	
	$('#swiper-tab2').find(".lq-item").each(function(i,item){
		$(item).click(function(){
			incomeSwiper.slideTo(i,300,true)
		})
	})
	
	otherIncome();
	
	aniShow('#a1','#alert1');
	aniShow('#a2','#alert2');
	$(".alert").on('touchmove',function(e){
    	e.preventDefault();
	})
	$(".iKnow").on('click',function(e){
	    aniHide($(this).parent().parent());
	})
})