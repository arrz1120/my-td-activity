using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb
{
    public partial class ReadyForStock : BasePage
    {
        
        protected Guid UserId;
        protected bool completeValid = false;
        protected string msg = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/my_account.aspx");
            if (!IsPostBack)
            {
                UserId = WebUserAuth.UserId ?? Guid.Empty;
                if (UserId != Guid.Empty)
                {

                    UserBasicInfoInfo model = new UserBLL().GetUserBasicInfoModelById(UserId);
                    if (model == null)
                        return;
                    if (model.IsValidateEmail && model.IsValidateIdentity && model.IsValidateMobile && !string.IsNullOrEmpty(model.BankAccountNo))
                    {
                        completeValid = true;
                    }
                    if (!model.IsValidateEmail)
                    {
                        msg =(msg==""?"":"、")+"邮箱认证";
                    }
                    if (!model.IsValidateMobile)
                    {
                        msg = (msg == "" ? "" : "、") + "手机认证";
                    }
                    if (!model.IsValidateIdentity)
                    {
                        msg = (msg == "" ? "" : "、") + "实名认证";
                    }
                    if (string.IsNullOrEmpty(model.BankAccountNo))
                    {
                        msg = (msg == "" ? "" : "、") + "绑定银行卡";
                    }
                }
            }
        }
    }
}