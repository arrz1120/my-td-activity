<style lang="scss">
  .sidebar-container{
    position: fixed;
    z-index: 9;
    top: 7rem;
    right: .15rem;
    .sidebar-share{
      @include wh(110,124);
      @include bg('../assets/images/common/11-01.png');
      margin-left: 0.55rem;
    }
    .sidebar-home{
      @include wh(110,124);
      @include bg('../assets/images/common/11-02.png');
      margin-top: -.35rem;
      margin-left: 0.55rem;
    }
    .sidebar-prize{
      @include wh(133,162);
      @include bg('../assets/images/common/11-03.png');
      position: relative;
      font-size: rem(26);
      color: #ff5753;
      text-align: center;
      padding-top: 1.25rem;
      padding-left: 0.25rem;
      line-height: 1;
    }
    .sidebar-prize-mark{
      font-size: rem(40);

    }
  }
</style>

<template>
  <section class="sidebar-container">
    <div class="sidebar-share" name="分享2a" @click="onShareClk"></div>
    <div class="sidebar-home" name="1218封面5a" @click="onHomeClk"></div>
    <div class="sidebar-prize" name="加息特权_奖品6a" @click="onPrizeClk"><i class="sidebar-prize-mark">{{isLogined?jxVal:'?'}}</i>%</div>
  </section>
</template>

<script>
  import initShare from '../js/lib/initShare.js'
  export default {
    
    props:['jxVal','isLogined'],

    methods:{
      onShareClk({target}){
        initShare.show()
        AddMaiDian('share2a',target)
      },
      onHomeClk({target}){
        AddMaiDian('cover5a',target)
        window.location.href=router.index
      },
      onPrizeClk({target}){
        AddMaiDian('interest_prize6a',target)
        this.$emit('prizeCallback')
      }
    },

    created(){
      initShare.set()
    }

  }
</script>


