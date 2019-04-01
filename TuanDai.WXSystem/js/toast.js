// msgBox
(function(win,MsgBox){

	function createMask(){
		var div = document.createElement("div");
		div.setAttribute("id","mask");
		return div;
	};

	MsgBox.comfirm = function(title,content,callback){
		var mask = createMask();
		var div = document.createElement("div"),
			str = '<p>'+title+'</p><p>'+content+'</p><a class="sureBtn">确定</a>';
			div.setAttribute("class","msgBox1");
			div.innerHTML = str;
		document.body.appendChild(mask);
		document.body.appendChild(div);
		div.offsetHeight;
		mask.classList.add("in");
		div.classList.add("show");
		// add events
		div.querySelector(".sureBtn").addEventListener("click",function(ev){
			div.classList.remove("show");
			mask.classList.remove("in");
			div.remove();
			if(typeof callback === 'function'){
				callback();
			};
		});
		mask.addEventListener("transitionend",function(ev){
			if(!mask.classList.contains("in")){
				mask.remove();
			}
		});
	};

	MsgBox.alert = function(title,callback){
		var mask = createMask();
		var div = document.createElement("div"),
			str = '<p class="ct0">'+title+'</p><a class="sureBtn">确定</a>';
			div.setAttribute("class","msgBox1");
			div.innerHTML = str;
		document.body.appendChild(mask);
		document.body.appendChild(div);
		div.offsetHeight;
		mask.classList.add("in");
		div.classList.add("show");
		// add events
		div.querySelector(".sureBtn").addEventListener("click",function(ev){
			div.classList.remove("show");
			mask.classList.remove("in");
			div.remove();
			if(typeof callback === 'function'){
				callback();
			};
		});
		mask.addEventListener("transitionend",function(ev){
			if(!mask.classList.contains("in")){
				mask.remove();
			}
		});
	};

	MsgBox.toast = function(content,duration){
		var div = document.createElement("div"),
			delayTiem = duration || 1000;
		div.classList.add("toast");
		div.innerHTML = content;
		// event
		div.addEventListener("transitionend",function(){
			if(!div.classList.contains("active")){
				div.parentNode.removeChild(div);
				div = null;
			}
		});
		div.addEventListener("click",function(){
			div.parentNode.removeChild(div);
			div = null;
		});
		// transition
		document.body.appendChild(div);
		div.offsetHeight;
		// fadein
		div.classList.add("active");
		//
		setTimeout(function(){
			div && div.classList.remove("active");
		},delayTiem);
	};
})(window, window.MsgBox || (window.MsgBox={}));