<template>
    <div class="mask-tips">
        <p class="tips-p1">亲，旅途已经圆满完成了~</p>
        <p class="tips-p2">很遗憾，{{isAtHome?'您之前':''}}只答对了<span>{{gameState.correctAnswerCount}}</span>道题~</p>
        <div class="mask-btn" @click="toShare" :mtaName="mtaName" :name="name">分享再玩一次</div>
        <!-- <p class="tips-p3">亲，点此按钮才可以再玩一次喔~</p> -->
    </div>
</template>

<script>
import Share from '../../js/lib/initShare'

export default {
    props: ['gameState','name','mtaName','isAtHome'],
    methods: {
        toShare(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.$emit('hideMask')
            Share.show()
        }
    }
}
</script>

