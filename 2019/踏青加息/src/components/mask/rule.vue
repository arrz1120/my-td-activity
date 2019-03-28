<template>
    <div class="mask-rule">
        <p class="mask-rule-tit">活动规则</p>
        <div class="swiper-container" id="ruleSwiper">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <ul>
                        <li>
                            <p class="rule-tit">(一)出借赚积分</p>
                            <p class="rule-sub">1、普惠加息 最高1%</p>
                            <p class="rule-txt">
                                <i>①</i>活动期间，用户成功出借（且匹配成功）指定的We自动服务、We+自动服务（新手专享服务除外），即可获得相应的加息奖励；
                            </p>
                            <p class="rule-txt">
                                <i>②</i>活动结束后，若用户出借带有加息标识的We自动服务、We+自动服务（新手专享服务除外），也可享受加息奖励。
                            </p>
                            <p class="rule-sub">2、抢购专享 最高加息3.5%</p>
                            <p class="rule-txt">
                                <i>①</i>活动期间，每日限量开放专享服务，用户成功出借（且匹配成功）We自动服务12、We+自动服务24和We+自动服务36，即可获得相应的加息奖励。
                            </p>
                            <p class="rule-sub">3、出借赚积分</p>
                            <p class="rule-txt">
                                <i>①</i>用户成功出借We自动服务、We+自动服务（新手专享服务除外），即可获得积分<span>（100元=1积分），</span>消耗积分可参与刮刮乐抽奖或兑换礼品，<span>用户所获得积分仅在活动期间有效</span>；
                            </p>
                        </li>
                        <li>
                            <p class="rule-tit">（二）积分兑好礼</p>
                            <p class="rule-txt">
                                <i>①</i>分享刮刮乐：活动期间，用户通过分享活动和消耗30积分，可分别获得1次刮奖机会，每位用户每日限刮2次，刮奖机会当天有效，奖品有出借红包、加息券等（在团贷网App内进行分享，需返回团贷网App才能获得刮奖机会）；
                            </p>
                            <p class="rule-txt">
                                <i>②</i>积分兑出游好礼：用户可使用相应的积分进行兑换，奖品每日10点限量放出，当日奖品兑完即止。
                            </p>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="swiper-scrollbar"></div>
        </div>
    </div>
</template>

<script>
import Swiper from 'swiper'

export default {
    mounted(){
        this.initSwiper()
    },
    methods: {
        initSwiper(){
            new Swiper('#ruleSwiper', {
                direction: 'vertical',
                freeMode: true,
                // freeModeSticky : true,
                slidesPerView: 'auto',
                scrollbar: '.swiper-scrollbar',
                scrollbarHide:false,
                // resistanceRatio :0,
                // roundLengths :true
            })
        }
    }
}
</script>
