using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using Tool;
using TuanDai.CgtCallbackUrl.Model.ModelRequest;
using TuanDai.CunGuanTong.Model;
using TuanDai.Payment.Models.Withdraw;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.WXSystem.Core;
using TuanDai.WXSystem.Core.Common;
using TuanDai.WXSystem.Core.models;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// ajax_withdrawals 的摘要说明
    /// </summary>
    public class ajax_withdrawals : SafeHandlerBase
    {
        public void CheckPayPwd()
        {
            Guid userid = WebUserAuth.UserId.Value;
            if (userid == Guid.Empty)
            {
                PrintJson("-99", "登录已失效");
            }
            string msg = string.Empty;
            var isWithdrawal = new CgtCheckBLL().GetUserCgtIsOper(userid, "tixian", ref msg);
            if (!isWithdrawal)
            {
                PrintJson("-199", msg + "，不允许提现");
                return;
            }

            string amountStr = Context.Request.Form["amount"];
            string couponAmountStr = Context.Request.Form["couponAmount"];
            decimal amount = 0m;
            decimal couponAmount = 0m;
            if (!string.IsNullOrEmpty(amountStr))
            {
                amount = Convert.ToDecimal(amountStr);
            }
            if (!string.IsNullOrEmpty(couponAmountStr))
            {
                couponAmount = Convert.ToDecimal(couponAmountStr);
            }
            string userPrizeId = Context.Request.Form["userPrizeId"];
            Guid couponId = new Guid();
            if (!string.IsNullOrEmpty(userPrizeId))
            {
                couponId = Guid.Parse(userPrizeId);//优惠券Id
            }
            //可提现金额
            decimal aviMoney = new UserBLL().GetDrawAviAmount(userid);
            if (amount > aviMoney)
            {
                PrintJson("-1", "申请提现金额大于可用金额");
                return;
            }

            string withdrawNo = string.Empty;
            if (GlobalUtils.IsBankService)
            {
                WXResponsePublicInfo<WXResponseWithdrawInit> init =
                    new BankFromJavaService().WithdrawalInit(new WXRequestPublicInfo<WXRequestWithdrawInit>
                    {
                        serverName = TdConfig.ApplicationName,
                        reqData = new WXRequestWithdrawInit
                        {
                            amount = amount,
                            couponId = couponId,
                            couponAmount = couponAmount,
                            fundType = "USER",
                            userId = userid,
                            withdrawType = "GATEWAY"
                        }
                    });
                if (init != null)
                    withdrawNo = init.respData.withdrawNo;
                else
                {
                    PrintJson("-1", "生成提现申请出错");
                    return;
                }
            }
            else
            {
                string err = "";
                WithdrawResponseModel resmodel = TuanDai.Payment.Client.Withdraw.ApplyWithdraw(new WithdrawRequestModel
                {
                    Amount = amount,
                    CouponAmount = couponAmount,
                    CouponId = couponId,
                    FundType = 0,
                    UserId = userid,
                    WithdrawType = 1//1:存管通,2:定期
                }, ref err);

                if (resmodel == null)
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "生成提现申请出错", "", err);
                    PrintJson("-1", "生成提现申请出错");
                    return;
                }
                if (resmodel.ReturnCode != 1)
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog("WXTouch", "TuanDai.Payment.Client.Withdraw.ApplyWithdraw", "提现申请错误", resmodel.ReturnMessage);
                    PrintJson("-1", resmodel.ReturnMessage);
                }

                withdrawNo = resmodel.WithdrawNo;
            }


            //申请提现金额
            //decimal handingcharge= decimal.Parse(resmodel.HandingCharge.ToString());
            //if ((aviMoney - amount - handingcharge) < 0)
            //{
            //    amount = amount - handingcharge;
            //}
            string strSQL = "SELECT TOP 1 * FROM AppWithdrewFund WHERE UserId=@UserId and WithdrawNo=@WithdrawNo";

            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@UserId", userid);
            dyParams.Add("@WithdrawNo", withdrawNo);
            WXAppWithdrewFund fundInfo = TuanDai.DB.TuanDaiDB.QuerySingleOrDefault<WXAppWithdrewFund>(TdConfig.ApplicationName, TdConfig.DBRealRead, strSQL, ref dyParams);
            if (fundInfo == null)
            {
                PrintJson("-1", "获取提现金额失败");
                return;
            }
            var isCallBackPayment = System.Configuration.ConfigurationManager.AppSettings["IsCallBackPayment"];
            var paymentUrl = System.Configuration.ConfigurationManager.AppSettings["PaymentUrl"];
            string callBackUrl = paymentUrl + "/PaymentPlatform/H5/commonCallBack.aspx";
            if (isCallBackPayment != "1")
            {
                callBackUrl = CgtCallBackConfig.GetCgtCallBackUrl(CgtCallBackConfig.CgtCallBackType.Withdraw);
            }
            TuanDai.CunGuanTong.Model.WITHDRAW_Request info = new TuanDai.CunGuanTong.Model.WITHDRAW_Request
            {

                callbackUrl = callBackUrl,
                platformUserNo = userid.ToString(),
                userDevice = TuanDai.CunGuanTong.Model.userDevice.MOBILE,
                amount = decimal.Parse(fundInfo.ActualWithdrawDeposit.Value.ToString("0.00")),
                commission = fundInfo.HandingCharge.HasValue ? decimal.Parse(fundInfo.HandingCharge.Value.ToString("0.00")) : decimal.Zero,//,//提现手续费
                requestNo = withdrawNo //提现订单流水号
            };
            string responseStr = TuanDai.CunGuanTong.Client.FundClient.WITHDRAW_Req(info);
            PrintJson("1", responseStr);
        }
        public void GetWithDrawalShowList()
        {
            int pagesize = 15;
            int pageindex = Tool.SafeConvert.ToInt32(HttpContext.Current.Request.Form["pageIndex"], 1);
            int status = Tool.SafeConvert.ToInt32(HttpContext.Current.Request.Form["status"], -1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }

            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            ProjectBLL bll = new ProjectBLL();
            IList<WXAppWithdrewFund> list = bll.WXGetUserWithdrewFund(WebUserAuth.UserId.Value, pagesize, pageindex, status, out totalcount);

            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"list\":[");
                foreach (WXAppWithdrewFund temp in list)
                {
                    sb.Append("{\"Amount\":\"" + ToolStatus.ConvertLowerMoney(temp.Amount ?? 0) + "\",\"AppDate\":\"" + (temp.AppDate.Value.ToString("yyyy-MM-dd HH:mm")) +
                                 "\",\"StatusStr\":\"" + this.GetWithdrawStatusIcon(temp.Status ?? 0));
                    if (index == list.Count())
                    {
                        sb.Append("\"}]}");
                    }
                    else
                    {

                        sb.Append("\"},");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + totalcount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }
        private string GetWithdrawStatusIcon(object o)
        {
            int status = int.Parse(o.ToString());
            string str = "";
            switch (status)
            {
                case 0:
                    str = "<i class='ico-inline ico-state03'></i>提现处理中";
                    break;
                case 1:
                    str = "<i class='ico-inline ico-state02'></i>提现失败";
                    break;
                case 2:
                    str = "<i class='ico-inline ico-state01'></i>提现成功";
                    break;
                case 12:
                    str = "<i class='ico-inline ico-state03'></i>未验密";
                    break;
                case 3:
                    str = "<i class='ico-inline ico-state03'></i>正在审核";
                    break;
                case 4:
                case 8:
                case 9:
                case 10:
                case 13:
                    str = "<i class='ico-inline ico-state02'></i>审核失败";
                    break;
                case 6:
                    str = "<i class='ico-inline ico-state02'></i>取消提现";
                    break;
                case 7:
                    str = "<i class='ico-inline ico-state04'></i>审核成功";
                    break;
                case 11:
                    str = "<i class='ico-inline ico-state02'></i>暂不审核";
                    break;
                default:
                    str = "<i class='ico-inline ico-state02'></i>提现失败";
                    break;
            }
            return str;
        }

        //获取充值记录分页数据
        public void GetRechageShowList()
        {
            int pagesize = 15;
            int pageindex = Tool.SafeConvert.ToInt32(HttpContext.Current.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            Guid userId = WebUserAuth.UserId.Value;
            if (userId == null || userId == Guid.Empty)
            {
                PrintJson("0", "还未登录");
                return;
            }

            int status = Tool.WEBRequest.GetFormInt("status", 0);
            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            ProjectBLL bll = new ProjectBLL();
            IList<WXAccountRechare> list = bll.WXGetUserAccountRechare(status, userId, pagesize, pageindex, out totalcount);
            double divide = totalcount / pagesize;
            double floor = System.Math.Floor(divide);
            if (totalcount % pagesize != 0)
                floor++;
            int pageCount = Convert.ToInt32(floor);//总页数  
            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"pagecount\":\"" + pageCount + "\",\"list\":[");
                foreach (WXAccountRechare temp in list)
                {
                    sb.Append("{\"Amount\":\"" + ToolStatus.ConvertLowerMoney(temp.Amount) + "\",\"AddDate\":\"" + (temp.AddDate.ToString("yyyy-MM-dd HH:mm")) +
                               "\",\"StatusStr\":\"" + GetStatusIcon(temp.Status) +
                               "\",\"DeviceType\":\"" + GetDeviceType(temp.From ?? 1));

                    if (index == list.Count())
                    {
                        sb.Append("\"}]}");
                    }
                    else
                    {

                        sb.Append("\"},");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"pagecount\":\"0\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }


        private string GetStatusIcon(object o)
        {
            int status = int.Parse(o.ToString());
            string str = "";
            switch (status)
            {
                case 0:
                    str = "<i class='ico-inline ico-state03'></i>正在处理";
                    break;
                case 1:
                    str = "<i class='ico-inline ico-state02'></i>充值失败";
                    break;
                case 2:
                    str = "<i class='ico-inline ico-state01'></i>充值成功";
                    break;
                case 3:
                    str = "<i class='ico-inline ico-state04'></i>等待审核";
                    break;
                case 4:
                    str = "<i class='ico-inline ico-state02'></i>审核失败";
                    break;
                case 5:
                    str = "<i class='ico-inline ico-state04'></i>审核成功";
                    break;
                case 6:
                    str = "<i class='ico-inline ico-state04'></i>暂未付款";
                    break;
                case 7:
                    str = "<i class='ico-inline ico-state04'></i>取消付款";
                    break;
                default:
                    str = "<i class='ico-inline ico-state04'></i>等待审核";
                    break;
            }
            return str;
        }
        private static string GetDeviceType(object o)
        {
            int deviceType = SafeConvert.ToInt32(o, 1);
            string str = "ico-pc";
            switch (deviceType)
            {
                case 1:
                    str = "ico-pc";
                    break;
                case 2:
                    str = "ico-android";
                    break;
                case 3:
                    str = "ico-apple";
                    break;
                case 5:
                    str = "ico-weixin";
                    break;
            }
            return str;
        }
    }
}