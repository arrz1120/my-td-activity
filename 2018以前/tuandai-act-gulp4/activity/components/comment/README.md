#垂直自滚( 没有手势事件 )
```javascript
new Comment(src[,opts])
```
示例:
```html
<!-- HTML -->
<div class="comment-container">
  <p class="comment-item">1</p>
  <p class="comment-item">2</p>
  <p class="comment-item">3</p>
  <p class="comment-item">4</p>
  <p class="comment-item">5</p>
</div>
```
```javascript
// JS
var comment=new Comment('.comment-container')
```
### 参数:
---
>**src**  
滚动节点  

>**opts**  

|Name|Info|Types|Default
|--|--|--|--
showSlides|显示条数|Int|3
autoplay|自动滚动|Boolean|ture
|delay|滚动间隔|Number|2000
|startIdx|初始化索引|Int|0
|onInit|初始化回调|Function
onChange|滚动结束后回调|Function

