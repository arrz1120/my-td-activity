import Matter from 'matter-js'
let PI=Math.PI
let {
  Engine,
  Render,
  Runner,
  Mouse,
  MouseConstraint,
  World,
  Bodies,
  Body,
  Composites,
  Common,
  Events,
  Constraint
}=Matter

let state={
  counter:0,
  timer0:null,
  timer1:null
}

let methods={
  addCircleConstraint(x,y,radius){
    let bodies=[]
    for(let i=0;i<45;i++){
      let rect=Bodies.circle(
        x+Math.sin(i*8*PI/180)*radius*1.365,
        y+Math.cos(i*8*PI/180)*radius*1.365,
        150
      )
      bodies.push(rect)
    }
    return Body.create({
      parts:bodies,
      isStatic:true,
      render:{
        visible:false
      }
    })
  },
  explosion(){
    state.counter++
    if(state.counter<60*.175) return
    xBodies.lotteryBalls0.bodies.forEach(item=>{
      Body.setVelocity(item,{x:Common.random(-75,75),y:Common.random(-75,75)})
    })
    xBodies.lotteryBalls1.bodies.forEach(item=>{
      Body.setVelocity(item,{x:Common.random(-75,75),y:Common.random(-75,75)})
    })
    xBodies.lotteryBalls2.bodies.forEach(item=>{
      Body.setVelocity(item,{x:Common.random(-75,75),y:Common.random(-75,75)})
    })
    state.counter=0
  }
}

let xEngine=Engine.create()

let xWorld=xEngine.world
xWorld.gravity.y=4

let xRender=Render.create({
  element:document.querySelector('.canvas-container'),
  engine:xEngine,
  options: {
    width: 800,
    height: 800,
    wireframes:false,
    background:'#fff',
    background:'transparent',
  }
})
Render.run(xRender)

let xRunner=Runner.create()

let xBodies={
  likeCircle:methods.addCircleConstraint(400,400,400),
  lotteryBalls0:Composites.stack(130,275,6,1,10,5,(x,y)=>{
    return Bodies.circle(x,y,40,{
      restitution: .7,
      frictionAir:.005,
      isStatic:false,
      render:{
        sprite:{
          texture:`./images/7-1.png`,
        }
      }
    })
  }),
  lotteryBalls1:Composites.stack(130,360,6,1,10,5,(x,y)=>{
    return Bodies.circle(x,y,40,{
      restitution: .7,
      frictionAir:.005,
      isStatic:false,
      render:{
        sprite:{
          texture:`./images/7-2.png`
        }
      }
    })
  }),
  lotteryBalls2:Composites.stack(130,450,6,1,10,5,(x,y)=>{
    return Bodies.circle(x,y,40,{
      restitution: .7,
      frictionAir:.005,
      isStatic:false,
      render:{
        sprite:{
          texture:`./images/7-3.png`
        }
      }
    })
  })
}

World.add(xWorld,[
  xBodies.likeCircle,
  xBodies.lotteryBalls0,
  xBodies.lotteryBalls1,
  xBodies.lotteryBalls2,
])

Runner.run(xRunner,xEngine)

window.xLottery={
  start(){
    Events.on(xEngine,'tick',methods.explosion)
  },
  stop(){
    Events.off(xEngine,'tick',methods.explosion)
  },
  run(dur,nextTick,callback){
    Events.on(xEngine,'tick',methods.explosion)
    if(dur==null){
      Events.off(xEngine,'tick',methods.explosion)
      return
    }
    clearTimeout(state.timer0)
    clearTimeout(state.timer1)
    state.timer0=setTimeout(()=>{
      nextTick&&nextTick()
      Events.off(xEngine,'tick',methods.explosion)
      state.timer1=setTimeout(()=>{
        callback&&callback()
      },1750)
    },dur)
  },
  render:xRender
}