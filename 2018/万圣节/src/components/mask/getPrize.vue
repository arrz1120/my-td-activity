<style lang="scss" scoped>
    .get-prize{
        text-align: center;
        padding-top: rem(65);
        padding-bottom: rem(45);
        .p1{
            color: #333333;
            font-size: rem(30);
            font-weight: bold;
        }
        .box-p{
            color: #666;
            text-align: center;
            font-size: rem(20);
            margin-top: rem(28);
        }
        .box-img{
            @include wh(291,233);
            @include bg('../../assets/images/box.png');
            margin:  rem(35) auto 0;
        }
        .hb-img{
            @include wh(242,253);
            @include bg('../../assets/images/hb.png');
            margin:  rem(36) auto 0;
            padding-top: rem(110);
            text-align: center;
            .hb-p1{
                color: #ffef8e;
                font-size: rem(36);
                font-weight: bold;
                span{   
                    font-size: rem(50);
                }
            }
            .hb-p2{
                color: #fffdfd;  
                font-size: rem(28);  
                // margin-top: rem(12);
            }
        }
        .btn{
            width: rem(400);
            padding: rem(25) 0;
            color: #5f2d06;
            font-size: rem(30);
            margin: rem(30) auto 0;
            @include bg('../../assets/images/mask-btn.png');
            background-size: 100% 100%;
        }
    }
</style>


<template>
    <div class="get-prize">
        <div class="p1">{{title}}</div>
        <div class="prize-box" v-if="!isGetPrize">
            <div class="box-img" @click="getPrize" name="宝箱"></div>
            <p class="box-p">（点击宝箱领取奖励）</p>
        </div>
        <div class="hb-box" v-else>
            <div class="hb-img">
                <p class="hb-p1"><span>{{amo}}</span>元</p>
                <p class="hb-p2">{{prizeType}}</p>
            </div>
            <div class="btn" @click="watchPrize" name="宝箱_查看奖品">查看奖品</div>
        </div>
    </div>
</template>

<script>
import {draw} from '../../api/api.js'
import '../../js/lib/toast.js'
import {toTBX} from '../../js/lib/utils.js'
export default {
    data() {
        return {
            title: '恭喜你绝境逃生，获得万圣节宝箱~',
            isGetPrize: false,
            amo: null,
            prizeType: ''
        }
    },
    methods: {
        watchPrize({target}) {
            MtaH5.clickStat('checkgift_b9')
            sa.quick('trackHeatMap',target)
            toTBX()
        },
        getPrize({target}) {
            if(this.isDraw) return
            MtaH5.clickStat('gift_b8')
            sa.quick('trackHeatMap',target)
            this.idDraw = true
            let str = "0.5元现金红包"
            draw().then(res => {
                let {prizeName,typeId} = res
                this.title = '恭喜你获得万圣节奖励~'
                this.amo = prizeName.slice(0,prizeName.length-5)
                this.prizeType = typeId === 1? '现金红包': '投资红包'
                this.isGetPrize = true
            }).catch(err => {
                if(err.response){
                    let {code,message} = err.response.data
                    if(code === 'USER_IS_READED'){
                        this.$emit('isRead')
                    }else{
                        toast.show(message)
                    }
                }else{
                    toast.show('网络异常，请稍后重试')
                } 
            })
        }
    }
}
</script>

