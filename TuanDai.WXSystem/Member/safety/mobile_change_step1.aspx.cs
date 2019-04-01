using System;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class mobile_change_step1 : BasePage
    {
        protected string TelNo;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                Response.Redirect("//m.tuandai.com/pages/downOpenApp.aspx", true);
                return;
                string t = Request.QueryString["t"];
                string s = Request.QueryString["s"];
                //Response.Redirect(GlobalUtils.WebURL + "/Member/safety/mobile_change_step1.aspx?t="+t+"&s="+s);
                if (Tool.DESC.HexToString(s) != t)
                {
                    Response.Redirect("mobile_change.aspx");
                }
            }
        }
    }
}