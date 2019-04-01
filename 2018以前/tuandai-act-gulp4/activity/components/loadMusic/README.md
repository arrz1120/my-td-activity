## 音乐播放(兼容 app 和 wx 自动播放)
```javascript
new LoadAudio(src[,opts]);

//demo
var loadAudio=new LoadAudio('http://10.100.65.151:3002/music/bg.mp3',{
  autoplay:true,
  loop:true
});
```
### 参数:
---
>**src**  
音乐地址(绝对路径)  

>**opts**

|Name|Info|Types|Default
|--|--|--|--
autoplay|自动播放|Boolean|true
loop|循环播放( app IOS 环境无效)|Boolean|ture
|onLoad|音频开始加载回调(autoplay 设置与否都会执行)|Function|
|onLoaded|音频加载完毕回调(autoplay 设置与否都会执行)|Function|

### 方法:
---

>**play()**  
播放音乐(微信端)

>**pause()**  
暂停音乐(微信端)

### 静态方法:
---
>**LoadAudio.appPlay(src)**  
播放音乐(App),即Jsbridge.appPlayMusic()

>LoadAudio.appPause(src)  
暂停音乐(App),Jsbridge.appStopMusic()

### 注意:
---
由于 app 端自动播放要放在生命周期里面执行(页面只能定义一次生命周期回调,多次定义会出 bug ,所以只能把 app 端的抽离出来),即如下:
```javascript
Jsbridge.appLifeHook(null, function(){
  Jsbridge.appPlayMusic(src);
},function(){
  Jsbridge.appStopMusic(src);
});
```
因此如果有自动播放音乐的需求,要单独处理:
```JavaScript
/*
  简单来说就是

  微信端播放:loadAudio.play();
  微信端暂停:loadAudio.puase();
  app 端播放:LoadAudio.appPlay(src);
  app 端暂停:LoadAudio.appPause(src);

  (注意 loadAudio 与 LoadAudio 区别, loadAudio 是自定义的实例变量, LoadAudio 是构造函数名)
*/

//app
Jsbridge.appLifeHook(null, function(){
  LoadAudio.appPlay(src)
},function(){
  LoadAudio.appPause(src)
});

//weixin
var loadAudio=new LoadAudio(src,{
  autoplay:true,
  loop:true
});

```