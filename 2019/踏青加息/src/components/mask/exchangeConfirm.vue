
<template>
    <div class="mask-normal">
        <div class="mask-txt">
            <p class="mask-p1">确认兑换？</p>
            <p class="mask-p2">是否消耗 <span>{{choiceItem.exchangeCost}}</span>积分，兑换 <br><span>{{choiceItem.prizeName}}</span>？</p>
        </div>
        <div class="mask-btn" mtaName="comfirm_b13" name="积分兑奖确认兑换" @click="sureChange">确认兑换</div>
    </div>
</template>

<script>
import {track} from '../../js/lib/util'
export default {
    props:['choiceItem'],
    methods:{
        sureChange(e){
            track(e)
            this.$emit('exchangeFun')
        }
    }
}
</script>


