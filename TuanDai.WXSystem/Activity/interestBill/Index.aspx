<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.interestBill.Index" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no" />
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <title>团贷三周年趣味账单</title>
    <meta name="keywords" content="团贷网,你我金融,互联网金融,P2P网贷,P2P理财" />
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。" />
    <link rel="stylesheet" type="text/css" href="css/swiper.min.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
    <div style="display: none;">
        <img src="images/weixin-share.png" />
    </div>
    <!--loading-->
    <div id="loading" class="loading">
        <div class="loadbox">
            <div class="loadlogo">
            </div>
            <div class="loadbg">
            </div>
        </div>
    </div>
    <!-- 主内容开始 -->
    <div class="swiper-container" id="swiper-container">
        <div class="swiper-wrapper">
            <!--第1页-->
            <div class="swiper-slide p1">
                <div class="pic-box p1_1 animated pulse">
                    <img src="images/p1_1.png" /></div>
                <div class="pic-box p1_2">
                    <img src="images/p1_2.png" /></div>
                <div class="pic-box p1_3">
                    <img src="images/p1_3.png" /></div>
                <div class="pic-box p1_4">
                    <img src="images/p1_4.png" /></div>
                <div class="pic-box p1_5 animated fadeInUpBig">
                    <img src="images/p1_5.png" /></div>
                <div class="pic-box p1_6">
                    <img src="images/p1_6.png" /></div>
                <div class="pic-box p1_7">
                    <img src="images/p1_7.png" /></div>
                <img class="arrow-up pt-page-moveIconUp" />
                <a href="javascript:;" class="start f13 c-fff pos-a text-c next" id="start_but">开启账单</a>
            </div>
            <!--第2页-->
            <div class="swiper-slide p2">
                <div class="text-cn">
                    <p class="f14">
                        <span class="f13 c-ff6a2f">
                            <%= interestBillInfo.UserAddDate.Year%></span>年<span class="f14 c-ff6a2f"><%= interestBillInfo.UserAddDate.Month%></span>月<span
                                class="f13 c-ff6a2f"><%= interestBillInfo.UserAddDate.Day%></span>日</p>
                    <p class="f14">
                        我第一次来到团贷网</p>
                </div>
                <div class="pic-box p2_1">
                    <img src="images/p2_1.png" /></div>
                <div class="pic-box p2_2 animated fadeInLeft">
                    <img src="images/p2_2.png" /></div>
                <div class="pic-box p2_3 animated fadeInLeft">
                    <img src="images/p2_3.png" /></div>
                <div class="pic-box p2_4">
                    <img src="images/p2_4.png" /></div>
                <div class="pic-box p2_5 animated slideInUp">
                    <img src="images/p2_5.png" /></div>
                <img src="images/icon_up.png" class="arrow-up pt-page-moveIconUp" />
            </div>
            <!--第3页-->
            <div class="swiper-slide p3">
                <div class="text-cn">
                    <p class="f14">
                        这是我在团贷网的</p>
                    <p class="f14">
                        第<span class="f14 c-ff6a2f"><%= interestBillInfo.UserAddDay%></span>天</p>
                </div>
                <div class="pic-box p3_1">
                    <img src="images/p3_1.png" /></div>
                <div class="pic-box p3_2 animated fadeInLeft">
                    <img src="images/p3_2.png" /></div>
                <div class="pic-box p3_3 animated fadeIn">
                    <img src="images/p3_3.png" /></div>
                <div class="pic-box p3_4 animated fadeInLeft">
                    <img src="images/p3_4.png" /></div>
                <img src="images/icon_up.png" class="arrow-up pt-page-moveIconUp" />
            </div>
            <!--第4页-->
            <div class="swiper-slide p4">
                <div class="timeline-box invest">
                    <div class="cn-title ">
                        <p class="f14 c-fff">
                            当前我在团贷网投了</p>
                        <div class="number pos-r">
                            <img src="images/ico1.png" class="ico1 pos-a" />
                            <p class="f15 c-ff6a2f">
                                <%=ToolStatus.ConvertLowerMoney(InvestMoney)%>元</p>
                        </div>
                    </div>
                    <div class="line-wrap clearfix text-c">
                        <div class="line-box fl">
                            <div class="line-cn pos-r">
                                <span class="f115 c-2583af">2012 (下半年)</span>
                                <img src="images/ico2.png" class="pos-a" />
                                <i class="triangle  pos-a"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(1)%></span>
                                </p>
                            </div>
                            <div class="line-cn pos-r">
                                <span class="f115 c-2583af">2013 (上半年)</span>
                                <img src="images/ico2.png" class="pos-a" />
                                <i class="triangle pos-a"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(2)%></span>
                                </p>
                            </div>
                            <div class="line-cn pos-r">
                                <span class="f115 c-2583af">2013 (下半年)</span>
                                <img src="images/ico2.png" class="pos-a" />
                                <i class="triangle pos-a"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(3)%></span>
                                </p>
                            </div>
                            <div class="line-cn pos-r">
                                <span class="f115 c-2583af">2014 (上半年)</span>
                                <img src="images/ico2.png" class="pos-a" />
                                <i class="triangle pos-a"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(4)%></span>
                                </p>
                            </div>
                            <div class="line-cn pos-r">
                                <span class="f115 c-2583af">2014 (下半年)</span>
                                <img src="images/ico2.png" class="pos-a" />
                                <i class="triangle pos-a"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(5)%></span>
                                </p>
                            </div>
                            <div class="line-cn pos-r">
                                <span class="f115 c-2583af">2015 (上半年) </span>
                                <img src="images/ico2.png" class="pos-a" />
                                <i class="triangle pos-a"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(6)%></span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <img src="images/icon_up.png" class="arrow-up pt-page-moveIconUp" />
            </div>
            <!--第5页-->
            <div class="swiper-slide p5">
                <div class="timeline-box earn">
                    <div class="cn-title ">
                        <p class="f13 c-fff">
                            当前我在团贷网赚取了</p>
                        <div class="number pos-r">
                            <img src="images/ico3.png" class="ico1 pos-a" />
                            <p class="f15 c-ff6a2f">
                                <%=ToolStatus.ConvertLowerMoney(ReturnMoney)%>元</p>
                        </div>
                    </div>
                    <div class="line-wrap clearfix text-c">
                        <div class="line-box fl">
                            <div class="line-cn pos-r">
                                <span class="f115 c-ed7c0e">2012 (下半年)</span>
                                <img src="images/ico4.png" class="pos-a" />
                                <i class="triangle pos-a"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(1,"1")%></span>
                                </p>
                            </div>
                            <div class="line-cn pos-r">
                                <span class="f115 c-ed7c0e">2013 (上半年)</span>
                                <img src="images/ico4.png" class="pos-a" />
                                <i class="triangle pos-a"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(2,"1")%></span>
                                </p>
                            </div>
                            <div class="line-cn pos-r">
                                <span class="f115 c-ed7c0e">2013 (下半年)</span>
                                <img src="images/ico4.png" class="pos-a" />
                                <i class="triangle pos-a"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(3,"1")%></span>
                                </p>
                            </div>
                            <div class="line-cn pos-r">
                                <span class="f115 c-ed7c0e">2014 (上半年)</span>
                                <img src="images/ico4.png" class="pos-a" />
                                <i class="triangle pos-a bg-"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(4,"1")%></span>
                                </p>
                            </div>
                            <div class="line-cn pos-r">
                                <span class="f115 c-ed7c0e">2014 (下半年)</span>
                                <img src="images/ico4.png" class="pos-a" />
                                <i class="triangle pos-a"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(5,"1")%></span>
                                </p>
                            </div>
                            <div class="line-cn pos-r">
                                <span class="f115 c-ed7c0e">2015 (上半年) </span>
                                <img src="images/ico4.png" class="pos-a" />
                                <i class="triangle pos-a"></i>
                                <p class="pos-a number">
                                    <span class="f125 c-fff">￥<%=GetValue(6,"1")%></span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <img src="images/icon_up.png" class="arrow-up pt-page-moveIconUp" />
            </div>
            <!--第6页-->
            <div class="swiper-slide p6">
                <div class="text-cn">
                    <p class="f14 c-fff">
                        当前我的投资项目分布</p>
                </div>
                <div class="distribution pos-a">
                    <div class="dist-box pos-r">
                        <div class="dist1 ring pos-a animated bounceIn">
                            <div class="va-m">
                                <span>小微企业</span><span><%=GetProject("小微企业")%>%</span>
                            </div>
                        </div>
                        <div class="dist2 ring pos-a animated bounceIn">
                            <div class="va-m">
                                <span>其他</span><span><%=GetProject("其他")%>%</span>
                            </div>
                        </div>
                        <div class="dist3 ring pos-a animated bounceIn">
                            <div class="va-m">
                                <span>净股专区</span><span><%=GetProject("净股专区")%>%</span>
                            </div>
                        </div>
                        <div class="dist4 ring pos-a animated bounceIn">
                            <div class="va-m">
                                <span>证券宝</span><span><%=GetProject("证券宝")%>%</span>
                            </div>
                        </div>
                        <div class="dist5 ring pos-a animated bounceIn">
                            <div class="va-m">
                                <span>微团贷</span><span><%=GetProject("微团贷")%>%</span>
                            </div>
                        </div>
                        <div class="dist6 ring pos-a animated bounceIn">
                            <div class="va-m">
                                <span>分期宝</span><span><%=GetProject("分期宝")%>%</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="pic-box p6_1">
                    <img src="images/p6_1.png" /></div>
                <img src="images/icon_up.png" class="arrow-up pt-page-moveIconUp" />
            </div>
            <!--第7页-->
            <div class="swiper-slide p7">
                <div class="text-cn">
                    <p class="f13">
                        我的赚钱能力 <span class="f13 c-209f7d">(<%= interestBillInfo.ReturnIntegral %>分)</span></p>
                </div>
                <div class="due-in pos-a">
                    <p class="c-fff f13">
                        预期待收本息</p>
                    <p class="f13 number c-ff6c2c animated fadeIn">
                        <%=ToolStatus.ConvertLowerMoney(interestBillInfo.ReturnInMoney == null ? 0 : interestBillInfo.ReturnInMoney)%>元</p>
                </div>
                <div class="pic-box p7_1">
                    <img src="images/p7_1.png" /></div>
                <div class="pic-box p7_2 animated fadeInDown">
                    <img src="images/p7_2.png" /></div>
                <div class="pic-box p7_3">
                    <img src="images/p7_3.png" /></div>
                <div class="pic-box p7_4">
                    <img src="images/p7_4.png" /></div>
                <div class="pic-box p7_5 animated slideInUp">
                    <img src="images/p7_5.png" /></div>
                <img src="images/icon_up.png" class="arrow-up pt-page-moveIconUp" />
            </div>
            <!--第8页  -->
            <div class="swiper-slide p8">
                <div class="text-cn">
                    <p class="f14 c-fff">
                        我的人脉圏</p>
                    <p class="f14 c-3689a8">
                        共推荐<span class="c-ff6a2f f20"><%=interestBillInfo.ExtendCount%></span>位小伙伴</p>
                </div>
                <%if (interestBillInfo.ExtendCount == 1)
                  {%>
                <div class="invite1 pos-a">
                    <div class="invite-box box1 pos-r">
                        <div class="inv1 ring2 pos-a">
                            <div class="img-box ring3">
                                <img src="<%=interestBillInfo.HeadImage %>" />
                            </div>
                        </div>
                        <div class="pos-a inv2-box">
                            <div class="inv2 ring1">
                                <img src="<%=ExtendtList[0].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[0].ParaValue2 %></span>
                        </div>
                    </div>
                </div>
                <%}
                  else if (interestBillInfo.ExtendCount == 2)
                  {%>
                <div class="invite2 pos-a">
                    <div class="invite-box box2 pos-r">
                        <div class="inv1 ring2 pos-a">
                            <div class="img-box ring3">
                                <img src="<%=interestBillInfo.HeadImage %>" />
                            </div>
                        </div>
                        <div class="pos-a inv2-box">
                            <div class="inv2 ring1">
                                <img src="<%=ExtendtList[0].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[0].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv3-box">
                            <div class="inv3 ring1">
                                <img src="<%=ExtendtList[1].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[1].ParaValue2 %></span>
                        </div>
                    </div>
                </div>
                <%}
                  else if (interestBillInfo.ExtendCount == 3)
                  { %>
                <div class="invite3 pos-a">
                    <div class="invite-box box3 pos-r">
                        <div class="inv1 ring2 pos-a">
                            <div class="img-box ring3">
                                <img src="<%=interestBillInfo.HeadImage %>" />
                            </div>
                        </div>
                        <div class="pos-a inv2-box">
                            <div class="inv2 ring1">
                                <img src="<%=ExtendtList[0].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[0].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv3-box">
                            <div class="inv3 ring1">
                                <img src="<%=ExtendtList[1].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[1].ParaValue2%></span>
                        </div>
                        <div class="pos-a inv4-box">
                            <div class="inv4 ring1">
                                <img src="<%=ExtendtList[2].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[2].ParaValue2 %></span>
                        </div>
                    </div>
                </div>
                <%}
                  else if (interestBillInfo.ExtendCount == 4)
                  {%>
                <div class="invite4 pos-a">
                    <div class="invite-box box4 pos-r">
                        <div class="inv1 ring2 pos-a">
                            <div class="img-box ring3">
                                <img src="<%=interestBillInfo.HeadImage %>" />
                            </div>
                        </div>
                        <div class="pos-a inv2-box">
                            <div class="inv2 ring1">
                                <img src="<%=ExtendtList[0].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[0].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv3-box">
                            <div class="inv3 ring1">
                                <img src="<%=ExtendtList[1].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[1].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv4-box">
                            <div class="inv4 ring1">
                                <img src="<%=ExtendtList[2].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[2].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv5-box">
                            <div class="inv5 ring1">
                                <img src="<%=ExtendtList[3].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[3].ParaValue2 %></span>
                        </div>
                    </div>
                </div>
                <%}
                  else if (interestBillInfo.ExtendCount == 5)
                  {%>
                <div class="invite5 pos-a">
                    <div class="invite-box box5 pos-r">
                        <div class="inv1 ring2 pos-a">
                            <div class="img-box ring3">
                                <img src="<%=interestBillInfo.HeadImage %>" />
                            </div>
                        </div>
                        <div class="pos-a inv2-box">
                            <div class="inv2 ring1">
                                <img src="<%=ExtendtList[0].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[0].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv3-box">
                            <div class="inv3 ring1">
                                <img src="<%=ExtendtList[1].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[1].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv4-box">
                            <div class="inv4 ring1">
                                <img src="<%=ExtendtList[2].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[2].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv5-box">
                            <div class="inv5 ring1">
                                <img src="<%=ExtendtList[3].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[3].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv6-box">
                            <div class="inv6 ring1">
                                <img src="<%=ExtendtList[4].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[4].ParaValue2 %></span>
                        </div>
                    </div>
                </div>
                <%}
                  else if (interestBillInfo.ExtendCount == 6)
                  {%>
                <div class="invite6 pos-a">
                    <div class="invite-box box6 pos-r">
                        <div class="inv1 ring2 pos-a">
                            <div class="img-box ring3">
                                <img src="<%=interestBillInfo.HeadImage %>" />
                            </div>
                        </div>
                        <div class="pos-a inv2-box">
                            <div class="inv2 ring1">
                                <img src="<%=ExtendtList[0].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[0].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv3-box">
                            <div class="inv3 ring1">
                                <img src="<%=ExtendtList[1].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[1].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv4-box">
                            <div class="inv4 ring1">
                                <img src="<%=ExtendtList[2].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[2].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv5-box">
                            <div class="inv5 ring1">
                                <img src="<%=ExtendtList[3].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[3].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv6-box">
                            <div class="inv6 ring1">
                                <img src="<%=ExtendtList[4].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[4].ParaValue2 %></span>
                        </div>
                        <div class="pos-a inv7-box">
                            <div class="inv7 ring1">
                                <img src="<%=ExtendtList[5].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[5].ParaValue2 %></span>
                        </div>
                    </div>
                </div>
                <%}
                  else if (interestBillInfo.ExtendCount > 6)
                  {%>
                <div class="invite7 pos-a">
                    <div class="invite-box box7 pos-r">
                        <div class="inv1 ring2 pos-a">
                            <div class="img-box ring3">
                                <img src="<%=interestBillInfo.HeadImage %>" />
                            </div>
                        </div>
                        <div class="pos-a inv2-box">
                            <div class="inv2 ring1">
                                <img src="<%=ExtendtList[0].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[0].ParaValue2%></span>
                        </div>
                        <div class="pos-a inv3-box">
                            <div class="inv3 ring1">
                                <img src="<%=ExtendtList[1].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[1].ParaValue2%></span>
                        </div>
                        <div class="pos-a inv4-box">
                            <div class="inv4 ring1">
                                <img src="<%=ExtendtList[2].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[2].ParaValue2%></span>
                        </div>
                        <div class="pos-a inv5-box">
                            <div class="inv5 ring1">
                                <img src="<%=ExtendtList[3].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[3].ParaValue2%></span>
                        </div>
                        <div class="pos-a inv6-box">
                            <div class="inv6 ring1">
                                <img src="<%=ExtendtList[4].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[4].ParaValue2%></span>
                        </div>
                        <div class="pos-a inv7-box">
                            <div class="inv7 ring1">
                                <img src="<%=ExtendtList[5].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[5].ParaValue2%></span>
                        </div>
                        <div class="pos-a inv8-box">
                            <div class="inv8 ring1">
                                <img src="<%=ExtendtList[6].ParaValue4 %>" />
                            </div>
                            <span class="f08 c-31758e">
                                <%=ExtendtList[6].ParaValue2%></span>
                        </div>
                    </div>
                </div>
                <%}
                  else
                  {%>
                <!--没有邀请人的时候-->
                <div class="invite0 pos-a">
                    <div class="v0-c">
                        <img src="images/v0-c.png">
                    </div>
                </div>
                <%} %>
                <img src="images/icon_up.png" class="arrow-up pt-page-moveIconUp" />
            </div>
            <!--第9页-->
            <div class="swiper-slide p9">
                <div class="text-cn">
                    <p class="f14">
                        我的团贷颜值</p>
                </div>
                <div class="role-wrap pos-a">
                    <div class="role-box pos-r">
                        <div class="circle">
                            <div class="role-cn">
                                <img src="<%=image %>" />
                            </div>
                        </div>
                        <p class="role-name c-fff f13 pos-a">
                            <%=name %></p>
                    </div>
                    <p class="f12 c-d76806 mt20">
                        颜值已击败全国<span class="f13 c-d76806"><%=(int)interestBillInfo.TotalInMoneyPercent%>%</span>的用户</p>
                </div>
                <div class="pic-box p9_1">
                    <img src="images/p9_1.png" /></div>
                <div class="pic-box p9_2">
                    <img src="images/p9_2.png" /></div>
                <img src="images/icon_up.png" class="arrow-up pt-page-moveIconUp" />
            </div>
            <!--第10页-->
            <div class="swiper-slide p10">
                <div class="text-cn">
                    <p class="f14 c-fff">
                        十年后我将拥有</p>
                    <p class="f14 c-fff">
                        <span class="f13 c-ff6a2f">
                            <%=ToolStatus.ConvertLowerMoney(tenMoney)%></span>元</p>
                </div>
                <div class="pic-box p10_1 animated fadeIn">
                </div>
                <div class="full-pos p10_2">
                </div>
                <div class="full-pos p10_3">
                </div>
                <div class="full-pos p10_4">
                </div>
                <div class="full-pos p10_5">
                </div>
                <div class="full-pos p10_6">
                </div>
                <img src="images/icon_up.png" class="arrow-up pt-page-moveIconUp" />
            </div>
            <!--第11页-->
            <div class="swiper-slide p11">
                <div class="pic-box p11_1">
                </div>
                <div class="pic-box p11_2">
                </div>
                <div class="full-pos p11_3">
                </div>
                <div class="pic-box p11_4 animated fadeIn">
                </div>
                <div class="pic-box p11_5">
                </div>
                <div class="full-pos p11_6">
                </div>
                <%if (type == "wx")
                  { %>
                <a href="javascript:;" class="share f13 c-fff pos-a text-c" id="share_but">发给好友炫一下</a>
                <%}
                  else
                  {%>
                <a href="javascript:;" class="share f13 c-fff pos-a text-c" id="share_but" style="display: none">
                    发给好友炫一下</a>
                <%} %>
            </div>
        </div>
    </div>
    <!--音乐-->
    <div class="music">
        <i class="icon-music open" num="1"></i><i class="music-span"></i>
        <audio id="aud" src="images/music.mp3" loop="loop" autoplay="autoplay"></audio>
        <div class="music_text">
            开启</div>
    </div>
    <script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="js/swiper.min.js"></script>
    <script type="text/javascript" src="js/index.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1.0"></script>
</body>
</html>
