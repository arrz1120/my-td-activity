<template>
    <div class="game-wapper">
        <div class="game-timeout">
            <p class="gt-p1">倒计时</p>
            <p class="gt-p2">{{currentTime}}s</p>
        </div>
        <div id="canvas" class="canvas"></div>
    </div>
</template>

<script>
import Game from '../js/lib/game.js'
import Timr from 'timrjs'

const GAME_TIME = 8

export default {
    created() {
        this.gameTimer = null
    },
    mounted() {
        this.game = new Game(this)
        this.init()
    },
    data() {
        return {
            currentTime: GAME_TIME,
            counter: 0
        }
    },
    methods: {
        init() {
            const timr = Timr(GAME_TIME)
            timr.ticker(({currentTime})=>{
                this.currentTime = currentTime
            })
            timr.onStart(() => {
                this.game.gamePlay.call(this.game)
            })
            timr.finish(() => {
                clearInterval(this.gameTimer)
                this.gameTimer = null
                this.game.end.call(this.game)
                this.$emit('gameOver')
            })
            timr.start()
        }
    },
    watch: {
        counter(newVal) {
            this.$emit('onCount',newVal)
        }
    }
}
</script>

<style>
    .game-wapper{
        width: 100vw;
        height: 100vh;
        position: absolute;
        top: 0;
        left: 0;
    }
    .canvas{
        width: 100vw;
        height: 100vh;
        position: absolute;
        top: 0;
        left: 0;
    }
    .game-timeout{
        padding-top: rem(50);
    }
    .gt-p1{
        font-size: rem(30);
        color: #fff;
        margin-left: rem(32);
    }
    .gt-p2{
        font-size: rem(70);
        color: #ffdf04;
        margin-left: rem(44);
    }
    
</style>


