import {h,Component} from 'preact';
import './msgbox.less';
window.preact=window.preact={};

export default class Msgbox extends Component{
  constructor(props){
    super(props);
    this.state={
      show:false,
      opts:{}
    }
    window.preact.msgbox=this;
  }
  set(opts){
    this.setState({
      opts:opts
    });
    return this;
  }
  show(){
    this.setState({
      show:true
    });
  }
  hide(){
    this.setState({
      show:false
    });
  }
  render(props,state){
    let ctx=this;
    let {opts}=state;
    let awardCls={
      0:'n1',//团币
      1:'n2',//投资红包
      2:'n3',//提现券
      3:'n4',//超级会员
      4:'n5'//补签卡
    }
    let tmpls={
      award(){
        if(opts.type===-1){
          return (
            <div className="prc-msgbox-noaward"></div>
          )
        };
        return (
          <div className={`prc-msgbox-award-wrapper ${awardCls[opts.type]}`}>
            <div className="prc-msgbox-award"></div>
          </div>
        )
      },
      btns(){
        if(!opts.btns) return null;
        return (
          <div className={`prc-msgbox-btns ${opts.msg&&'mt-small'}`}>
            {
              opts.btns.map((item,i)=>{
                return (
                  <p 
                    onClick={()=>{
                      item.callback&&item.callback.call(ctx);
                    }}
                    style={item.style}
                    className={`prc-msgbox-btns-item n${i+1}`}>
                    {item.text}
                  </p>
                )
              })
            }
          </div>
        )
      }
    }
    return (
      state.show?
      (
        <section className="prc-msgbox">
          <div className="prc-msgbox-shade"></div>
          <div className="prc-msgbox-container">
            {tmpls.award()}
            {
              opts.title?(<p className="prc-msgbox-title">{opts.title}</p>):null
            }
            {
              opts.title?(<p className="prc-msgbox-msg">{opts.msg}</p>):null
            }
            {tmpls.btns()}
            {
              opts.tips?(<p dangerouslySetInnerHTML={{__html:opts.tips}} className="prc-msgbox-tips"></p>):null
            }
          </div>
        </section>
      ):
      null
    );
  }
}