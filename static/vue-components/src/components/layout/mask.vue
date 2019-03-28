<template>
    <transition name="fade">
        <div class="mask" @touchmove.prevent>
            <div class="mask-bg"></div>
            <div class="mask-con">
                <slot></slot>
            </div>
            <div class="mask-close" @click="closeMask" v-show="showClose"></div>
        </div>
    </transition>
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
        closeMask() {
            this.$emit('closeMask')
        }
    }
}
</script>

