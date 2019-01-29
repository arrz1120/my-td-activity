<style lang="scss" scoped>
    .pass-tips-txt{
        height: rem(320);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        .pass-tips-p1{
            color: #37256b;
            font-weight: bold;
            font-size: rem(34);
        }
        .pass-tips-p2{
            line-height: rem(36);
            text-align: center;
            margin-top: rem(32);
        }
    }
</style>

<template>
    <div class="pass-tips-con">
        <div class="pass-tips-txt">
            <p class="pass-tips-p1">提示</p>
            <p class="pass-tips-p2" v-html="tips"></p>
        </div>
        <div class="mask-close" @click="playAgain"></div>
    </div>
</template>

<script>

const PASS_TIPS = [
  '题目中还有一颗糖果哦~',
  '将手机横过来试试~<br />（记得先锁定手机竖屏状态哦）',
  '请用力晃动手机试试~',
  '窗户上的迷雾可用手指擦除哟~'
]

export default {
    props: ['nowPass'],
    data() {
        return {
            tips: PASS_TIPS[this.nowPass - 1]
        }
    },
    methods: {
        playAgain() {
            this.$emit('playAgain')
        }
    }
}
</script>

