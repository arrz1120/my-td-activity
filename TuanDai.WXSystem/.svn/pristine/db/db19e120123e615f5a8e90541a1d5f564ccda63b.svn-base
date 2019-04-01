using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Linq;
using System.Collections;
using System.Text;
using BusinessDll;
using System.Data.Objects;
using System.Collections.Generic;
using System.Data.SqlClient;
using TuanDai.PortalSystem.DAL;
using Kamsoft.Data.Dapper;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Member.Bank
{
    public partial class account_lianlian_pay : UserPage
    {
        private static object lockstatus = new object();
        protected void Page_Load(object sender, EventArgs e)
        {
            Guid userid = WebUserAuth.UserId.Value;
           
            var bankmodel = new BankInfoBLL().GetBankInfoListByUserId(userid);
            if (bankmodel != null && bankmodel.Count > 0)
            {
                if (bankmodel.Any(p => p.Status == 2))
                {
                    
                    Response.Write("您好，银行卡在审核中不允许充值！");
                    ClientScript.RegisterStartupScript(this.GetType(), "ss", "<script>ShowMsg('您好，银行卡在审核中不允许充值！','1','确定');</script>");
                    return; 
                }
            } 

            decimal Amount = Tool.SafeConvert.ToDecimal(Request.Params["Amount"], 0);
            decimal tmpAmount= Math.Floor(Amount * 100)/100; 
            if (tmpAmount != Amount)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss", "<script>ShowMsg('充值金额最多只能2位小数，如106.32！','1','确定');</script>");
                return;
            }
            TuanDai.PortalSystem.Model.WebSettingInfo rechargeSet = new TuanDai.PortalSystem.DAL.WebSettingDAL().GetWebSettingInfo("9A89CBAE-6550-4EA1-8224-EB645F38F8FA");
            decimal minRecharge = decimal.Parse(rechargeSet.Param1Value);
            if (Amount < minRecharge)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss", "<script>ShowMsg('单次充值最少"+minRecharge.ToString("N2")+"元！','1','确定');</script>");
                return;
            }
            if (Amount > 500000)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss", "<script>ShowMsg('单次充值不能超过50万！','1','确定');</script>");
                return;
            }
            NoHandler noHandler = new NoHandler();
            string orderNo = noHandler.OnLineRechare();
            if (orderNo == "0")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss", "<script>ShowMsg('您好，您的提交失败请重试！','1','确定');</script>");
                return;
            }

            int Sel = Tool.SafeConvert.ToInt32(Request.Params["Sel"], 8);
            Guid rechargeId = Guid.NewGuid();
            int outStatus = 0;
            string bankcode = "";
            if (Request.Params["bankcode"] != null)
            {
                bankcode = Request.Params["bankcode"];
            }
            string userIP = Tool.WebFormHandler.GetIP();
            
            var paramData = new Dapper.DynamicParameters();
            paramData.Add("@userid", userid);
            paramData.Add("@type", Sel);
            paramData.Add("@amount", Amount);
            paramData.Add("@orderNo", orderNo);
            paramData.Add("@backcode", bankcode);
            paramData.Add("@clientIp", userIP);
            paramData.Add("@from", "5");
            paramData.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, "AccountRechargeInit", ref paramData, CommandType.StoredProcedure);
            outStatus = paramData.Get<int>("@outStatus");
            
            int result = outStatus;
            if (result > 0)
            {
                lock (lockstatus)
                {
                    if (UpdateAccountRechare(5, orderNo) <= 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "ss", "<script>ShowMsg('您好，您的提交失败请重试！','1','确定');</script>");
                        return;
                    }

                    Response.Redirect("/PaymentPlatform/lianlian/plainPay.aspx?orderno=" + orderNo + "&totalprice=" + Amount + "&bankcode=" + bankcode);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss", "<script>ShowMsg('您好，您的提交失败请重试！','1','确定');</script>");
            }
        }

        public class AccountRechareInfo
        {
            public string TranOrder { get; set; }
            public byte? From { get; set; }
        }

        private AccountRechareInfo getAccountRechare(string TranOrder)
        {
            AccountRechareInfo model = null;
            
            string strSQL = " select TranOrder,[From] from AccountRechare WITH(NOLOCK) WHERE TranOrder=@TranOrder";
            var paramData = new Dapper.DynamicParameters();
            paramData.Add("@TranOrder", TranOrder);
            model = PublicConn.QuerySingle<AccountRechareInfo>(strSQL, ref paramData);
            
            return model;
        } 
        

        private int UpdateAccountRechare(byte? From, string TranOrder)
        {
            int result = 0;

            string strSQL = " Update AccountRechare Set" +
                            " [From]=@From WHERE TranOrder=@TranOrder";
            var paramData = new Dapper.DynamicParameters();
            paramData.Add("@From", From);
            paramData.Add("@TranOrder", TranOrder);
            result = PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, strSQL, ref paramData);
            return result;
        }
    }
}