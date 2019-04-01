## 环形进度条(canvas)
```javascript
new CircularProcess(el[,opts])
```
**示例:**
```HTML
<div class="circular"></div>
```
```javascript
new CircularProcess('#circular',{
  circles:[
    {
      color:'#f60',
      radius:100,
      val:10,
    }
  ]
})
```
### 参数
---
>**el**  
canvas节点 {String|DOM Node}

>**opts**  
选项配置

|Name|Info|Types|Default
|-|-|-|-
|anticlockwise|逆时针|Boolean|false
|bgColor|进度条底色|String|'#ddd'
|animate|开启动画|Boolean|true
|animateSpeed|动画速率|Number|15
|startDeg|开始角度|Number( 0~360 )|0
|maxDeg|最大角度|Number( startDeg~360 )|360
|lineWidth|进度条线宽|Number|5
|dpr|放大倍数,解决高清屏下锯齿问题,可能会引起性能问题|Number|1
|circles|进度条列表|Array

circles:

|Name|Info|Types|Default
|-|-|-|-
|color|进度条颜色|String|
|radius|进度条半径|Number|
|val|进度条数值( 自动渲染正确各自百分比 )|Number
|percent|进度条百分比( 0~1 )|Number

### 方法
---
>**render()**  
渲染 canvas

>**clear()**  
清除 canvas 画布

>**set(opts)**
重设参数配置( 调用后默认清除 canvas 画布,需自行调用 render() )