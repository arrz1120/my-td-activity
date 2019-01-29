<style lang="scss">
    .award-con{
        @include wh(637,535);
        background: #fff url('../../assets/images/alert/bg-frame3.png') center rem(94) no-repeat;
        background-size: rem(582) rem(400);
        padding-top: rem(20);
        .award-img{
            @include wh(264,197);
            margin: 0 auto;
        }
        .hb{
            @include bg('../../assets/images/alert/hb.png');
        }
        .tb{
            @include bg('../../assets/images/alert/tb.png');
            transform: translateX(rem(-25));
        }
        .award-txt{
            padding-top: rem(28);
            text-align: center;
            .p1{
                color: #a77d41;
                font-size: rem(50);
                line-height: rem(70);
            }
            .p2{
                color: #db893a;
                font-size: rem(30);
                margin-top: rem(30);
            }
        }
        .tips-btn{
            width: rem(508);
        }
    }
</style>

<template>
    <div class="alert" @touchmove.prevent v-if="show">
        <div class="alert-bg" @click="hideAlert"></div>

        <div class="alert-con award-con" v-if="showType === 3">
            <div class="award-img tb"></div>
            <div class="award-txt">
                <p class="p1">恭喜你</p>
                <p class="p1">获得{{prizeName}}</p>
                <p class="p2">*可在会员中心进行查看</p>
            </div>
            <div class="alert-close" @click="hideAlert"></div>
        </div>

        <div class="alert-con award-con" v-if="showType === 1">
            <div class="award-img hb"></div>
            <div class="award-txt">
                <p class="p1">恭喜你</p>
                <p class="p1">获得{{prizeName}}</p>
                <p class="p2">*可在团宝箱进行查看</p>
            </div>
            <div class="alert-close" @click="hideAlert"></div>
        </div>

    </div>
</template>

<script>
export default {
    props:['show','showType','prizeName'],
    methods: {
        hideAlert() {
            this.$emit('hideAlert')
        }
    }
}
</script>
