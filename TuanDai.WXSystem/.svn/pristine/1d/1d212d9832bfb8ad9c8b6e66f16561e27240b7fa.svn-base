using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.News.Client;
using TuanDai.News.Contract;


namespace TuanDai.WXApiWeb.pages.helpCenter
{
    public partial class helpDetail : BasePage
    {
        protected int NewsId = -1;
        protected WXHelpDetialInfo model = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            NewsId = WEBRequest.GetQueryInt("id", 0);
            string action = WEBRequest.GetQueryString("action");
            if (action == "feedback")
            {
                UpdateHelpTopStepNum();
            }
            else
            {
                if (!IsPostBack)
                {
                    BinderData();
                }
            }
        }

        protected void BinderData()
        {
            //从APP跳转过来不显示导航条
            string strType = Tool.CookieHelper.GetCookie("HelpCenterType").ToText();
            if (strType.ToLower() == "mobileapp") {
                IsShowRightBar = false;
            }

            model = WXHelpService.GetDetailInfoById(NewsId);
            if (model == null)
            {
                Response.Redirect("helpIndex.aspx");
                return;
            }
            //异步更新浏览记录
            Action doAction = new Action(delegate()
            {
                UpdateClickNumber(NewsId);
            });
            doAction.BeginInvoke(null, null);
        }

        private void UpdateClickNumber(int newsId)
        {
            WXHelpService.UpdateClickNumber(NewsId); 
        }

        protected void UpdateHelpTopStepNum()
        {
            int reqId = WEBRequest.GetQueryInt("id", 0);
            string feedback = WEBRequest.GetQueryString("feedtype");

            WXHelpService.UpdateHelpTopStepNum(reqId, feedback);

            var jsonObj = new { result = "1", msg = "" };
            var jsonString = TuanDai.WXSystem.Core.JsonHelper.ToJson(jsonObj);
            this.Context.Response.Write(jsonString);
            this.Context.Response.End();
        }


    }
}