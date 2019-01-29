<style lang="scss">
  .footerbar-container{
    font-size: rem(24);
    position: fixed;
    z-index: 9;
    left: 0;
    right: 0;
    bottom: 0;
    background: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
    transform: translateZ(1px);
    border-top: 1px solid #eee;
    .footerbar-item{
      flex: 1;
      text-align: center;
      padding: 0.25rem 0;
      &.on{
        .footerbar-item-img{
          &.n1{
            @include bg('../assets/images/common/01-02.png');
          }
          &.n2{
            @include bg('../assets/images/common/02-02.png');
          }
          &.n3{
            @include bg('../assets/images/common/03-02.png');
          }
          &.n4{
            @include bg('../assets/images/common/04-02.png');
          }
        }
        .footerbar-item-text{
          color: #ff9c00;
        }
      }
    }
    .footerbar-item-img{
      @include wh(60,60);
      margin: 0 auto;
      margin-bottom: 0.15rem;
      &.n1{
        @include bg('../assets/images/common/01-01.png');
      }
      &.n2{
        @include bg('../assets/images/common/02-01.png');
      }
      &.n3{
        @include bg('../assets/images/common/03-01.png');
      }
      &.n4{
        @include bg('../assets/images/common/04-01.png');
      }
    }
    .footerbar-item-text{
      color: #e917a6;
    }
  }
</style>

<template>
  <section class="footerbar-container">
    <div 
      class="footerbar-item" 
      :class="{'on':idx===i}"
      v-for="(item,i) in nav"
      :key="i"
      :name="item.saTrackName"
      @click="onNavItemClk(i,$event,item.txTrackName)">
      <div class="footerbar-item-img" :class="item.cls"></div>
      <p class="footerbar-item-text">{{item.text}}</p>
    </div>
  </section>
</template>

<script>
  export default {
    
    props:['idx'],

    data(){
      return{
        nav:[
          {text:'加息专享',cls:'n1',saTrackName:'加息专享',txTrackName:'menu1'},
          {text:'瓜分现金',cls:'n2',saTrackName:'瓜分现金',txTrackName:'menu2'},
          {text:'幸运翻牌',cls:'n3',saTrackName:'幸运翻牌',txTrackName:'menu3'},
          {text:'爱心榜单',cls:'n4',saTrackName:'爱心榜单',txTrackName:'menu4'},
        ]
      }
    },

    methods:{
      onNavItemClk(idx,{target},txTrackName){
        AddMaiDian(txTrackName,target)
        if(idx===this.idx) return
        const routerMap={
          0:router.jiaxi,
          1:router.carveRedpacket,
          2:router.lottery,
          3:router.rank
        }  
        window.location.href=routerMap[idx]
      }
    }

  }
</script>


