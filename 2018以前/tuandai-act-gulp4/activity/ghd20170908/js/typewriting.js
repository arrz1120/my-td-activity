(function() {


	//打字效果

	var input_type = {
		init: function($obj, $objCon, callBack) {
			this.name = $obj.html().split("")
			this.length = this.name.length;
			this.i = 0;
			this.box = $objCon;
			this.callBack = callBack;
		},
		pri: function() {
			var $this = this
				//在此处只能使用闭包，因为windown.settimeout使函数的this指向object windown，而非原型链的this对象。而此时我需要递归，所以只能将this对象传到闭包内，递归匿名的闭包函数。
			return (function() {
				if ($this.i > $this.length) {
					window.clearTimeout(Go);



					$this.callBack && $this.callBack();
					return false;
				}
				var char = $this.name
				$this.box.append(char[$this.i])
				$this.i++
					var Go = window.setTimeout(arguments.callee, 35) //在这里arguments.callee妙用因为是匿名闭包，调用函数本身。
			})
		}
	}


	//建立class类
	function Input_type() {
		this.init.apply(this, arguments)
	}

	Input_type.prototype = input_type;


	window.Input_type = Input_type;
	// window.autoPlayAudio1 = autoPlayAudio1;





})();