<template>
    <div class="mask-normal">
        <div class="mask-txt">
            <p class="mask-p1">请先登录</p>
            <p class="mask-p2">亲，请先登录再参加活动哦~</p>
        </div>
        <div class="mask-btn" mtaName="login_a6" name="弹窗登录" @click="maskNoLogin">前往登录</div>
    </div>
</template>

<script>
import {toLogin,track} from '../../js/lib/util'

export default {
    methods: {
        maskNoLogin(e) {
            track(e)
            toLogin()
        }
    }
}
</script>

