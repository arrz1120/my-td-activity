<style lang="scss">
  .bg{
      position: absolute;
      top: 0;
      left: 0;
      z-index: 1;
  }
  .bg1{
      @include wh(750,1000);
      @include bg('../assets/images/bg1.jpg');
  }
  .bg2{
      @include wh(750,1000);
      @include bg('../assets/images/bg2.jpg');
  }
  .bg3{
      @include wh(750,1000);
      @include bg('../assets/images/bg3.jpg');
  }
  .bg4{
      @include wh(750,887);
      @include bg('../assets/images/bg4.jpg');
  }
</style>

<template>
  <div class="bg">
      <div class="bg1"></div>
      <div class="bg2"></div>
      <div class="bg3"></div>
      <div class="bg4"></div>
  </div>
</template>

<script>
export default {
  
}
</script>
