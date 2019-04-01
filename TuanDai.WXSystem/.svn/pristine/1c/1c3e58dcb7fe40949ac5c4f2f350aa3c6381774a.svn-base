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
using TuanDai.WXSystem.Core.models;

namespace TuanDai.WXApiWeb.Member.cgt
{
    public partial class cgtBindCard : UserPage
    {
        public UserBasicInfoInfo model;
        public string Href;
        protected string PreTelNo = "";//预留手机号
        public int iCardType = 1;
        protected WXResponsePublicInfo<WXResponseSelectBankInfoChild> bankInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("https://m.tuandai.com", true);
            //未开通存管时还是跳之前界面
            if (!GlobalUtils.IsOpenCGT) {
                Response.Redirect("/member/safety/bindBankCardNew.aspx");
                return;
            }
            if (!IsPostBack)
            {
                //Response.Redirect(GlobalUtils.WebURL+"/Member/cgt/cgtBindCard.aspx");
                InitFormData();
            }
        }

        protected void InitFormData()
        {
            var userid = WebUserAuth.UserId.Value;
            if (userid != null && userid != Guid.Empty)
            {
                model = new UserBLL().GetUserBasicInfoModelById(userid);
            }
            if (model == null)
            {
                model = new UserBasicInfoInfo();
                model.IsValidateIdentity = false;
            }

            cgt_user_UserExt_Info cgtUser = new QueryClient().GetUserByPlatformUserNo(userid);
            if (cgtUser != null)
            {
                PreTelNo = cgtUser.mobile;

                //1.身份证 2.港澳台同胞回乡证 3.外国人永久居留证 4.护照
                if (cgtUser.idCardType.Value != 0)
                    iCardType = cgtUser.idCardType.Value;
            }
            if (GlobalUtils.IsBankService)
            {
                WXResponsePublicInfo<WXResponseSelectBankInfoChild> bankInfo =
                    new BankFromJavaService().GetBankInfo(userid, ServiceType.TuoMin);
                if (bankInfo != null && !string.IsNullOrEmpty(bankInfo.respData.bankNo))
                {
                    Response.Redirect("/member/bank/bankInfo.aspx");
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(model.BankAccountNo))
                {
                    Response.Redirect("/member/bank/bankInfo.aspx");
                }
            }
        }

    }
}