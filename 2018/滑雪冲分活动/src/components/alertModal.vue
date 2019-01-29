<style lang="scss">
  .alertModal-container{
    padding-bottom: 1.5rem;
    .alertModal-title{
      text-align: center;
      font-size: rem(28);
      >.item{
        &:not(:last-child){
          margin-bottom: 0.25rem;
        }
      }
    }
    .alertModal-msg{
      color: #cb2d2d;
      font-size: rem(22);
      text-align: center;
      margin-top: .75rem;
      >.item{
        &:not(:last-child){
          margin-bottom: 0.25rem;
        }
      }
    }
    .alertModal-icon{
      margin: 0 auto;
      margin-bottom: 0.25rem;
      &.n1{
        @include wh(243,205);
        @include bg('../assets/images/modal/06.png');
      }
    }
    .alertModal-btn{
      @include wh(450,85);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: rem(34);
      color: #ffffff;
      margin: 0 auto;
      margin-top: 1rem;
      background: linear-gradient(to bottom,#ffb83d,#ff8f1e);
      border-radius: .25rem;
    }
  }
</style>

<template>
  <section class="alertModal-container">
    <div v-if="iconCls" class="alertModal-icon" :class="iconCls"></div>
    <ul class="alertModal-title">
      <li 
        class="item" 
        v-for="(item,idx) in title"
        :key="idx">
        {{item}}
      </li>
    </ul>
    <ul class="alertModal-msg" v-if="msg">
      <li 
        class="item"
        v-for="(item,idx) in msg"
        :key="idx">
        {{item}}
      </li>
    </ul>
    <p class="alertModal-btn" :name="trackName" @click="onBtnClk">{{btnText}}</p>
  </section>
</template>

<script>
  export default {
    
    props:['iconType','title','msg','btnText','btnCallback','trackName'],

    computed:{
      iconCls(){
        switch (this.iconType) {
          case 'activityEnd':
            return 'n1'
        }
        return null
      }
    },

    methods:{
      onBtnClk(e){
        this.btnCallback&&this.btnCallback(e)
      }
    }

  }
</script>


