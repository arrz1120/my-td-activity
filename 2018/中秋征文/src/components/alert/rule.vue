<style lang="scss">
   
   .rule-con{
       height: 80vh;
       max-height: rem(1078);
       width: rem(600);
       background-color: #fff;
       display: flex;
       flex-direction: column;
       background-image: url('../../assets/images/bg-rule.png');
       background-repeat: no-repeat; 
       background-position: center rem(61);
       background-size: rem(560) 90%;
       border-radius: 6px;
       .rule-tit{
           flex: 0 0 rem(134);
           display: flex;
           justify-content: center;
           align-items: center;
           font-size: rem(40);
           color: #a77d41;
           font-weight: bold;
       }
       .rule-content{
           display: flex;
           flex-direction: column;
           flex: 1;
           padding-left: rem(56);
           padding-right: rem(37);
           padding-bottom: rem(93);
           .rule-scroll{
               height: auto;
               overflow: hidden;
               padding-right: rem(50);
               position: relative;
               .bscroll-vertical-scrollbar{
                    background: #f5f5f5;
                    border-radius: 3px;
                }
                .bscroll-indicator{
                    background: #d4be9e !important;
                }
           }
           .r-tit{
               padding: rem(12);
               background: #fff9f3;
               color: #a77d41;
               font-size: rem(20);
               font-weight: bold;
           }
           p{
               color: #666;
               font-size: rem(20);
               line-height: rem(28);
               padding: rem(15) 0;
               text-align: justify;
           }
       }
       .close{
           transform: translate(-50%,130%);
       }
   }

   .rule-enter-active,.rule-leave-active{
        transition: 0.4s;
    }

    .fade-enter-active, .fade-leave-active {
        transition: opacity 0.4s;
    }
    .fade-enter, .fade-leave-to {
        opacity: 0;
    }

    .rule-move-enter-active,.rule-move-leave-active {
        transition: all 0.4s ease-out;
    }
    .rule-move-enter, .rule-move-leave-to {
        transform: translate3d(0,30px,0);
        opacity: 0;
    }
</style>

<template>
    <transition name="rule">
        <div v-show="showRule" class="alert" @touchmove.prevent>
            <transition name="fade">
                <div v-show="showRule" class="alert-bg" @click="close"></div>
            </transition>
            <transition name="rule-move">
                <div v-show="showRule" class="alert-con rule-con">
                    <div class="rule-tit">活动规则</div>
                    <div class="rule-content">
                        <scroll class="rule-scroll" :data="showRule">
                            <ul>
                                <li>
                                    <div class="r-tit">活动一：有奖灯谜征集</div>
                                    <p>用户在灯谜征集页面写下谜语和谜底，即可获得随机奖品，写灯谜次数不限，奖品每人仅限1份，奖品有现金红包、投资红包及团币等。</p>
                                </li>
                                <li>
                                    <div class="r-tit">活动二：中秋征文</div>
                                </li>
                                <li>
                                    <div class="r-tit">1.投稿方式</div>
                                    <p>①活动页投稿：在活动页面点击“马上投稿”，即可进入投稿页面；</p>
                                    <p>②邮箱投稿：将稿件与生活照发送至征文邮箱zhengwen@tuandai.com，邮件标题命名格式为“中秋节征文+姓名+地区+手机号码”。</p>
                                </li>
                                <li>
                                    <div class="r-tit">2.征文规则</div>
                                    <p>以“难忘的中秋节”为主题书写800字以上，与中秋节有关的故事或经历，成功入选的原创文章将于活动结束后，按照注册时间、签到天数和会员等级等维度分为A、B、C三档从高往低计算稿费。</p>
                                    <p>①A档稿费：1字/1.5元</p>
                                    <p>②B档稿费：1字/1元</p>
                                    <p>③C档稿费：1字/0.5元</p>
                                </li>
                                <li>
                                    <div class="r-tit">3.补充说明</div>
                                    <p>①入选名单将于活动结束后3个工作日内在团粉圈公布，稿费将于5个工作日内以现金红包形式发放；</p>
                                    <p>②现金红包将发放至团宝箱，使用规则以团宝箱提示为准，逾期未领取或未使用视为放弃，不予补发；</p>
                                    <p>③团贷网对全部参赛作品具有收藏、发表、出版、宣传等处置权，包括网络发表权、出版权；</p>
                                    <p>④因参赛者抄袭带来的版权纠纷，由参赛者个人承担全部责任，参赛者享受自己作品署名权；</p>
                                    <p>⑤凡参与活动的团粉视为了解并接受以上规则；</p>
                                    <p>⑥本活动最终解释权归团贷网所有。</p>
                                </li>
                            </ul>
                        </scroll>
                    </div>
                    <div class="alert-close close" @click="close"></div>
                </div>
            </transition>
        </div>
    </transition>
</template>

<script>
import Scroll from '../base/scroll'

export default {
    props:['showRule'],
    methods: {
        close() {
            this.$emit('toggleRuleAlert',false)
        }
    },
    components: {
        Scroll
    },
}
</script>
