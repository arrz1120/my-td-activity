let transitionEnd=()=>{
  let el=document.createElement('p')
  let map={
    'WebkitTransition' : 'webkitTransitionEnd',
    'MozTransition' : 'transitionend',
    'OTransition' : 'oTransitionEnd',
    'msTransition' : 'MSTransitionEnd',
    'transition' : 'transitionend'
  }
  for (var transition in map) {
    if (null != el.style[transition]) {
      return map[transition]
    }
  }
  throw new Error('不支持 transitionend 事件')
}

class Slider{
  constructor(el,opts){
    this.el=typeof el==='string'?document.querySelector(el):el
    this.opts=Slider.merge(opts)
    this.idx=this.opts.startIdx
    this.init()
  }
  init(){
    if(this.el.children.length<this.opts.showSlides){
      return
    }
    let fragment=document.createDocumentFragment()
    let cloneFragment=document.createDocumentFragment()
    let slides=[].slice.call(this.el.children)
    slides.slice(0,this.opts.showSlides).forEach((item,i)=>{
      let node=item.cloneNode(true)
      cloneFragment.appendChild(node)
    })
    this.el.appendChild(cloneFragment)
    this.realLen=slides.length
    this.slides=[].slice.call(this.el.children)
    this.slidesFrag=document.createElement('div')
    this.slidesFrag.classList.add('scroll-wrapper')
    this.slidesFrag.style.transition=this.slidesFrag.style.webkitTransition=`all ${this.opts.duration}ms`
    this.slidesFrag.style.transform='translate3d(0,0,0)'
    this.slides.map((item,i)=>{
      let domDIV=document.createElement('div')
      domDIV.setAttribute('data-idx',i)
      domDIV.appendChild(item)
      fragment.appendChild(domDIV)
    })
    this.el.innerHTML=''
    this.slidesFrag.appendChild(fragment)
    this.el.appendChild(this.slidesFrag)
    this.slideHeight=this.slidesFrag.getBoundingClientRect().height/this.slides.length
    this.el.setAttribute('data-curidx',this.idx)
    this.el.style.height=`${this.slideHeight*this.opts.showSlides}px`
    this.el.style.overflow='hidden'
    this.slidesFrag.addEventListener(transitionEnd(),()=>{
      if(this.idx==0){
        this.slidesFrag.style.transform=this.slidesFrag.style.webkitTransform=`translate3d(0,0,0)`
        this.slidesFrag.style.transition=this.slidesFrag.style.webkitTransition=`all 0ms`
      }
    })
    this.opts.onInit&&this.opts.onInit.call(this)
    if(this.opts.autoplay){
      this.start()
    }
  }
  start(){
    setTimeout(()=>{ 
      this.idx++
      this.slidesFrag.style.transform=this.slidesFrag.style.webkitTransform=`translate3d(0,-${this.idx*this.slideHeight}px,0)`
      this.slidesFrag.style.transition=this.slidesFrag.style.webkitTransition=`all ${this.opts.duration}ms`
      if(this.idx===this.realLen){
        this.idx=0
      }
      this.opts.onChange&&this.opts.onChange.call(this)
      this.el.setAttribute('data-curidx',this.idx)
      this.start()
    },this.opts.delay)
  }
  static merge(opts){
    let defaults={
      showSlides:3,
      duration:200,
      delay:2000,
      startIdx:0,
      autoplay:true,
      onInit(){},
      onChange(){},
    }
    opts=opts==null?{}:opts
    for(let i in opts){
      defaults[i]=opts[i]
    }
    return defaults
  }
}

export default Slider