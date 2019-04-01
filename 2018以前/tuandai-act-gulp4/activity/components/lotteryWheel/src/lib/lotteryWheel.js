import _findIdx from 'lodash.findindex';
let transitionEnd= function(){
  var el = document.createElement('p');
  var map={
    'WebkitTransition' : 'webkitTransitionEnd',
    'MozTransition' : 'transitionend',
    'OTransition' : 'oTransitionEnd',
    'msTransition' : 'MSTransitionEnd',
    'transition' : 'transitionend'
  }
  for (var transition in map) {
    if (null != el.style[transition]) {
      return map[transition];
    }
  }
  throw new Error('不支持 transitionend 事件');
}

class LotteryWheel{
  constructor(target,opts){
    this.el=typeof target==='string'?document.querySelector(target):target;
    this.opts=LotteryWheel.mergeOpts(opts);
    this.isRotating=false;
    this.init();
  }
  init(){
    this.el.style.transform=this.el.style.webkitTransform=`rotate(0)`;
    this.el.addEventListener(transitionEnd(),()=>{
      this.isRotating=false;
      this.callback&&this.callback();
    })
  }
  start(key,callback){
    if(this.isRotating) return;
    this.isRotating=true;
    let {duration,items}=this.opts;
    this.callback=callback&&callback.bind(this);
    let initDeg=duration/1000*360;
    let idx=_findIdx(items,item=>{
      return item.key===key;
    });
    let curDeg=items[idx].percent*360;
    let computedDeg=(()=>{
      let sliceItems=items.slice(0,idx+1);
      let percentsArr=sliceItems.map(item=>{
        return item.percent*360;
      });
      let rotateDeg=(()=>{
        let computed=percentsArr.reduce((x,y)=>{
          return x+y
        });
        return computed-Math.ceil(Math.random()*(curDeg-7.5))
        
      })();
      return rotateDeg;
    })();
    this.el.style.transition=this.el.style.webkitTransition=`${duration}ms cubic-bezier(0.34, 0.01, 0, 0.99)`;
    this.el.style.transform=this.el.style.webkitTransform=`rotate(${-computedDeg+initDeg}deg)`;
  }
  reset(){
    this.el.style.transition=this.el.style.webkitTransition=`0ms cubic-bezier(0.34, 0.01, 0, 0.99)`;
    this.el.style.transform=this.el.style.webkitTransform=`rotate(0)`;
  }
  static mergeOpts(opts){
    let defaults={
      duration:5000,
      items:[]
    };
    for(let i in opts){
      defaults[i]=opts[i];
    }
    return defaults;
  }
}

window.LotteryWheel=LotteryWheel;