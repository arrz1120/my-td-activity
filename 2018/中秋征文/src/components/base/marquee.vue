<template>
  <div ref="marquee">
    <slot></slot>
  </div>
</template>

<script>
import '../../js/lib/marquee.js'

export default {
  props: ['slides'],
  mounted() {
    new Marquee(this.$refs.marquee,{
      showSlides: this.slides
    })
  }
}
 
</script>
