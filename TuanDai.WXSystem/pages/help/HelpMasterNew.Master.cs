using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.pages.help
{
    public partial class HelpMasterNew : System.Web.UI.MasterPage
    {
        protected string Title { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (Control ctrl in this.head.Controls)
            {
                if (ctrl is HtmlGenericControl && (ctrl as HtmlGenericControl).TagName == "title")
                {
                    Title = (ctrl as HtmlGenericControl).InnerText;
                }
            }
        }


        #region 导航样式
        protected string GetNavStr()
        {
            string str = "";
            str += "<div class=\"list-nav\">";
            str += "<div class='pos-r list-nav-cn'>";
            str += "<b class='ico-sj pos-a'></b>";
            str += "<div class='j-but pos-a'>";
            str += "    <a class=\"i-1\" href=\"" + (GlobalUtils.IsWeiXinBrowser ? "/WeiXinIndex.aspx" : "/Index.aspx") + "\">首页</a>";
            str += "    <a class=\"i-2\" href=\"/pages/invest/invest_list.aspx\">投资专区</a>";
            str += "    <a class=\"i-3\" href=\"/pages/loan/borrowMoney.aspx\">借款服务</a>";
            if (WebUserAuth.IsAuthenticated)
            {
                str += "    <a class=\"i-4\" href=\"/Member/my_account.aspx\">个人中心</a>";
            }
            else
            {
                str += "    <a class=\"i-5\" href=\"/user/Login.aspx\">登录注册</a>";
            }
            str += "  </div></div></div>\r\n";
            str += "<div class=\"layer\"></div>";
            return str;
        }
        protected string GetNavIcon()
        {
            return "<a href=\"javascript:void(0);\" class=\"header-list-icon\">" +
                   "  <img src=\"/imgs/images/header-list-icon01.png\">" +
                   "</a>";
        }
        #endregion
    }
}