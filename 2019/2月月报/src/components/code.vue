<template>
    <transition name="code">
        <div class="code-component">
            <div class="code-mask" @click="hideCode"></div>
            <div class="code-content">
                <img :src="require(`../assets/images/code${index+1}.png`)" alt="">
                <p class="p1">{{codeData[index]}}</p>
                <p class="p2">{{index==2?'在新浪微博搜索“团贷网”添加关注':'长按并复制微信号查找添加'}}<br />或截屏后在微信端打开识别二维码</p>
                <div class="code-close" @click="hideCode"></div>
            </div>
        </div>
    </transition>
</template>

<script>

export default {
    props: ['index'],
    created() {
        this.codeData = ['团贷网订阅号（dgtuandaiwang）','团贷网微服务（dgtuandaiservice）','新浪微博@团贷网']
    },
    methods: {
        hideCode(){
            this.$emit('hideCode')
        }
    }
}
</script>

