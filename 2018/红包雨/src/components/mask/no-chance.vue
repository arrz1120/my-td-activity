<template>
    <div class="no-chance">
        <p class="mask-p">分享活动可以再获得一次抽奖机会哦~</p>
        <div class="no-chance-btn" mtaName="share6c" name="马上分享6c" @click="goToShare">马上分享</div>
    </div>
</template>

<script>
export default {
    methods: {
        goToShare(e) {
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.$emit('goToShare')
        }
    }
}
</script>


<style lang="scss" scoped>
    .no-chance{
        @include wh(650,455);
        @include bg('../../assets/images/mask-no-chance.png');
        text-align: center;
        padding-top: rem(180);
        .no-chance-btn{
            @include wh(488,112);
            @include bg('../../assets/images/lookPrize-btn2.png');
            color: #ff413d;
            font-size: rem(34);
            padding-top: rem(24);
            margin: rem(40) auto 0;
        }
    }
    .mask-p{
        color: #fff;
        line-height: rem(40);
        font-size: rem(24);
        text-align: center;
    }
</style>

