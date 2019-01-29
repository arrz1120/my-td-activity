<template>
    <div class="prize-list">
        <scroll v-if="listData.length" class="prize-list-scroll">
            <div class="list-container">
                <ul v-if="listData.length">
                    <li v-for="(item,index) in listData" :class="{'active':item.jiaxi}" :key="index">
                        <div class="item">{{item.prizeName}}</div>
                        <div class="item">{{item.drawTime}}</div>
                    </li>
                </ul>
                <div v-else class="no-data"></div>
            </div>
        </scroll>
        <div v-else class="no-data">
            <p>暂时没有相关数据</p>
        </div>
    </div>
</template>

<script>
import Scroll from '../scroll'
import {record} from '../../api/api'

export default {
    created(){
        this.getPrizeListData()
    },
    data() {
        return {
            listData: []
        }
    },
    methods: {
        getPrizeListData(){
            record().then(res => {
                this.listData = res
            })
        }
    },
    components: {
        Scroll
    }
}
</script>

