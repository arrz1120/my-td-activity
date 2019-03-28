let throttle=(()=>{
  let flag=true
  return function(func,dur,ctx){
    return function(){
      let args=arguments
      if(flag){
        func.apply(ctx,args)
        flag=false
        setTimeout(()=>{
          flag=true
        },dur)
      }
    }
  }
})()

class Eraser{
  constructor(el,opts){
    this.el=typeof el==='string'?document.querySelector(el):el
    this.opts=Eraser.mergeOpts(opts)
    let {dpr,width,height}=this.opts
    this.ctx=this.el.getContext('2d')
    this.el.style.width=`${width}px`
    this.el.style.height=`${height}px`
    this.elRect=this.el.getBoundingClientRect()
    this.elW=this.elRect.width||width
    this.elH=this.elRect.height||height
    this.el.width=this.elW*dpr
    this.el.height=this.elH*dpr
    this.ctx.scale(dpr,dpr)
    this.init()
  }
  init(){
    this.completed=false
    this.drawCover()
  }
  reset(){
    this.ctx.clearRect(0,0,this.elW,this.elH)
    this.ctx.globalCompositeOperation='source-over'
    this.el.removeEventListener('touchstart',this.onTouch.bind(this))
    this.el.removeEventListener('touchmove',this.onTouch.bind(this))
    this.init()
  }
  drawCover(){
    let {cover,onInit}=this.opts
    let ctx=this.ctx
    this.coverType=(()=>{
      if(cover.slice(0,1)==='#'||cover.slice(0,3)==='rgb') return 'color'
      return 'img'
    })()
    if(this.coverType==='color'){
      ctx.fillStyle=cover
      ctx.fillRect(0,0,this.elW,this.elH)
      ctx.globalCompositeOperation = 'destination-out'
      this.el.addEventListener('touchstart',this.onTouch.bind(this))
      this.el.addEventListener('touchmove',this.onTouch.bind(this))
      onInit&&onInit.call(this)
    }
    if(this.coverType==='img'){
      let img=new Image()
      img.src=cover
      img.onload=()=>{
        ctx.drawImage(img,0,0,this.elW,this.elH)
        ctx.globalCompositeOperation = 'destination-out'
        this.el.addEventListener('touchstart',this.onTouch.bind(this))
        this.el.addEventListener('touchmove',this.onTouch.bind(this))
        onInit&&onInit.call(this)
      }
      img.onerror=()=>{
        throw new Error('加载图片失败')
      }
    }
  }
  drawPoint(x,y){
    let ctx=this.ctx
    let {touchSize,ratio,onComplete,onErase}=this.opts
    ctx.beginPath()
    let ctxGradient=ctx.createRadialGradient(x,y,0,x,y,touchSize)
    ctxGradient.addColorStop(0, 'rgba(0,0,0,0.4)')
    ctxGradient.addColorStop(1, 'rgba(255, 255, 255, 0)')
    ctx.fillStyle=ctxGradient
    ctx.arc(x,y,touchSize,0,Math.PI * 2,true)
    ctx.fill()
    let throttlePercent=throttle(this.getErasePercent,1000,this)
    throttlePercent()
    onErase&&onErase.call(this,this.currentRatio)
    if(this.currentRatio>ratio){
      this.completed=true
      onComplete&&onComplete.call(this)
    }
  }
  getErasePercent(){
    let ctx=this.ctx
    let imgData=ctx.getImageData(0,0,this.elW,this.elH).data
    let erasePixs=[]
    for(let i=0,j=imgData.length;i<j;i+=4*200){
      if(imgData[i+3]<100){
        erasePixs.push(1)
      }
    }
    this.currentRatio=(erasePixs.length/(imgData.length/(4*200))).toFixed(3)*1
    return this.currentRatio
  }
  onTouch(e){
    if(this.completed) return
    e.preventDefault()
    e.stopPropagation()
    let elRect=this.elRect
    let clientX=e.touches[0].pageX-elRect.left
    let clientY=e.touches[0].pageY-elRect.top
    this.drawPoint(clientX,clientY)
  }
  static mergeOpts(opts){
    let defaults={
      cover:'rgba(0,0,0,.9)',
      width:null,
      height:null,
      touchSize:25,
      ratio:.3,
      dpr:1,
      onInit:null,
      onErase:null,
      onComplete:null
    }
    for(let i in opts){
      defaults[i]=opts[i]
    }
    return defaults
  }
}

export default Eraser