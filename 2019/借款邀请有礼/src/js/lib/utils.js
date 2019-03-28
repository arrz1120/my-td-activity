
import './sa' 
import './jsbridge-loan'

import './toast'
// import vConsole from 'vconsole'

// new vConsole()

const qs = require('./qs')

const ua = navigator.userAgent.toLowerCase()

const isWeixin = ua.match(/MicroMessenger/i) == 'micromessenger'

const isAndroid = /android|adr/gi.test(ua)

const isIos = /iphone|ipod|ipad/gi.test(ua) && !/android|adr/gi.test(ua)

export default {
  rem(px) {
    const rem = mobileUtils.rem
    const ratio = 16 / 750
    return px * ratio * rem
  },
  toLogin() {
    Jsbridge.exec('gotoLogin')
  },
  toCouponPage() {
    Jsbridge.exec('gotoCouponPage')
  },
  getQueryString(name) {
    const reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    const r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
  },
  messageAwake() {
    var awakeAppUrl = getAwakeAppUrl()
    setTimeout(() => {
      if (awakeAppUrl) {
        location.href = awakeAppUrl
      }
    }, 20)
  },
  clickToAwake() {
    var hasApp = true,
      t = 1000;
    setTimeout(function () {
      if (!hasApp) {
        if (isAndroid) {
          location.href = 'https://loan.tuandai.com/guide.html'
        } else if (isIos) {
          location.href = 'https://itunes.apple.com/cn/app/id1442784688'
        }
      }
    }, 2000);
    var t1 = Date.now();
    window.location.href = 'tuandailoan://com.tuandai.loan'
    setTimeout(function () {
      var t2 = Date.now();
      hasApp = !(!t1 || t2 - t1 < t + 150);
    }, t);
  },
  downloadApp() {
    if (isAndroid) {
      location.href = 'https://loan.tuandai.com/guide.html'
    } else if (isIos) {
      location.href = 'https://itunes.apple.com/cn/app/id1442784688'
    }
  },
  toShare(extenderKey) {
    const config = {
      "shareUrl": `https://loan.tuandai.com/loan/loan201903/landPage?extenderKey=${extenderKey}`,
      "shareTitle": "友情推荐！我最近在用的借款神器>>",
      "shareContent": "邀你一起用团贷网借款，最高5万可借1-24个月，年化利率低至6%，当天到帐",
      "shareIcon": "https://loan.tuandai.com/loan/loan201903/images/share-icon.jpg",
      "sharePlatformTypes": 71
    }
    Jsbridge.gotoShare(function (str) {
      console.log(str)
    }, config)
  },
  track(e) {
    tracker(e.target)
  }
}

//短信唤起app
/**落地页地址中需带上唤起app所需的参数
 *打开原生页面
 * http://10.100.98.250:3000/html/msgTest.html?tdappurl=tuandai://splashscreen&target=ToAppHomePage&action=jump
 *打开app内H5页面
 *http://10.100.98.250:3000/html/msgTest.html?tdappurl=tuandai://splashscreen&target=ToAppH5&action=jump&apph5url='活动链接地址'&apph5title='活动名字'
 */
//http://10.100.98.250:3002/html/msgTest.html?tdappurl=tuandai://splashscreen&target=ToAppH5&action=jump&apph5url=http://www.baidu.com&apph5title=h5打开测试

function getAwakeAppUrl() {
  var qsUrl = qs.parse(location.search),
    protocol = qsUrl.tdappurl,
    target = qsUrl.target,
    action = qsUrl.action,
    apph5url = qsUrl.apph5url,
    apph5title = qsUrl.apph5title;
  if (protocol && target && action) {
    if (apph5url) {
      apph5url = encodeURIComponent(apph5url)
      return protocol + '?target=' + target + '&action=' + action + '&apph5url=' + apph5url + '&apph5title=' + apph5title;
    } else {
      return protocol + '?target=' + target + '&action=' + action
    }
  }
  return ''
}

function tracker(target) {
  try {
    sa.quick('trackHeatMap', target)
  } catch (error) {}
}

// {
//   var nwbi_userName = '';
//   var nwbi_sysNo = 'TD_loan';
//   var bi_sensor_project = 'tdwloantest';
//   var bi_load_sensor_script = 1;
//   var nodeScript = document.createElement('script');
//   nodeScript.async = true;
//   nodeScript.src = ((("https:") == document.location.protocol) ? "https://" : "http://") + 'bilog.niiwoo.com/js/webaccess.js';
//   document.querySelector('body').appendChild(nodeScript);
// }