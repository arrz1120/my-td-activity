<template>
    <div class="register-finish">
        <div class="pic-success"></div>
        <p class="r-p1">注册成功</p>
        <p class="r-p2">记得下载团贷网借款APP <br />领取您的红包哦~
</p>
        <div class="download-btn" @click="callApp" name="下载APP">下载APP</div>
    </div>
</template>

<script>
import 'assets/sass/finish.scss'
import util from 'js/utils'

export default {
    methods: {
        callApp(e){
            util.track(e)
            util.clickToAwake()
        }
    }
}
</script>

