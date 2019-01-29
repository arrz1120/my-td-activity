<template>
  <section class="popup-wrapper" @touchmove="handleTouchmove">
    <div class="mask" ></div>
    <div class="popup-con">
      <div class="con-inner">
        <h3 class="con-tit" v-if="showTitle">{{ title }}</h3>
        <slot></slot>
        <div @click="onBtnClick" v-if="showButton" class="con-btn" :name="name" :mtaName="mtaName">{{ buttonText }}</div>
      </div>
      <div class="close" @click="handleClose"></div>
    </div>
  </section>
</template>

<script>
import '../../src/assets/sass/popup.scss'


export default {
  props: {
    buttonText: String,
    title: String,
    preventDefault: {
      type: Boolean,
      default: true
    },
    name: {
      type: String,
      default: null
    },
    mtaName: {
      type: String,
      default: null
    }
  },
  computed: {
    showTitle () {
      return typeof this.title !== 'undefined' ? true : false
    },
    showButton () {
      return (typeof this.buttonText !== 'undefined') && this.buttonText!=='' ? true : false
    }
  },
  methods: {
    handleClose (e) {
      this.$emit('on-close', e)
    },
    onBtnClick(e) {
      this.$emit('onBtnClick',e)
    },
    handleTouchmove (event) {
      this.preventDefault && event.preventDefault()
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
