<template>
  <div class="container">
      <div class="bg"></div>
      <div class="top">
        <div class="logo"></div>
        <div class="btn-rule" 
            name="活动规则1a"
            @click="_toggleRule">
            活动规则
        </div>
      </div>
      <Header :state="state" />
      <Box 
        :state="state"
        @showPrize="_showPrize"
        @showAlertTips="_showAlertTips"
        @showAlertAward="_showAlertAward">
        </Box>
      <Strategy
        @showAlertTips="_showAlertTips"
        @showAlertRecord="_showAlertRecord"
        :state="state"></Strategy>
      <p class="footer">【广告】市场有风险，投资需谨慎</p>
  </div>
</template>

<script>
    import Header from '../header/header'
    import Box from '../box/box'
    import Strategy from '../strategy/strategy'
    export default {
        props:['state'],
        data() {
            return {
                test: 123
            }
        },
        methods: {
            _toggleRule(e) {
                AddMaiDian('rule1a', e.target)
                this.$emit('toggleRule',true)
            },
            _showAlertTips(type) {
                this.$emit('showAlertTips',type)
            },
            _showAlertRecord(type) {
                this.$emit('showAlertRecord',type)
            },
            _showAlertAward(type){
                this.$emit('showAlertAward',type)
            },
            _showAlertTips(type){
                this.$emit('showAlertTips',type)
            },
            _showPrize(param) {
                this.$emit('showPrize',param)
            }
        },
        components: {
            Header,
            Box,
            Strategy
        }
    }
</script>

<style lang="scss" scoped>
    @import '../../assets/sass/_util.scss';

    .container{
        width: 100%;
        position: relative;
        padding-bottom: rem(121);
        background-image: -webkit-linear-gradient(top,#6e1687,#3c0b5e);
        // background-image: linear-gradient(top,#6e1687,#3c0b5e);
        background-position: left rem(1058);
        background-repeat: no-repeat;
        .bg{
            @include wh(750,2711);
            @include bg('../../assets/images/app/bg.png');
            position: absolute;
            bottom: 0;
            left: 0;
            z-index: 0;
        }
        .top{
            height: rem(148);
            padding: 0 0 rem(8) rem(29);
            display: flex;
            justify-content: space-between;
            align-items: center;
            // background-image: -webkit-linear-gradient(top, #2c0246, #2b0347);
            background: #2b0347;
            // background-image: linear-gradient(top, #2c0246, #2b0347);
        }
        .logo{
            @include wh(195,65);
            @include bg('../../assets/images/app/logo.png');
        }
        .btn-rule{
            @include wh(148,53);
            background: #8b256e;
            line-height: rem(53);
            color: #ff95c8;
            font-size: rem(24);
            text-align: center;
            border-radius: rem(22) 0 0 rem(22);
        }
        .footer{
            text-align: center;
            margin-top: rem(58);
            color: #8168be;
            font-size: rem(20);
        }
    }
</style>
