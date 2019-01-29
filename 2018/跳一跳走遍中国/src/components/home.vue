<template>
    <div class="home">
        <div class="logo"></div>
        <div class="rule-btn" @click="showRule" mtaName="rule_a1" name="活动规则"></div>
        <div class="share-btn" @click="toShare" mtaName="share_a2" name="分享"></div>
        <p class="ad-txt">【广告】市场有风险 出借需谨慎</p>
        <div class="home-tit animated bounceInDown"></div>
        <div class="home-time animated zoomIn">活动时间：2018年12月31日-2019年1月8日</div>
        <div class="home-btn breath" @click="onStartClick" mtaName="travel_a3" name="首页_开启旅途">开启旅途</div>
    </div>
</template>

<script>
import '../assets/sass/home.scss'
import Share from '../js/lib/initShare'

export default {
    methods: {
        showRule(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.$emit('showRule',e)
        },
        onStartClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.$emit('onStartClick')
        },
        toShare(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            Share.show()
        }
    }
}
</script>

