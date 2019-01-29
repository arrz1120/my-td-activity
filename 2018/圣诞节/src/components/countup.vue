<style lang="scss">
  .counterEnd{
    color: #ffd82b;
  }
</style>

<template>
  <section class="counter-wrapper">
    <div class="iCountUp" ref="iCountUp" v-show="false"></div>
    <div>{{counter}}<span class="counterEnd">{{counterEnd}}</span></div>
  </section>
</template>

<script>
import CountUp from '../js/lib/countUp.js'
export default {
    props: ['endVal'],
    data() {
      return {
        iCountUp: 0,
      }
    },
    mounted(){
      this.initCounter()
    },
    computed: {
      counter(){
        let str = this.iCountUp.toString()
        return str.substring(0,str.length-1)
      },
      counterEnd(){
        let str = this.iCountUp.toString()
        return str.substring(str.length-1,str.length)
      },
      prefix(){
        let str = this.endVal.toString()
        if(str.length<6){
          let temp = '0'
          for(var i=0;i<(6-str.length-1);i++){
            temp += '0'
          }
          return temp
        }
        if(str.length>6){
          return str.substring(0,6)
        }
        return ''
      }
    },
    methods: {
      initCounter(){
        var countUpOption = {
          startVal: 0,
          endVal: this.endVal,
          el:document.querySelector('.iCountUp'),
          duration: 2.5,
          decimals: 0,
          format:{
              useEasing: true, 
              useGrouping: true, 
              separator: '', 
              decimal: '', 
              prefix: this.prefix
          }
        }
        var newCountUp = new CountUp(
          countUpOption.el, 
          countUpOption.startVal, 
          countUpOption.endVal, 
          countUpOption.decimals, 
          countUpOption.duration, 
          countUpOption.format, 
          this
        )
        if (!newCountUp.error) {
          newCountUp.start()
        } else {
          console.error(newCountUp.error);
        }
      }
    }
}
</script>
