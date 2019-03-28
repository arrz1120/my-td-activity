<template>
    <div class="mask-con-normal">
        <div class="mask-txt">
            <p class="mask-p1">亲，您已分享，赶紧去刮奖吧~</p>
        </div>
        <div class="mask-btn" @click="goToScoreEraser">前往刮奖</div>
    </div>
</template>

<script>
export default {
    methods: {
        goToScoreEraser(){
            this.$emit('goToScoreEraser')
        }
    }
}
</script>

