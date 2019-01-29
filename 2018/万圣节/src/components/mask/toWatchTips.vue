<style lang="scss" scoped>
    .to-watch-tips{
        height: rem(384);
    }
    .to-txt{
        .to-flex{
            display: flex;
            padding-bottom: rem(30);
            align-items: center;
            height: rem(88);
            .to-flex-left{
                width: rem(328);
                margin-left: rem(30);
                margin-right: rem(25);
            }
            .to-flex-right{
                .to-watch-btn{
                    height: rem(58);
                    text-align: center;
                    width: rem(141);
                    padding: rem(17) 0;
                    @include bg('../../assets/images/mask-btn.png');
                    background-size: 100% 100%;
                    color: #5f2d06;
                    font-size: rem(22);
                }
                .btn-ban{
                    @include bg('../../assets/images/btn-ban.png');
                    background-size: 100% 100%;
                    color: #666;
                }
            }
        }
    }
    .to-p1{
        padding-top: rem(56);
        color: #333;
        font-weight: bold;
        font-size: rem(28);
        text-align: center;
        margin-bottom: rem(49);
    }
    .to-p2{
        line-height: rem(36);
    }
    .to-p3{
        text-align: center;
        margin-top: rem(10);
        color: #fb5620;
        font-size: rem(18);
    }
</style>

<template>
    <div class="to-watch-tips">
        <p class="to-p1">亲，通过以下方式可查看提示喔~</p>
        <div class="to-txt">
            <div class="to-flex">
                <div class="to-flex-left">
                    <p class="to-p2">① 分享活动到微信或朋友圈，最多获得2次机会；</p>
                </div>
                <div class="to-flex-right">
                    <div class="to-watch-btn" @click="toShare" name="立即分享">立即分享</div>
                </div>
            </div>
            <div class="to-flex">
                <div class="to-flex-left">
                    <p class="to-p2">②消耗88团币查看提示，最多获得1次机会</p>
                </div>
                <div class="to-flex-right">
                    <div class="to-watch-btn" :class="{'btn-ban': exchangeCount >= 1}" @click="toExchange" name="团币获取">团币获取</div>
                </div>
            </div>
            <p class="to-p3" v-if="isApp">亲，通过App分享后，请点击返回团贷网才有效哦</p>
            <div class="mask-close" @click="passFail"></div>
        </div>
        <div class="mask-close" @click="passFail"></div>
    </div>
</template>

<script>
import {getUsesrTbExchangeCount, getUserCoin,shareAdd} from '../../api/api.js'
import share from '../../js/lib/initShare.js'

export default {
    props:['extenderKey','telNo','nowPass'],
    created() {
        getUsesrTbExchangeCount().then(res => {
            this.exchangeCount = res
        }).catch(err => {
            toast.show('网络异常，请稍后重试')
        })
    },
    data() {
        return {
            exchangeCount: 0,
            isApp: Jsbridge.isApp()
        }
    },
    methods: {
        toExchange({target}) {
            if(this.exchangeCount >= 1) return
            MtaH5.clickStat('tuancoin_b5')
            sa.quick('trackHeatMap',target)
            getUserCoin().then(res => {
                if(res >= 88){
                    this.$emit('toExchangeTb',res)
                }else{
                    this.$emit('tbNotEnough',res)
                }
            }).catch(err => {
                toast.show('网络异常，请稍后重试')
            })
        },
        passFail() {
            this.$emit('passFail')
        },
        // shareCallback(str) {
        //     shareAdd().then(res => {
        //         this.$emit('showTips')
        //     }).catch(err => {
        //         this.passFail()
        //     })
        // },
        setShare(){
            let way = this.isApp? 2: 1
            share.set({
                shareUrl:`${window.router.land}?telNo=${this.telNo}&extenderKey=${this.extenderKey}`,
                callback: ()=>{
                    if(!this.isApp){
                        share.hide()
                    }
                    shareAdd(this.nowPass,way).then(res => {
                        if(res>0 && res<=2){
                            this.$emit('showTips')
                        }
                    }).catch(err => {
                        this.passFail()
                    })
                }
            })
        },
        toShare({target}) {
            this.setShare()
            share.show()
            MtaH5.clickStat('share_b4')
            sa.quick('trackHeatMap',target)
        }
    },
}
</script>

