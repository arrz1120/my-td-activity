using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    public partial class my_payment :UserPage
    {
        protected Guid UserId;
        protected UserBasicInfoInfo userModel;
        protected void Page_Load(object sender, EventArgs e)
        {
            UserId = WebUserAuth.UserId.Value;
            if (!this.IsPostBack)
            {
                userModel = new UserBLL().GetUserBasicInfoModelById(UserId);
            }
        }

        protected decimal GetMoney(decimal money)
        {
            decimal ss = Tool.SafeConvert.ToDecimal(money.ToString().IndexOf(".").ToString().Substring(2, 2));
            if (ss > 0)
            {
                ss = 0.01M;
            }
            return ss;
        }
    }
}