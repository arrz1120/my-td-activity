<template>
    <div class="swiper-container" ref="swiper">
        <div class="swiper-wrapper">
            <slot></slot>
        </div>
    </div>
</template>

<script>
import Swiper from 'swiper'

export default {
    props: ['config'],
    created() {
        this.swiper = null
    },
    mounted() {
        this.$nextTick(() => {
            this.init()
        })
    },
    methods: {
        init() {
            this.swiper = new Swiper(this.$refs.swiper,{
                ...this.config,
                onSlideChangeEnd: (swiper) => {
                    this.$emit('onSlideChangeEnd',swiper.activeIndex)
                }
            })
        },
        slideTo(index,duration=1) {
            this.swiper && this.swiper.slideTo(index,duration,false)
        }
    }
}
</script>
