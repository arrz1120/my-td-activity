using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Activity.inviteGetgift
{
    public partial class Index : BasePage
    {
        protected bool IsLogin = false;
        protected string ExtendKey = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["key"]))
                {
                    if (WebUserAuth.IsAuthenticated)
                    {
                        Guid userId = WebUserAuth.UserId.Value;
                        UserBasicInfoInfo userModel = new UserBLL().GetUserBasicInfoModelById(userId);
                        ExtendKey = userModel.ExtendKey;
                        IsLogin = true;
                        if (ExtendKey == Request.QueryString["key"])
                        {
                            return;
                        }
                        else
                        {
                            Response.Redirect("Index.aspx?key=" + ExtendKey);
                        }
                    }
                    else
                    {
                        Response.Redirect("register.aspx?ExtendKey=" + Request.QueryString["key"]);
                    }
                }
                if (WebUserAuth.IsAuthenticated)
                {
                    IsLogin = true;
                    if(string.IsNullOrEmpty(Request.QueryString["key"])){
                        Guid userId = WebUserAuth.UserId.Value;
                        UserBasicInfoInfo userModel = new UserBLL().GetUserBasicInfoModelById(userId); 
                        ExtendKey = userModel.ExtendKey;
                        Response.Redirect("Index.aspx?key=" + ExtendKey);
                    }
                }
            }
        }
    }
}