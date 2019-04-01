let self;
function addClass(el,className){
  return el.classList.add(className)
}
function removeClass(el,className){
  return el.classList.remove(className)
}
function nextFrame(fn){
  setTimeout(fn,0)
}
class AdvTransition{
  constructor(el,opts){
    this.el=typeof el==='string'?document.querySelector(el):el;
    this.opts=AdvTransition.mergeOpts(opts);
    this.classes=this.opts.classes;
    this.transitionStatus=null;
    if(this.opts.show){
      removeClass(this.el,this.classes.start);
      addClass(this.el,this.classes.end);
    }
    this.el.addEventListener('transitionend',this.onTransition)
    self=this;
  }

  show(){
    this.transitionStatus='in';
    if(this.opts.show) return;
    this.opts.show=true;
    addClass(this.el,this.classes.enter);
    removeClass(this.el,this.classes.start);
    nextFrame(()=>{
      removeClass(this.el,this.classes.enter);
      addClass(this.el,this.classes.end);
    })
  }
  
  hide(){
    this.transitionStatus='out';
    if(!this.opts.show) return;
    this.opts.show=false;
    addClass(this.el,this.classes.leave);
    removeClass(this.el,this.classes.end);    
  }
  onTransition(){
    if(self.transitionStatus==='in'){
      self.opts.onTransitionIn&&self.opts.onTransitionIn.call(self);
    }
    if(self.transitionStatus==='out'){
      removeClass(self.el,self.classes.leave);
      addClass(self.el,self.classes.start);
      self.opts.onTransitionOut&&self.opts.onTransitionOut.call(self);
    }
    self.transitionStatus=null;
  }

  static mergeOpts(opts){
    let defaults={
      show:false,
      classes:{
        start:'',
        enter:'',
        end:'',
        leave:'',
      },
      onTransitionIn:null,
      onTransitionOut:null
    }
    for(let i in opts){
      defaults[i]=opts[i];
    }
    return defaults;
  }
}

export default AdvTransition;
window.AdvTransition=AdvTransition;