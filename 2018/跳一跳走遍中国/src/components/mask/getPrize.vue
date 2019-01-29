<template>
    <div class="mask-tips">
        <p class="tips-p1">亲，旅途已经圆满完成了~</p>
        <p class="tips-p2">恭喜你共答对<span>{{gameState.correctAnswerCount}}</span>道题~</p>
        <div class="mask-btn" @click="getPrize" mtaName="reward_a6" name="领取奖励">领取奖励</div>
    </div>
</template>

<script>
export default {
    props: ['gameState'],
    methods: {
        getPrize(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.$emit('getPrize')
        }
    }
}
</script>

