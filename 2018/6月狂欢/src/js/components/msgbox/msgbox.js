import {h,Component} from 'preact'

window.prc=window.prc||{}

export default class Msgbox extends Component{
  constructor(props){
    super(props)
    this.state={
      show:false,
      type:null,
      val:0,
      msg:'',
      btn:{
        text:'查看奖品',
        callback:null
      },
      closeCallback:null
    }
    window.prc.msgbox=this
  }
  set({type,val,msg,btn,closeCallback}){
    this.setState({
      type,
      val,
      msg,
      btn,
      closeCallback
    })
    return this
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
    let renderAward=()=>{
      /**
       * type
       * 团币: 0
       * 投资红包: 1
       * 现金红包: 2
       */
      let map={
        0:'prc-msgbox-img n1',
        1:'prc-msgbox-img n2',
        2:'prc-msgbox-img n3',
      }
      return(
        <div className={map[state.type]}>
          {
            state.type!==0?<p className="prc-msgbox-val">{state.val}</p>:null
          }
        </div>
      )
    }
    let renderBtn=()=>{
      if(!state.btn) return null
      return(
        <div className="prc-msgbox-btn-container">
          <p 
            onClick={(e)=>state.btn.callback&&state.btn.callback(e.target)}
            className="prc-msgbox-btn">
            {state.btn.text}
          </p>
        </div>
      )
    }
    return(
      state.show?
      (
        <section 
          onTouchMove={e=>e.preventDefault()}
          className="prc-msgbox">
          <div className="prc-msgbox-shade"></div>
          <div className="prc-msgbox-container">
            <div className="prc-msgbox-stars"></div>
            {renderAward()}
            <p className="prc-msgbox-msg">{state.msg}</p>
            {renderBtn()}
          </div>
          <div 
            onClick={(e)=>{
              this.hide()
              state.closeCallback&&state.closeCallback(e.target)
            }} 
            className="prc-msgbox-closeBtn">
          </div>
        </section>
      )
      :
      null
    )
  }
}