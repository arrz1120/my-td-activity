<template>
    <div>
        <div class="bottom-fixed">
            <div class="item bottom-btn1" 
                mtaName="invest1c"
                name="立即出借"
                @click="onBtnLeftClick"
            ></div>
            <div class="item" 
                @click="onBtnRightClick"
                mtaName="redenveloperain02"
                name="红包滚滚来"
            ></div>
        </div>
    </div>
</template>

<script>

import {pageHost} from '../api/config'

const urlPrefix = `${pageHost}/huodong/newYearsRaiseInterest2019/`

export default {
    methods: {
        onBtnLeftClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.$emit('toInvest')
        },
        onBtnRightClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            location.href = `${urlPrefix}redPacketRain.html`
        }
    }
}
</script>

