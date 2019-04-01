<%@ Page Language="C#" AutoEventWireup="true" CodeFile="myPrivileges.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.myPrivileges" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>特权详情</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/myPrivileges.css?v=20151111001" />
    <!--会员中心-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body>
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header">
                <div class="back" onclick="javascript:history.go(-1);">返回</div>
                <h1 class="title">特权详情</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>
        <% if (vipModel.Level == 1)
           { %>
        <div class="newUserTips">
            <p>您还差<%=userRankInfo.Growth %>分才能领取投资礼包的特权！</p>
        </div>
        <%} %>
        <div class="myPrivileges">
            <div class="banner">
                <div class="swiper-container" id="in_industry">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <div class="pics <%=curLevel==1?"myLevel":"" %>">
                                <div class="img img_s">
                                    <img src="/imgs/member/lv1_s.png" />
                                </div>
                                <div class="img img_b">
                                    <img src="/imgs/member/lv1_b.png" />
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="pics <%=curLevel==2?"myLevel":"" %>">
                                <div class="img img_s">
                                    <img src="/imgs/member/lv2_s.png" />
                                </div>
                                <div class="img img_b">
                                    <img src="/imgs/member/lv2_b.png" />
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="pics <%=curLevel==3?"myLevel":"" %>">
                                <div class="img img_s">
                                    <img src="/imgs/member/lv3_s.png" />
                                </div>
                                <div class="img img_b">
                                    <img src="/imgs/member/lv3_b.png" />
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="pics <%=curLevel==4?"myLevel":"" %>">
                                <div class="img img_s">
                                    <img src="/imgs/member/lv4_s.png" />
                                </div>
                                <div class="img img_b">
                                    <img src="/imgs/member/lv4_b.png" />
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="pics <%=curLevel==5?"myLevel":"" %>">
                                <div class="img img_s">
                                    <img src="/imgs/member/lv5_s.png" />
                                </div>
                                <div class="img img_b">
                                    <img src="/imgs/member/lv5_b.png" />
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="pics <%=curLevel==6?"myLevel":"" %>">
                                <div class="img img_s">
                                    <img src="/imgs/member/lv6_s.png" />
                                </div>
                                <div class="img img_b">
                                    <img src="/imgs/member/lv6_b.png" />
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="pics <%=curLevel==7?"myLevel":"" %>">
                                <div class="img img_s">
                                    <img src="/imgs/member/lv7_s.png" />
                                </div>
                                <div class="img img_b">
                                    <img src="/imgs/member/lv7_b.png" />
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="pics <%=curLevel==8?"myLevel":"" %>">
                                <div class="img img_s">
                                    <img src="/imgs/member/lv8_s.png" />
                                </div>
                                <div class="img img_b">
                                    <img src="/imgs/member/lv8_b.png" />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="list">
                <div class="itemOuter">
                    <div class="item gray01">
                        <h3>升级投资礼包</h3>
                        <p>礼包包含团贷付费特权尊享，投资红包。其中LV2、3、4分别可获得88、158、228元的投资红包。</p>
                    </div>
                </div>
                <div class="itemOuter">
                    <div class="item gray02">
                        <h3>专享服务</h3>
                        <p>团贷网将不定期为不同等级会员提供专享服务。</p>
                    </div>
                </div>
                <div class="itemOuter">
                    <div class="item gray03">
                        <h3>快速提现</h3>
                        <p>快速提现可每日提取应急资金，等级不同，每日限额不同。其中LV5、6、7、8分别可获得1、3、5、10万元/天的提现额度。</p>
                    </div>
                </div>
                <div class="itemOuter">
                    <div class="item gray04">
                        <h3>生日特权</h3>
                        <p>会员生日当月投资满888元即可收到团贷精美生日礼品一份。</p>
                    </div>
                </div>
                <div class="itemOuter">
                    <div class="item gray05">
                        <h3>专属客服</h3>
                        <p>一对一专属客服，随时随地接听客户电话，为客户解决问题。</p>
                    </div>
                </div>
                <div class="itemOuter">
                    <div class="item gray06">
                        <h3>贵宾俱乐部</h3>
                        <p>受邀成为团贷网高级俱乐部成员，定期举办各类高端活动，更有各种俱乐部福利。</p>
                    </div>
                </div>
                <div class="itemOuter">
                    <div class="item gray07">
                        <h3>周年纪念品</h3>
                        <p>团贷网将为注册满一周年且达到特定级别的用户送出周年纪念品一份。</p>
                    </div>
                </div>
                <div class="itemOuter">
                    <div class="item gray08">
                        <h3>年会邀请函</h3>
                        <p>获邀参与团贷网年会一次，包含交通，食宿等一切费用，还可以参与年会现场抽奖。</p>
                    </div>
                </div>
            </div>
        </div>
        <!--end-->



    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
    <script type="text/javascript">
        var arr = [];
        function active(index) {
            switch (index) {
                case 0: //一级
                    arr = [0, 0, 0, 0, 0, 0, 0, 0];
                    addGrayClass();
                    break;
                case 1:
                    arr = [1, 0, 0, 0, 0, 0, 0, 0];
                    addGrayClass();
                    break;
                case 2: //三级
                    arr = [1, 1, 0, 0, 0, 0, 0, 0];
                    addGrayClass();
                    break;
                case 3:
                    arr = [1, 1, 0, 0, 0, 0, 0, 0];
                    addGrayClass();
                    break;
                case 4:
                    arr = [1, 1, 1, 0, 0, 0, 0, 0];
                    addGrayClass();
                    break;
                case 5:
                    arr = [1, 1, 1, 1, 0, 0, 0, 0];
                    addGrayClass();
                    break;
                case 6:
                    arr = [1, 1, 1, 1, 1, 1, 1, 0];
                    addGrayClass();
                    break;
                case 7:
                    arr = [1, 1, 1, 1, 1, 1, 1, 1];
                    addGrayClass();
                    break;
                default:
                    break;
            }
        }
        function addGrayClass() {
            var item = $(".item");
            for (var i = 0; i < 8; i++) {
                if (arr[i] == 1) {
                    item.eq(i).removeClass('gray0' + (i + 1)).addClass('item0' + (i + 1));
                } else {
                    item.eq(i).removeClass('item0' + (i + 1)).addClass('gray0' + (i + 1));
                }
            }
        }
        function lineStyle() {
            var w = $(".swiper-slide").width() - 40;
            var l = w / 2 + 40;
            $(".line").css({
                'left': l,
                'width': w
            });
        }
        function newUserTips() {
            setTimeout(function () {
                $(".newUserTips").slideUp();
            }, 5000);
        }
        $(document).ready(function () {
            $(".swiper-slide").eq(<%=curLevel-1 %>).find(".pics").before("<div class='userLevel'><img src='/imgs/member/userLevel.png' /></div>");
	        var swiper = new Swiper('#in_industry', {
	            initialSlide:<%=curLevel-1 %>,
	            slidesPerView: 'auto',
	            spaceBetween: 0,
	            centeredSlides: true,
	            spaceBetween: 0,
	            onSlideChangeEnd: function (swiper) {
	                active(swiper.activeIndex); 
	            }
	        });
	        lineStyle();
		    <%if (vipModel.Level == 1)
        { %>
	        newUserTips();
	        <%} %> 
	        //设置当前用户所处级别
	        active(<%=curLevel-1 %>);
	    });
    </script>
</asp:Content>
