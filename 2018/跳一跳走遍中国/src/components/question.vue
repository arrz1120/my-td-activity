<template>
    <div class="question">
        <div class="question-con">
            <div class="question-tit">第{{city[jumpIndex].questionNumber}}题</div>
            <p class="question-p1">{{city[jumpIndex].question}}</p>
            <div class="answer" :class="{mt0: jumpIndex === 1}">
                <div class="item" 
                    v-for="(item,index) in city[jumpIndex].answer"
                    :key="index">
                    {{index === 0?'A.':'B.'}}
                    {{item}}
                    <div v-if="item === ''" :class="'imgAnswer'+(index+1)"></div>
                    <div v-if="answerData[index].answer !== false" 
                        :class="{
                            'icon-wrong': answerData[index].answer !== false && answerData[index].answer !== correctFlag,
                            'icon-correct': answerData[index].answer !== false && answerData[index].answer === correctFlag
                        }">
                    </div>
                </div>
            </div>
        </div>
        <div class="question-select">
            <div v-for="(item,index) in answerData" 
                class="question-btn" 
                :key="index"
                :class="{
                    'btn-red': item.answer!==false && item.answer !== correctFlag,
                    'btn-yellow': item.answer!==false && item.answer === correctFlag
                }"
                @click="selectAnswer(index)">
                {{item.text}}
            </div>
        </div>
    </div>
</template>

<script>
import '../assets/sass/question.scss'
import config from '../js/lib/config'

export default {
    props: ['jumpIndex','showSelectResult'],
    data(){
        return {
            city: config,
            isSelected: false,
            correctFlag: false,
            answerData: [
                {text:'当然选A',answer:false},
                {text:'B才是真的',answer:false}
            ]
        }
    },
    methods: {
        selectAnswer(number){
            if(this.isSelected) return
            this.isSelected = true
            this.correctFlag = this.city[this.jumpIndex].correct
            this.answerData[number].answer = number
            let result 
            if(this.correctFlag === number){
                result = 1
            }else{
                result = 0
            }
            this.$emit('selectAnswer',result)
        }
    }
}
</script>

