<style lang="scss">
    .lantern-con{
        width: rem(688);
        height: rem(615);
        background: #fff url('../../assets/images/alert/bg-frame1.png') center no-repeat;
        background-size: rem(639) rem(509);
        padding-top: rem(44);
        .tit{
            font-size: rem(40);
            color: #a77d41;
            font-weight: bold;
            text-align: center;
        }
        .input-box{
            padding-top: rem(54);
            padding-left: rem(54);
        }
        .input-flex{
            display: flex;
            padding-bottom: rem(48);
            align-items: center;
            position: relative;
            span{
                color: #a77d41;
                font-size: rem(30);
                margin-right: rem(16);
            }
            input{
                display: block;
                border: 1px solid #c4a579;
                color: #a77d41;
                border-radius: 4px;
                @include wh(502,82);
                padding: 0 rem(10);
            }
            .tips{
                color: #ff3c00;
                position: absolute;
                top: rem(82);
                left: rem(77);
                line-height: rem(48);
            }
        }
        .txt{
            color: #a77d41;
            text-align: center;
            font-size: rem(20);
        }
        .lantern-btn{
            width: rem(575);
            margin-top: rem(29);
        }
    }
</style>


<template>
    <div class="alert" @touchmove.prevent v-if="show">
        <div class="alert-bg" @click="hideAlert"></div>
        <div class="alert-con lantern-con">
            <div class="tit">有奖灯谜征集</div>
            <div class="input-box">
                <div class="input-flex">
                    <span>谜语</span>
                    <input 
                        type="text" 
                        @compositionend="inputEnd($event,{maxLength:50, tipsIndex:1})"
                        @input="onInput($event,{maxLength:50, tipsIndex:1})"
                        placeholder="请输入50字以内的谜语~"
                        ref="question"/>
                    <p class="tips" v-show="tips1.show">{{tips1.val}}</p>
                </div>
                <div class="input-flex">
                    <span>谜底</span>
                    <input 
                        type="text" 
                        @compositionend="inputEnd($event,{maxLength:30, tipsIndex:2})"
                        @input="onInput($event,{maxLength:30, tipsIndex:2})"
                        ref="answer" 
                        placeholder="请输入30字以内的谜底~"/>
                    <p class="tips" v-show="tips2.show">{{tips2.val}}</p>
                </div>
            </div>
            <p class="txt">您写下的灯谜将有机会用于下一个活动，请务必认真填写喔~</p>
            <div class="alert-btn lantern-btn" @click="commit" name="藏好灯谜">藏好灯谜</div>
            <div class="alert-close" @click="hideAlert"></div>
        </div>
    </div>
</template>

<script>
import {lanternRiddle} from '../../api/api.js'
export default {
    props:['show'],
    data() {
        return {
            tips1: {
                show: false,
                val: ''
            },
            tips2: {
                show: false,
                val: ''
            }
        }
    },
    mounted() {

    },
    methods: {
        showTips(idx,opt) {
            if(idx === 1) {
                this.tips1 = opt
            } else {
                this.tips2 = opt
            }
            this.timer = setTimeout(() => {
                clearTimeout(this.timer)
                this.tips1.show = false
                this.tips2.show = false
            },2000)
        },
        inputEnd(e,param) {
            let len = e.target.value.length;
            let {maxLength,tipsIndex} = param
            console.log(len)
            if(len > maxLength) {
                len = maxLength
                e.target.value = e.target.value.substring(0,maxLength)
                this.showTips(tipsIndex,{
                    show: true,
                    val: e.target.getAttribute('placeholder')
                })
            }
        },
        onInput(e,param) {
            let len = e.target.value.length;
            let {maxLength,tipsIndex} = param
            if(len > maxLength) {
                len = maxLength
                e.target.value = e.target.value.substring(0,maxLength)
                this.showTips(tipsIndex, {
                    show: true,
                    val: e.target.getAttribute('placeholder')
                })
            }
        },
        hideAlert() {
            this.$emit('hideAlert')
        },
        commit(e) {
            AddMaiDian('hide1c', e.target)
            let {question,answer} = this.$refs
            if(question.value === ''){
                this.showTips(1,{
                    show: true,
                    val: '谜语不能为空'
                })
                return
            }
            if(answer.value === ''){
                this.showTips(2,{
                    show: true,
                    val: '谜底不能为空'
                })
                return
            }
            if(question.value.length > 50){
                this.showTips(1,{
                    show: true,
                    val: '请填写50字以内的谜语~'
                })
                return
            }
            if(answer.value.length > 30 === ''){
                this.showTips(2,{
                    show: true,
                    val: '请填写30字以内的谜底~'
                })
                return
            }
            lanternRiddle(question.value, answer.value).then(res => {
                let {submitCount,prizeName,type} = res
                if(submitCount > 1){
                    this.$emit('showHasPrize')
                } else {
                    this.$emit('showAward',{
                        type: type,
                        prizeName: prizeName
                    })
                }
                this.hideAlert()
            })
        },
    }
}
</script>

