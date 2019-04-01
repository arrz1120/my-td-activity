(function() {
	FastClick.attach(document.body);

	var singleCount = []
	var len = $(".single-select").length;
	for(var i = 0; i < len; i++) {
		singleCount.push(0);
	}
	var singleSelectAll = false;
	var moreSelect = false;
	var moreCount = [0,0,0,0];
	
	var answerObj = {
		
	}
	
	//a卷单选
	$(".testing-item").eq(0).find(".single-select").each(function(i, item) {
		var li = $(item).find('li');
		li.each(function(j, opt) {
			$(opt).click(function() {
				li.removeClass('selected');
				$(this).addClass('selected');
				var key_name = 'a'+ (i+1);
				answerObj[key_name] = j+1;
				singleSelectCheck(i);
			})
		})
	})
	
	//b卷单选
	$(".testing-item").eq(1).find(".single-select").each(function(i, item) {
		var li = $(item).find('li');
		li.each(function(j, opt) {
			$(opt).click(function() {
				li.removeClass('selected');
				$(this).addClass('selected');
				var key_name = 'b'+ (i+1);
				answerObj[key_name] = j+1;
				singleSelectCheck(i+7);
			})
		})
	})

	//a卷多选
	$(".more-select").find('li').each(function(i, item) {
		$(item).click(function() {
			if($(this).hasClass('selected')){
				$(this).removeClass('selected');
				moreSelectCheck(0,i);
			}else{
				$(this).addClass('selected');
				moreSelectCheck(1,i);
			}
			
		})
	})

	//单选校验
	function singleSelectCheck(index) {
		singleCount[index] = 1;
		var temp = singleCount.join(';');
		if(temp.indexOf(0) == -1) {
			singleSelectAll = true;
		} else {
			singleSelectAll = false;
		}
		submitDeal();
	}

	//多选校验
	function moreSelectCheck(isSelect,index) {
		moreCount[index] = isSelect;
		var temp = moreCount.join('');
		if(temp.indexOf(1) != -1) {
			for(var i=0;i<moreCount.length;i++){
				if(moreCount[i] == 1){
					moreCount[i] = i+1;
				}
			}
			var answerTemp = moreCount.join('').replace(/0/g,'').split('').join(',');
			answerObj.a8 = answerTemp;
			moreSelect = true;
		} else {
			moreSelect = false;
		}
		submitDeal();
	}
	
	function submitDeal(){
		if(singleSelectAll && moreSelect){
			$(".testing-btn").removeClass('btn-ban').addClass('btn-on');
			console.log(answerObj);
			 submitEvent();
		}else{
			$(".testing-btn").removeClass('btn-on').addClass('btn-ban');
		}
	}
	
	function submitEvent(){
		$(".btn-on").unbind();
		$(".btn-on").on('click',function(){
			$.ajax({
				type:"POST",
				url:"/wap/risk/submit",
				async:true,
				dataType:"json",
				data:{'result':JSON.stringify(answerObj)},
				success:function(data){
					console.log(data);
				},
				error:function(res){
					console.log(res);
				}
			});
		})
	}
	
	$(".back-btn").click(function(){
		window.history.back();
	})

})();