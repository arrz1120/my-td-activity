using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb
{
    public partial class ErrorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string GetNavStr()
        {
            string str = "";
            str += "<div class=\"wb-fix cm-loading show\" id=\"cMloading\">" +
                    "<p class=\"load\"><img src=\"/imgs/loading02.gif\" width=\"40\" height=\"40\" alt=\"\"></p>" +
                    "</div>";


            str += "<!-----底部跳转按钮---->" +
                  "<div class='float-jump'>" +
                  "	  <a href='" + (GlobalUtils.IsWeiXinBrowser ? "/WeiXinIndex.aspx" : "/Index.aspx") + "'><img src='/imgs/images/icon/ico_toHome.png'/></a>";
            if (Request.RawUrl.ToLower().IndexOf("/member/my_account.aspx") == -1)
                str += "   <a href='/Member/my_account.aspx'><img src='/imgs/images/icon/ico_toAccount.png'/></a>";
            str += "</div>";
            return str;
        }
    }
}