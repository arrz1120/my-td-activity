<template>
    <div class="no-login">
        <div class="mask-content mask-content2">
            <p class="p1">
                亲，请先登录后再参与活动哦~
            </p>
            <div class="no-login-btn" mtaName="login05" name="前往登录_弹窗" @click="goToLogin"></div>
        </div>
    </div>
</template>

<script>
export default {
    methods: {
        goToLogin(e) {
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.$emit('goToLogin')
        }
    }
}
</script>


<style lang="scss" scoped>
   
</style>

