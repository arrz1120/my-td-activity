class Marquee{
  constructor(el,opts){
    this.el=typeof el==='string'?document.querySelector(el):el;
    opts=opts==null?{}:opts;
    this.opts=Marquee.mergeOpts(opts);
    this.timerCount=0;
    this.el.style.transform=this.el.style.webkitTransform='translateX(0)';
    this.el.style.overflow='hidden';
    this.init();
  }
  init(){
    let fragment=document.createDocumentFragment();
    this.domWrapper=document.createElement('div');
    this.domWrapper.style.cssText=`white-space: nowrap;`;
    this.opts.items.forEach((item,i)=>{
      let domSPAN=document.createElement('span');
      domSPAN.style.cssText=`margin-right: 1.5rem;display: inline-block;vertical-align: middle;`;
      domSPAN.innerHTML=`<i style="vertical-align:middle;display:inline-block;">${item.val}</i>`;
      fragment.appendChild(domSPAN);
    })
    this.domWrapper.appendChild(fragment);
    this.el.appendChild(this.domWrapper);
    this.scrollW=this.el.scrollWidth;
    this.domWrapper.style.width=`${this.scrollW}px`;
    if(this.opts.autoplay&&this.scrollW>this.el.clientWidth){
      this.move();
    }
  }
  move(){
    if(this.opts.loop&&-this.timerCount===this.scrollW){
      this.timerCount=this.el.clientWidth;
      this.domWrapper.style.transform=this.domWrapper.style.webkitTransform=`translate(${this.el.clientWidth}px,0)`
    }
    setTimeout(()=>{
      if(this.timerCount<this.scrollW){
        this.timerCount--;
        this.domWrapper.style.transform=this.domWrapper.style.webkitTransform=`translate(${this.timerCount}px,0)`
        this.move();
      }
    },1000/this.opts.speed)
  }
  static mergeOpts(opts){
    let defaults={
      direction:'left',
      speed:25,
      items:[],
      loop:true,
      autoplay:true
    };
    for(let key in opts){
      defaults[key]=opts[key];
    }
    return defaults;
  }
}

export default Marquee;