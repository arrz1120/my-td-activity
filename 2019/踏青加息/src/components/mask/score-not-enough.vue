<template>
    <div class="mask-normal">
        <div class="mask-txt mask-txt-nobtn">
            <p class="mask-p1">您当前积分不足！</p>
            <p class="mask-p2">活动期间，用户成功出借We自动服务、We+自动服务（新手专享服务除外）可获得积分，100元=1积分。消耗30积分可参与1次分享刮刮乐的抽奖。</p>
        </div>
        <div class="mask-btn" mtaName="login05" name="前往登录_弹窗" @click="maskNoLogin">出借赚积分</div>
    </div>
</template>

<script>
import {toAppP2p,track} from '../../js/lib/util'

export default {
    methods: {
        maskNoLogin(e) {
            track(e)
            toAppP2p()
        }
    }
}
</script>

