<template>
    <div class="long-page">
        <banner></banner>
        <page-content></page-content>
        <page-footer></page-footer>
        <page-mask v-show="mask.show" @maskClose="closeMask">
            <no-login v-if="mask.noLogin"></no-login>
            <activity-end v-if="mask.activityEnd"></activity-end>
            <activity-not-start v-if="mask.activityNotStart"></activity-not-start>
        </page-mask>
    </div>
</template>

<script>
import Banner from './banner'
import PageContent from './content'
import PageFooter from './footer'
import PageMask from './mask'
import NoLogin from 'components/mask/no-login'
import ActivityEnd from 'components/mask/activity-end'
import ActivityNotStart from 'components/mask/activity-not-start'

export default {
    data(){
        return {
            mask: {
                show: false,
                noLogin: false,
                activityEnd: false,
                activityNotStart: false
            }
        }
    },
    methods: {
        showMask(name){
            this.hideMask()
            this.mask.show = true
            this.mask[name] = true
        },
        hideMask(){
            for(let key in this.mask) {
                if(this.mask[key]){
                    this.mask[key] = false
                }
            }
        },
        closeMask(){
            this.hideMask()
        },
    },
    components: {
        Banner,
        PageContent,
        PageFooter,
        PageMask,
        NoLogin,
        ActivityEnd,
        ActivityNotStart
    }
}
</script>

