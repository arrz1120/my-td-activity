import raf from 'raf';

let computeAngle=function(deg){
  return (Math.PI/180)*deg;
}

class CircularProcess{
  constructor(el,opts){
    this.el=typeof el==='string'?document.querySelector(el):el;
    this.ctx=this.el.getContext('2d');
    this.totalVal=0;
    this.centerPoint=0;
    this.opts=CircularProcess.mergeOpts(opts);
    this.init();
  }
  init(){
    let {circles,dpr}=this.opts;
    let radiusArr=circles.map((item,i)=>{
      this.totalVal+=item.val;
      return item.radius*2+this.opts.lineWidth;
    });
    let maxRadius=Math.max.apply(null,radiusArr);
    this.centerPoint=maxRadius/2;
    this.el.style.width=this.el.style.height=`${maxRadius}px`;
    this.el.width=this.el.height=maxRadius*dpr;
    this.ctx.scale(dpr,dpr);
  }
  drawBgCircles(){
    let ctx=this.ctx;
    let {bgColor,startDeg,maxDeg,anticlockwise,lineWidth,circles}=this.opts;
    let centerPoint=this.centerPoint;
    ctx.strokeStyle=bgColor;
    ctx.lineWidth=lineWidth;
    ctx.lineCap='round';
    circles.forEach((item,i)=>{
      let itemStartDeg=anticlockwise?(computeAngle(-startDeg)-Math.PI/2):(-computeAngle(-startDeg)-Math.PI/2);
      let endDeg=anticlockwise?(-computeAngle(maxDeg)+itemStartDeg):(computeAngle(maxDeg)+itemStartDeg);
      ctx.beginPath();
      ctx.arc(centerPoint,centerPoint,item.radius,itemStartDeg,endDeg,anticlockwise);  
      ctx.stroke();
    })
  }
  render(){
    this.clear();
    let ctx=this.ctx;
    let self=this;
    let {startDeg,maxDeg,anticlockwise,lineWidth,circles,animate}=this.opts;
    this.drawBgCircles();
    ctx.lineWidth=lineWidth;
    circles.forEach((item,i)=>{
      let startVal=0;
      let itemStartDeg=anticlockwise?(computeAngle(-startDeg)-Math.PI/2):(-computeAngle(-startDeg)-Math.PI/2);
      let centerPoint=self.centerPoint;
      let percent=item.percent||(item.val/this.totalVal).toFixed(2);
      if(animate){
        raf(function render(){   
          if(startVal<percent){
            if(self.opts.percent){
              startVal=self.opts.percent
            }else{
              startVal=(startVal+self.opts.animateSpeed/1000>=percent)?percent:startVal+self.opts.animateSpeed/1000;
              startVal=(+startVal).toFixed(2)*1;
            }
            let endDeg=anticlockwise?(-computeAngle(startVal*maxDeg)+itemStartDeg):(computeAngle(startVal*maxDeg)+itemStartDeg);
            ctx.strokeStyle=item.color;
            ctx.beginPath();
            ctx.arc(centerPoint,centerPoint,item.radius,itemStartDeg,endDeg,anticlockwise);  
            ctx.stroke();
            raf(render);
          }
        });
        return;
      }
      let endDeg=anticlockwise?(-computeAngle(percent*maxDeg)+itemStartDeg):(computeAngle(percent*maxDeg)+itemStartDeg);
      ctx.strokeStyle=item.color;
      ctx.beginPath();
      ctx.arc(centerPoint,centerPoint,item.radius,itemStartDeg,endDeg,anticlockwise);  
      ctx.stroke();
    });
  }
  set(opts){
    opts=opts==null?{}:opts;
    this.opts=CircularProcess.mergeOpts(opts);
    this.init();
  }
  clear(){
    this.ctx.clearRect(0,0,this.el.width,this.el.height);
  }
  
  static mergeOpts(opts){
    let defaults={
      anticlockwise:false,
      bgColor:'#ddd',
      animate:true,
      animateSpeed:15,
      startDeg:0,
      maxDeg:360,
      lineWidth:5,
      dpr:1,
      circles:[
        {
          color:'#f60',
          radius:45,
          val:0,
        }
      ]
    }
    for(let i in opts){
      defaults[i]=opts[i];
    }
    return defaults;
  }
}

window.CircularProcess=CircularProcess;
// if(typeof module!=='undefined'&&typeof exports==='object'){
//   module.exports=CircularProcess
// }else{
//   window.CircularProcess=CircularProcess;
// }