/*
 *
 * depand ： jquery,swiper
  author : chenrunrong,
  date ： 20160126，
  version : 1.0
 * 
 * 
 * */

function monthSwiper(options){
	var objDate = new Date();
	var	startMonth = options==undefined ? objDate.getMonth()+1 : options.startMonth,
		monthCount = options==undefined ? 6 : options.monthCount;
	if(startMonth>12){
		startMonth=12
	}
	if(startMonth<1){
		startMonth=1
	}
	if(startMonth==undefined){
		startMonth = objDate.getMonth()+1;
	}
	if(monthCount==undefined){
		monthCount = 6;
	}
	this.callBack = options==undefined ? undefined : options.slideCallBack;
	this.year = objDate.getFullYear();
	this.startMonth = startMonth;
	this.monthCount = monthCount;
	this.init();
}

monthSwiper.prototype = {
	//初始化调用
	init:function(){
		var monthIndex = this.startMonth-1;
		var monthCount = this.monthCount;
		for(var i=0;i<monthCount;i++){
			monthIndex++;
			if(monthIndex>12){
				monthIndex = 1;
				this.year += 1;
			}
			this.getDate(monthIndex);
			
		}
		this.setCss();
		this.addTodayStyle();
		this.initSwiper();
		this.addTipsEvent();
	},
	//获取指定月份有多少天、第一天是星期几、第一天是星期几
	getDate:function(monthIndex){
		var objDate = new Date();
		objDate.setYear(this.year);
		objDate.setMonth(monthIndex);
	 	objDate.setDate(0);
   	  	var days =  objDate.getDate();
   	  	objDate.setDate(1);
		var weekday =  objDate.getDay();
		this.buildDom(monthIndex,days,weekday);
	},
	//创建布局
	buildDom:function(monthIndex,days,weekday){
		var strDay = '';
		var $ul = $('<ul class="date_row date_ul clearfix"></ul>');
		var swiperSlide = $('<div class="swiper-slide"></div>');
		if(weekday!=0){
			for(var i=0;i<weekday;i++){
				strDay += '<li></li>';
			}
		}
		for(var i=1;i<=days;i++){
			strDay += '<li>'+i+'</li>';
		}
		$ul.attr({'year':this.year,'month':monthIndex}).html(strDay);
		swiperSlide.append($ul);
		$(".swiper-wrapper").append(swiperSlide);
	},
	//控制样式适配各种屏幕
	setCss:function(){
		var margin = ($(window).width()-36*7)/14 + 'px';
	  	$('.date_row').find('li').css({
	  		'margin-left':margin,
	  		'margin-right':margin
	  	});
	},
	//给当天加样式
	addTodayStyle:function(){
	  	var firstMonthLi = $(".swiper-slide:first").find('li');
	  	firstMonthLi.each(function(i){
	  		var eqLi = firstMonthLi.eq(i);
	  		if(eqLi.html()==(new Date()).getDate()){
	  			eqLi.addClass('today');
	  		}
	  	})
	},
	//初始化swiper
	initSwiper:function(){
		var _this = this;
		var swiper = new Swiper ('#swiper', {
		    direction: 'horizontal',
		    pagination: '#date_mark',
		    onSlideChangeStart:function(swiper){
		    	if(_this.callBack!=undefined && typeof _this.callBack == 'function'){
			    	_this.callBack(swiper.activeIndex);
		    	}
		    }
	  	});
	  	return swiper;
	},
	//绑定事件
	addTipsEvent:function(){
		var allLi = $("#swiper").find('li'),
			_this = this;
		allLi.click(function(e){
	  		if($(this).hasClass('red')){
		  		if($(this).hasClass('selected')){
		  			_this.removeTips(allLi);
		  		}else{
  					_this.removeTips(allLi);
		  			_this.addTips($(this));
		  		}
	  		}else{
	  			_this.removeTips(allLi);
	  		}
	  	})
	},
	//添加回款金额提示
	addTips:function(obj){
		obj.addClass('selected');
		obj.append('<div class="returnMoney rf">回款：'+ obj.attr('money') +'元</div>').append('<div class="triangle-up"></div>');
		if(obj.offset().left<=70){
  			obj.find('.returnMoney').removeClass('rf').addClass('lf');
  		}
	},
	//移除回款金额提示
	removeTips:function(obj){
		obj.removeClass('selected');
		$('.returnMoney').remove();
		$('.triangle-up').remove();
	},
	//高亮显示回款日，并把回款金额绑定到当日li的money属性上
	lightDay:function(data){
//		for(var i=0;i<data.length;i++){
//			var month = data[i].month,
//				day = data[i].day,
//			    monthSlide = $("#swiper").find("ul[month="+ month+"]");
//			if(monthSlide.html()!=undefined){
//				var liSlide = monthSlide.find('li');
//				for(var m=0;m<day.length;m++){;
//					liSlide.each(function(j){
//						var eqLi = liSlide.eq(j);
//						if(eqLi.html() == day[m].day){
//							eqLi.addClass('red').attr('money',day[m].money);
//						}
//					})
//				}
//			}
//		}
	}
}