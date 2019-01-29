<template>
    <div class="mask-tips">
        <p class="tips-p1">亲，您还未登录喔~</p>
        <div class="mask-btn" @click="toLogin">请先登录</div>
    </div>
</template>

<script>
import {login} from '../../js/lib/util'

export default {
    methods: {
        toLogin(){
            login()
        }
    }
}
</script>

