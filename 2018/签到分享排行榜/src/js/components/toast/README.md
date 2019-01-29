# toast 方法

## demo:
```html
<!-- html -->
<script src="dist/toast.bdle.js"></script>
```
```javascript
// js
toast.show('提示内容',2500,function(){
  // 回调
})
```

## API:  
* `toast.show(msg,duration,callback)`: 显示 toast
  * **msg**: {String} 提示内容, 默认 ''
  * **duration**: {Number} 持续时间, 默认 2500
  * **callback**: {Function} 回调函数,默认 null

* `toast.hide()`: 隐藏 toast  





