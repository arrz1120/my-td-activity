import './jsbridge-3.1.6'
import $ from 'jquery'
import './appShare'
import {WeiXinShare} from './wxConfig'
import {isApp} from './bridge'

let urlPrefix = __DEV__? `${location.origin}/` : `https://at.tuandai.com${window.webUrlPrefix}/thanksgivingAutumn/`

let shareUrl = urlPrefix + 'index'
let vtitle = '金秋感恩回馈，免费领紅包加息券'
let vcontent = '天天抽奖，必中紅包加息券，投资上榜最高可获得2888元！'
let icoUrl = `https://at.tuandai.com/userActivity/thanksgivingAutumnGb/images/shareLogo.png`

WeiXinShare(shareUrl, vtitle, vcontent, icoUrl, shareCallBack)

appShare.set({
    icon: icoUrl,
    title: vtitle,
    content: vcontent,
    shareUrl: shareUrl,
    cover: {
        src:`https://at.tuandai.com/userActivity/thanksgivingAutumnGb/images/wx-cover.png?20181019`,
        style: {
            width: '70%',
            left: '0.8rem',
            top: '1rem'
        }
    },
    callback: function (res) {
        if (res === 'onComplete') {
            
        }
    }
})


function unpateCount(res){
    $('.state-chance').html(res + '次') 
    if(res === 0){
        $('.finger').hide()
    }else{
        $('.finger').show()
    }
    $('#state_share').hide()
    $('#state_lottery').show()
  }

  //用户分享后更新抽奖次数接口
  function shareToCount(){
    if(window.isLogin){
      $.ajax({
          url: window.webUrlPrefix + '/thanksgivingAutumn/shareToCount',
          type: 'post',
          success:function(res){
            if(!window.isWeRank) return
            if(isApp){
              setTimeout(function(){
                unpateCount(res)
              },2000)
            }else{
              unpateCount(res)
            }
          },
          error:function(err){
              console.log(err)
          }
      })
    }
  }

function shareCallBack() {
    shareToCount()
}

$('.share-btn,.toShare').on('click',function(){
    $('.alert').hide()
    if(window.isLogin){
        if(isApp){
            shareToCount()
        }
        appShare.show()
    }else{
        $('#loginAlert').show()
    }
})