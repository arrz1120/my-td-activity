using System.Data;
using BusinessDll;
using Kamsoft.Data.Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.DAL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// WXPayment 的摘要说明
    /// </summary>
    public class WXPayment : SafeHandlerBase
    {

        public void GetWXJsApiParam()
        {
            string strOpenId = GlobalUtils.OpenId;
            if (strOpenId.IsEmpty())
            {
                PrintJson("-1", "微信未授权,取不到OpenId值");
                return;
            }
            Guid? userId = WebUserAuth.UserId;
            if (userId == null || userId == Guid.Empty)
            {
                PrintJson("-1", "对不起,您还未登录!");
                return;
            }
            TuanDai.PortalSystem.BLL.UserBLL bll = new TuanDai.PortalSystem.BLL.UserBLL();
            UserBasicInfoInfo userModel = bll.GetUserBasicInfoModelById(userId.Value);
            if (userModel == null) {
                PrintJson("-1", "对不起,该用户不存在!");
                return;
            }
            decimal Amount = Tool.SafeConvert.ToDecimal(WEBRequest.GetFormString("Amount"), 0); 
            decimal tmpAmount = Math.Floor(Amount * 100) / 100;
            if (tmpAmount != Amount)
            {
                PrintJson("-1", "充值金额最多只能2位小数，如106.32！");
                return;
            }
            WebSettingInfo rechargeSet = new TuanDai.PortalSystem.DAL.WebSettingDAL().GetWebSettingInfo("9A89CBAE-6550-4EA1-8224-EB645F38F8FA");
            decimal MinRechargeAmount = decimal.Parse(rechargeSet.Param1Value);
            if (Amount < MinRechargeAmount)
            {
                PrintJson("-1", "最低充值金额为" + MinRechargeAmount.ToString("N2") + "元!");
                return;
            }
            if (Amount > 500000)
            {
                PrintJson("-1", "单次充值不能超过50万!");
                return;
            }

            NoHandler noHandler = new NoHandler();
            string orderNo = noHandler.OnLineRechare();
            if (orderNo == "0")
            {
                PrintJson("-1", "您好，您的提交失败请重试!");
                return;
            }

            int Sel = 9; //标记是微信支付
            Guid rechargeId = Guid.NewGuid();
            int outStatus = 0;
            string bankcode = "";
            string userIP = Tool.WebFormHandler.GetIP();
            //using (SqlConnection connection = TuanDai.PortalSystem.DAL.PubConstant.CrateConnection())
            //{
            var paramData = new Dapper.DynamicParameters();
            paramData.Add("@userid", userId);
            paramData.Add("@type", Sel);
            paramData.Add("@amount", Amount);
            paramData.Add("@orderNo", orderNo);
            paramData.Add("@backcode", bankcode);
            paramData.Add("@clientIp", userIP);
            paramData.Add("@from", "5");
            paramData.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.DBFundWrite, "AccountRechargeInit", ref paramData,CommandType.StoredProcedure);
            outStatus = paramData.Get<int>("@outStatus");
            //    connection.Execute("AccountRechargeInit", paramData, null, null, System.Data.CommandType.StoredProcedure);
            //    outStatus = paramData.Get<int>("@outStatus");
            //    connection.Close();
            //    connection.Dispose();
            //}
          

            int result = outStatus;
            if (result > 0)
            {
                TuanDai.Payment.PaymentBLL jsApiPay = new TuanDai.Payment.PaymentBLL("JSAPI", strOpenId, orderNo, userModel.RealName, userModel.IdentityCard);
                TuanDai.Payment.WxPayData unifiedOrderResult = null;
                try
                {
                    int PayAmount = int.Parse(double.Parse((Amount * 100).ToString()).ToString());

                    unifiedOrderResult = jsApiPay.WXJsApiUnifiedOrder(PayAmount.ToString());
                }
                catch (Exception ex)
                {
                    PrintJson("-1", ex.Message);
                    return;
                }
                string wxJsApiParam = jsApiPay.GetJsApiParameters();//获取H5调起JS API参数  
                var jsonData = new { result = "1", msg = wxJsApiParam };
                PrintJson(jsonData);
            }
            else
            {
                PrintJson("-1", "您好，您的提交失败请重试!");
                return;
            }
        }
       
        
    }
}