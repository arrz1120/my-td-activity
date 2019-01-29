<template>
    <div class="alert-tips">
        <div class="rule-con">
            <div class="tab">
                <div
                    class="item"
                    v-for="(item, index) in tab"
                    :class="{active: ruleTxtIndex===index}"
                    :key="item"
                    @click="_tabRule(index)"
                >
                    {{item}}
                </div>
            </div>
            <Scroll
                class="wrapper"
                :scrollbar="{}"
                :data="ruleTxtIndex"
            >
                <div>
                    <div v-html="ruleTxt"></div>
                </div>
            </Scroll>
            <div class="close" @click="_hideRule"></div>
        </div>
    </div>
</template>

<script>
import Scroll from '../../base/scroll'

let txt = [
    `
        <p>1、累计召唤3只喜鹊即可开启第一个宝箱，累计召唤6只喜鹊即可搭建鹊桥，助牛郎织女重逢，此时可开启第二个宝箱（有机会获得iPhone X），超出6只部分不予奖励；</p>
        <p>2、 通过召唤喜鹊获得的开宝箱机会仅限活动期间内使用，逾期视为自动放弃奖励；</p>
        <p>3、用户获得的团币、投资红包、现金红包将在1个工作日内发放，查看奖品请前往团宝箱（团币请前往会员中心），其中现金红包，需用户在15天内到团宝箱手动领取，逾期失效且不予补偿；</p>
        <p>4、获得实物奖品的用户请按要求前往团宝箱完善个人配送信息，奖励将在填写收货信息后的15个工作日内发出，商品颜色默认随机发放，奖品图片仅供参考，以最终收到的实物为准；</p>
        <p>5、本活动禁止一切刷奖行为，一经发现，所得奖品将不予承兑；</p>
        <p>6、活动与苹果公司无关，活动规则最终解释权归团贷网所有。</p>

    `,
    `
        <p>活动期间，用户可通过以下方式召唤喜鹊：</p>
        <p>1、分享活动到微信/朋友圈，可召唤1只喜鹊（1只/天，最多召唤2只，需点击活动页面的分享按钮分享活动才有效）。</p>
        <p>2、单笔投资≥5000元（1个月及以上项目，债权转让和智享转让除外），可召唤1只喜鹊（1只/天，最多3只）。</p>
        <p>3、 消耗200团币可召唤1只喜鹊（最多1只）。</p>
        <p>4、 邀请1位好友注册团贷网，可召唤1只喜鹊（最多1只，通过分享活动页面邀请才有效）。</p>
        <p>5、通过活动分享链接注册的新用户，赠送10元投资红包（同享平台新手福利），同时，邀请人和好友记录邀请关系，同享平台“邀请有礼”奖励。</p>
        <p>6、通过本活动所邀请的好友投资团贷网（投资金额、项目不限），可召唤1只喜鹊（最多召唤1只）。</p>
    `
]

export default {
    data() {
        return {
            tab: ['活动规则','召唤喜鹊'],
            ruleTxtIndex: 0
        }
    },
    computed: {
        ruleTxt(){
            return txt[this.ruleTxtIndex]
        }
    },
    components: {
        Scroll
    },
    methods: {
        _tabRule(idx){
            this.ruleTxtIndex = idx
        },
        _hideRule(){
            this.$emit('toggleRule',false)
        }
    }
}
</script>

<style lang="scss">
    @import "./alert.scss";
    .rule-con{
        @include wh(600,753);
        @include bg("../../assets/images/app/alert/rule-con.png");
        padding: rem(51) rem(42) 0 rem(70);
        position: relative;
    }
    .wrapper{
        height: rem(550);
        padding-right: rem(48);
        width: 100%;
        overflow: hidden;
        position: relative;
        margin-top: rem(24);
        .bscroll-vertical-scrollbar{
            z-index: 2 !important;
            background: #d3bdda;
            opacity: 1 !important;
            border-radius: 3px;
        }
        .bscroll-indicator{
            background: #f9f1fc !important;
            border-color: #d3bdda !important;

        }
        p{
            line-height: rem(55);
            color: #7d1ca1;
            font-size: rem(22);
        }
    }
    .tab{
        width: rem(284);
        display: flex;
        margin: 0 auto;
        .item{
            flex: 1;
            text-align: center;
            height: rem(47);
            line-height: rem(47);
            color: #654bdd;
            font-size: rem(24);
            background: #fff;
            border: 1px solid #644cdd;
        }
        .active{
            background-image: -webkit-linear-gradient(left,#634bdd,#a147b8);
            color: #fefefe;
            font-weight: bold;
            border: 0;
        }
        .item:nth-child(1){
            border-radius: 4px 0 0 4px
        }
        .item:nth-child(2){
            border-radius: 0 4px 4px 0
        }
    }
</style>
