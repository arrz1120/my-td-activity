<template>
    <div class="index">
        <div class="banner">
            <div class="rule-btn" @click="showRule" name="活动规则a">活动
                <br>规则
            </div>
            <div class="banner-tit"></div>
            <div class="banner-sub">活动时间：3月14日-4月15日</div>
        </div>
        <div class="index-award"></div>
        <div class="sec">
            <h2 class="sec-tit">返现计算方式</h2>
            <div class="sec1"></div>
        </div>
        <div class="sec">
            <h2 class="sec-tit">我的邀友战绩</h2>
            <div class="sec2">
                <div class="item">
                    <div class="item-left">
                        <p class="item-p1">{{totalAmount}}</p>
                        <p class="item-p2">累计获得奖励（元）</p>
                    </div>
                    <div v-if="logined" class="item-right" @click="showMyAward" name="我的奖励">我的奖励</div>
                    <div v-else class="item-right" @click="goToLogin" name="登录查看">登录查看</div>
                </div>
                <div class="item">
                    <div class="item-left">
                        <p class="item-p1">{{totalInviteCnt}}</p>
                        <p class="item-p2">累计邀请好友（人）</p>
                    </div>
                    <div
                        v-if="logined"
                        class="item-right"
                        @click="showMyInvitation"
                        name="我的邀请"
                    >我的邀请</div>
                    <div v-else class="item-right" @click="goToLogin" name="登录查看">登录查看</div>
                </div>
            </div>
        </div>
        <footer v-show="isInit">
            <div v-if="logined" class="index-btn" @click="goToShare" name="立即邀请a">立即邀请</div>
            <div v-else class="index-btn" @click="goToLogin">马上登录</div>
        </footer>

        <rule v-if="showRuleFlag" @hideRule="hideRule"></rule>
    </div>
</template>

<script>
import util from 'js/utils'
import Share from 'js/initShare.js'
import Rule from 'components/rule.vue'
import * as api from 'api/baseAPI'

export default {
    created() {
        this.getIndexData()
    },
    data() {
        return {
            showRuleFlag: false,
            logined: false,
            totalAmount: '---',
            totalInviteCnt: '---',
            extenderKey: '',
            isInit: false
        }
    },
    methods: {
        getIndexData() {
            api.getIndexData().then(res => {
                this.isInit = true
                if (res && res.extenderKey) {
                    this.extenderKey = res.extenderKey
                    this.logined = true
                    this.totalAmount = res.totalAmount
                    this.totalInviteCnt = res.totalInviteCnt
                    this.$emit('getExtenderKey', res.extenderKey)
                    Share.set(res.extenderKey)
                    sa.login(res.userId) 
                }
            }).catch(err => {
                this.isInit = true
            })
        },
        showMyAward(e) {
            util.track(e)
            this.$emit('showMyAward')
        },
        showMyInvitation(e) {
            util.track(e)
            this.$emit('showMyInvitation')
        },
        showRule(e) {
            util.track(e)
            this.showRuleFlag = true
        },
        hideRule() {
            this.showRuleFlag = false
        },
        goToLogin(e) {
            util.track(e)
            util.toLogin()
        },
        goToShare(e) {
            const tips = '抱歉，本活动仅对部分用户开放'
            util.track(e)
            api.checkwhitelist().then(res => {
                if (res.flag) {
                    util.toShare(this.extenderKey)
                } else {
                    toast.show(tips)
                }
            }).catch(err => {
                toast.show(tips)
            })
        }
    },
    components: {
        Rule
    }
}
</script>
