using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Activity.ExpGold
{
    public partial class Register : System.Web.UI.Page
    {
        protected string tdFrom = "";
        protected int UserCount = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tdFrom = Request.QueryString["tdFrom"] == null ? "" : Request.QueryString["tdFrom"];
                LoadData();
            }
        }

        protected void LoadData() {
            try
            {
                WebSiteDataInfo websitedatemodel = new WebSiteDataBLL().GetWebSiteData();
                if (websitedatemodel != null)
                {
                    this.UserCount = websitedatemodel.TotalUser ?? 0;
                } 
            }
            catch (Exception ex) {
                UserCount = 2021679;
            }
        }
    }
}