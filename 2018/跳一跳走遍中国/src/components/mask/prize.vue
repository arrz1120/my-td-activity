<template>
    <div class="mask-prize">
        <p class="prize-p1">恭喜你</p>
        <p class="prize-p2">获得{{prizeName}}~</p>
        <div class="prize-img">
            <div v-if="prizeType===3" class="tb">{{tbCount}}</div>
            <div v-if="prizeType===1" class="hb"></div>
        </div>
        <div class="mask-btn" @click="watchPrize">立即查看</div>
    </div>
</template>

<script>
import {toTBX,toTB} from '../../js/lib/util'

export default {
    props: ['prizeType','prizeName'],
    computed: {
        tbCount(){
            if(this.prizeType === 3){
                return this.prizeName.replace('团币','')
            }
        }
    },
    methods: {
        watchPrize(){
            if (window.sessionStorage) {
                sessionStorage.setItem("need-refresh", true);
            }
            if(this.prizeType === 3){
                toTB()
            }else{
                toTBX()
            }
        }
    }
}
</script>

