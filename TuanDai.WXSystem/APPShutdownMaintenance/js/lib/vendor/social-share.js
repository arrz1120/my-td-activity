!function(a,b,c){function d(a,b){var c=o({},B,b||{},p(a));k(a,"share-component social-share"),a.initialized=!0,e(a,c),f(a,c)}function e(a,b){var c=g(b),d="prepend"==b.mode;b.initialized=!0,r(d?c.reverse():c,function(c){var e=h(c,b),f=b.initialized?m(a,"icon-"+c):n('<a class="social-share-icon icon-'+c+'" target="_blank"></a>');return f.length?(f[0].href=e,void(b.initialized||(d?a.insertBefore(f[0],a.firstChild):a.appendChild(f[0])))):!0})}function f(a,b){var c=m(a,"icon-wechat","a");if(0===c.length)return!1;var d=n('<div class="wechat-qrcode"><h4>'+b.wechatQrcodeTitle+'</h4><div class="qrcode"></div><div class="help">'+b.wechatQrcodeHelper+"</div></div>"),e=m(d[0],"qrcode","div");c[0].appendChild(d[0]),new QRCode(e[0],{text:b.url,width:100,height:100})}function g(a){a.mobileSites.length||(a.mobileSites=a.sites);var b=(w?a.mobileSites:a.sites).slice(0),c=a.disabled;return"string"==typeof b&&(b=b.split(/\s*,\s*/)),"string"==typeof c&&(c=c.split(/\s*,\s*/)),v&&c.push("wechat"),c.length&&r(c,function(a){b.splice(q(a,b),1)}),b}function h(a,b){return b.summary=b.description,C[a].replace(/\{\{(\w)(\w*)\}\}/g,function(c,d,e){var f=a+d+e.toLowerCase();return e=(d+e).toLowerCase(),encodeURIComponent(b[f]||b[e]||"")})}function i(c){return(b.querySelectorAll||a.jQuery||a.Zepto||j).call(b,c)}function j(a){var c=[];return r(a.split(/\s*,\s*/),function(d){var e=d.match(/([#.])(\w+)/);if(null===e)throw Error("Supports only simple single #ID or .CLASS selector.");if(e[1]){var f=b.getElementById(e[2]);f&&c.push(f)}c=c.concat(m(a))}),c}function k(a,b){if(b&&"string"==typeof b){var c=(a.className+" "+b).split(/\s+/),d=" ";r(c,function(a){d.indexOf(" "+a+" ")<0&&(d+=a+" ")}),a.className=d.slice(1,-1)}}function l(a){return(b.getElementsByName(a)[0]||0).content}function m(a,b,c){if(a.getElementsByClassName)return a.getElementsByClassName(b);var d=[],e=a.getElementsByTagName(c||"*");return b=" "+b+" ",r(e,function(a){(" "+(a.className||"")+" ").indexOf(b)>=0&&d.push(a)}),d}function n(a){var c=b.createElement("div");return c.innerHTML=a,c.childNodes}function o(){var a=arguments;if(u)return u.apply(null,a);var b={};return r(a,function(a){r(a,function(a,c){b[c]=a})}),a[0]=b}function p(a){if(a.dataset)return a.dataset;var b={};return a.hasAttributes()?(r(a.attributes,function(a){var c=a.name;return 0!==c.indexOf("data-")?!0:(c=c.replace(/^data-/i,"").replace(/-(\w)/g,function(a,b){return b.toUpperCase()}),void(b[c]=a.value))}),b):{}}function q(a,b,c){var d;if(b){if(t)return t.call(b,a,c);for(d=b.length,c=c?0>c?Math.max(0,d+c):c:0;d>c;c++)if(c in b&&b[c]===a)return c}return-1}function r(a,b){var d=a.length;if(d===c){for(var e in a)if(a.hasOwnProperty(e)&&b.call(a[e],a[e],e)===!1)break}else for(var f=0;d>f&&b.call(a[f],a[f],f)!==!1;f++);}function s(c){var d="addEventListener",e=b[d]?"":"on";~b.readyState.indexOf("m")?c():"load DOMContentLoaded readystatechange".replace(/\w+/g,function(f,g){(g?b:a)[e?"attachEvent":d](e+f,function(){c&&(6>g||~b.readyState.indexOf("m"))&&(c(),c=0)},!1)})}var t=Array.prototype.indexOf,u=Object.assign,v=/MicroMessenger/i.test(navigator.userAgent),w=b.documentElement.clientWidth<=768,x=(b.images[0]||0).src||"",y=l("site")||l("Site")||b.title,z=l("title")||l("Title")||b.title,A=l("description")||l("Description")||"",B={url:location.href,origin:location.origin,source:y,title:z,description:A,image:x,weiboKey:"",wechatQrcodeTitle:"微信扫一扫：分享",wechatQrcodeHelper:"<p>微信里点“发现”，扫一下</p><p>二维码便可将本文分享至朋友圈。</p>",sites:["weibo","qq","wechat","tencent","douban","qzone","linkedin","diandian","facebook","twitter","google"],mobileSites:[],disabled:[],initialized:!1},C={qzone:"http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={{URL}}&title={{TITLE}}&desc={{DESCRIPTION}}&summary={{SUMMARY}}&site={{SOURCE}}",qq:"http://connect.qq.com/widget/shareqq/index.html?url={{URL}}&title={{TITLE}}&source={{SOURCE}}&desc={{DESCRIPTION}}",tencent:"http://share.v.t.qq.com/index.php?c=share&a=index&title={{TITLE}}&url={{URL}}&pic={{IMAGE}}",weibo:"http://service.weibo.com/share/share.php?url={{URL}}&title={{TITLE}}&pic={{IMAGE}}&appkey={{WEIBOKEY}}",wechat:"javascript:",douban:"http://shuo.douban.com/!service/share?href={{URL}}&name={{TITLE}}&text={{DESCRIPTION}}&image={{IMAGE}}&starid=0&aid=0&style=11",diandian:"http://www.diandian.com/share?lo={{URL}}&ti={{TITLE}}&type=link",linkedin:"http://www.linkedin.com/shareArticle?mini=true&ro=true&title={{TITLE}}&url={{URL}}&summary={{SUMMARY}}&source={{SOURCE}}&armin=armin",facebook:"https://www.facebook.com/sharer/sharer.php?u={{URL}}",twitter:"https://twitter.com/intent/tweet?text={{TITLE}}&url={{URL}}&via={{ORIGIN}}",google:"https://plus.google.com/share?url={{URL}}"};a.socialShare=function(a,b){a="string"==typeof a?i(a):a,a.length===c&&(a=[a]),r(a,function(a){a.initialized||d(a,b)})},s(function(){socialShare(".social-share, .share-component")})}(window,document);