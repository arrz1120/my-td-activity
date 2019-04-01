<%@ WebHandler Language="C#" Class="TuanDai.WXApiWeb.ajaxCross.Ajax_zqbproject" %>

using System;
using System.Web;
using System.Data.Objects;
using System.Data;
using System.Linq;
using Kamsoft.Data;
using System.Configuration;
using System.Data.SqlClient;
using Newtonsoft.Json;
using Kamsoft.Data.Dapper;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.ajaxCross
{
    public class Ajax_zqbproject : SafeHandlerBase
    {
        private readonly string sqlconnection = TuanDai.Config.BaseConfig.ConnectionString;

        public void ApplyBefore()
        {
            //JunTeEntities dbread = JunTeEntities.Read();
            Guid userid = WebUserAuth.UserId ?? Guid.Empty;
            //判断是否登陆
            if (userid == Guid.Empty)
            {
                this.PrintJson("2", "对不起，你未登录，请先登录。");
            }

            //UserBasicInfo userBasic = dbread.UserBasicInfo.First(p => p.Id == userid);
            var userBasic = new UserBLL().GetUserBasicInfoModelById(userid);
            if (!userBasic.IsValidateIdentity || !userBasic.IsValidateMobile)
            {
                this.PrintJson("4", "未进行安全验证");
            }
            this.PrintJson("1", "");
        }

        public void ApplyStockMatchFund()
        {
            //JunTeEntities dbread = JunTeEntities.Read();
            Guid userid = WebUserAuth.UserId ?? Guid.Empty;
            //判断是否登陆
            if (userid == Guid.Empty)
            {
                this.PrintJson("2", "对不起，你未登录，请先登录。");
            }

            if (string.IsNullOrEmpty(Context.Request.Form["PayPwd"]))
            {
                this.PrintJson("15", "交易密码错误");
            }

            string payPwd = Tool.Encryption.MD5(Context.Request.Form["PayPwd"]);
            //UserBasicInfo userBasic = dbread.UserBasicInfo.First(p => p.Id == userid);
            var userBasic = new UserBLL().GetUserBasicInfoModelById(userid);
            if (payPwd != userBasic.PayPwd)
            {
                this.PrintJson("15", "交易密码错误");
            }

            if (!userBasic.IsValidateIdentity || !userBasic.IsValidateMobile)
            {
                this.PrintJson("10", "未进行安全验证");
            }
            var bll = new WebSettingBLL();
            decimal Amount = Tool.SafeConvert.ToDecimal(Context.Request.Form["Amount"]);
            int Lever = Tool.SafeConvert.ToInt32(Context.Request.Form["Lever"]);
            int DeadLine = Tool.SafeConvert.ToInt32(Context.Request.Form["DeadLine"]);
            //Guid setId = Guid.Parse("f65b7518-e60f-4cd4-b895-895e40a84609");
            //DB.WebSetting amountSet = dbread.WebSetting.FirstOrDefault(p => p.Id == setId);
            var amountSet = bll.GetWebSettingInfo("f65b7518-e60f-4cd4-b895-895e40a84609");
            //setId = Guid.Parse("5724A794-A380-45E8-837D-5326487E9C48");
            //DB.WebSetting set = dbread.WebSetting.FirstOrDefault(p => p.Id == setId);
            var set = bll.GetWebSettingInfo("5724A794-A380-45E8-837D-5326487E9C48");
            if (DeadLine != 15 && DeadLine != 26 && DeadLine != 30 && DeadLine != 45 && DeadLine != 60 && DeadLine != 90 && DeadLine != 180)
            {
                this.PrintJson("14", "借款期限有误");
            }

            decimal InvestRate = Tool.SafeConvert.ToDecimal(Context.Request.Form["Rate"]);
            if (InvestRate < 10 || InvestRate > 24)
            {
                this.PrintJson("15", "借款年化利率有误");
            }
            decimal rate = 0;
            switch (DeadLine)
            {
                case 15:
                    rate = 10;
                    break;
                case 26:
                    rate = 11;
                    break;
                case 30:
                    rate = 11.5M;
                    break;
                case 45:
                    rate = 12;
                    break;
                case 60:
                    rate = 13;
                    break;
                case 90:
                    rate = 14;
                    break;
                case 180:
                    rate = 15;
                    break;
            }

            if (InvestRate < rate)
            {
                this.PrintJson("15", "借款年化利率有误");
            }

            if (Amount % 1000 != 0)
            {
                this.PrintJson("5", "保证金格式不正确");
            }
            decimal dispost = decimal.Parse(set.Param3Value);
            if (Amount < dispost)
            {
                this.PrintJson("6", "保证金必须大于" + dispost);
            }
            dispost = decimal.Parse(set.Param4Value) / 5;
            if (Amount > dispost)
            {
                this.PrintJson("7", "保证金最多" + dispost / 10000 + "万");
            }

            if (Lever != 2 && Lever != 3 && Lever != 4 && Lever != 5)
            {
                this.PrintJson("8", "配资比例错误");
            }

            decimal ManagerAmount = decimal.Parse(amountSet.Param4Value) * Amount * (Lever + 1);
            ManagerAmount = ManagerAmount.ToString().IndexOf(".") > 0 ? decimal.Parse(ManagerAmount.ToString().Substring(0, ManagerAmount.ToString().IndexOf(".") + 3)) : ManagerAmount;
            //decimal AviMoney = db.FundAccountInfo.Where(p => p.UserId == userid).Select(p => p.AviMoney).FirstOrDefault() ?? 0;
            decimal AviMoney = new FundAccountInfoBll().GetFundAccountInfoById(userid).AviMoney.Value;
            decimal serviceRate = 0M;
            if (Amount * Lever < decimal.Parse(amountSet.Param1))
            {
                serviceRate = decimal.Parse(amountSet.Param1Value);
            }
            else if (Amount * Lever >= decimal.Parse(amountSet.Param1) && Amount * Lever < decimal.Parse(amountSet.Param2))
            {
                serviceRate = decimal.Parse(amountSet.Param2Value);
            }
            else
            {
                serviceRate = decimal.Parse(amountSet.Param3Value);
            }

            decimal DepositAmount = 0, ServiceAmount = 0, IntertestAmount = 0;
            if (DeadLine <= 30)
            {
                ServiceAmount = Amount * Lever * DeadLine * serviceRate / 100;
                ServiceAmount = ServiceAmount.ToString().IndexOf(".") > 0 ? decimal.Parse(ServiceAmount.ToString().Substring(0, ServiceAmount.ToString().IndexOf(".") + 3)) : ServiceAmount;
                IntertestAmount = Math.Ceiling(Amount * Lever * DeadLine * InvestRate / 100 / 360);
            }
            else
            {
                ServiceAmount = Amount * Lever * 30 * serviceRate / 100;
                ServiceAmount = ServiceAmount.ToString().IndexOf(".") > 0 ? decimal.Parse(ServiceAmount.ToString().Substring(0, ServiceAmount.ToString().IndexOf(".") + 3)) : ServiceAmount;
                IntertestAmount = Math.Ceiling(Amount * Lever * 30 * InvestRate / 100 / 360);
            }
            DepositAmount = Amount + IntertestAmount + ServiceAmount + ManagerAmount;
            if (AviMoney < DepositAmount)
            {
                this.PrintJson("3", "发布失败：账户资金不足!");
            }

            //SqlParameter[] parms = {
            //                        SqlHelper.MakeInParam("Userid",SqlDbType.UniqueIdentifier,userid),
            //                        SqlHelper.MakeInParam("Deadline",SqlDbType.Int, DeadLine),
            //                        SqlHelper.MakeInParam("InvestRate",SqlDbType.Decimal,InvestRate),
            //                        SqlHelper.MakeInParam("DepositAmount",SqlDbType.Decimal, Amount),
            //                        SqlHelper.MakeInParam("Lever",SqlDbType.Int, Lever),
            //                        SqlHelper.MakeOutParam("OutStatus",SqlDbType.Int,0),
            //                        SqlHelper.MakeOutParam("ReturnMsg",SqlDbType.NVarChar,200)};
            var paras = new Dapper.DynamicParameters();
            paras.Add("@Userid",userid);
            paras.Add("@Deadline", DeadLine);
            paras.Add("@InvestRate", InvestRate);
            paras.Add("@DepositAmount", Amount);
            paras.Add("@Lever", Lever);
            paras.Add("@OutStatus", 0,DbType.Int32,ParameterDirection.Output);
            paras.Add("@ReturnMsg", "",DbType.String,ParameterDirection.Output);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.DBSubscribeWrite, "p_gp_ProjectSubmit", ref paras,
                CommandType.StoredProcedure);
            //SqlHelper.ExecuteNonQuery(TuanDai.Config.BaseConfig.ConnectionString, CommandType.StoredProcedure,"p_gp_ProjectSubmit", parms);
            //if (int.Parse(parms[5].Value.ToString()) == 1)
            //{
            //    //启动We计划
            //    BusinessDll.Invest.StartWePlan(Guid.Parse(parms[6].Value.ToString()));
            //}
            this.PrintJson(paras.Get<int>("@OutStatus").ToString(), paras.Get<string>("@ReturnMsg"));
        }

        /// <summary>
        /// 申请续配
        /// </summary>
        public void ApplyContinueDistribe()
        {
            //JunTeEntities dbread = JunTeEntities.Read();
            Guid userid = WebUserAuth.UserId.Value;
            //判断是否登陆，得到用户ID
            if (WebUserAuth.UserId == null || WebUserAuth.UserId==Guid.Empty)
            {
                this.PrintJson("2", "对不起，你未登录，请先登录。");
                return;
            }

            if (string.IsNullOrEmpty(Context.Request.Form["PayPwd"]))
            {
                this.PrintJson("15", "交易密码错误");
            }

            string payPwd = Tool.Encryption.MD5(Context.Request.Form["PayPwd"]);
            //UserBasicInfo userBasic = dbread.UserBasicInfo.First(p => p.Id == userid);
            var userBasic = new UserBLL().GetUserBasicInfoModelById(userid);
            if (payPwd != userBasic.PayPwd)
            {
                this.PrintJson("15", "交易密码错误");
            }
            if (!userBasic.IsValidateIdentity || !userBasic.IsValidateMobile)
            {
                this.PrintJson("10", "未进行安全验证");
            }
            Guid projectId = Tool.SafeConvert.ToGuid(Context.Request.Form["ProjectId"]) ?? Guid.Empty;
            int DeadLine = Tool.SafeConvert.ToInt32(Context.Request.Form["DeadLine"]);
            if (DeadLine != 15 && DeadLine != 26 && DeadLine != 30)
            {
                this.PrintJson("14", "借款期限有误");
            }

            decimal InvestRate = Tool.SafeConvert.ToDecimal(Context.Request.Form["Rate"]);
            if (InvestRate < 10 || InvestRate > 24)
            {
                this.PrintJson("16", "借款年化利率有误");
            }
            decimal rate = 0;
            switch (DeadLine)
            {
                case 15:
                    rate = 10;
                    break;
                case 26:
                    rate = 11;
                    break;
                case 30:
                    rate = 11.5M;
                    break;
            }

            if (InvestRate < rate)
            {
                this.PrintJson("16", "借款年化利率有误");
            }

            //SqlParameter[] parms = {
            //                        SqlHelper.MakeInParam("ProjectId",SqlDbType.UniqueIdentifier,projectId),
            //                        SqlHelper.MakeInParam("UserId",SqlDbType.UniqueIdentifier,userid),
            //                        SqlHelper.MakeInParam("Deadline",SqlDbType.Int, DeadLine),
            //                        SqlHelper.MakeInParam("InvestRate",SqlDbType.Decimal,InvestRate),
            //                        SqlHelper.MakeOutParam("OutStatus",SqlDbType.Int,0),
            //                        SqlHelper.MakeOutParam("ReturnMsg",SqlDbType.NVarChar,200)};
            var paras = new Dapper.DynamicParameters();
            paras.Add("@ProjectId",projectId);
            paras.Add("@UserId", userid);
            paras.Add("@Deadline", DeadLine);
            paras.Add("@InvestRate", InvestRate);
            paras.Add("@OutStatus", 0,DbType.Int32,ParameterDirection.Output);
            paras.Add("@ReturnMsg", "", DbType.String, ParameterDirection.Output);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.DBSubscribeWrite, "p_gp_ContinueDistribe", ref paras,
                CommandType.StoredProcedure);
            //SqlHelper.ExecuteNonQuery(TuanDai.Config.BaseConfig.ConnectionString, CommandType.StoredProcedure,
            //    "p_gp_ContinueDistribe", parms);
            //this.PrintJson(parms[4].Value.ToString(), parms[5].Value.ToString());
            PrintJson(paras.Get<int>("@OutStatus").ToString(), paras.Get<string>("@ReturnMsg"));
        }


        //protected System.Data.SqlClient.SqlConnection OpenConnection()
        //{
        //    System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection(sqlconnection);
        //    connection.Open();
        //    return connection;
        //}
    }
}