<style lang="scss" scoped>
    .timer{
        @include wh(108,105);
        @include bg('../assets/images/timer.png');
        display: flex;
        align-items: center;
        justify-content: center;
        color: #252151;
        font-size: rem(36);
        position: absolute;
        top: rem(40);
        right: rem(30);
    }
</style>


<template>
    <div class="timer">{{time}}s</div>
</template>

<script>
export default {
    data() {
        return {
            time: 0
        }
    },
    mounted() {
        
    },
    methods: {
        start() {
           this.time = 3
           this.timer = setInterval(() => {
               this.time--
               if(this.time <= 0){
                   this.stop()
               }
           },1000) 
        },
        stop() {
            clearInterval(this.timer)
            this.timer = null
            this.$emit('timerStop')
        }
    }
}
</script>

