import {h,Component} from 'preact'
import Swiper from 'swiper';

export default class Rule extends Component{
    constructor(props){
        super(props)
        this.state = {
            showDom:false,
            index : 0
        }
        this.swiper = null;
        window.prc.rule = this;
    }

    show(){
        this.setState({
            showDom:true
        },()=>{
            this.initSwiper();
        })
    }

    hide(){
        this.setState({
            showDom:false
        })
    }

    initSwiper(){
        this.swiper = new Swiper('#ruleSwiper', {
            direction: 'vertical',
            freeMode: true,
            slidesPerView: 'auto',
            scrollbar: '#scrollBar',
            scrollbarHide:false
        });
    }

    render(props,state){
        let nav = ["加息专区","邀友挖矿","周年彩蛋"]
        let data = [
            <ul>
                <li>
                    <p><i>1</i>普惠加息1%</p>
                    <p>7月1日-7月18日，用户成功加入（且匹配成功）指定的We自动服务、We+自动服务（新手专享服务除外），即可享受1%的加息奖励；</p>
                    <p><span>※</span>若该期间开放的We自动服务、We+自动服务未能在活动期内满额，则该加息可延续至其满额为止（如：7月18日开放的We自动服务和We+自动服务当天未能满额，则用户次日加入仍能享受加息）；</p>
                </li>
                <li>
                    <p><i>2</i>“邀友挖矿”赢0.3%加息特权</p>
                    <p>7月1日-7月18日，参与“邀友挖矿”活动可赢0.3%加息特权和现金红包等奖励，每位用户通过该活动最多可获得0.3%加息特权；</p>
                </li>
                <li>
                    <p><i>3</i>团币最高可兑换0.2%加息特权</p>
                    <p>7月1日-7月18日，使用团币可兑换加息特权，每位用户仅有1次兑换机会，最高可兑换0.2%加息特权；</p>
                    <p><span>※</span>加息特权（获取方式：参与“邀友挖矿”、“团币兑换”）可与普惠加息叠加使用，加息额度均以最终叠加结果计算，加息范围：7月1日-7月18日期间开放的We自动服务、We+自动服务（新手专享服务除外），且仅限本次活动期间内使用，过期作废；</p>
                    <p><span>※</span>加息特权所加利息额度会在7月19日00:00开始的5个工作日内发出，由系统自动添加至用户符合条件的We自动服务和We+自动服务上。</p>
                </li>
                <li>
                    <p>本活动与苹果公司无关，活动规则最终解释权归团贷网所有。</p>
                </li>
            </ul>,
            <ul>
                <li>
                    <p><i>1</i>挖掘普通宝矿：等待数秒即可获得奖品；</p>
                    <p><i>2</i>挖掘稀有宝矿：每挖掘出1个稀有宝矿需邀请1个好友注册并加入任意金额（期限不限，智享转让，债权转让除外）即可完成挖掘；</p>
                    <p><i>3</i>协助挖掘稀有宝矿的好友可获得稀有宝矿奖品：10元现金红包；</p>
                    <p><i>4</i>当待挖掘的稀有宝矿达到3个，挖矿暂停，需邀请好友协助挖掘；</p>
                    <p><i>5</i>普通、稀有宝矿奖品：现金红包、团币、补签卡、超级会员等，其中10元及以上现金红包为稀有宝矿奖品；</p>
                    <p><i>6</i>每成功挖掘3个稀有宝矿，可获得幸运宝矿（3~88元现金红包）；</p>
                    <p><i>7</i>每位用户挖掘出第一个幸运宝矿时赠送0.3%加息特权奖励，通过该活动最多可获得0.3%加息特权；</p>
                </li>
                <li>
                    <p><span>※</span>邀请奖励说明：</p>
                    <p>a、通过该渠道邀请好友另享三重礼：0.5%年化佣金、80元现金、160元红包；</p>
                    <p>b、邀请的好友可获得新手福利：518元新手红包、2888元体验金、11%参考年回报率新手专享服务、充值送超级会员；</p>
                    <p>c、邀请人通过本活动获得的稀有宝矿现金红包累加面额上限为400元；</p>
                </li>
                <li>
                    <p><span>※</span>其他说明：</p>
                    <p>a、加息特权可与普惠加息叠加使用，加息额度均以最终叠加结果计算，加息范围：7月1日至7月18日期间开放的We自动服务、We+自动服务（新手专享服务除外），且仅限本次活动期间内使用，过期作废；</p>
                    <p>b、加息特权所加利息额度会在7月19日00:00开始的5个工作日内发出，由系统自动添加至用户符合条件的We自动服务和We+自动服务上；</p>
                    <p>c、成功获得的现金红包、补签卡请前往团宝箱查看，其中现金红包需用户手动领取，领取成功后可直接提现；</p>
                    <p>d、团币奖励查看请前往团贷网App端“我-我的会员-我的团币”；</p>
                    <p>e、宝矿产出后请及时领取，未领取的将于活动结束后清零；</p>
                    <p>f、挖矿资格仅限活动期间有效，过期作废；</p>
                    <p>g、挖矿活动仅限当前待收>0的用户参与。</p>
                </li>
                <li>
                    <p>本活动与苹果公司无关，活动规则最终解释权归团贷网所有。</p>
                </li>
            </ul>,
            <ul>
                <li>
                    <p><i>1</i>获得彩蛋：7月1日-7月18日，用户可在周年庆相关活动页面寻找三个隐藏的周年庆彩蛋，集满三个彩蛋，即可参与7月15日-7月18日的6周年抽奖活动；</p>
                    <p><i>2</i>砸蛋抽奖：7月15日-7月18日，集满三个彩蛋的用户都可以参与抽奖活动，每位用户仅有1次抽奖机会；</p>
                    <p><i>3</i>获得的彩蛋及抽奖资格仅限活动期间有效，过期作废；</p>
                    <p><i>4</i>现金红包、投资红包将于24小时内发至用户团宝箱，请您及时领取奖品，逾期失效，不予补发； </p>
                    <p><i>5</i>京东E卡将以兑换码的形式发放团宝箱，请您于获奖后15天内领取奖品，逾期失效，不予补发，并于收到卡密之日起15天内激活使用，超过15天将不再处理售后问题；</p>
                    <p><i>6</i>成功获得实物商品的用户请按要求前往团宝箱完善个人配送信息，奖品将在填写收货信息后的15个工作日内发出，商品颜色默认随机发放； </p>
                    <p><i>7</i>超级会员将于24小时内发放，请前往PC端“我的账户-超级会员-会员记录”查看；</p>
                    <p><i>8</i>团币奖励查看请前往团贷网App端“我-我的会员-我的团币”。</p>
                </li>
                <li>
                    <p>本活动与苹果公司无关，活动规则最终解释权归团贷网所有。</p>
                </li>
            </ul>

        ]

        return(
            <div class="alert" style={{display:!state.showDom?'none':''}}>
                <div
                     class="alert-bg"
                     onclick={
                         ()=>{
                             this.hide();
                         }
                     }
                ></div>
                <div class="alert-con rule">
                    <div class="alert-tit">活动规则</div>
                    <div class="rule-tit">
                        {
                            nav.map((item,i)=>{
                                return(
                                    <div
                                        key={i}
                                        class={state.index === i?'item active':'item'}
                                        onclick = {
                                            ()=>{
                                                if(state.index === i) return
                                                this.setState({
                                                    index:i
                                                },()=>{
                                                    this.swiper.slideTo(0,0,true);
                                                    this.swiper.update();
                                                })
                                            }
                                        }
                                    >
                                        {item}
                                    </div>
                                )
                            })
                        }
                    </div>
                    <div class="rule-con">
                        <div class="swiper-container" id="ruleSwiper">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                   {data[state.index]}
                                </div>
                            </div>
                            <div class="swiper-scrollbar" id="scrollBar"></div>
                        </div>
                    </div>
                    <div
                        class="close"
                        onclick={
                            ()=>{
                                this.hide();
                            }
                        }
                    ></div>
                </div>
            </div>
        )
    }

}