module.exports={
    rem(px){
        const rem=mobileUtils.rem
        const ratio=16/750
        return px*ratio*rem
    },
    toLogin(){
        if(Jsbridge.isApp()){
            Jsbridge.toAppLogin()
            return
        }
        window.location.href=`//passport.tuandai.com/2login?ret=${window.router.index}`
    },
    toTBX(){
        if(Jsbridge.isApp()){
            Jsbridge.exec('ToAppTreasureChest')
        }else{
            window.location.href='//m.tuandai.com/Member/UserPrize/Index.aspx'
        }
    }
}