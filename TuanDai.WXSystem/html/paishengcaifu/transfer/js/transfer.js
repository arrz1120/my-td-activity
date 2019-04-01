(function() {
    FastClick.attach(document.body);
	    //do your thing.
	    
	$("#input").on('input',function(){
		var val = $(this).val();
		var amo = $("#amo").html();
		console.log(val);
		if(val.length > 0){
			$(".con-btn").addClass('btn-on');
		}else{
			$(".con-btn").removeClass('btn-on');
		}
		if(val>amo){
			val = amo;
		}
	})
	
	$("#tranAll").on('click',function(){
		$("#input").val($("#amo").html());
		$(".con-btn").addClass('btn-on');
	})
})();