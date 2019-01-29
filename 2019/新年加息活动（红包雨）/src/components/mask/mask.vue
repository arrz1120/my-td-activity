<template>
    <div class="mask" @touchmove.prevent>
        <div class="mask-bg"></div>
        <div class="mask-con">
            <slot></slot>
        </div>
        <div class="mask-close" @click="hideMask"></div>
    </div>
</template>

<script>
export default {
    methods: {
        hideMask() {
            this.$emit('hideMask')
        }
    }
}
</script>

