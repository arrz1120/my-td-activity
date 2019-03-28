<template>
    <div class="mask-normal">
        <div class="mask-txt">
            <p class="mask-p1">恭喜兑换成功！</p>
            <p class="mask-p2">恭喜您成功兑换<span>{{exchangePrice}}</span></p>
        </div>
        <div class="mask-btn" mtaName="check_b15" name="积分兑奖查看奖品" @click="watchPrize">查看奖品</div>
    </div>
</template>

<script>
import {toTBX,track} from '../../js/lib/util'
export default {
    props:['exchangePrice'],
    methods:{
        watchPrize(e){
            track(e)
            toTBX()
        }
    }
}
</script>


