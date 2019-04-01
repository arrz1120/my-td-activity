using Kamsoft.Data.Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.WXSystem.Core;

namespace TuanDai.WXApiWeb.Member.safety
{
    /// <summary>
    /// 提现时绑定录入地址界面
    /// Allen 2016-01-27
    /// </summary>
    public partial class binding_cardaddress : UserPage
    {
        protected Guid UserId;
        protected BankNoInfo bankModel;
        protected string BankHotLine = "4006410888";
        protected string BankName = "团贷网";
        protected List<T_ProvinceInfo> provincelist;
        protected List<T_CityInfo> citylist;
        protected string jsonStr;
        protected FormPostData formObj;
        protected void Page_Load(object sender, EventArgs e)
        {
            jsonStr = WEBRequest.GetFormString("jsondata");
            formObj = JsonHelper.ToObject<FormPostData>(jsonStr);

            UserId = WebUserAuth.UserId.Value;
            if (!IsPostBack) {
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
            //using (SqlConnection connection = TuanDai.PortalSystem.DAL.PubConstant.CrateReadConnection())
            //{
            string strSQL = " select BankNo as BankAccountNo, BankType from dbo.UserBankInfo where userid=@userId ";
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@userId", UserId);
            bankModel = PublicConn.QuerySingle<BankNoInfo>(strSQL, ref dyParams);
            if (bankModel == null)
            {
                bankModel = new BankNoInfo() { };
            }
            switch (bankModel.BankType) { 
                case 3:
                    BankHotLine = "95588";
                    BankName = "工商银行";
                    break;
                case 4:
                    BankHotLine = "95533";
                    BankName = "建设银行";
                    break;
                case 2:
                    BankHotLine = "95566";
                    BankName = "中国银行";
                    break;
                case 5:
                    BankHotLine = "95599";
                    BankName = "农业银行";
                    break;
                case 1:
                    BankHotLine = "95555";
                    BankName = "招商银行";
                    break;
                case 10:
                    BankHotLine = "95595";
                    BankName = "光大银行";
                    break;
                case 7:
                    BankHotLine = "95528";
                    BankName = "浦发银行";
                    break;
                case 15:
                    BankHotLine = "95511";
                    BankName = "平安银行";
                    break;
            } 
            //}
        } 
    }

    public class BankNoInfo
    {
        public string BankAccountNo { get; set; }
        public int BankType { get; set; } 
    }
    public class FormPostData
    {
        public decimal Amount { get; set; }
        public decimal CouponAmount { get; set; }
        //提现类型
        public int DrawType { get; set; }
    }
}