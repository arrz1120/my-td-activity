<template>
    <div class="mask" @touchmove.prevent>
        <div class="mask-bg"></div>
        <div class="mask-con">
            <div class="mask-con-img"></div>
            <div class="mask-con-bg">
                <div class="mask-wrapper">
                    <slot></slot>   
                </div>
            </div>
        </div>
        <div class="mask-close" @click="hideMask" v-show="showClose"></div>
    </div>
</template>

<script>
export default {
    props: {
        showClose: {
            type: Boolean,
            default: true
        }
    },
    methods: {
        hideMask() {
            this.$emit('maskClose')
        }
    }
}
</script>

