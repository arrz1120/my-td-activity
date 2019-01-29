import {h,Component} from 'preact';
import './toast.scss';
window.prc=window.prc||{};

class Toast extends Component{
  constructor(props){
    super(props);
    window.prc.toast=this;
    this.state={
      msg:'',
      show:false,
      duration:2500,
      timer:null,
    }
  }
  show(msg,duration,callback){
    duration=duration==null?this.state.duration:duration;
    clearTimeout(this.state.timer);
    this.setState({
      msg:msg,
      show:true,
      duration:duration,
    },()=>{
      this.state.timer=setTimeout(()=>{
        this.setState({
          show:false
        },()=>{
          callback&&callback.call(this)
        })
      },this.state.duration);
    });
  }
  hide(){
    clearTimeout(this.state.timer)
    this.setState({
      show:false,
      timer:null
    })
  }
  render(props,state){
    return (
      state.show?
      (
        <div className="prc-toast">{state.msg}</div>
      ):
      null
    )
  }
}

export default Toast