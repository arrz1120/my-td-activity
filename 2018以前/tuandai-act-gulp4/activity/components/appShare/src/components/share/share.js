import {h,Component} from 'preact';
import './share.less';
import _findIdx from 'array-find-index';

window.preact=window.preact||{};

let ua = navigator.userAgent.toLowerCase();
let isWeiXin=function(){
  if (ua.match(/MicroMessenger/i) == 'micromessenger') {
      return true;
  } else {
      return false;
  }
}
let isAndroid=/android|adr/gi.test(ua);
let isIos=/iphone|ipod|ipad/gi.test(ua) && !isAndroid;

let shareList=[
  {key:1,val:'微信'},
  {key:5,val:'朋友圈'},
  {key:4,val:'QQ'},
  {key:6,val:'QQ空间'},
  {key:3,val:'微博'},
  {key:8,val:'复制链接'}
];

export default class Share extends Component{
  constructor(props){
    super(props);
    window.appShare=window.preact.share=this;
    this.state={
      show:false,
      cover:{
        src:'',
        style:{}
      }
    }
  }
  list(){
    return shareList;
  }
  set(opts){
    if (Jsbridge.isApp()) {
      let shareTypeList=shareList;
      if(opts.custom!=null){
        opts.custom.forEach((item,i)=>{
          let idx=_findIdx(shareList,function(innerItem){
            return innerItem.key===item.key
          });
          shareTypeList[idx]=item;
        })
      }

      shareTypeList=shareTypeList.map((item,i)=>{
        let content=(()=>{
          if(item.key===3||item.key===5){
            return item.title||opts.title
          }
          return item.content||opts.content;
        })();
        if(item.enabled!==false){
          return {
            ShareToolType:item.key,
            ShareToolName:item.val,
            IconUrl:opts.icon,
            Title:item.title||opts.title,
            ShareContent:content,
            ShareUrl:item.shareUrl||opts.shareUrl,
            IsEnabled:true
          }
        }
      }).filter(item=>{
        return item!=undefined
      })

      Jsbridge.toAppWebViewShare({
        shareTypeList
      },(status)=>{
        //回调函数
        // result:分享状态('onCancel':分享失败,'onComplete':分享成功,'onCancel':分享取消)
        let result=(()=>{
          if(isAndroid){
            return JSON.parse(status).ShareResult;
          }
          if(isIos){
            return status;
          }
        })();
        opts.callback&&opts.callback(result);
      });
    } else { 
      if (isWeiXin()) {
        try {
          opts.cover.style=opts.cover.style==null?{}:opts.cover.style;
          opts.cover.src=opts.cover.src;
        } catch (error) {
          console.log(error)
        }
        this.setState({
          cover:{
            src:opts.cover.src,
            style:opts.cover.style,
          },
          show:true
        })
      } else {
        alert('打开app即可分享');
      }
    }
  }
  show(){
    this.setState({
      show:true
    })
  }
  hide(){
    this.setState({
      show:false
    })
  }
  render(props,state){
    return(
      state.show?
      (
        <div onTouchMove={(e)=>e.preventDefault()} onClick={()=>this.hide()} className="prc-share">
          <div style={state.cover.style} className="prc-share-img">
            <img src={state.cover.src} style={state.cover.style} />
          </div>
        </div>
      ):
      null
    )
  }
}