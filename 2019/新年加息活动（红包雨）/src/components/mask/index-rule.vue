<template>
    <div class="mask-index-rule">
        <div class="scroll-wrapper">
            <scroll class="index-rule-scroll">
                <div class="scroll-content">
                    <div class="index-rule-tit">活动规则</div>
                    <ul>
                        <li>
                            <h3>1、新年加息  最高1.0%</h3>
                            <p>活动期间，用户成功加入（且匹配成功）We自动服务、We+自动服务（新手专享服务除外），即可获得相应的加息奖励。</p>
                        </li>
                        <li>
                            <h3>2、登录即送0.8%加息特权</h3>
                            <p>活动期间，用户登录访问活动页面，即可获得一份0.8%的加息特权，每位用户限获得一次</p>
                        </li>
                        <li>
                            <h3>3、出借达标享最高1%加息特权</h3>
                            <p>活动期间，用户累计成功出借We自动服务、We+自动服务（新手专享服务除外）的金额达标，即可获得相应的加息特权。</p>
                        </li>
                        <li>
                           <div class="table">
                                <div class="th">
                                    <div class="td">累计出借金额</div>
                                    <div class="td">加息特权奖励</div>
                                </div>
                                <div class="tbody">
                                    <div class="tr">
                                        <div class="td">≥0.5万元</div>
                                        <div class="td">0.2%</div>
                                    </div>
                                    <div class="tr">
                                        <div class="td">≥2万元</div>
                                        <div class="td">0.5%</div>
                                    </div>
                                    <div class="tr">
                                        <div class="td">≥10万元</div>
                                        <div class="td">1.0%</div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li>
                            <h3>4、智享加息0.1%</h3>
                            <p>活动期间，用户使用自动投标工具承接年化利率10%以下（不含10%）的智享转让服务，即可获得0.1%加息奖励。</p>
                        </li>
                    </ul>
                    <div class="index-rule-tit index-rule-tit2">加息特权说明</div>
                    <ul>
                        <li>
                            <p>1、加息特权可与普惠加息叠加使用，加息额度均以最终叠加结果计算，加息范围：1月29日~2月13日期间的We自动服务、We+自动服务（新手专享服务除外），且仅限本次活动期间内使用，过期作废。</p>
                        </li>
                        <li>
                            <p>2、加息特权所加利息额度会在活动结束后5个工作日内发出，由系统自动添加至用户符合条件的We自动服务、We+自动服务上： <br />①We自动服务：加息匹配至所投标的，加息奖励将随标的回款计划按月发放或到期发放；<br />②We+自动服务：加息至所投计划，退出计划时一次性发放持有时间产生的加息奖励。</p>
                        </li>
                    </ul>
                </div>
            </scroll>
        </div>
    </div>
</template>

<script>
import Scroll from '../scroll'

export default {
    components: {
        Scroll
    }
}
</script>

<style lang="scss" scoped>


.mask-index-rule{
    @include wh(580,821);
    @include bg('../../assets/images/index/index-rule.png');
    padding-top: rem(104);
    .scroll-wrapper{
        padding: rem(27) 0 rem(25) 0;
        background: #fff8ea;
        width: rem(546);
        margin: 0 auto;
    }
    .index-rule-scroll{
        @include wh(546,637);
        border-radius: rem(10);
        position: relative;
        overflow: hidden;
        padding-bottom: rem(31);
    }
    .scroll-content{
        padding: rem(27) rem(47) 0 rem(25);
    }
    .index-rule-tit{
        @include wh(189,54);
        @include bg('../../assets/images/index/index-rule-tit.png');
        margin: 0 auto;
        @include flexCenter;
        color: #b4283d;
        font-size: rem(30);
        font-weight: bold;
    }
    .index-rule-tit2{
        width: rem(249);
        @include bg('../../assets/images/index/index-rule-tit2.png');
    }
    .bscroll-vertical-scrollbar{
        right: rem(19) !important;
        background: rgba(213,202,185,0.5) !important;
        border-radius: 3px;
        width: rem(10) !important;
        .bscroll-indicator{
            background: rgba(255,129,28,0.3) !important;
            border: 0 !important;
        }
    }
    ul{
        padding-top: rem(32);
    }
    li{
        margin-bottom: rem(35);
        h3{
            color: #b4283d;
            font-size: rem(22);
            font-weight: bold;
        }
        p{
            color: #b4283d;
            font-size: rem(22);
            line-height: rem(30);
            margin-top: rem(15);
            text-align: justify;
        }
        .table{
            width: rem(390);
        }
    }
}
</style>

