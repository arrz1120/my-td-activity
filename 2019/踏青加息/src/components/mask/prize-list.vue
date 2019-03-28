<template>
    <div class="mask-prize-list">
        <div class="prize-box">
            <div class="prize-tab">
                <div class="item" 
                    v-for="(item,index) in tab"
                    :key="index"
                    @click="onTabClick(index)"
                    :class="{active: tabIndex===index}">{{item}}</div>
            </div>
            <div v-if="tabIndex === 0">
                <div class="prize-list" v-if="prizeList.length" @touchmove.stop>
                    <ul>
                        <li v-for="(item,index) in prizeList"
                            :key="index"
                        >
                            <div class="item">{{item.prizeName}}</div>
                            <div class="item">{{item.prizeSource}}</div>
                            <div class="item">{{item.drawDate}}</div>
                        </li>
                    </ul>
                </div>
                <div class="no-data" v-else>
                    <img :src="require('../../assets/images/no-data.png')" alt="">
                    <p>暂时没有相关数据</p>
                </div>
            </div>
            <div v-else>
                <div class="score-list" v-if="scoreList.length" @touchmove.stop>
                    <div class="now-score">当前积分：<span>{{score}}</span></div>
                    <ul>
                        <li v-for="(item,index) in scoreList"
                            :key="index"
                        >
                            <div class="item">{{item.remark}}</div>
                            <div class="item">{{item.changeCount}}</div>
                            <div class="item">{{item.createTime}}</div>
                        </li>
                    </ul>
                </div>
                <div class="no-data" v-else>
                    <img :src="require('../../assets/images/no-data.png')" alt="">
                    <p>暂时没有相关数据</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import {getUserDrawRecordList,getUserIntegralRecordList} from '../../api/baseAPI'

const TAB = ['我的奖品','我的积分']

export default {
    created(){
        this.getListData()
    },
    data() {
        return {
            tab: TAB,
            tabIndex: 0,
            score: 0,
            prizeList: [],
            scoreList: []
        }
    },
    methods: {
        async getListData(){
            const prizeData = await getUserDrawRecordList()
            const scoreData = await getUserIntegralRecordList()
            this.prizeList = prizeData
            this.score = scoreData.totalTicket
            this.scoreList = scoreData.userTicketChangeLogList
        },
        onTabClick(index){
            this.tabIndex = index
        }
    }
}
</script>

