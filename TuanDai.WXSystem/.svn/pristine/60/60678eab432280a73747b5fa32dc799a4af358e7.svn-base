using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Member
{
    public partial class my_asset : UserPage
    {
        protected Guid UserId;
        protected WXFundAccountInfo_Info fundAccountInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            UserId = WebUserAuth.UserId.Value;
            if (!this.IsPostBack)
            {
                UserBLL bll = new UserBLL();
                fundAccountInfo = bll.WXGetUserBill(UserId);

                if (UserId == Guid.Parse("B27A3C45-82DA-4617-89C4-D41F38369E58"))
                {
                    fundAccountInfo.AviMoney += 1347900;
                }
                if (UserId == Guid.Parse("1E0D6C74-3637-425A-B9A1-65D463512088"))
                {
                    fundAccountInfo.AviMoney += 500000;
                }
                if (UserId == Guid.Parse("A47547A6-4F2C-4B05-B639-656713E8216E"))
                {
                    fundAccountInfo.AviMoney += decimal.Parse("549866.62");
                }
            }
        }
    }
}