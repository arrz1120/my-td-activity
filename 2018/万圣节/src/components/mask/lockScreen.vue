<style lang="scss" scoped>
    .lock-screen{
        height: rem(428);
        text-align: center;
        padding-top: rem(60);
        .p1{
            color: #333333;
            font-size: rem(24);
        }
        .lock-img{
            @include wh(144,144);
            @include bg('../../assets/images/lockScreen.png');
            margin:  rem(47) auto 0;
        }
        .btn{
            width: rem(400);
            padding: rem(25) 0;
            color: #5f2d06;
            font-size: rem(30);
            margin: rem(33) auto 0;
            @include bg('../../assets/images/mask-btn.png');
            background-size: 100% 100%;
        }
    }
</style>


<template>
    <div class="lock-screen">
        <div class="p1">温馨提醒：逃生前先锁定手机竖屏状态喔~</div>
        <div class="lock-img"></div>
        <div class="btn" @click="onBtnClk">确定</div>
    </div>
</template>

<script>
export default {
    methods: {
        onBtnClk() {
            this.$emit('onBtnClk')
        }
    }
}
</script>

