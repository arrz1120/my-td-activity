# TDApp 分享:
window.appShare.set(options);
``` javascript
window.appShare.set({
  icon:'',
  title:'',
  content:'',
  shareUrl:'',
  cover:{
    src:'',
    style:{
      width:'',
    }
  },
  custom:[],
  callback:function(){}
})
```
## options 参数

Name |Info | Types | Defaults | required
--- | --- | --- | --- |---|
icon | 分享图标 | String || true
title | 分享标题 | String || true
content | 分享内容 | String || true
shareUrl | 分享链接 | String || true
cover | 微信弹层遮罩 | Object || true
custom | 自定义分享 | Array || false
callback | 分享回调 | Function|| false

### cover:
Name |Info | Types | Defaults
--- | --- | --- | ---
src | 遮罩图片路径 | String |
style | 样式 | Object |

### custom:
#### 自定义分享列表:
``` javascript
custom=[
  {key:1,val:'微信',title:'',content:'',shareUrl:'',enabled:true},
  {key:5,val:'朋友圈',title:'',content:'',shareUrl:'',enabled:true},
  {key:4,val:'QQ',title:'',content:'',shareUrl:'',enabled:true},
  {key:6,val:'QQ空间',title:'',content:'',shareUrl:'',enabled:true},
  {key:3,val:'微博',title:'',content:'',shareUrl:'',enabled:true},
  {key:8,val:'复制链接',title:'',content:'',shareUrl:'',enabled:true}
]
```
Name |Info | Types | Defaults
--- | --- | --- | ---
key | 分享 key 值 | Int | 
val | 分享名称 | String |
title | 分享标题 | String | options.title
content | 分享内容 | String | options.content
shareUrl | 分享链接 | String | options.shareUrl
enabled|启用|Boolean|true





