## 抽奖轮盘
``` javascript
new LotteryWheel(rotateElem,opts);

 // demo
 var lottery=new LotteryWheel('.lottery-innerCircle',{
  duration:5000,//旋转持续时间
  items:[//奖品列表
    {key:0,val:'vip卡',percent:.16},
    {key:1,val:'现金红包',percent:.16},
    {key:2,val:'团币',percent:.16},
    {key:3,val:'补签卡',percent:.16},
    {key:4,val:'购物卡',percent:.16},
    {key:5,val:'投资红包',percent:.16},
  ]
});
lottery.start(3,function(){
  //3对应奖品列表的 key 值,function(){} 动画结束后回调
  alert('bingo');
})
```
### params:
---
>rotateElem

旋转节点,可以是 className,DOM Node


>opts

|Name|Info|Types|Default
|---|---|---|---
duration|旋转时间(ms)|Number|5000
items|奖品列表|Array|

items:

|Name|Info|Types|Default
|---|---|---|---
key|key 值|Number,String|
val|奖品名称(设不设置都可以)|String|
percent|转盘占比|Float

### methods:
---
>start(key,callback)

开始旋转,key 对应奖品列表的 key 值,callback 转盘结束后回调

>reset()

轮盘复位
 

