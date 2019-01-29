<template>
    <div class="mask-chance no-chance">
        <p class="p1">您当前已没有游戏机会了!</p>
        <p class="p2">分享活动可以再获得一次游戏机会哦~</p>
        <div class="no-chance-share" mtaName="share2e" name="马上分享_弹窗" @click="noChanceShare"></div>
    </div>
</template>



<script>
export default {
    methods: {
        noChanceShare(e) {
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.$emit('noChanceShare')
        }
    }
}
</script>

