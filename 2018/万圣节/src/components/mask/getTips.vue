<style lang="scss" scoped>
    
</style>

<template>
    <div class="tb-con">
        <div class="tb-txt">
            <p class="tb-p1">确定消耗88团币查看提示？</p>
            <p class="tb-p2">我的团币：{{tb}}</p>
        </div>
        <div class="mask-btn" @click="toExchange" name="团币消耗_查看提示">确定</div>
        <div class="mask-close" @click="passFail"></div>
    </div>
</template>

<script>
import {exchange} from '../../api/api.js'

export default {
    props: ['tb','nowPass'],
    methods: {
        toExchange({target}){
            MtaH5.clickStat('cointips_b7')
            sa.quick('trackHeatMap',target)
            exchange(this.nowPass).then(res => {
                if(res >= 0) {
                    this.$emit('exchangeSuccess')   
                }else{
                    this.toastErr()
                }
            }).catch(err => {
                if(err.response){
                    let {code,message} = err.response.data
                    if(code === 'TB_NOT_ENOUGH') {
                        this.$emit('tbNotEnough')    
                    }
                    else if(code === 'TB_EXCHANGE_OVER'){
                        this.$emit('isRead')
                    }
                    else if(code === 'USER_IS_READED'){
                        this.$emit('isRead')
                    }
                    else{
                        toast.show(message)
                    }
                }else{
                    toast.show('网络异常，请稍后重试')
                }   
            })
        },
        passFail() {
            this.$emit('passFail')
        }
    }
}
</script>

