<template>
    <div class="mask">
        <div class="mask-bg"></div>
        <div class="award-close" @click="hideAward"></div>
        <div class="award-box">
            <p class="box-p1">恭喜您成功获得</p>
            <div class="box-flex">
                <div class="item" 
                    v-for="(item,index) in awardData" 
                    :key="index"
                >
                    <p class="award-p">{{item.prizeName}}</p>
                    <div 
                        class="award-img"
                        :class="{
                            'award-jxq': item.typeId === 2,
                            'award-hb': item.typeId === 1
                        }"
                    >
                        <p v-if="item.prizeValue" :class="item.typeId === 1?'box-hb-p':'box-jxq-p'">
                            {{item.typeId === 1? '￥'+item.prizeValue: '+'+item.prizeName.replace('加息券','')}}
                        </p>
                    </div>
                </div>
            </div>
            <div class="award-watchPrize" @click="awardWatchPrize" mtaName="checkprize2e" name="查看奖品"></div>
            <div class="award-share" v-if="!shared" @click="awardShare" mtaName="share2k" name="分享再玩一次"></div>
        </div>
    </div>
</template>

<script>
export default {
    props: ['awardData','shared'],
    methods: {
        awardWatchPrize(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.$emit('awardWatchPrize')
        },
        awardShare(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.$emit('awardShare')
        },
        hideAward(){
            this.$emit('hideAward')
        }
    }
}
</script>

