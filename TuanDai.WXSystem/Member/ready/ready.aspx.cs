using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Member.ready
{
    public partial class ready : UserPage
    {
        /// <summary>
        /// 是否验证身份信息
        /// </summary>
        protected bool IsIdentity = false;
        /// <summary>
        /// 是否绑定银行卡
        /// </summary>
        protected bool IsBankCard = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Guid userId = WebUserAuth.UserId.Value;
                if (userId == Guid.Empty || userId == null)
                {
                    Response.Redirect("/user/Login.aspx?ReturnUrl=" + Request.RawUrl, true);
                }
                else
                {
                    var model = new UserBLL().GetUserBasicInfoModelById(userId);
                    IsIdentity = model.IsValidateIdentity;
                    if (!string.IsNullOrEmpty(model.BankAccountNo))
                    {
                        IsBankCard = true;
                    }
                    else
                    {
                        if (GlobalUtils.IsOpenCGT)
                        {
                            var bankInfo = GlobalUtils.GetBankInfo(userId);
                            if (!string.IsNullOrEmpty(bankInfo.BankNo))
                            {
                                IsBankCard = true;
                            }
                        }
                        else
                        {
                            string sql = @"SELECT BankNo FROM UserBankInfo WITH(NOLOCK) WHERE UserId = @UserId ";
                            var para = new Dapper.DynamicParameters();
                            para.Add("@UserId", userId);
                            var cardNo = PublicConn.QuerySingle<string>(sql, ref para);
                            if (!string.IsNullOrEmpty(cardNo))
                            {
                                IsBankCard = true;
                            } 
                        }
                    }
                }
            }
        }
    }
}