<template>
    <div class="no-login">
        <p class="mask-p">亲，请先登录后再参与活动哦~</p>
        <div class="no-login-btn" mtaName="login5c" name="前往登录5c" @click="goToLogin">前往登录</div>
    </div>
</template>

<script>
export default {
    methods: {
        goToLogin(e) {
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.$emit('goToLogin')
        }
    }
}
</script>


<style lang="scss" scoped>
    .no-login{
        @include wh(650,455);
        @include bg('../../assets/images/no-login.png');
        text-align: center;
        padding-top: rem(180);
        .no-login-btn{
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

