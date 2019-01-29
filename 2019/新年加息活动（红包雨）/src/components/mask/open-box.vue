<template>
    <div class="mask">
        <div class="mask-bg"></div>
        <div class="open-box">
            <p class="box-p1">恭喜您击中了<span>{{redCount}}</span>个红包</p>
            <p class="box-p2">可从以下四个宝箱中选择打开<span>{{boxCount}}</span>个宝箱</p>
            <div class="box-flex">
                <div class="item" 
                    v-for="(item,index) in box" 
                    :key="index"
                >
                    <div 
                        class="box-img"
                        :class="{
                            'box-img-jxq': boxOpenFlag[index] && item.typeId === 2,
                            'box-img-hb': boxOpenFlag[index] && item.typeId === 1
                        }"
                    >
                        <p v-if="item.prizeValue && boxOpenFlag[index]" 
                           :class="item.typeId === 1?'box-hb-p':'box-jxq-p'"
                        >
                            {{item.typeId === 1? '￥'+item.prizeValue: '+'+item.p2.replace('加息券','')}}
                        </p>
                    </div>
                    <p class="box-flex-p1" :class="{'yellow': boxOpenFlag[index]}">{{item.p1}}</p>
                    <p class="box-flex-p2">{{item.p2}}</p>
                    <div class="btn-open" 
                        :class="{'btn-opened':boxOpenFlag[index]}"  
                        :mtaName="'prizepool1'+(index+1)"
                        :name="'打开奖池'+(index+1)"
                        @click="onBoxClick(index,$event)"
                    ></div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>

import * as api from '../../api/api'
import {hex_md5} from '../../js/lib/md5'

let box = [{
      p1: "0.5%~2.5%加息券",
      p2: "适用于We自动服务",
      typeId: 2,
      prizeValue: '',
      boxName: 'A'

},{
      p1: "0.5%~2.5%加息券",
      p2: "适用于We+自动服务",
      typeId: 2,
      prizeValue: '',
      boxName: 'B'
},{
      p1: "10元~280元出借红包",
      p2: "1:200使用，期限≥6个月",
      typeId: 1,
      prizeValue: '',
      boxName: 'C'
},{
      p1: "60元~480元出借红包",
      p2: "1:300使用，期限≥3个月",
      typeId: 1,
      prizeValue: '',
      boxName: 'D'
}]

export default {
    props: ['userId','redCount','boxCount'],
    created(){
        this.getUserCurDraw()
        this.boxClickFlag = [false,false,false,false]
    },
    data(){
        return {
            box: box,
            boxOpenFlag: [false,false,false,false]
        }
    },
    methods: {
        async getUserCurDraw(){
            const res = await api.userCurDraw()
            const {redCount,boxCount,openBoxPrizes} = res
            this.$emit('updateCountData',redCount,boxCount)
            if(openBoxPrizes.length){
                this.mergeBoxData(openBoxPrizes)
            }
        },
        mergeBoxData(data){
            for(let i=0;i<this.box.length;i++){
                for(let j=0;j<data.length;j++){
                    if(this.box[i].boxName === data[j].boxName){
                        this.boxOpenFlag[i] = true
                        this.box[i].p1 = '恭喜打开宝箱获得'
                        this.box[i].p2 = data[j].prizeName
                        this.box[i].prizeValue = data[j].prizeValue
                    }
                }
            }
        },
        onBoxClick(index,e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            if(this.boxOpenFlag[index]){
                return
            }
            if(this.boxClickFlag[index]){
                return
            }
            this.boxClickFlag[index] = true
            this.lottery(this.box[index].boxName)
        },
        async lottery(boxName){
            try {
                const res = await api.draw({
                    key: hex_md5(this.userId + '@' + boxName),
                    boxName: boxName
                })
                const {shared,completed,drawPrizeList} = res
                this.mergeBoxData(drawPrizeList)
                if(res.completed){
                    setTimeout(() => {
                        this.$emit('lotteryCompleted',shared,drawPrizeList)
                    },500)
                }
            } catch (err) {
                if(err.response){
                    toast.show(err.response.data.message,2000,() => {
                        location.href = location.href
                    })
                }
            }
            
        }
    }
}
</script>

