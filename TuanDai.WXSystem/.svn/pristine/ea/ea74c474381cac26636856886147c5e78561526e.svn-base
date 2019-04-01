using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using System.Data.SqlClient;
using Dapper;
using TuanDai.PortalSystem.DAL;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class safety : UserPage
    {
        protected string BankAccountNo = string.Empty;
        protected UserBasicInfoInfo userModel;
        protected Guid userId;
        protected bool? IsTenderNeedPayPassword = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            userId = WebUserAuth.UserId.Value;
            UserBLL bll = new UserBLL();
            if (!this.IsPostBack)
            {

                userModel = bll.GetUserBasicInfoModelById(userId);
                if (userModel != null)
                    BankAccountNo = userModel.BankAccountNo;
                UserSettingInfo UserSetting = new UserSettingBLL().GetUserSettingInfo(userId);
                
                if (UserSetting != null)
                {
                    IsTenderNeedPayPassword = UserSetting.IsTenderNeedPayPassword;
                }
                if (string.IsNullOrEmpty(BankAccountNo))
                {
                    //string sql = @"SELECT BankNo FROM UserBankInfo WITH(NOLOCK) WHERE UserId = @UserId ";
                    //var para = new Dapper.DynamicParameters();
                    //para.Add("@UserId", userId);
                    //BankAccountNo = PublicConn.QuerySingle<string>(sql, ref para);
                    var bankInfo= GlobalUtils.GetBankInfo(userId);
                    BankAccountNo = bankInfo.BankNo;
                }
            }
        }
    }
}