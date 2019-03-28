<template>
    <transition name="fade">
        <div class="nav">
            <div class="nav-mask" @click="hideNav"></div>
            <transition name="nav">
                <div class="nav-content" v-show="show">
                    <ul>
                        <li v-for="(item,index) in navData" :key="index" :class="{'active': index == activeNav}" @click="onNavSelect(index)">
                            {{item}}
                        </li>
                    </ul>
                    <div class="nav-close" @click="hideNav"></div>
                </div>
            </transition>
        </div>
    </transition>
</template>

<script>
import '../assets/sass/nav.scss'

const navData = ['运营数据概览','出借人数据','运营大事记','团贷大事记','团粉互动']

export default {
    props: ['activeNav','show'],
    created() {
        this.navData = navData
    },
    methods: {
        hideNav(){
            this.$emit('hideNav')
        },
        onNavSelect(index){
            this.$emit('onNavSelect',index)
        }
    }
}
</script>

