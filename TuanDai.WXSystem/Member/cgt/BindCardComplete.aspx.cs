using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.CunGuanTong.Client;
using TuanDai.CunGuanTong.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.WXSystem.Core.Common;
using TuanDai.WXSystem.Core.models;

namespace TuanDai.WXApiWeb.Member.cgt
{
    /// <summary>
    /// 完善银行卡信息
    /// Allen 2016-12-22
    /// </summary>
    public partial class BindCardComplete : UserPage
    {
        protected Guid UserId = Guid.Empty;
        protected List<T_ProvinceInfo> provincelist;
        protected List<T_CityInfo> citylist;

        protected string bankNo = "";
        protected string BankName = "";
        protected string PreTelNo = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            UserId = WebUserAuth.UserId.Value;
            if (!IsPostBack)
            {
                BinderCity();
                GetUserBankInfo();
            }
        }

        protected void BinderCity()
        {
            provincelist = new T_ProvinceBLL().GetProvinceList();

            T_ProvinceInfo promodel = provincelist.FirstOrDefault();
            citylist = new T_ProvinceBLL().GetCityListByProId(promodel.ProID);
        }
        protected void GetUserBankInfo()
        {
            if (GlobalUtils.IsBankService)
            {
                var bankInfoFromJava = new BankFromJavaService().GetBankInfo(UserId, ServiceType.TuoMin);
                if (bankInfoFromJava != null && bankInfoFromJava.respData != null)
                {
                    bankNo = bankInfoFromJava.respData.bankNo;
                    BankName = bankInfoFromJava.respData.bankName;
                    PreTelNo = bankInfoFromJava.respData.mobileNo;
                }
                else
                {
                    Response.Redirect("/Member/cgt/cgtBindCard.aspx");
                }
            }
            else
            {
                string strSQL = " SELECT BankAccountNo ,BankType FROM dbo.UserBasicInfo WITH(NOLOCK) where Id=@userId ";
                var dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@userId", UserId);
                var bankModel = PublicConn.QuerySingle<BankNoInfo>(strSQL, ref dyParams);
                if (bankModel == null)
                {
                    bankModel = new BankNoInfo() { };
                }
                bankNo = bankModel.BankAccountNo;
                GlobalUtils.GetBankImg(UserId, out BankName);
                cgt_user_UserExt_Info cgtUser = new QueryClient().GetUserByPlatformUserNo(UserId);
                if (cgtUser != null)
                {
                    PreTelNo = cgtUser.mobile;
                }
            }
        }
        public class BankNoInfo
        {
            public string BankAccountNo { get; set; }
            public int BankType { get; set; }
        }
    }
}