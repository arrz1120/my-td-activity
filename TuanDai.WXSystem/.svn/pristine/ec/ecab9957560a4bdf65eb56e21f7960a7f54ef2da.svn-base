<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="Xmb_detail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.App.Xmb_detail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>项目详情</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/app-xiangmubao.css" />
</head>
<body>
    <div class="smbDetail">
        <%if (mPageModel.mProject_XMB.Type == 1)
          {%>
        <section class="smb_sec mt20 mb20">
            <p class="tit_txt"><i></i>借款详情</p>
            <div class="md_wraper">
                <h4 class="tit_black">投资范围：</h4>
                <p><%=mPageModel.mProject_XMB.InvestRange%></p>
            </div>
            <div class="md_wraper">
                <h4 class="tit_black">投资亮点：</h4>
                <p><%=mPageModel.mProject_XMB.InvestHighlight%></p>
            </div>
            <div class="md_wraper">
                <h4 class="tit_black">盈利预期：</h4>
                <p><%=mPageModel.mProject_XMB.ProfitBudget%></p>
            </div>
            <div class="md_wraper last-md">
                <h4 class="tit_black">还款保障：</h4>
                <p><%=mPageModel.mProject_XMB.RepaymentSecurity%></p>
            </div>
        </section>

        <section class="smb_sec mb20">
            <p class="tit_txt"><i></i>管理机构</p>
            <div class="md_wraper">
                <h4 class="tit_black">管理机构：</h4>
                <p><%=mPageModel.mProject_XMB.DepositOrgDesc%></p>
            </div>
            <div class="md_wraper last-md">
                <h4 class="tit_black">管理团队：</h4>
                <p><%=mPageModel.mProject_XMB.DepositTeam%></p>
            </div>
        </section>
        <%}
          else
          { %>
        <section class="smb_sec mb20">
            <p class="tit_txt"><i></i>借款详情</p>
            <div class="md_wraper">
                <h4 class="tit_black">资料展示：</h4>
                <div class="wrap">
                    <div class="nav swipable">
                        <%foreach (var item in mPageModel.listProjectImage)
                          {%>
                        <a href="myapp://imgurl?url=<%=item.LargeImg %>"><span>
                            <img src="<%=item.SmallImg %>" /></span></a>
                        <%  } %>
                    </div>
                </div>
            </div>

            <div class="md_wraper">
                <h4 class="tit_black">资金用途：</h4>
                <p><%=mPageModel.mProject_XMB.AmountUsedDesc%></p>
            </div>
            <div class="md_wraper">
                <h4 class="tit_black">项目简介：</h4>
                <p><%=mPageModel.mProject_XMB.ProjectDescription%></p>
            </div>
            <div class="md_wraper">
                <h4 class="tit_black">项目前景：</h4>
                <p><%=mPageModel.mProject_XMB.ProjectProspect%></p>
            </div>
            <div class="md_wraper">
                <h4 class="tit_black">盈利预测：</h4>
                <p><%=mPageModel.mProject_XMB.ProfitBudget%></p>
            </div>
            <div class="md_wraper last-md">
                <h4 class="tit_black">还款保障：</h4>
                <p><%=mPageModel.mProject_XMB.RepaymentSecurity%></p>
            </div>
        </section>
        <%} %>

        <section class="smb_sec mb20  timeline">
            <p class="tit_txt"><i></i>项目进展</p>
            <%if (mPageModel.listProjectProgress.Count > 0)
              {
                  int i = 1;
                  int j = mPageModel.listProjectProgress.Count();
                  foreach (var item in mPageModel.listProjectProgress)
                  {
            %>
            <div class='<%=i==1?"time_cur":(i!=j?"time_normal":"time_normal last-time")%>'>
                <div class="time_bg"></div>
                <div class="time-con">
                    <p class="time"><%=item.ProgressDate.ToString("yyyy-MM-dd")%></p>
                    <p class="detail"><%=item.Desc%></p>
                    <div class="wrap">
                        <div class="nav swipable">
                            <%foreach (var itemB in item.listProjectProgressImage)
                              {%>
                            <a href="myapp://imgurl?url=<%=itemB.MaxImageUrl %>"><span>
                                <img src="<%=itemB.MinImageUrl %>" /></span></a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <%i++;
                  }
              } %>
        </section>

        <section class="smb_que pl20">
            <p><a href="http://m.tuandai.com/pages/app/help/xmb_what.html">什么是项目宝<i><img src="/imgs/App/smb-que-ico.png" /></i></a></p>
            <p><a href="http://m.tuandai.com/pages/app/help/xmb_question.html">常见问题<i><img src="/imgs/App/smb-que-ico.png" /></i></a></p>
            <p><a href="InvistInfo">投资记录<i><img src="/imgs/App/smb-que-ico.png" /></i></a></p>
        </section>
    </div>
    <!--大图显示层-->
    <div id="img_wraper">
        <img src="" id="big-img">
    </div>

</body>
<script src="/scripts/zepto.js"></script>
<script src="/scripts/widget.1.0.2.js"></script>
<script src="/scripts/swipable.1.0.0.js"></script>
<script type="text/javascript">
    var allWrap = $('.wrap');
    for (var i = 0; i < allWrap.length; i++) {
        if ($(allWrap[i]).find('span').length > 4) {
            $(allWrap[i]).attr('id', 'wrap_' + i);
            var swipable = new Swipable({
                element: '#wrap_' + i,
                dir: 'horizontal'
            });
        }
    }
</script>
</html>
