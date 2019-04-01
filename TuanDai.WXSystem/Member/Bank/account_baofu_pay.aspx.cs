using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessDll;
using System.Data.Objects;
using System.Data.SqlClient;
using TuanDai.PortalSystem.DAL;
using Kamsoft.Data.Dapper;
using System.Data;

namespace TuanDai.WXApiWeb.Member.Bank
{
    public partial class account_baofu_pay : System.Web.UI.Page
    {
        private object lockstatus = new object();
        protected void Page_Load(object sender, EventArgs e)
        {
            Guid userid = WebUserAuth.UserId.Value;

            decimal Amount = Tool.SafeConvert.ToDecimal(Request.Params["Amount"], 0);
            //if (Amount < 100)
            //{
            //    Response.Write("您好，充值金额必须大于或者等于100！");
            //    return;
            //}

            if (Amount > 5000000)
            {
                Response.Write("单次充值不能超过500万！");
                return;
            }


            NoHandler noHandler = new NoHandler();
            string orderNo = noHandler.OnLineRechare();
            if (orderNo == "0")
            {
                Response.Write("您好，您的提交失败请重试！");
                return;
            }

            int Sel = Tool.SafeConvert.ToInt32(Request.Params["Sel"], 12);
            Guid rechargeId = Guid.NewGuid();
            int outStatus = 0;

            //string bankcode = "";
            //bankcode = Request.Params["bankcode"];
            ////if (Request.Params["bankcode"] != null)
            ////{

            ////}

            //if (string.IsNullOrEmpty(bankcode))
            //{
            //    Response.Write("您好，银行编号获取错误！" + Request.QueryString["bankcode"]);
            //    return;
            //}

            string userIP = Tool.WebFormHandler.GetIP();
            
                var paramData = new Dapper.DynamicParameters();
                paramData.Add("@userid", userid);
                paramData.Add("@type", Sel);
                paramData.Add("@amount", Amount);
                paramData.Add("@orderNo", orderNo);
                paramData.Add("@backcode", "");
                paramData.Add("@clientIp", userIP);
                paramData.Add("@from", "5");
                paramData.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            TuanDai.WXApiWeb.PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, "AccountRechargeInit",
                ref paramData, CommandType.StoredProcedure);
            outStatus = paramData.Get<int>("@outStatus");
            
            int result = outStatus;

            //NetLog.WriteLoginHandler("宝付5-调用写入充值记录存储过AccountRechargeInit", "UserId:"+userid+",Sel:"+Sel+",Amount:"+Amount+",OrderNo:"+orderNo+",bankcode:"+bankcode+",OutStatus:"+outStatus.Value.ToString());
            if (result > 0)
            {
                //NetLog.WriteLoginHandler("宝付6","进入写入来源" );
                AccountRechareInfo ar = null;
                lock (lockstatus)
                {
                    ar = getAccountRechare(orderNo);
                }
                //1:PC
                if (null == ar)
                {
                    Response.Write("您好，您的提交失败请重试！");
                }

                ar.From = 5;
                //ar.CradNo = db.UserBasicInfo.FirstOrDefault(x => x.Id == userid).BankAccountNo;

                if (UpdateAccountRechare(ar) <= 0)
                {
                    Response.Write("您好，您的提交失败请重试！");
                    return;
                }

                //NetLog.WriteLoginHandler("宝付7", "进入跳转");
                var url = "/PaymentPlatform/Baofu/pay_post.aspx?orderno=" + orderNo + "&totalprice=" + Amount + "&PayID=";
                //NetLog.WriteLoginHandler("宝付8--跳转的URL", url);
                try
                {
                    Response.Redirect(url, false);
                }
                catch (Exception ex)
                {
                    SysLogHelper.WriteErrorLog("宝付9跳转错误", "错误详细信息：" + ex.Message + "|" + ex.StackTrace);
                }
            }
            else
            {
                Response.Write("您好，您的提交失败请重试！");
            }
        }

        public class AccountRechareInfo
        {
            public string TranOrder { get; set; }
            public byte? From { get; set; } 
        }

        private AccountRechareInfo getAccountRechare(string TranOrder)
        {
            string strSQL = " select TranOrder from AccountRechare WHERE TranOrder=@TranOrder";
            var paramData = new Dapper.DynamicParameters();
            paramData.Add("@TranOrder", TranOrder);
            return PublicConn.QuerySingle<AccountRechareInfo>(strSQL, ref paramData);
        }

        private int UpdateAccountRechare(AccountRechareInfo Info)
        {
            string strSQL = " Update AccountRechare Set" +
                            " [From]=@From WHERE TranOrder=@TranOrder";
            var paramData = new Dapper.DynamicParameters();
            paramData.Add("@From", Info.From);
            paramData.Add("@TranOrder", Info.TranOrder);
            return PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, strSQL, ref paramData);

        }
    }
}