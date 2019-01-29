<style lang="scss" scoped>
  .comp-modal{
    position: fixed;
    z-index: 10;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    transform: translateZ(1px);
    .modal-shade{
      position: absolute;
      z-index: 0;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
      background: rgba(0,0,0,.85);
    }
    .modal-container{
      position: relative;
      z-index: 1;
      margin: 0 auto;
    }
    .modal-topic{
      font-size: rem(34);
      color: #ffffff;
      font-weight: bold;
      @include wh(462,109);
      @include bg('../assets/images/modal/01.png');
      margin: 0 auto;
      padding-top: 0.65rem;
      text-align: center;
      position: relative;
      z-index: 1;
    }
    .modal-close{
      position: relative;
      z-index: 1;
      margin-top: .75rem;
      @include wh(70,70);
      @include bg('../assets/images/modal/02.png');
    }
    .modal-content{
      width: 12rem;
      background: #ffffff;
      min-height: 6rem;
      margin-top: -1.25rem;
      padding-top: 1.75rem;
      position: relative;
      z-index: 0;
      border-radius: .5rem;
      box-shadow: 0 0 1.5rem 0.15rem rgba(0,59,169,.25) inset;
      overflow: hidden;
    }
  }
</style>

<template>
  <section class="comp-modal">
    <div class="modal-shade"></div>
    <div class="modal-container">
      <p v-if="topic" class="modal-topic">{{topic}}</p>
      <div class="modal-content">
        <slot></slot>
      </div>
    </div>
  </section>
</template>

<script>
  export default {
    props:['topic'],
  }
</script>


