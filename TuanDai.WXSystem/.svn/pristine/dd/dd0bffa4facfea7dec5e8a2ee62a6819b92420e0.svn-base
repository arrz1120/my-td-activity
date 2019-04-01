
var imgs;
var startY,endY;

$(function(){
	_s.init(750,1184);
	_s.zoomDom($(".box"),_s.ssh);
	_s.zoomDom($(".loading"),_s.ssh);
	initAll();
});

function initAll(){
	initEvent();

	new _s.PreloadImg({
		list:["images/p1.jpg","images/p2.jpg","images/p1_wx_icon.png","images/p8_huatong.png","images/shaxiao.png","images/p5.jpg","images/p9_anwse.png","images/p5_btn_answer.png"],
		progress:function(){
			$(".loading").hide();
			$(".box").fadeIn();
			playMusic("info");
		},
		end:function(){
		}
	});
}

function initEvent(){
	$("#p1 .btn_wx").click(function(){
		$("#p2").show();
		$("#p1").addClass("p1_act");
		pauseMusic("info");
		setTimeout(function(){
			$("#p1").remove();
			$("#p3").fadeIn(function(){
				$("#p2").remove();
			});
		},1500);
	});
	var move=true;
	$("#p3 .p3_quan").click(function(){
		
		$("#p4").css({left:_s.tw}).show().animate({left:0});
		$("#p3").animate({left:-_s.tw},function(){
			$(this).remove();
			if(move){
				setTimeout(function(){$(".shaxiao").show().addClass("fadeInUp");move=false;playMusic("SendMessage");},500);
			}
			setTimeout(showP5,2200);
		});
	});
	$("#p5 .btn_answer").click(function(){
		pauseMusic("VideoChat");
		$("#p6").fadeIn();
		$("#p5").fadeOut();
		playMusic("talk");

		setTimeout(function(){
			showP7();
		},4500)

	});
	$(".p7_bottom,.p7_weijing,.p7_quan").on("touchstart",function(){
			$(".p7_bottom,.p7_quan").hide();
			playMusic("SendMessage");
			showP9();
			$(".hua").removeClass("huaa")
		
	});

	$(".pup").click(function(){
		$(".pup,.p9_quan").fadeOut();
		setTimeout(function(){
		playMusic("SendMessage");
		$(".p9_huida2").show().addClass("fadeInUp");
		setTimeout(function(){
			playMusic("paopao");
			$(".qwbdw").show();
			$(".qwbdw1").show().addClass("bounceIn");
			setTimeout(function(){
			$(".qwbdw2").show().addClass("bounceIn");
			},200)
			setTimeout(function(){
				$(".qwbdz").fadeIn();
			},1500)
			},3000)
			},1000)
	})

	$(".qwbdw").click(function(){
		playMusic("paopao");
		$(".qwbdw").addClass("xiao").fadeOut();
		$(".jianhe").fadeIn(1000).addClass("bounceIn");
		setTimeout(function(){
			$(".app").fadeIn(1500)
		},1500)
	})

}

function showP5(){
	playMusic("VideoChat");
	$("#p5").fadeIn();
	$("#p4").fadeOut();
	$("#p5 .btn_answer").fadeIn();
}
function showP7(){
	$("#p6").fadeOut();
	$("#p4,#p7").show();
	$(".shaxiao").removeClass("fadeInUp");
}

function showP9(){
	$(".p9").show();
	$(".p8_huatong,.p8_anwse,.p8_songkai").hide();
	setTimeout(function(){
		playMusic("SendMessage");
		$(".p9_huida1").show().addClass("fadeInUp")
		
	},2000)

	setTimeout(function(){
		openMyposts();
	},4000)
}
function playMusic(id){
	document.getElementById(id).play();
}
function pauseMusic(id){
	document.getElementById(id).pause();
}

function openMyposts(){
    //location.href = "myposts.aspx";
    var jsonData = { HeadImg: HeadImg, NickName: NickName };
    var jsonStr = JSON.stringify(jsonData);
    PostSubmit("myposts.aspx", jsonStr);
}

function PostSubmit(url, data) {
    var postUrl = url; //提交地址  
    var postData = data; //第一个数据  
    var ExportForm = document.createElement("FORM");
    document.body.appendChild(ExportForm);
    ExportForm.method = "POST";
    var newElement = document.createElement("input");
    newElement.setAttribute("name", "jsondata");
    newElement.setAttribute("type", "hidden");
    ExportForm.appendChild(newElement);
    newElement.value = postData;
    ExportForm.action = postUrl;
    ExportForm.submit();
}; 