## 自定义滚动插件(提供上拉下拉事件,没兼容 PC )
new Scroller(el,opts);
```javascript
// demo
var scroller=new Scroller('.scroller-container',{
  target:'.scroller-wrapper',
  pushThresholdY:85,
  pullThresholdY:85,      
  onScroll:null,
  onInit:null,
  onTouchStart:null,
  onTouchMove:null,
  onTouchEnd:null,
  onPush:null,
  onPushed:null,
  onPull:null,
  onPulled:null,
})
```
### 参数
>**el**

滚动容器节点,需设定高度
>**opts**

Name|Info|Types|Defaults
-|-|-|-
target|滚动内容节点,注意不要设置 margin 值,会导致计算高度误差|String,DOM Node|el 节点第一个子元素
pushThresholdY|上拉触发阈值|Number|85
pullThresholdY|下拉触发阈值|Number|85
onScroll|滚动回调(包含惯性滚动)|Function|null
onInit|滚动初始化回调|Function|null
onTouchStart|触摸开始回调|Function|null
onTouchMove|触摸移动回调|Function|null
onTouchEnd|触摸结束回调|Function|null
onPush|上拉回调|Function|null
onPushed|上拉触发释放回调|Function|null
onPull|下拉回调|Function|null
onPulled|下拉触发释放回调|Function|null

### 方法
>**enabled()**  
滚动启用

>**disabled()**  
滚动停用

>**scrollStart(dur)**  
滚动到顶部  
@param {} dur:持续时间

>**scrollEnd(dur)**  
滚动到底部  
@param {Number} dur:持续时间

>**scrollTo(y,dur)**  
滚动到指定位置  
@param {Number} y:纵轴坐标(单位px)  
@param {Number} dur:持续时间

>**refresh()**  
重新计算滚动区域,当滚动内容高度发生变化时,请务必执行此方法

### 属性
>**el**  
滚动容器节点

>**target**  
滚动内容节点

>**y**  
纵轴坐标,即滚动值

>**directionY**  
滑动方向  
上滑:'push'  
下滑:'pull'

>**isEndY**  
是否到达底部

>**isStartY**  
是否到达顶部

>**maxScrollY**  
最大滚动值

>**pullBounceY**  
下拉值,滚动到顶部,再继续下拉的位移值

>**pushBounceY**  
上拉值,滚动到顶部,再继续上拉的位移值

### 待优化
>**onScroll 事件**  
这个事件监听了两种情况,一种是手指实时滑动,即 touchMove,这种情况 y 是实时更新;另外种情况是惯性滚动的时候,这个时候的 y 值并不是实时,而是等于惯性滚动后的 y 值,当时尝试过实时更新,发现会影响滚动的流畅性,日后作优化.

>**onTouchStart 事件**  
在惯性滚动过程中,再触摸滚动区域,会出现轻微跳动,这是由于上面提到的滚性过程中 y 值没实时更新所导致,所以触摸滚动区域的时候,滚动内容会直接跳到触发惯性滚动计算的 y 值.








