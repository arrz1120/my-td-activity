<template>
    <div class="mask-normal">
        <div class="mask-txt">
            <p class="mask-p1">您当前积分不足！</p>
            <p class="mask-p2">您当前积分为<span>{{score}}</span>，不足以<br>兑换该礼品哦！</p>
        </div>
        <div class="mask-btn" @click="toInvest" mtaName="lend_b14" name="积分兑奖积分不足出借赚积分">出借赚积分</div>
    </div>
</template>

<script>
import {toAppP2p,track} from '../../js/lib/util'

export default {
    props:['score','otherMask'],
    methods: {
        toInvest(e){
            track(e)
            toAppP2p()
        }
    }
}
</script>

