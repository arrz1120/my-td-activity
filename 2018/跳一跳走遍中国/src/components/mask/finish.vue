<template>
    <div class="mask-tips">
        <p class="tips-p1">亲，旅途已经圆满完成了~</p>
        <div class="mask-btn" @click="hideMask">我知道了</div>
    </div>
</template>

<script>
export default {
    methods: {
        hideMask(){
            this.$emit('hideMask')
        }
    }
}
</script>

