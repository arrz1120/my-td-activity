import {h,Component} from 'preact'
import './msgbox.scss'
window.prc=window.prc||{}

export default class Msgbox extends Component{
  constructor(props){
    super(props)
    window.prc.msgbox=this
    this.state={
      show:false,
      isShake:false,
      msgs:[],
      tips:'',
      btns:[]
    }
  }
  set({msgs,tips,btns}){
    let state=this.state
    this.setState({
      msgs:msgs==null?state.msgs:msgs,
      tips:tips==null?state.tips:tips,
      btns:btns==null?state.btns:btns
    })
    return this
  }
  show(callback){
    this.setState({
      show:true
    },()=>{
      callback&&callback.call(this)
    })
  }
  hide(){
    this.setState({
      tips:'',
      show:false
    })
  }
  shakeTips(tips){
    this.setState({
      tips:tips||this.state.tips,
      isShake:true
    })
    setTimeout(()=>{
      this.setState({
        isShake:false
      })
    },500)
  }
  render(props,state){
    let renderMsgs=()=>{
      return state.msgs.map((item,i)=>{
        return (
          <li key={i} className="item">{item}</li>
        )
      })
    }
    let renderBtns=()=>{
      return state.btns.map((item,i)=>{
        let btnCls=(()=>{
          switch (item.type) {
            case 1:
              return 'item n2'
            }
          return 'item n1'
        })()
        return (
          <li
            onClick={(e)=>{
              item.callback&&item.callback.call(this,e.target)
            }}
            key={i}
            className={btnCls}>
            {item.text}
          </li>
        )
      })
    }
    return(
      state.show?
      (
        <section 
          onTouchMove={(e)=>{
            e.preventDefault()
          }}
          className="prc-msgbox-modal">
          <div className="prc-msgbox-shade"></div>
          <div className="prc-msgbox-container">
            <ul className="prc-msgbox-msg">{renderMsgs()}</ul>
            <p className={state.isShake?'prc-msgbox-tips animate':'prc-msgbox-tips'}>{state.tips}</p>
            <ul className="prc-msgbox-btn">{renderBtns()}</ul>
          </div>
        </section>     
      ):
      null
    )
  }
}