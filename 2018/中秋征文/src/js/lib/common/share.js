import '../jsbridge3.1.6'
import '../appShare'
import {WeiXinShare} from './wxConfig'

let urlPrefix = __DEV__? `${location.origin}/` : `https://at.tuandai.com/huodong/midAutumnSolicitArticle/`

let shareUrl = urlPrefix + 'index.html'
let vtitle = '团贷网中秋节有奖征文'
let vcontent = '月圆中秋寄相思，记录你最难忘的中秋故事'
let icoUrl = urlPrefix + 'images/share-icon.jpg'

WeiXinShare(shareUrl, vtitle, vcontent, icoUrl, shareCallBack)

appShare.set({
    icon: icoUrl,
    title: vtitle,
    content: vcontent,
    shareUrl: shareUrl,
    cover: {
        src: require('../../../assets/images/wxShare.png'),
        style: {
            width: '100%',
        }
    },
    callback: function (res) {
        if (res === 'onComplete') {
            
        }
    }
})

export function ShareShow() {
    appShare.show()
}

function shareCallBack() {
    
}
