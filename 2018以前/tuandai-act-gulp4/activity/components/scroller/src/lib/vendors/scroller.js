let self;
let timer;
let winH=window.innerHeight;
let getRect=function(el){
  return typeof el==='string'?
    document.querySelector(el).getBoundingClientRect()
    :
    el.getBoundingClientRect();
}
class Scroller{
  constructor(el,opts){
    self=this;
    this.el=typeof el==='string'?document.querySelector(el):el;
    this.el.style.overflow='hidden';
    this.opts=Scroller.mergeOpts(opts);
    this.target=typeof this.opts.target==='string'?document.querySelector(this.opts.target):this.opts.target;
    this.init();
  }
  init(){
    this.y=0;
    this.isStartY=true;
    this.isEndY=false;
    this.getWH();
    this.directionY=null;
    this.pullBounceY=0;
    this.pushBounceY=0;
    this.touch={
      y:0,//moveY
      startY:0,// pageY
      curY:0,// currentY
      diffY:0,// distanceY
      flipStartY:0,//惯性滚动开始Y
      flipY:0,// 惯性滚动距离Y
      isFlipY:false,//是否惯性滚动Y
    };
    this.timestamp={
      prev:0,
      next:0,
    };
    this.inertia={
      startY:0,
      increaseY:0,
      directionY:'',
    };
    this.enabled();
    this.opts.onInit&&this.opts.onInit.call(this);
  }

  //计算容器高度
  getWH(){
    let maxScrollY;
    this.elRect=getRect(this.el);
    this.targetRect=getRect(this.target);
    this.isEndY=this.isStartY=false;
    maxScrollY=this.targetRect.height-this.elRect.height;
    if(maxScrollY>=0){
      if(maxScrollY<this.maxScrollY){
        this.scrollTo(maxScrollY);
      }
      this.maxScrollY=maxScrollY;
      this.isStartY=this.y===0?true:false;
    }else{
      this.maxScrollY=0;
      this.scrollStart();
      this.isEndY=this.isStartY=true;
    }
  }

  //touchstart 事件
  onTouchStart(event){
    let touch=event.touches[0];
    self.touch.curY=self.touch.startY=touch.pageY;
    self.touch.flipStartY=0;
    self.timestamp.prev=Date.now();
    self.target.style.webkitTransition=self.target.style.transition=`0s`;
    self.opts.onTouchStart&&self.opts.onTouchStart.call(this);
  }

  //touchmove 事件
  onTouchMove(event){
    event.preventDefault();
    let translateY;
    let touch=event.touches[0];
    let prevTimestamp=self.timestamp.prev;
    self.timestamp.prev=Date.now();
    self.directionY=touch.pageY-self.touch.curY>0?'pull':'push';
    self.touch.curY=touch.pageY;
    self.touch.diffY=touch.pageY-self.touch.startY;
    self.touch.flipY=(()=>{
      if(self.timestamp.prev-prevTimestamp>25){
        self.touch.flipStartY=self.touch.diffY;
        self.touch.isFlipY=false;      
      }else{
        self.touch.isFlipY=true;
      }
      return self.touch.diffY-self.touch.flipStartY
    })();
    translateY=self.touch.y+self.touch.diffY;
    self.isStartY=self.isEndY=false;

    if(translateY>0){
      self.isStartY=true;
      translateY*=.25;
      self.pullBounceY=translateY;
      self.touch.isFlipY=false;
      self.opts.onPull&&self.opts.onPull.call(self);
    }

    if(translateY*-1>self.maxScrollY){
      self.isEndY=true;
      translateY=(self.maxScrollY+translateY)*.25-self.maxScrollY;
      self.pushBounceY=-translateY-self.maxScrollY;
      self.touch.isFlipY=false;      
      self.opts.onPush&&self.opts.onPush.call(self);
    }

    self.y=translateY;
    self.inertia.directionY=self.directionY;
    self.target.style.webkitTransform=self.target.style.transform=`translate3d(0,${self.y}px,0)`;
    self.opts.onTouchMove&&self.opts.onTouchMove.call(self);
    // debugger
  }

  //touchend 事件
  onTouchEnd(event){
    self.touch.y+=self.touch.diffY;
    self.directionY=null;
    self.timestamp.next=Date.now();
    let flipTime=self.timestamp.next-self.timestamp.prev;
    let flipDistance=self.touch.flipY*3.5;
    self.touch.curY=self.touch.diffY=self.touch.flipY=0;
    if(self.touch.isFlipY&&flipTime<25){
      let translateY=self.touch.y+flipDistance;
      if(translateY>0){
        translateY=0
      }
      if(translateY*-1>self.maxScrollY){
        translateY=-self.maxScrollY;
      }
      self.target.style.webkitTransition=self.target.style.transition=`.65s cubic-bezier(0.165, 0.84, 0.44, 1)`; 
      self.target.style.webkitTransform=self.target.style.transform=`translate3d(0,${translateY}px,0)`;      
      self.touch.y=translateY;
      //self.inertia.startY=self.y;
      self.touch.isFlipY=false;
      self.opts.onTouchEnd&&self.opts.onTouchEnd.call(self);    
      return;
    }

    if(self.isStartY){
      self.y=self.touch.y=0;
      self.target.style.webkitTransition=self.target.style.transition=`.25s`;
      if(self.pullBounceY>self.opts.pullThresholdY){
        self.opts.onPulled&&self.opts.onPulled.call(self);
      }
    }

    if(self.isEndY){
      self.y=self.touch.y=-self.maxScrollY;
      self.target.style.webkitTransition=self.target.style.transition=`.25s`;
      if(self.pushBounceY>self.opts.pushThresholdY){
        self.opts.onPushed&&self.opts.onPushed.call(self);
      }
    }    
    self.target.style.webkitTransform=self.target.style.transform=`translate3d(0,${self.touch.y}px,0)`;      
    self.opts.onTouchEnd&&self.opts.onTouchEnd.call(self);        
  }
  
  refresh(){
    this.getWH();
  }

  enabled(){
    this.disabled();
    this.el.addEventListener('touchstart',this.onTouchStart);
    this.el.addEventListener('touchmove',this.onTouchMove,{passive:false});
    this.el.addEventListener('touchend',this.onTouchEnd);
  }

  disabled(){
    this.el.removeEventListener('touchstart',this.onTouchStart);
    this.el.removeEventListener('touchmove',this.onTouchMove);
    this.el.removeEventListener('touchend',this.onTouchEnd);
  }

  scrollStart(dur){
    dur=dur==null?0:dur;
    this.y=this.touch.y=0;
    this.isStartY=true;
    this.touch.isFlipY=false;
    this.target.style.webkitTransition=this.target.style.transition=`${dur}ms`;
    this.target.style.webkitTransform=this.target.style.transform=`translate3d(0,${this.y}px,0)`;
  }

  scrollTo(y,dur){
    dur=dur==null?0:dur;
    this.isStartY=this.isEndY=false;
    this.touch.isFlipY=false;
    if(y<0){
      y=0;
      this.isStartY=true;
    }
    if(y>this.maxScrollY){
      y=this.maxScrollY;
      this.isEndY=true;
    }
    this.y=this.touch.y=-y;
    this.target.style.webkitTransition=this.target.style.transition=`${dur}ms`;
    this.target.style.webkitTransform=this.target.style.transform=`translate3d(0,${this.y}px,0)`;
  }

  scrollEnd(dur){
    dur=dur==null?0:dur;    
    this.y=this.touch.y=-this.maxScrollY;
    this.isEndY=true;
    this.touch.isFlipY=false;
    this.target.style.webkitTransition=this.target.style.transition=`${dur}ms`;
    this.target.style.webkitTransform=this.target.style.transform=`translate3d(0,${this.y}px,0)`;
  }

  static mergeOpts(opts){
    let defaults={
      target:self.el.firstElementChild,
      pushThresholdY:85,
      pullThresholdY:85,      
      onScroll:null,
      onInit:null,
      onTouchStart:null,
      onTouchMove:null,
      onTouchEnd:null,
      onPush:null,
      onPushed:null,
      onPull:null,
      onPulled:null,
    }
    for(let i in opts){
      defaults[i]=opts[i]
    }
    return defaults;
  }
}
window.Scroller=Scroller;