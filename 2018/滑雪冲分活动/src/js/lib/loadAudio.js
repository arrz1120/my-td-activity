let UA = navigator.userAgent.toLowerCase();

let isWX=(()=>{
  return UA.match(/MicroMessenger/i) == 'micromessenger';
})();

let isAndroid=(()=>{
  return /android|adr/gi.test(UA);
})();

let isIOS=(()=>{
  return /iphone|ipod|ipad/gi.test(UA) && !isAndroid;
})();

let isApp=()=>{
  if(!Jsbridge){
    throw new Error('没有引入 Jsbridge');
  }
  return Jsbridge.isApp();
}

class LoadAudio{
  constructor(src,opts){
    this.src=src;
    this.opts=LoadAudio.mergeOpts(opts);
    this.hasPlayed=false;
    this.init();
  }
  init(){
    let {autoplay,loop,onLoad,onLoaded}=this.opts;
    let self=this;
    this.domAudio=null;
    this.domAudio=document.createElement('audio');
    this.domAudio.src=this.src;
    this.domAudio.loop=loop;
    this.domAudio.autoplay=autoplay;
    if(isIOS){
      document.addEventListener('WeixinJSBridgeReady',()=>{
        this.domAudio.play();
        if(!autoplay){
          this.domAudio.pause();
        }
      }, false);
    }
    if(isAndroid){
      if(!autoplay){
        this.domAudio.pause();
      }
    }
    this.domAudio.addEventListener('loadstart',()=>{
      onLoad&&onLoad.call(this);
    });
    this.domAudio.addEventListener('loadeddata',()=>{
      onLoaded&&onLoaded.call(this);
    });
  }

  play(){
    this.domAudio.play();
  }

  pause(){
    this.domAudio.pause();
  }
  
  static mergeOpts(opts){
    let defaults={
      autoplay:true,
      loop:false,
    }
    for(let i in opts){
      defaults[i]=opts[i];
    }
    return defaults;
  }

  static appPlay(src){
    Jsbridge.appPlayMusic(src)
  }

  static appPause(src){
    Jsbridge.appStopMusic(src)
  }
}

export default LoadAudio