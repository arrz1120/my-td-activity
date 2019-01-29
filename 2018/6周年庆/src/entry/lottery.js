import "../sass/lottery.scss";
import {h,render} from 'preact';
import Toast from "../js/components/toast/toast";
import SinglePageJustify from "../js/components/singlePageJustify/singlePageJustify";
import Swiper from 'swiper';
import Timr from 'timrjs';

window.Timr=Timr
window.winH=window.innerHeight

new SinglePageJustify(".content",0.84);

window.listScroll = {
    start(){
        new Swiper('.user-swiper', {
            loop: true,
            speed:1000,
            autoplay:2000,
            autoplayDisableOnInteraction : false
        })  
    }
}

let PrizeSwiper = (props) => {
    let data = [
        'iPhone X 256G',
        '大疆无人机',
        '小米平衡车',
        '智能扫地机器人',
        '6周年纪念金币',
        '九阳果蔬榨汁机',
        '600元现金红包',
        '空调扇',
        '松下智能电饭煲',
        '6周年纪念银币',
        '100元京东E卡',
        '10元投资红包',
        '3元现金红包',
        '166团币',
        '66团币'
    ];
    return(
        <div class="swiper-wrapper">
            {
                data.map((item,i)=>{
                    return(
                        <div 
							key = {i}
                            class="swiper-slide">
                            {/* <img src={`../images/lottery/prize/${(i+1)}.png`} /> */}
                            <img src={ window.webUrlPrefix + `/anniversary2018/mobile/mainMeeting/images/lottery/prize/${(i+1)}.png`} />	
                            <p>{data[i]}</p>	
						</div>
                    )
                })
            }
        </div>
    )
    
}

render(
    <PrizeSwiper />,
    document.getElementById("prizeSwiper")
);

let prizeSwiper = new Swiper('#prizeSwiper', {
    loop: true,
    autoplay:2000,
    autoplayDisableOnInteraction : false,
    slidesPerView :'auto'
})  

render(
    <Toast />,
    document.body
);

  