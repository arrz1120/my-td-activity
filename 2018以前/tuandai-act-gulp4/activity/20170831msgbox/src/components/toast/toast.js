import {h,Component} from 'preact';
import './toast.less';
window.preact=window.preact||{};

export default class Toast extends Component{
  constructor(props){
    super(props);
    window.preact.toast=this;
    this.state={
      msg:'',
      show:false,
      duration:2000,
      timer:null,
    }
  }
  show(msg,duration){
    duration=duration==null?this.state.duration:duration;
    clearTimeout(this.state.timer);
    this.setState({
      msg:msg,
      show:true,
      duration:duration
    },()=>{
      this.state.timer=setTimeout(()=>{
        this.setState({
          show:false
        })
      },this.state.duration);
    });
  }

  render(props,state){
    return (
      state.show?
      (
        <div dangerouslySetInnerHTML={{__html:state.msg}} className="prc-toast"></div>
      ):
      null
    )
  }
}