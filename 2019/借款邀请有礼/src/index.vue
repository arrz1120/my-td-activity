<template>
  <section>
    <index v-if="state === 'index'" @showMyAward="showMyAward" @showMyInvitation="showMyInvitation" @getExtenderKey="setExtenderKey" />
    <!-- <my-award :extenderKey="extenderKey" v-if="state === 'myAward'"/> -->
    <!-- <my-invitation :extenderKey="extenderKey" v-if="state === 'myInvitation'" /> -->
  </section>
</template>

<script>
  import 'assets/sass/index.scss'
  import Index from 'components/index.vue'

  export default {
    data() {
      return {
        state: 'index',
        extenderKey: ''
      }
    },
    methods: {
      showMyAward(){
        location.href = 'https://loan.tuandai.com/loan/loan201903/prizePage?extenderKey=' + this.extenderKey
      },
      showMyInvitation(){
        location.href = 'https://loan.tuandai.com/loan/loan201903/invitePage?extenderKey=' + this.extenderKey
      },
      setExtenderKey(key){
        this.extenderKey = key
      }
    },
    components: {
      Index
    }
  }
</script>
