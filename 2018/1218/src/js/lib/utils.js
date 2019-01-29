module.exports={
  rem(px){
    const rem=mobileUtils.rem
    const ratio=16/750
    return px*ratio*rem
  },
  toLogin(){
    if(Jsbridge.isApp()){
      Jsbridge.toAppLogin()
    }else{
      window.location.href=`//passport.tuandai.com/2login?ret=${window.location.href}`
    }
  },
  toTBX(){
    if(Jsbridge.isApp()){
      Jsbridge.toAppTBX()
    }else{
      window.location.href='//m.tuandai.com/Member/UserPrize/Index.aspx'
    }
  },
  toTB(){
    window.location.href='//mvip.tuandai.com/member/mall/tuanbiDetail.aspx'
  },
  toP2P() {
    if(Jsbridge.isApp()){
      Jsbridge.exec('ToAppP2p')
    }else{
      window.location.href=`https://www.tuandai.com/app/install.aspx`
    }
  }
}