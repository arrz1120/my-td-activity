
<template>
    <div class="mask-normal">
        <div class="mask-txt">
            <p class="mask-p1">确认兑换？</p>
            <p class="mask-p2">亲，是否使用30个积分兑换刮奖机会？</p>
        </div>
        <div class="mask-btn" mtaName="confirm_b8" name="刮刮乐确认兑换" @click="sureChange">确认兑换</div>
    </div>
</template>

<script>
import {track} from '../../js/lib/util'
import {integralExchangeDraw} from '../../api/baseAPI'
export default {
    props:['choiceItem'],
    methods:{
        sureChange(e){
            track(e)
            integralExchangeDraw().then(res => {
                this.$emit('exchangeSuccess30')
            })
        }
    }
}
</script>


