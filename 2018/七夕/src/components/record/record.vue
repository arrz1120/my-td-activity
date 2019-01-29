<template>
  <div class="record" @click="_showAlertRecord" name="喜鹊2a">
    <div 
        class="number" 
        v-show="state.logined && state.activityTimeStauts===1 && state.unReadCount>0">
       {{state.unReadCount}}
    </div>
  </div>
</template>

<script>

import {Login} from '../../js/bridge.js'
import {getDetailItem} from '../../api/api.js'

export default {
    props: ['state'],
    data() {
        return {
            recordListData: []
        }
    },
    created() {
        
    },
    methods: {
        beforeToDo() {
            let {activityTimeStauts, logined} = this.state
            if (!logined) {
                this.$emit('showAlertTips',{
                type: 'con-2'
                })
                return false
            }
            if (activityTimeStauts === 0 || activityTimeStauts === 2) {
                this.$emit('showAlertTips',{
                type: 'con-1'
                })
                return false
            }
            return true
        },
        _showAlertRecord(e){
            AddMaiDian('magpie2a', e.target)
            if(!this.beforeToDo()){
                return
            }
            getDetailItem().then(res => {
                if (res.data.status === 1) {
                    this.recordListData = res.data.xiQueDrawInfoList
                }
                this.$emit('showAlertRecord',{
                    type: 'con-record',
                    recordList: this.recordListData
                })
            })
            
        }
    }
}
</script>

<style lang="scss" scoped>
  @import '../../assets/sass/_util.scss';

  .record{
    @include wh(95,95);
    @include bg("../../assets/images/app/record.png");
    position: absolute;
    top: rem(422);
    right: rem(34);
    z-index: 8;
    border-radius: 50%;
    .number{
        @include wh(29,29);
        background: #ff4d7f;
        text-align: center;
        line-height: rem(29);
        color: #342055;
        font-size: rem(22);
        position: absolute;
        top: 0;
        left: rem(67);
        border-radius: 50%;
    }
  }
</style>
