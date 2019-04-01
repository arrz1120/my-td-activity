using BusinessDll;
using Dapper;
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

namespace TuanDai.WXApiWeb.PaymentPlatform.weixin
{
    /// <summary>
    /// 微信支付--公众号充值
    /// Allen 2015-12-18
    /// </summary>
    public partial class wxJSRecharge : UserPage
    {
        protected string wxJsApiParam = "";
        public ResponseData responObj = new ResponseData();
        protected UserBasicInfoInfo userModel = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {

                //判断openid为空时,重新授权
                if (GlobalUtils.IsWeiXinBrowser)
                {
                    Guid? userId = WebUserAuth.UserId;
                    if (userId == null || userId == Guid.Empty)
                    {
                        PrintJson("-1", "对不起,您还未登录!");
                        return;
                    }

                    TuanDai.PortalSystem.BLL.UserBLL bll = new TuanDai.PortalSystem.BLL.UserBLL();
                    userModel = bll.GetUserBasicInfoModelById(userId.Value);

                    if (GlobalUtils.OpenId.IsEmpty())
                    {
                        string strOpenId = TuanDai.WXApiWeb.Common.WeiXinApi.GetUserWXOpenId(userModel.Id);
                        if (strOpenId.IsNotEmpty())
                        {
                            GlobalUtils.WriteOpenIdToCookie(strOpenId.ToText());
                        }
                        else
                        {
                            TuanDai.WXApiWeb.Common.WeiXinApi wxApi = new Common.WeiXinApi();
                            wxApi.GetOpenidAndAccessToken(this);
                        }
                    }
                }

                GetWXJsApiParam();
            } 
        }

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
            decimal Amount = Tool.SafeConvert.ToDecimal(WEBRequest.GetQueryString("Amount"), 0);

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

            DynamicParameters paramData = new DynamicParameters();
            paramData.Add("@userid", userId);
            paramData.Add("@type", Sel);
            paramData.Add("@amount", Amount);
            paramData.Add("@orderNo", orderNo);
            paramData.Add("@backcode", bankcode);
            paramData.Add("@clientIp", userIP);
            paramData.Add("@from", "5");
            paramData.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);

            PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, "AccountRechargeInit", ref paramData, System.Data.CommandType.StoredProcedure);
            outStatus = paramData.Get<int>("@outStatus");

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
                wxJsApiParam = jsApiPay.GetJsApiParameters();//获取H5调起JS API参数    
                PrintJson("1", "");
            }
            else
            {
                PrintJson("-1", "您好，您的提交失败请重试!");
                return;
            }
        }

        protected void PrintJson(string strstate, string strmsg)
        {
            responObj = new ResponseData() { result = strstate, msg = strmsg };
        } 
        
    }
    public class ResponseData
    {
        public string result { get; set; }
        public string msg { get; set; }
    }
}