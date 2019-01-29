<style lang="scss" scoped>
    .pass-success{
        height: rem(328);
        text-align: center;
        padding-top: rem(100);
        .p1{
            color: #333333;
            font-size: rem(34);
            font-weight: bold;
        }
        .btn{
            width: rem(400);
            padding: rem(25) 0;
            color: #5f2d06;
            font-size: rem(30);
            margin: rem(65) auto 0;
            @include bg('../../assets/images/mask-btn.png');
            background-size: 100% 100%;
        }
    }
</style>


<template>
    <div class="pass-success">
        <div class="p1">恭喜您，逃生成功</div>
        <div class="btn" @click="nextPass" name="下一关">下一关</div>
    </div>
</template>

<script>
export default {
    methods: {
        nextPass({target}) {
            this.$emit('nextPass')
            MtaH5.clickStat('next_b3')
            sa.quick('trackHeatMap',target)
        }
    }
}
</script>

