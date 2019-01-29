<style lang="scss">
  .skiing-container{
    position: relative;
    z-index: 0;
  }
</style>

<template>
  <section id="js-canvas" class="skiing-container"></section>
</template>

<script>
  import random from 'lodash.random'
  import shuffle from 'lodash.shuffle'
  import {Scene,Sprite,Group,Label} from '../js/lib/spritejs.2.19.min.js'
  import {rem} from '../js/lib/utils.js'
  const winW=window.innerWidth
  const winH=window.innerHeight
  export default {

    data(){
      return{
        scene:null,
        layer:null,
        layerHeight:0,
        treesHeight:0,
        paiX:winW/2,
        bodies:{
          sideTrees:null,
          pai:null,
          awards:null
        },
        touchData:{
          startX:0,
          moveX:0
        }
      }
    },

    methods:{
      // 初始化游戏场景
      initScene(){
        this.scene=new Scene('#js-canvas',{
          viewport:[winW,winH],
          resolution:[winW,winH],
          displayRatio:'2vw'
        })
        this.layer=this.scene.layer('game',{
          evaluateFPS:true,
        })
      },
      // 生成侧边树木
      rangeTrees(num){
        const trees=[]
        const spacing=rem(280)
        const imgs=[
          require('../assets/images/game/08-01.png'),
          // require('../assets/images/game/08-02.png'),
          // require('../assets/images/game/08-03.png'),
          ]
        for(let i=0;i<num;i++){
          const texture=imgs[random(0,imgs.length-1)]
          const tree=new Sprite({
            pos:[0,i*spacing],
            size:[rem(360),rem(330)],
            anchor:[0,0],
            textures:[texture],
          })
          trees.push(tree)
        }
        return trees
      },
      // 渲染侧边树木
      drawSideTrees(row){
        const {layer,rangeTrees,bodies}=this
        const paddingTop=rem(75)
        const groupHeight=rem(330*row)
        const leftTrees=new Group({
          pos:[rem(-210),paddingTop],
          size:[rem(360),groupHeight],
          anchor:[0,0],
        })
        leftTrees.append(...rangeTrees(row))
        const rightTrees=new Group({
          pos:[rem(600),paddingTop],
          size:[rem(360),groupHeight],
          anchor:[0,0],
        })
        rightTrees.append(...rangeTrees(row))
        const totalTrees=new Group({
          pos:[0,0],
          size:[winW,groupHeight],
          zIndex:0,
        })
        totalTrees.append(leftTrees,rightTrees)
        layer.append(totalTrees)
        bodies.sideTrees=totalTrees
        this.treesHeight=groupHeight
      },
      // 渲染小派
      drawPai(){
        const {bodies,layer}=this
        const group=new Group({
          pos:[this.paiX,rem(-230)],
          size:[rem(132),rem(230)],
          anchor:[.5,0],
          zIndex:1,
        })
        const pai=new Sprite({
          pos:[0,rem(50)],
          size:[rem(132),rem(182)],
          anchor:[0,0],
          textures:[require('../assets/images/game/06.png')],
          zIndex:1,
        })
        const path=new Sprite({
          pos:[0,rem(0)],
          size:[rem(132),rem(230)],
          textures:[require('../assets/images/game/10.png')],
          zIndex:0,
          opacity:0,
        })
        group.transition(.5).attr({
          y:rem(172)
        })
        group.append(pai,path)
        layer.append(group)
        this.addTouchEvent()
        bodies.pai=group
      },
      // 生成奖品/炸弹
      rangeAwards(){
        const iconData={
          star:{
            src:require('../assets/images/game/09-01.png'),
            size:[rem(61),rem(79)],
            val:10,
            count:50,
          },
          box:{
            src:require('../assets/images/game/09-02.png'),
            size:[rem(70),rem(82)],
            val:20,
            count:20,
          },
          chest:{
            src:require('../assets/images/game/09-03.png'),
            size:[rem(80),rem(81)],
            val:50,
            count:6,
          },
          bomb:{
            src:require('../assets/images/game/09-04.png'),
            size:[rem(68),rem(79)],
            val:-50,
            count:15,
          }
        }
        let awardList=[]
        Object.keys(iconData).forEach(item=>{
          const award=iconData[item]
          const arr=Array.apply(null,{length:award.count}).map(()=>{
            return award
          })
          awardList=awardList.concat(arr)
        })
        awardList=shuffle(awardList)
        return awardList
      },
      // 渲染奖品/炸弹
      drawAwards(){
        const {bodies,layer}=this
        const awardList=this.rangeAwards().map((item,i)=>{
          const pos=[random(rem(150),rem(580)),winH/2+172*i]
          return new Sprite({
            pos,
            size:item.size,
            textures:[item.src],
            anchor:[.5,0],
            val:item.val
          })
        })
        const groupHeight=winH*2+awardList.length*90
        const awardGroup=new Group({
          pos:[0,0],
          size:[rem(750),winH],
          anchor:[0,0],
          zIndex:0,
        })
        awardGroup.append(...awardList)
        layer.append(awardGroup)
        bodies.awards=awardGroup
        this.layerHeight=groupHeight
      },
      // layer touchstart
      onLayerTouchStart(e){
        const {x}=e
        const {touchData}=this
        touchData.startX=x
      },
      // layer touchmove
      onLayerTouchMove(e){
        const {x}=e
        const {touchData,bodies,paiX}=this
        touchData.moveX=x-touchData.startX+paiX
        if(touchData.moveX<rem(200)){
          touchData.moveX=rem(200)
        }
        if(touchData.moveX>rem(550)){
          touchData.moveX=rem(550)
        }
        bodies.pai.attr({
          x:touchData.moveX
        })
      },
      // layer touchend
      onLayerTouchEnd(e){
        const {x}=e
        const {touchData,paiX}=this
        this.paiX=touchData.moveX
      },
      // 碰撞检测
      addOBB(){
        const {bodies,layer}=this
        const awardList=bodies.awards.children
        const pai=bodies.pai
        awardList.forEach((award)=>{
          if(award.OBBCollision(pai)){
            const score=award.attributes.val
            // const text=new Label({
            //   text:score>0?`+${score}`:`${score}`,
            //   anchor:[.5,.5],
            //   fillColor:score>0?'#f4ac38':'#cb2d2d',
            //   font:`${rem(26)}px "微软雅黑"`,
            //   pos:[rem(620),rem(120)],
            //   opacity:0,
            // })
            // text.transition(.5).attr({
            //   opacity:1,
            //   y:rem(110),
            // }).then(()=>{
            //   text.remove()
            // })
            // layer.append(text)
            award.remove()
            this.$emit('postScore',score)
          }
        })
      },
      addTouchEvent(){
        this.layer.on('touchstart',this.onLayerTouchStart)
        this.layer.on('touchmove',this.onLayerTouchMove)
        this.layer.on('touchend',this.onLayerTouchEnd)
        this.layer.on('update',this.addOBB)
      },
      offTouchEvent(){
        this.layer.off('touchstart',this.onLayerTouchStart)
        this.layer.off('touchmove',this.onLayerTouchMove)
        this.layer.off('touchend',this.onLayerTouchEnd)
        this.layer.off('update',this.addOBB)
      },
      // 加载游戏初始功能
      initGame(){
        this.initScene()
        this.drawPai()
        this.drawSideTrees(13)
        this.drawAwards()
      },
      startGame(){
        const {bodies,layer,layerHeight,treesHeight}=this
        bodies.awards.children.forEach((item,i)=>{
          item.animate([
            {y:-layerHeight*1.65+i*175}
          ],{
            duration: 30*1000,
            fill: 'forwards',
          })
        })
        bodies.sideTrees.animate([
          {y:-treesHeight+winH*1.5}
        ],{
          duration: 2.5*1000,
          iterations: Infinity,
        })
        const paiPath=bodies.pai.children[1]
        paiPath.attr({
          opacity:1,
        })
        paiPath.animate([
          {scale:[1,1]},
          {scale:[1,1.5]},
        ],{
          duration: 750,
          iterations: Infinity,
          direction:'alternate',
        })
      },
      stopGame(callback){
        const {layer,bodies}=this
        bodies.pai.transition(.5).attr({
          y:winH
        }).then(()=>{
            layer.timeline.playbackRate=0
            bodies.pai.remove()
            callback&&callback()
          })
        this.offTouchEvent()
      }
    },

    mounted(){
      this.initGame()
    }

  }
</script>


