<template>
    <div class="layout">
        <swiper-container
            class="swiper-container page-swiper"
            :config="pageSwiperConfig"
            ref="pageSwiper"
            :style="{
                height:winHeight
            }"
        >
            <div class="swiper-slide slide-bg">
                <div class="home">
                    <div class="logo"></div>
                    <p class="top-txt">【广告】市场有风险 出借需谨慎</p>
                    <div class="banner zoomIn"></div>
                    <div class="home-dropdown dropdown-move"></div>
                </div>
            </div>
            <div class="swiper-slide slide-bg">
                <swiper-container
                    class="content-swiper"
                    :config="contentSwiperConfig"
                    @onSlideChangeEnd="contentSlideEnd"
                    ref="contentSwiper"
                >
                    <div
                        class="swiper-slide"
                        v-for="(item,index) in slide"
                        :key="index"
                        :nav="item.nav"
                    >
                        <div class="img-box">
                            <div class="nav-btn" @click="onNavBtnClick(item.nav)"></div>
                            <swiper-container
                                class="innerSwiper"
                                v-if="item.slide"
                                :config="innerSwiperConfig"
                                ref="innerSwiper"
                                @onSlideChangeEnd="innerSlideEnd"
                            >
                                <div
                                    class="swiper-slide"
                                    v-for="(itemSlide,itemSlideIndex) in item.slide"
                                    :key="itemSlideIndex"
                                >
                                    <div class="tab" v-if="item.tab">
                                        <div
                                            class="item"
                                            v-for="(tab,tabIndex) in item.tab"
                                            :key="tabIndex"
                                            :class="{'tab-active': tabIndex === tabSwiperIndex}"
                                            @click="swiperTab(tabIndex)"
                                        >{{tab}}</div>
                                    </div>
                                    <img :src="require(`../assets/images/${itemSlide}.png`)" alt>
                                </div>
                            </swiper-container>
                            <img
                                v-else
                                :data-src="require(`../assets/images/${item.src}.png`)"
                                class="swiper-lazy"
                                alt
                            >
                            <div class="share-btn" @click="toShare"></div>
                            <div class="content-dropdown dropdown-move"></div>
                        </div>
                    </div>
                    <div class="swiper-slide end-slide">
                        <div class="img-box">
                            <div class="end-logo"></div>
                            <p class="end-p1">如果您还想了解团贷网更多的动态信息，
                                <br>请关注我们的微信订阅号、服务号或新浪微博。
                            </p>
                            <div class="code-box">
                                <div
                                    class="item"
                                    v-for="(item,index) in codeData"
                                    :key="index"
                                    @click="onCodeClick(index)"
                                >
                                    <img :src="require(`../assets/images/code${index+1}.png`)" alt>
                                    <p>
                                        {{item.p1}}
                                        <br>
                                        {{item.p2}}
                                    </p>
                                </div>
                            </div>
                            <div class="btn-back" @click="backToIndex">
                                <div class="btn"></div>
                                <p>返回首页</p>
                            </div>
                            <div class="share-btn" @click="toShare"></div>
                        </div>
                    </div>
                </swiper-container>
            </div>
        </swiper-container>
        <page-nav
            :activeNav="navIndex"
            v-show="showNav"
            :show="showNav"
            @hideNav="hideNav"
            @onNavSelect="onNavSelect"
        ></page-nav>
        <code-component v-show="showCode" :index="showCodeIndex" @hideCode="hideCode"></code-component>
    </div>
</template>

<script>
import Swiper from 'swiper'
import Config from '../js/lib/config'
import SwiperContainer from './swiper-container'
import PageNav from './nav'
import CodeComponent from './code'
import Share from '../js/lib/initShare'

const VERTICAL = 'vertical'

const codeData = [{
    p1: '团贷网订阅号',
    p2: 'dgtuandaiwang'
}, {
    p1: '团贷网微服务',
    p2: 'dgtuandaiservice'
}, {
    p1: '新浪微博',
    p2: '@团贷网'
}]

export default {
    created() {
        Share.set()
        this.pageSwiperConfig = {
            direction: VERTICAL,
            resistanceRatio: 0,
        }
        this.contentSwiperConfig = {
            direction: VERTICAL,
            nested: true,
            lazyLoading: true
        }
        this.innerSwiperConfig = {}
        this.codeData = codeData
        this.winHeight = window.innerHeight + 'px'
    },
    mounted() {
        // this.$refs.pageSwiper.style.height = window.innerHeight + 'px'
    },
    data() {
        return {
            slide: Config,
            navIndex: 0,
            activeContentIndex: 0,
            showNav: false,
            tabSwiperIndex: 0,
            showCode: false,
            showCodeIndex: 0
        }
    },
    methods: {
        contentSlideEnd(index) {
            this.activeContentIndex
        },
        innerSlideEnd(index) {
            this.tabSwiperIndex = index
        },
        onNavBtnClick(index) {
            this.navIndex = index - 1
            this.showNav = true
        },
        hideNav() {
            this.showNav = false
        },
        swiperTab(index) {
            if (index == this.tabSwiperIndex) return
            this.tabSwiperIndex = index
            this.$refs.innerSwiper[0].slideTo(index, 300)
        },
        onNavSelect(index) {
            this.navIndex = index
            this.showNav = false
            let i = -1
            Config.forEach((item, idx) => {
                if ((item.nav - 1) === index && i === -1) {
                    i = idx
                }
            })
            this.activeContentIndex = i
            this.$refs.contentSwiper.slideTo(i)
        },
        toShare() {
            Share.show()
        },
        backToIndex() {
            this.$refs.pageSwiper.slideTo(0, 300)
            this.$refs.contentSwiper.slideTo(0)
        },
        onCodeClick(index) {
            this.showCode = true
            this.showCodeIndex = index
        },
        hideCode() {
            this.showCode = false
        }
    },
    components: {
        SwiperContainer,
        PageNav,
        CodeComponent
    }
}
</script>
