(function() {
	FastClick.attach(document.body);
	//do your thing.

	//定义是否有礼品
	var hasGift = true;

	function index() {
		this.init();
		this.bindEvents();
	}

	index.prototype = {
		
		init:function(){
			//判断是否有礼品
			if(hasGift){
				$(".gift-item-box").show();
				$(".gift-none").hide();
			}else{
				$(".gift-item-box").hide();
				$(".gift-none").show();
			}
			
			//禁止弹框滑动
			$(".mask").on('touchmove',function(e){
//				e.preventDefault();
			})
		},

		bindEvents: function() {
			var _this = this;
			
			//显示规则
			$(".ruleBtn").click(function() {
				_this.showRuleMask();
			})
			
			//隐藏奖品
			$(".tit-l").click(function() {
				$(this).addClass('tab-cur');
				$(".tit-r").removeClass('tab-cur');
				$(".rule-con").fadeIn(200);
				$(".gift-con").hide();
			})
			
			//显示奖品
			$(".tit-r").click(function() {
				$(this).addClass('tab-cur');
				$(".tit-l").removeClass('tab-cur');
				$(".rule-con").hide();
				$(".gift-con").fadeIn(200);
			})
			
			//隐藏规则弹窗
			$(".confirm-btn").click(function(){
				_this.hideRuleMask();
			})
			
			//拆红包
			$("#open").click(function(){
				_this.showLoading();
			})
			
			//马上兑换
			$("#use200").click(function(){
				_this.show200();
			})
			
			//取消兑换
			$(".btn200-l").click(function(){
				_this.hide200();
			})	
			
			//确认兑换
			$(".btn200-r").click(function(){
				_this.result200();
			})		
		},
		
		//显示消耗200团币弹窗
		show200:function(){
			$("#mask200").show();
		},
		
		//隐藏消耗200团币弹窗
		hide200:function(){
			$("#mask200").hide();
		},
		
		//已兑换
		result200:function(){
			$("#use200").hide();
			$("#isChange").show();
			$("#mask200").hide();
		},
		
		//显示加载中弹窗
		showLoading:function(){
			$("#loadingMask").show();
		},
		//隐藏加载中弹窗
		hideLoading:function(){
			$("#loadingMask").hide();
		},
		
		//隐藏规则弹窗
		hideRuleMask:function(){
			$("#mask").hide();
			$(".rule-con").hide();
			$(".gift-con").hide();
			if($(".tit-r").hasClass('tab-cur')){
				$(".tit-r").removeClass('tab-cur');
				$(".tit-l").addClass('tab-cur');
			}
		},
		
		//显示规则弹窗
		showRuleMask: function() {
			$("#mask").show();
			$(".rule-con").show();
			$(".gift-con").hide();
		}

	}

	var newIndex = new index();

})();