let self;
let rafTimer;
let winH=window.innerHeight;
let easeFn=function(t){
  return 1 + --t * t * t * t * t;
}
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
    this.elRect=getRect(this.el);
    this.el.style.overflow='hidden';
    this.opts=Scroller.mergeOpts(opts);
    this.target=typeof this.opts.target==='string'?document.querySelector(this.opts.target):this.opts.target;
    this.target.style.minHeight=`${this.elRect.height}px`;
    this.opts.init&&this.opts.init.call(this);
    this.init();
  }

  //计算滚动内容高度
  getWrapperH(){
    let newMaxScrollY;
    this.targetRect=getRect(this.target);
    newMaxScrollY=this.targetRect.height-this.elRect.height;
    if(newMaxScrollY>0){
      if(newMaxScrollY<this.maxScrollY){
        this.scrollTo(newMaxScrollY);
      }
      this.maxScrollY=newMaxScrollY;
    }else{
      this.maxScrollY=0;
      //this.scrollStart();
      this.isEndY=this.isStartY=true;
    }
  }

  static mergeOpts(opts){
    let defaults={
      target:self.el.firstElementChild,
      pushThresholdY:85,
      pullThresholdY:85,      
      y:0,
      onInit:null,
      onMounted:null,
      onScroll:null,
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

  init(){
    this.y=this.opts.y||0;
    this.isStartY=this.y===0?true:false;
    this.isEndY=null;
    this.directionY=null;
    this.pullBounceY=0;
    this.pushBounceY=0;
    this.getWrapperH();
    this.pointer={
      y:0,
      startY:0,
      moveY:0,
      distanceY:0,
      flipStartY:0,
      flipY:0,
      isFlipY:false,
    }
    this.timestamp={
      prev:0,
      next:0
    }
    this.touchEnabled();
    this.opts.onInit&&this.opts.onInit.call(this);
  }

  // touchstart 事件
  onTouchStart(event){
    let touch=event.touches[0];
    self.pointer.startY=self.pointer.moveY=touch.pageY;
    self.pointer.flipStartY=0;
    self.timestamp.prev=Date.now();
    cancelAnimationFrame(rafTimer);
    self.target.style.webkitTransform=self.target.style.transform=`translate3d(0,${self.y}px,0)`;
    self.target.style.webkitTransition=self.target.style.transition=`0s`;
    self.opts.onTouchStart&&self.opts.onTouchStart.call(self);
  }

  // touchmove 事件
  onTouchMove(event){
    event.preventDefault();
    let y;
    let touch=event.touches[0];
    let prevTimestamp=self.timestamp.prev;
    self.timestamp.prev=Date.now();
    self.directionY=touch.pageY-self.pointer.moveY>0?'pull':'push';
    self.pointer.moveY=touch.pageY;
    self.pointer.distanceY=touch.pageY-self.pointer.startY;
    self.pointer.flipY=(()=>{
      if(self.timestamp.prev-prevTimestamp>25){
        self.pointer.flipStartY=self.pointer.distanceY;
        self.pointer.isFlipY=false;      
      }else{
        self.pointer.isFlipY=true;
      }
      return self.pointer.distanceY-self.pointer.flipStartY
    })();
    y=self.pointer.y+self.pointer.distanceY;
    y=Math.round(y);
    self.isStartY=self.isEndY=self.maxScrollY===0?true:false;
    if(y>=0){
      self.isStartY=true;
      y*=.25;
      self.pullBounceY=y;
      self.pointer.isFlipY=false;
    }
    if(y*-1>=self.maxScrollY){
      self.isEndY=true;
      y=(self.maxScrollY+y)*.25-self.maxScrollY;
      self.pushBounceY=-y-self.maxScrollY;
      self.pointer.isFlipY=false; 
    }
    self.y=y;
    self.target.style.webkitTransform=self.target.style.transform=`translate3d(0,${self.y}px,0)`;
    self.opts.onScroll&&self.opts.onScroll.call(self);
    self.opts.onTouchMove&&self.opts.onTouchMove.call(self);
  }

  // onTouchEnd 事件
  onTouchEnd(event){
    self.pointer.y+=self.pointer.distanceY;
    self.directionY=null;
    self.timestamp.next=Date.now();
    let flipTime=self.timestamp.next-self.timestamp.prev;
    let flipDistance=self.pointer.flipY*3.5;
    self.pointer.distanceY=self.pointer.flipY=0;
    if(self.pointer.isFlipY&&flipTime<25){
      let y=self.pointer.y+flipDistance;
      if(y>0){
        y=0
      }
      if(y*-1>self.maxScrollY){
        y=-self.maxScrollY;
      }
      self.pointer.y=Math.round(y);
      self.pointer.isFlipY=false;
      self.scrollTo(y,1250);
      self.opts.onTouchEnd&&self.opts.onTouchEnd.call(self);
      return;
    }
    if(self.isStartY){
      if(self.pullBounceY>0){
        self.scrollTo(0,350);
      }else{
        self.scrollTo(0,0);
      }
    }
    if(self.isEndY){
      if(self.pushBounceY>0){
        self.scrollTo(-self.maxScrollY,350);
      }else{
        self.scrollTo(0,0);
      }
    }
    self.opts.onTouchEnd&&self.opts.onTouchEnd.call(self);
  }

  scrollTo(y,dur=0){
    this.isStartY=this.isEndY=false;
    if(y>0){
      y=0;
      this.isStartY=true;
    }
    if(y<-this.maxScrollY){
      y=this.maxScrollY;
      this.IsEndY=true;
    }
    y=Math.round(y);
    this._animateY(y,dur,function(){
      self.pointer.y=self.y;
    })
    self.target.style.webkitTransition=self.target.style.transition=`${dur}ms cubic-bezier(0.165, 0.84, 0.44, 1)`; 
    self.target.style.webkitTransform=self.target.style.transform=`translate3d(0,${y}px,0)`;      
  }

  _animateY(destY,dur,callback){
    let startY=self.y;
    let startTime=Date.now();
    let endTime=startTime+dur;
    function step(){
      let now=Date.now();
      if(now>=endTime){
        self.y=destY;
        self.pullBounceY=self.pushBounceY=0;
        if(self.y>=0){
          self.isStartY=true;
        }
        if(self.y<-self.maxScrollY){
          self.isEndY=true;
        }
        self.opts.onScroll&&self.opts.onScroll.call(self);
        return;
      }
      now=(now-startTime)/dur;
      let newY=(destY-startY)*easeFn(now)+startY;
      self.y=Math.round(newY);
      callback&&callback();
      self.opts.onScroll&&self.opts.onScroll.call(self);
      rafTimer=requestAnimationFrame(step);
    }
    step();
  }

  // touch 启用
  touchEnabled(){
    this.el.addEventListener('touchstart',this.onTouchStart);
    this.el.addEventListener('touchmove',this.onTouchMove);
    this.el.addEventListener('touchend',this.onTouchEnd);
  }

  //touch 停用
  touchDisabled(){

  }
}

window.Scroller=Scroller;