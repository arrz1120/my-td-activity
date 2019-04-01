(function() {
    FastClick.attach(document.body);
	    //do your thing.
	    
	var isApp = Jsbridge.isApp();    
	
	//前往团贷网投资
	$(".toInvest").click(function(){
		if(isApp){
			Jsbridge.toAppP2p();
		}else{
			location.href = 'https://m.tuandai.com/pages/invest/WE/WE_list.aspx';
		}
	})
	
	//前往团宝箱
	$(".toUserPrize").click(function(){
		if(isApp){
			Jsbridge.toAppTBX();
		}else{
			location.href = 'https://m.tdw.cn/Member/UserPrize/Index.aspx';
		}
	})

})();