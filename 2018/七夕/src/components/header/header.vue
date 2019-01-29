<template>
    <header class="top-header">
      <h2 class="tit"></h2>
      <p class="time">活动时间：8月15日—8月21日</p>
      <div class="meet">
          <div class="moon"></div>
          <div class="cloud-1"></div>
          <!-- 牛郎 -->
          <div class="nl-wrapr " :class="state.xiQueTotalCount>5 ? 'nl-wrapr-move' : ''">
            <div class="nl"></div>
          </div>
          <!-- 织女 -->
          <div class="zn-wrapr "  :class="state.xiQueTotalCount>5 ? 'zn-wrapr-move' : ''">
            <div class="zn"></div>
          </div>
          <div class="cloud"></div>
          <!--喜鹊-->
          <ul class="bird">
              <li :class="state.xiQueTotalCount>0 ? 'light-1' : ''"></li>
              <li :class="state.xiQueTotalCount>1 ? 'light-2' : ''"></li>
              <li :class="state.xiQueTotalCount>2 ? 'light-3' : ''"></li>
              <li :class="state.xiQueTotalCount>3 ? 'light-4' : ''"></li>
              <li :class="state.xiQueTotalCount>4 ? 'light-5' : ''"></li>
              <li :class="state.xiQueTotalCount>5 ? 'light-6' : ''"></li>
          </ul>
          <!--喜鹊 end-->
          <p v-if="state.logined" class="bottome-txt">已召唤<span>{{state.xiQueTotalCount}}</span>只喜鹊</p>
          <p v-else class="bottome-txt">召唤<span>6</span>只喜鹊搭桥即可帮助牛郎织女重逢</p>  
      </div>
    </header>
</template>

<script>


export default {

  props:['state'],
  data(){
      return {

      }
  }
}
</script>

<style lang="scss" scoped>
    @import '../../assets/sass/_util.scss';


      .top-header{
        background-image: -webkit-linear-gradient(top,#2b0347,#681482);
        padding-top: rem(219);
        position: relative;
        &:before{
          position: absolute;
          content: "";
          @include wh(734,816);
          @include bg('../../assets/images/app/header/flower.png');
          top: 0;
          left: 0;
          z-index: 3;
        }



        &:after{
          position: absolute;
          content: "";
          @include wh(750,823);
          @include bg('../../assets/images/app/header/mountain.png');
          top: rem(230);
          left: 0;
          z-index: 0;
        }



        .tit{
              @include wh(648,147);
              @include bg('../../assets/images/app/header/tit.png');
              position: absolute;
              left: rem(50) ;
              top: rem(30);
              animation: scale .5s  ease-out both;
              opacity: 0;
        }




        .time{
              @include wh(643,58);
              @include bg('../../assets/images/app/header/time-banner.png');
              text-align: center;
              margin: 0 auto;
              line-height: rem(58);
              color:#ff95c8;
        }

        .meet{
            height: rem(660);
            position: relative;
            z-index: 2;
            padding-top: rem(480);
            overflow: hidden;

            .bottome-txt{
                text-align: center;
                font-size: rem(24);
                position: absolute;
                width: 100%;
                left: 0;
                bottom: rem(50);
                color: #fff;
                span{
                    font-weight: bold;
                    color: #fff22a;
                    margin: 0 rem(8);
                }
            }

            .moon{
                @include wh(689,687);
                @include bg('../../assets/images/app/header/moon.png');
                position: absolute;
                left: rem(30);
                top:rem(-30);
                animation:  fadeIn .5s .3s  ease-out both;
                opacity: 0;
            }

            .cloud{
                position: absolute;
                @include wh(750,280);
                @include bg('../../assets/images/app/header/cloud.png');
                left: 0;
                top: rem(360);
                animation:  fadeIn .3s .8s  ease-out both;
                opacity: 0;
            }


            .cloud-1{
                position: absolute;
                @include wh(708,173);
                @include bg('../../assets/images/app/header/cloud-1.png');
                left: rem(40);
                top: rem(260);
                animation:  fadeIn .3s .8s  ease-out both;
                opacity: 0;
            }

            .heart{
                position: absolute;
                @include wh(36,36);
                @include bg('../../assets/images/app/header/heart.png');
                left: rem(240);
                top: rem(200);
            }

           .nl,
           .zn{
               animation:  fadeIn .3s 1.5s  ease-out both;
               opacity: 0;
           }


           .nl-wrapr,
           .zn-wrapr{
               position: absolute;
           }

            .zn-wrapr{
                left: rem(-30) ;
                    top: rem(100);
            }

           .nl-wrapr{
                    right: rem(-50);
                    top: rem(90);
                    z-index: 1;
           }

           .nl{
                    @include wh(261,428);
                    @include bg('../../assets/images/app/header/nl.png');
            }

            .zn{
                    @include wh(330,427);
                    @include bg('../../assets/images/app/header/zn.png');
            }

            .nl-wrapr-move{
               animation:  moveR 1.5s 4s  ease-out both;

            }

            .zn-wrapr-move{
               animation:  moveL 1.5s 4s  ease-out both;
            }

            .bird{
                position: relative;
                @include bg('../../assets/images/app/header/brid-small.png');
                background-size: rem(634) auto;
                background-position: rem(30) 0;
                height: rem(180);
                z-index: 2;
                animation:  fadeIn .3s 1.8s  ease-out both;
                opacity: 0;


                li{
                    position: absolute;
                }

                :nth-child(1){
                    @include wh(123,84);
                    @include bg('../../assets/images/app/header/b1.png');
                    left: rem(33) ;
                    top: rem(50);
                }

                :nth-child(2){
                    @include wh(117,77);
                    @include bg('../../assets/images/app/header/b2.png');
                    left: rem(126) ;
                    top: rem(5);

                }

                :nth-child(3){
                    @include wh(122,91);
                    @include bg('../../assets/images/app/header/b3.png');
                    left: rem(260) ;
                    top: rem(-30);

                }
                :nth-child(4){
                    @include wh(114,102);
                    @include bg('../../assets/images/app/header/b4.png');
                    left: rem(412) ;
                    top: rem(-30);

                }
                :nth-child(5){
                    @include wh(102,104);
                    @include bg('../../assets/images/app/header/b5.png');
                    left: rem(540) ;
                    top: rem(-15);

                }
                :nth-child(6){
                    @include wh(107,73);
                    @include bg('../../assets/images/app/header/b6.png');
                    left: rem(636) ;
                    top: rem(30);

                }

                .light-1{
                      animation:  light1 1.5s  1s  ease-out both;
                }
                .light-2{
                      animation:  light2 1.5s  1.5s  ease-out both;
                }
                .light-3{
                      animation:  light3 1.5s  2s  ease-out both;
                }
                .light-4{
                      animation:  light4 1.5s  2.5s  ease-out both;
                }
                .light-5{
                      animation:  light5 1.5s  3s  ease-out both;
                }
                .light-6{
                      animation:  light6 1.5s  3.5s  ease-out both;
                }
            }

        }

      }


@keyframes light1{
  100%{
  @include bg('../../assets/images/app/header/l1.png');
  }
}


@keyframes light2{
  100%{
  @include bg('../../assets/images/app/header/l2.png');
  }
}
@keyframes light3{
  100%{
  @include bg('../../assets/images/app/header/l3.png');
  }
}

@keyframes light4{
  100%{
  @include bg('../../assets/images/app/header/l4.png');
  }
}
@keyframes light5{
  100%{
  @include bg('../../assets/images/app/header/l5.png');
  }
}
@keyframes light6{
  100%{
  @include bg('../../assets/images/app/header/l6.png');
  }
}



@keyframes  scale{
  0%{
      transform: scale(0);
      opacity: 0;
  }
  100%{
      transform: scale(1);
      opacity: 1;
  }
}



@keyframes  fadeIn{
  0%{
      opacity: 0;
  }
  100%{
      opacity: 1;
  }
}

@keyframes  moveL{
  0%{
      transform: translate3d(0,0,0);
  }
  100%{
      transform: translate3d(rem(250),0,0);
  }
}


@keyframes  moveR{
  0%{
      transform: translate3d(0,0,0);
  }
  100%{
      transform: translate3d(rem(-230),0,0);
  }
}







</style>
