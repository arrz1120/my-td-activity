<style lang="scss" scoped>
    
</style>

<template>
    <div class="tb-con">
        <div class="tb-txt">
            <p class="tb-p1">您当前团币不足88，不能看提示喔~</p>
            <p class="tb-p2">我的团币：{{tb}}</p>
        </div>
        <div class="mask-btn" @click="hideMask" name="朕知道了">朕知道了</div>
    </div>
</template>

<script>
export default {
    props: ['tb'],
    methods: {
        hideMask({target}){
            this.$emit('hideMask')
            MtaH5.clickStat('know_b6')
            sa.quick('trackHeatMap',target)
        }
    }
}
</script>

