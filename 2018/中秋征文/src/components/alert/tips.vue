<style lang="scss">
    .tips-con{
        @include wh(637,489);
        background: #fff url('../../assets/images/alert/bg-frame2.png') center no-repeat;
        background-size: rem(582) rem(392);
        padding-top: rem(50);
        .tips-txt{
            height: rem(263);
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            flex-direction: column;
            .p1{
                color: #a77d41;
                font-size: rem(50);
                line-height: rem(70);
            }
            .p2{
                color: #ff7454;
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

        <div class="alert-con tips-con" v-if="showType === 'login'">
            <div class="tips-txt">
                <p class="p1">请先登录再参与活动</p>
            </div>
            <div class="alert-btn tips-btn" @click="toLogin">去登录</div>
            <div class="alert-close" @click="hideAlert"></div>
        </div>

        <div class="alert-con tips-con" v-if="showType === 'hasPrize'">
            <div class="tips-txt">
                <p class="p1">精彩的谜语已收到！</p>
                <p class="p2">每人仅限1份奖品噢~</p>
            </div>
            <div class="alert-btn tips-btn" @click="hideAlert">完成</div>
            <div class="alert-close" @click="hideAlert"></div>
        </div>

        <div class="alert-con tips-con" v-if="showType === 'error'">
            <div class="tips-txt">
                <p class="p1">网络开小差喔，<br>请稍后再试~</p>
            </div>
            <div class="alert-btn tips-btn" @click="hideAlert">确定</div>
            <div class="alert-close" @click="hideAlert"></div>
        </div>

        <div class="alert-con tips-con" v-if="showType === 'thx'">
            <div class="tips-txt">
                <p class="p1">感谢您的投稿！</p>
            </div>
            <div class="alert-btn tips-btn" @click="hideAlert">返回活动首页</div>
            <div class="alert-close" @click="hideAlert"></div>
        </div>

    </div>
</template>

<script>
import {Login} from '../../js/lib/common/bridge.js'
export default {
    props:['show','showType','isToWrite'],
    methods: {
        toLogin() {
            Login(this.isToWrite)
        },
        hideAlert() {
            if(this.showType === 'thx') {
                window.location.href = "index.html"
            }
            else {
                this.$emit('hideAlert')
            }
        }
    }
}
</script>
