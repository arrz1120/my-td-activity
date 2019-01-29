import './footer.scss'
import {h,render,Component} from 'preact'
window.prc=window.prc||{}

let Footer=(props)=>{
    window.prc.footer = this;
    let footerItem = [
        {key:0,val:'普惠加息',url: window.webUrlPrefix + '/dragonBoat2018/jiaxi'},
        {key:1,val:'集粽兑红包',url: window.webUrlPrefix + '/dragonBoat2018/dumpling'},
        {key:2,val:'助力领豪礼',url: window.webUrlPrefix + '/dragonBoat2018/zhuli'}
    ]
    return(
        <div class="footer">
            {
                footerItem.map((item,i)=>{
                    return(
                        <div 
                            key={i}
                            class={
                                props.index == i ?  `item${i+1} active`:"item" + (i+1)
                            }
                            onClick = {
                                (e)=>{
                                    if(window.sa){
                                        window.sa.quick('trackHeatMap',e.target);
                                    }
                                    if(props.index != i){
                                        location.href = item.url;
                                    }
                                }
                            }
                        >
                            {item.val}
                        </div>
                    )
                })
            }
        </div>
    )
}
export default Footer
/*
export default class Footer extends Component{
    constructor(props){
        super(props)
        window.prc.footer = this;
    }

    // setIndex(i){
    //     this.setState({
    //         index:i
    //     })
    // }

    render(props,state){
        let footerItem = [
            {key:0,val:'普惠加息'},
            {key:1,val:'集粽兑红包'},
            {key:2,val:'0元领豪礼'}
        ]
        
        return(
            <div class="footer">
                {
                    footerItem.map((item,i)=>{
                        return(
                            <div 
                                key={i}
                                // onClick={()=>{
                                //     this.setIndex(i)
                                // }}
                                class={
                                    props.index == i ?  `item${i+1} active`:"item" + (i+1)
                                }
                            >
                                {item.val}
                            </div>
                        )
                    })
                }
            </div>
        )
    }
}
*/