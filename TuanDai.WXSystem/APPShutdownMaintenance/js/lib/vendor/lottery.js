function roll(){if(lottery.times+=1,lottery.roll(),lottery.times>lottery.cycle+10&&lottery.prize==lottery.index)clearTimeout(lottery.timer),lottery.prize=-1,lottery.times=0,click=!1;else{if(lottery.times<lottery.cycle)lottery.speed-=10;else if(lottery.times==lottery.cycle){var a=Math.random()*lottery.count|0;lottery.prize=a}else lottery.speed+=lottery.times>lottery.cycle+10&&(0==lottery.prize&&7==lottery.index||lottery.prize==lottery.index+1)?110:20;lottery.speed<40&&(lottery.speed=40),lottery.timer=setTimeout(roll,lottery.speed)}return!1}var lottery={index:-1,count:0,timer:0,speed:20,times:0,cycle:50,prize:-1,init:function(a){$("#"+a).find(".lottery-unit").length>0&&($lottery=$("#"+a),$units=$lottery.find(".lottery-unit"),this.obj=$lottery,this.count=$units.length,$lottery.find(".lottery-unit-"+this.index).addClass("active"))},roll:function(){var a=this.index,b=this.count,c=this.obj;return $(c).find(".lottery-unit-"+a).removeClass("active"),a+=1,a>b-1&&(a=0),$(c).find(".lottery-unit-"+a).addClass("active"),this.index=a,!1},stop:function(a){return this.prize=a,!1}};!function(a){var b=function(b){var c=this;c.config={index:-1,count:0,timer:0,speed:20,times:0,cycle:50,prize:-1},b&&(c.config=a.extend(c.config,config||{})),c.init()};b.prototype={constructor:b,init:function(){a("#"+this.config.id).find(".lottery-unit").length>0&&($lottery=a("#"+this.config.id),$units=$lottery.find(".lottery-unit"),this.config.obj=$lottery,this.config.count=$units.length,$lottery.find(".lottery-unit-"+this.config.index).addClass("active"))},roll:function(){var b=this.confit.index,c=this.confit.count,d=this.confit.obj;return a(d).find(".lottery-unit-"+b).removeClass("active"),b+=1,b>c-1&&(b=0),a(d).find(".lottery-unit-"+b).addClass("active"),this.config.index=b,!1},stop:function(a){return this.config.prize=a,!1}}}(window.Zepto||window.jQuery);