
<template>
    <div class="tb-con">
        <div class="tb-txt">
            <p class="tb-p1">已消耗88团币，获得1次<br />查看提示机会！</p>
        </div>
        <div class="mask-btn" @click="watchTips">查看提示</div>
    </div>
</template>

<script>
export default {
    methods: {
        watchTips() {
            this.$emit('watchTips')
        }
    }
}
</script>


