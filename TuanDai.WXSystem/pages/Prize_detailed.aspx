<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="Prize_detailed.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.Prize_detailed" %>

<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
     <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>奖品详情</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/app-prize.css" />
</head>
<body>
<header><a href="#" class="back" onClick="javascript :history.back(-1);"></a>奖品详情</header>
        <!--判断奖品详情是否存在-->
    <%if (this.Model == null)
      {
        %>
        <div style="text-align:center;display:block;font-size:12px;color:red">奖品详情不存在!</div>
        <!--存在-->
    <%
      }else{ %>
<div class="prizeDetail">

<section class="flexslider" id="prizeimgSlider">
  <ul class="slides">
    <li><img src="<%=this.Model.ImageUrl %>"></li>
  </ul>
</section>

<section class="prize_infobox pl20">
    <div class="prize_info pt10">
        <div class="c-212121 f16px pb10"><%=this.Model.ProductName %></div>
        <div class="c-fd6040 f20px pb5">￥<%=this.Model.MarketPrice %></div>
        <div class="pb10 c-ababab f12px">备注：<%=this.Model.Remark %></div>
    </div>
    <p><a href="<%=this.Model.ActivityUrl %>">活动：<%=this.Model.ActivityName %><i><img src="/imgs/App/smb-que-ico.png" /></i></a></p>
</section>

<section class="prize_title c-212121 f13px">奖品信息</section>

<section class="prize_detailbox">
    <%=this.Model.Description %>
   <%-- <img src="/imgs/prize/prize_detail_01.jpg">
    <img src="/imgs/prize/prize_detail_02.jpg">
    <img src="/imgs/prize/prize_detail_03.jpg">--%>
</section>
<section class="prize_title c-212121 f13px"><%=this.Model.ActivityName %>其他奖品</section>
    <% if(this.Model.OtherPrizes!=null){ 
           int _rowCount=0;
           if (this.Model.OtherPrizes.Count % 3 == 0)
           {
               _rowCount = this.Model.OtherPrizes.Count / 3;
           }else{
               _rowCount = this.Model.OtherPrizes.Count / 3 + 1;
           }
           %>
        <section class="prize_otherbox clearfix">
        <div class="prize_other clearfix">
          <div class="prizesliderbox">
              <div class="flexslider prizeSlider">
                  <ul class="slides" id="slides_img">
                      <!--循环显示页数-->
                      <%for(int idx=0;idx<_rowCount;idx++){ %>
                               <li>
                                <div class="prizebox clearfix">
                                <%if (((idx) * 3) < this.Model.OtherPrizes.Count)
                                  { %><dl><dt><img src="<%=this.Model.OtherPrizes[idx*3].ImageUrl %>"></dt><dd><%=this.Model.OtherPrizes[idx*3].ProductName %></dd></dl><%} %>
                                <%if (((idx) * 3 + 1) < this.Model.OtherPrizes.Count)
                                  { %><dl><dt><img src="<%=this.Model.OtherPrizes[idx*3+1].ImageUrl %>"></dt><dd><%=this.Model.OtherPrizes[idx*3+1].ProductName %></dd></dl><%} %>
                                <%if (((idx) * 3 + 2) < this.Model.OtherPrizes.Count)
                                  { %><dl class="lastprize"><dt><img src="<%=this.Model.OtherPrizes[idx*3+2].ImageUrl %>"></dt><dd><%=this.Model.OtherPrizes[idx*3+2].ProductName %></dd></dl><%} %>
                        </div>
                    </li>
                      <%} %>
                      <!--循环显示页数结束-->
                  </ul>
                </div>
          </div>
      </div>
    </section>
        <%} %>
</div>
    <%} %>
</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.flexslider.js"></script>
<script type="text/javascript">
    $(function () {
        //banner滑动
        $('#prizeimgSlider').flexslider({
            animation: "slide",
            directionNav: false,
        });
        //理财滑动
        $('.prizeSlider').flexslider({
            animation: "slide",
            directionNav: false,
            slideshow: false,
            itemMargin: 10,
            animationLoop: false,
        });

        setTimeout(function () {
            var imgWindth = $('#slides_img li img').eq(0).width();
            $('#slides_img li img').css('height', imgWindth + 'px');
        }, 100)

    });

</script>

</html>
