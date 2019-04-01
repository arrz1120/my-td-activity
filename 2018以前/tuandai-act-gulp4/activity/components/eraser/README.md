##canvas 刮奖擦拭功能(没兼容PC端,即没监听 mouseup/mousemove/mouseup 事件)
```javascript
new Eraser(elm,opts);
//demo
var eraser=new Eraser('.dom-eraser',{
  width:'16rem',
  height:'6.1rem',
});
```
### params:
---
>elm

canvas 节点，String||DOM Node

>opts

|Name|Info|Types|Default
|--|--|--|--
|width|canvas 长度|String|null
|height|canvas 高度|String|null
|cover|擦拭图层(可以是颜色值,本地图片路径)|String|'rgba(0,0,0,.9)'
|touchSize|笔触大小|Int|25
|ratio|擦拭比例(0-1),超过比例则不能擦拭|Number|.5
|dpr|放大比例(慎用,一些低端机可能会卡)|Int|1
|onInit|初始化完成回调|Function|null
|onErase|擦拭过程中回调|Function|null
|onComplete|擦拭完成回调(擦拭的比例大于tatio时)|Function|null

### methods:
>reset()

重新渲染 canvas

