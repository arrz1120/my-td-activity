<template>
    <div class="ad">
        <div class="banner">
            <div class="rule-btn" @click="showRule" name="活动规则b">活动
                <br>规则
            </div>
            <div class="banner-tit"></div>
            <div class="banner-sub">活动时间：3月14日-4月15日</div>
        </div>
        <div class="index-award"></div>
        <div class="ad-btn" @click="callApp" name="前往APP邀请">前往APP邀请</div>
        <footer>
            <p>2010-2019 版权所有 © 团贷网</p>
            <p>粤ICP备12043601号-1 粤公安网备44190002000538号</p>
            <p>东莞团贷网互联网科技服务有限公司</p>
        </footer>

        <rule v-if="showRuleFlag" @hideRule="hideRule"></rule>
    </div>
</template>

<script>
import Rule from 'components/rule.vue'
import util from 'js/utils'
import Share from 'js/initShare.js'

Share.set()

export default {
    data() {
        return {
            showRuleFlag: false
        }
    },
    methods: {
        showRule(e) {
            util.track(e)
            this.showRuleFlag = true
        },
        hideRule() {
            this.showRuleFlag = false
        },
        callApp(e) {
            util.track(e)
            util.clickToAwake()
        }
    },
    components: {
        Rule
    }
}
</script>
