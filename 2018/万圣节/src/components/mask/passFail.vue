<style lang="scss" scoped>
    .pass-fail{
        height: rem(328);
        text-align: center;
        padding-top: rem(100);
        .p1{
            color: #333333;
            font-size: rem(34);
            font-weight: bold;
        }
        .btn{
            width: rem(501);
            margin: rem(65) auto 0;
            display: flex;
            justify-content: space-between;
            font-size: rem(30);
        }
        .btn-left{
            width: rem(240);
            padding: rem(25) 0;
            color: #5f2d06;
            @include bg('../../assets/images/mask-btn.png');
            background-size: 100% 100%;
        }
        .btn-right{
            width: rem(240);
            padding: rem(25) 0;
            color: #000;
            @include bg('../../assets/images/red-btn.png');
            background-size: 100% 100%;
        }
    }
</style>


<template>
    <div class="pass-fail">
        <div class="p1">啊哦，逃生失败~</div>
        <div class="btn">
            <div class="btn-left" @click="tryAgain" name="再试一次">再试一次</div>
            <div class="btn-right" @click="watchTips" name="逃生失败_查看提示">查看提示</div>
        </div>
    </div>
</template>

<script>
export default {
    methods: {
        tryAgain({target}) {
            this.$emit('tryAgain')
            MtaH5.clickStat('try_b1')
            sa.quick('trackHeatMap',target)
        },
        watchTips({target}) {
            this.$emit('watchTips')
            MtaH5.clickStat('tips_b2')
            sa.quick('trackHeatMap',target)
        }
    }
}
</script>

