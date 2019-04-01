using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.CunGuanTong.Client;
using TuanDai.CunGuanTong.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.WXSystem.Core.Common;

namespace TuanDai.WXApiWeb.Member.cgt
{
    public partial class openCgt : UserPage
    {
        public UserBasicInfoInfo model;
        public string Href;
        protected string PreTelNo = "";//预留手机号
        public int iCardType = 1;
        protected string pageType = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            pageType = WEBRequest.GetQueryString("pageType");  
            if (!IsPostBack)
            {
                //Response.Redirect(GlobalUtils.WebURL+"/Member/Cgt/OpenCgt.aspx?pageType="+pageType);
                InitFormData();
            }
        }

        protected void InitFormData() {
            var userid = WebUserAuth.UserId.Value;
            if (userid != null && userid != Guid.Empty)
            {
                model = new UserBLL().GetUserBasicInfoModelById(userid);
            }
            else
            {
                Response.Redirect("/user/Login.aspx?ReturnUrl=/member/cgt/opencgt.aspx");
            }
            if (model == null)
            {
                model = new UserBasicInfoInfo();
                model.IsValidateIdentity = false;
            }

            GetCgtAccountStageResponse response = new CgtTool().CgtAccountStage(userid.ToString());
            if (response != null && response.status != 10100)
            {
                Response.Redirect("/Member/my_account.aspx");
            }
        }
    }
}