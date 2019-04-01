﻿<%@ WebHandler Language="C#"  Class="TuanDai.WXApiWeb.Activity.ExpGold.ajax" %>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TuanDai.PortalSystem.BLL;
using System.Data.SqlClient;
using TuanDai.PortalSystem.Model;
using BusinessDll;
using TuanDai.WXApiWeb.Common;
using Kamsoft.Data.Dapper;
using System.Data;
using TuanDai.InfoSystem.Model;
using TuanDaiDB=DB;
using TuanDai.InfoSystem.WcfClient;
using Tool;
using System.Text.RegularExpressions;
using TuanDai.PortalSystem.Model.Enums;
using System.Configuration;

namespace TuanDai.WXApiWeb.Activity.ExpGold
{
    /// <summary>
    /// ajax 的摘要说明
    /// </summary>
    public class ajax : SafeHandlerBase
    {
        private static object lockobj = new object();
        #region 用户注册
        public void RegisterUser()
        {
            string mobileNumber = Tool.WEBRequest.GetFormString("mobilenumber");
            string validateCode = Tool.WEBRequest.GetFormString("verificationCode");
            string from = Tool.WEBRequest.GetFormString("from");
            string ExtendKey = string.Empty;
            if (string.IsNullOrEmpty(mobileNumber))
            {
                PrintJson("0", "手机号码不能为空");
                return;
            }
            if (string.IsNullOrEmpty(validateCode))
            {
                PrintJson("0", "手机验证码不能为空");
                return;
            }
            UserBLL bll = new UserBLL();
            var userName = bll.StrGetUserName();
            SqlParameter[] paramData = new SqlParameter[] { new SqlParameter("@TelNo", mobileNumber), new SqlParameter("@UserName", userName) };
            UserBasicInfoInfo model = bll.WXGetUserBasicInfo("TelNo=@TelNo or UserName=@UserName", paramData);
            if (model != null)
            {
                PrintJson("0", "该手机号码已注册,请更换手机号码");
                return;
            }
            //判断注册IP是否受限
            string strIP = Tool.WebFormHandler.GetIP();
            string[] IP = strIP.Split(',');
            string RealIP = "";
            if (IP.Length > 1)
                RealIP = IP[1];
            else
                RealIP = IP[0];
            string result = Users.UserIsRegByIP(RealIP);
            if ("1" != result)
            {
                string dt = result.Split('|')[1];
                PrintJson("0", "注册失败：为防止恶意注册，请在" + dt + "后重新注册");
            }

            int codeResult = BusinessDll.Users.CheckCodeRecord(ConstString.MSCodeType.PhoneCode, ConstString.MSCodeType2.RegPhoneValid, mobileNumber, validateCode);
            if (codeResult != 1)
            {
                PrintJson("0", "注册失败：验证码错误或已过期,请重新获取输入");
            }
            Guid userid = Guid.NewGuid();
            string newPassWord = GetRandomPassword(8);
            from = string.IsNullOrEmpty(from) ? "ZLW-M-02" : from;
            UserBasicInfoInfo userModel = WXRegister.AddUserInfo(userid, from, userName, newPassWord, mobileNumber, ExtendKey, "", "", 0, RealIP);
            if (userModel != null)
            {
                //发送密码短信通知 
                var msgSender = new BusinessDll.MessageSend();
                string smsContent = string.Format("恭喜您，注册成功！请前往团宝箱领取礼品;团贷网用户名:{0}，密码:{1}, 登录www.tuandai.com免费领取收益奖金.", mobileNumber, newPassWord);
                msgSender.AsyncSendNoteHandler("Note", null, mobileNumber, smsContent);
                TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userModel.Id, (int)ConstString.UserGrowthType.EveryDayFirstLogin, null, 0);
                TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userModel.Id, (int)ConstString.UserGrowthType.BindMobile, null, 0);
                GetExperienceGoldDelegate getExperience = new GetExperienceGoldDelegate(GetExperienceGold);
                getExperience.BeginInvoke(userModel.Id, null, null);
                string ExpGoldFlag = SendExperienceGold(userModel.Id);//发放体验金
                switch (ExpGoldFlag)
                {
                    case "0":
                        PrintJson("0", "体验金领取失败");
                        break;
                    case "1":
                        PrintJson("1", "");
                        break;
                    case "2":
                        PrintJson("1", "");//已经领取过体验金
                        break;
                    case "3":
                        PrintJson("3", "没有领取体验金的资格");
                        break;                        
                }                
            }
            PrintJson("0", "注册失败");
        }

        /// <summary>
        /// 发放体验金
        /// </summary>
        /// <param name="UserId"></param>
        public string SendExperienceGold(Guid UserId)
        {
            string result = "0";
            if (UserId == Guid.Empty)
            {
                result = "-1";
            }
            else
            {
                var param = new DynamicParameters();
                param.Add("@userid", UserId);
                param.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
                using (SqlConnection connection = new SqlConnection(TuanDai.Config.BaseConfig.ConnectionString))
                {
                    connection.Execute("p_Send_InvestExperienceGold", param, null, null, CommandType.StoredProcedure);
                    result = (param.Get<int>("@outStatus")).ToString();
                    connection.Close();
                    connection.Dispose();
                }
            }
            if (result != "1")
            {
                BusinessDll.NetLog.WriteLoginHandler("领取体验金失败", "用户Id:" + UserId, "触屏版");
            }
            return result;
        }

        /// <summary>
        /// 体验金投资
        /// </summary>
        public void ExpGoldInvest()
        {
            Guid? userId = WebUserAuth.UserId;
            string result = "-101";
            if (userId == Guid.Empty)
            {
                result = "-1";
            }
            else
            {
                var param = new DynamicParameters();
                param.Add("@UserId", userId);
                param.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
                using (SqlConnection connection = new SqlConnection(TuanDai.Config.BaseConfig.ConnectionString))
                {
                    connection.Execute("p_ExperienceGoldInvest", param, null, null, CommandType.StoredProcedure);
                    result = (param.Get<int>("@outStatus")).ToString();
                    connection.Close();
                    connection.Dispose();
                }
            }
            this.Context.Response.Write("{\"result\":\"" + result + "\"}");
            this.Context.Response.End();
        }

        private delegate void GetExperienceGoldDelegate(Guid userId);
        //自动领取体验金
        private void GetExperienceGold(Guid userId)
        {
            using (SqlConnection connection = new SqlConnection(TuanDai.Config.BaseConfig.ConnectionString))
            {

                //发送团宝箱后,自动标记已领取,不然后面不好做投资             
                //string strSQL = "select Id from UserPrize WHERE ActivityCode='20150510' AND TypeId=16 and IsReceive=0 AND prizeName='注册送体验金活动' and UserId=@UserId";
                //var dyParams = new DynamicParameters();
                //dyParams.Add("@UserId", userId);

                //Guid? prizeId = connection.Query<Guid?>(strSQL, dyParams).FirstOrDefault();
                Guid? prizeId = null;
                string err = "";

                TuanDai.UserPrizeNew.ServiceClient.Models.UserPrizeInfo upi = new TuanDai.UserPrizeNew.Client.UserPrizeQueryClient(TdConfig.ApplicationName)
                        .GetUserPrizeListByUserId(userId, out err, new List<int>() { 16 }, false, new List<string>() { "20150510" },
                            "", null, null).FirstOrDefault();
                if (upi != null)
                    prizeId = upi.Id;
                if (prizeId != null && prizeId.HasValue)
                {

                    UserBLL userbll = new UserBLL();
                    int outStatus = -1;
                    userbll.GetUserPrize(userId, prizeId.Value, 2, out  outStatus);
                }
                connection.Close();
                connection.Dispose();
            }
        }
        #endregion

        /// <summary>
        /// 验证身份证
        /// </summary>
        public void RegisterRealNameValid()
        {
            lock (lockobj)
            {
                string realname = Context.Request["realname"];
                string idcard = Context.Request["idcard"];

                TuanDaiDB.UserBasicInfo model = null;
                if (!string.IsNullOrEmpty(WebUserAuth.UserName))
                {
                    model = db.UserBasicInfo.FirstOrDefault(p => p.Id == WebUserAuth.UserId);
                }

                if (model == null)
                {
                    PrintJson("-1", "验证失败：用户信息错误，请重新登录");
                }

                if (model.AuthenState >= 4 || model.IsValidateIdentity)
                {//如果已经完成验证
                    PrintJson("-2", "验证失败：已经验证，不能重复验证");
                }

                string IdentityCardRegex = "(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)";//验证身份证
                if (model.UserTypeId == 1 && System.Text.RegularExpressions.Regex.IsMatch(idcard, IdentityCardRegex) == false)//个人
                {
                    PrintJson("-6", "验证失败：身份证格式不正确，请重新输入");
                }

                //TuanDaiDB.UserBasicInfo ubInfo = db.UserBasicInfo.FirstOrDefault(p => p.IdentityCard == idcard);
                var ubInfo = new UserBLL().WXGetUserBasicInfo("IdentityCard=@IdentityCard",
                    new SqlParameter[] {new SqlParameter("@IdentityCard", idcard),});
                if (ubInfo != null)//身份证已经使用过
                    PrintJson("-3", "验证失败：此证件已被使用");


                #region 团贷网征信系统实名认证
                string IsValidateIdentity = ConfigurationManager.AppSettings["IsValidateIdentity"];
                if (IsValidateIdentity == "1")//团贷网征信系统实名认证开关
                {
                    if (model.UserTypeId == 1)
                    {
                        //调用征信系统验证真实姓名和身份证号码
                        Guid setid = Guid.Parse("A8CCC0CF-BA90-446B-945C-80EBABB77139");
                        TuanDaiDB.WebSetting set = db.WebSetting.FirstOrDefault(p => p.Id == setid);
                        if (set != null && set.Param1Value != null)//没有配置则不限制
                        {
                            int time1 = Tool.SafeConvert.ToInt32(set.Param1Value, 0);
                            int time2 = Tool.SafeConvert.ToInt32(set.Param2Value, 0);
                            int time3 = Tool.SafeConvert.ToInt32(set.Param3Value, 0);
                            List<WebLog> loglist = new WebLogService().GetListWebLogInfo(UserId: WebUserAuth.UserId.ToString());//db.Web_Log.Where(p => p.UserId == WebUserAuth.UserId && p.Content1.Contains("征信系统验证") == true).OrderByDescending(p => p.AddDate).Take(4);
                            if (loglist != null && loglist.Count() > 0)
                            {
                                WebLog wl = loglist.FirstOrDefault();
                                if (loglist.Count() == 1)
                                {
                                    DateTime adddate = wl.AddDate.Value;
                                    DateTime now = DateTime.Now.AddSeconds(-time1);
                                    if (adddate > now)
                                    {
                                        string dateDiff = MyDateTime.DateDiff(adddate, now);
                                        PrintJson("-11", "验证失败：请仔细核查姓名和身份证号，在" + dateDiff + "后重新实名认证");
                                    }
                                }
                                else if (loglist.Count() == 2)
                                {
                                    DateTime adddate = wl.AddDate.Value;
                                    DateTime now = DateTime.Now.AddSeconds(-time2);
                                    if (adddate > now)
                                    {
                                        string dateDiff = MyDateTime.DateDiff(adddate, now);
                                        PrintJson("-11", "验证失败：请仔细核查姓名和身份证号，请在" + dateDiff + "后重新实名认证");
                                    }
                                }
                                else if (loglist.Count() >= 3)
                                {
                                    DateTime adddate = wl.AddDate.Value;
                                    DateTime now = DateTime.Now.AddDays(-time3);
                                    if (adddate > now)
                                    {
                                        string dateDiff = MyDateTime.DateDiff(adddate, now);
                                        PrintJson("-11", "验证失败：您今天已经错误三次，请在" + dateDiff + "后重新实名认证");
                                    }
                                }
                            }
                        }

                        IPublicService service = new IPublicService();
                        string Result = service.ValidateRealName(realname, idcard);


                        //保存用户操作日志
                        WebLog logsm = new WebLog();
                        logsm.AddDate = DateTime.Now;
                        logsm.BusinessId = model.Id.ToString();
                        logsm.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                        logsm.HandlerTypeId = (int)ConstString.LogType.EditIdentityCard;
                        logsm.UserId = model.Id.ToString();
                        logsm.UserTypeId = (int)ConstString.LogUserType.WebUser;
                        logsm.Content1 = "征信系统验证";
                        logsm.Content2 = "真实姓名：" + realname + "身份证号：" + idcard + "验证结果：" + Result;
                        logsm.Id = Guid.NewGuid().ToString();
                        WebLogInfo.WriteLoginHandler(logsm);
                        if (Result != "1")
                        {
                            if (Result == "-7")
                            {
                                PrintJson("False", "验证失败：公民身份证号码一致，姓名不一致");
                            }
                            else if (Result == "-8")
                            {
                                PrintJson("False", "验证失败：征信系统库中无此身份证号码");
                            }
                            else if (Result == "-4" || Result == "-5")
                            {
                                PrintJson("False", "验证失败：姓名或身份证号码错误");
                            }
                            else if (Result == "-2" || Result == "-3" || Result == "0" || Result == "-1" || Result == "-6")
                            {
                                PrintJson("False", "验证失败：征信系统认证失败请联系客服");
                            }
                            else
                            {
                                PrintJson("-10", "验证失败：征信系统认证失败请联系客服");
                            }
                        }
                    }
                }

                #endregion 团贷网征信系统实名认证

                model.RealName = realname;
                model.IdentityCard = idcard;
                model.sex = GetSexFromIdCard(idcard);
                string ageTemp = model.IdentityCard.Substring(6, 8);
                DateTime dt = Convert.ToDateTime(ageTemp.Substring(0, 4) + "-" + ageTemp.Substring(4, 2) + "-" + ageTemp.Substring(6, 2));
                model.Birthday = dt;

                model.CredTypeId = 1;
                model.IsValidateIdentity = true;
                if (model.IsValidateEmail && model.IsValidateIdentity && model.IsValidateMobile && model.IsSafeQuestion)
                {
                    model.AuthenState = 4;
                }
                int result = db.SaveChanges();
                if (result > 0)
                {
                    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(model.Id, (int)ConstString.UserGrowthType.RealNameValid, null, 0);
                    WebLog log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.BusinessId = model.Id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                    log.HandlerTypeId = (int)ConstString.LogType.EditIdentityCard;
                    log.UserId = model.Id.ToString();
                    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                    log.Content1 = "实名认证:身份证号码：" + idcard + ";真实姓名：" + realname + "；证件类型：1";
                    log.Id = Guid.NewGuid().ToString();
                    WebLogInfo.WriteLoginHandler(log);
                }

                if (result > 0)
                {
                    PrintJson("1", "实名认证成功");
                }
                else
                {
                    PrintJson("2", "实名认证失败：系统错误，请重试或联系客服");
                }
            }
        }

        /// <summary>
        /// 根据身份证获取性别
        /// </summary>
        /// <param name="IdCard"></param>
        /// <returns></returns>
        private int GetSexFromIdCard(string IdCard)
        {
            int rtn;
            string tmp = "";
            if (IdCard.Length == 18)
            {
                tmp = IdCard.Substring(IdCard.Length - 2, 1);
            }
            int sx = int.Parse(tmp);
            int outNum;
            Math.DivRem(sx, 2, out outNum);
            if (outNum == 0)
            {
                rtn = 2;
            }
            else
            {
                rtn = 1;
            }
            return rtn;
        }
        #region 用体验金投资
        public void ExperienceGoldInvest()
        {
            Guid? userId = WebUserAuth.UserId;
            string result = "-101";
            if (userId == Guid.Empty)
            {
                this.PrintJson("0", "您还未登录!");
                return;
            }
            else
            {
                using (SqlConnection connection = new SqlConnection(TuanDai.Config.BaseConfig.ConnectionString))
                {

                    var dyParams = new DynamicParameters();
                    dyParams.Add("@UserId", userId);
                    dyParams.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);

                    connection.Execute("p_ExperienceGoldInvest", dyParams, null, null, CommandType.StoredProcedure);
                    result = dyParams.Get<int>("@outStatus").ToString();

                    connection.Close();
                    connection.Dispose();
                    this.PrintJson(result, "");
                }
            }
        }
        #endregion

        #region 获取手机验证码
        public void GetPhoneRegCode()
        {
            TuanDaiDB.JunTeEntities db = new TuanDaiDB.JunTeEntities();
            string mobileNumber = HttpContext.Current.Request["mobilenumber"];
            if (string.IsNullOrEmpty(mobileNumber))
            {
                PrintJson("0", "手机号码不能为空");
                return;
            }
            string validcode = HttpContext.Current.Request["ValidCode"];
            string strCode = HttpContext.Current.Session["webcheckcode"] == null ? "" : HttpContext.Current.Session["webcheckcode"].ToString();
            HttpContext.Current.Session["webcheckcode"] = null;
            if (string.IsNullOrEmpty(validcode) || validcode.ToLower() != strCode.ToLower())
            {
                PrintJson("0", "图形验证码错误");
                return;
            }

            string phoneRegex = @"^1[3|4|5|8][0-9]\d{4,8}$";
            if (!Regex.IsMatch(mobileNumber, phoneRegex))
            {
                PrintJson("0", "手机号码格式不正确");
                return;
            }

            string strIP = Tool.WebFormHandler.GetIP();
            DateTime enddate = DateTime.Parse(DateTime.Now.AddDays(-1).ToShortDateString());
            int count = db.CodeRecord.Where(p => (p.token == strIP || p.TypeValue == mobileNumber) && p.AddDate >= enddate).Count();
            if (count > 5 && strIP != "121.13.249.210")
            {
                PrintJson("0", "发送失败：验证码获取太频繁！");
            }

            TuanDaiDB.UserBasicInfo ubInfo = db.UserBasicInfo.FirstOrDefault(p => p.TelNo == mobileNumber);
            string random = "";
            if (ubInfo != null)
            {
                PrintJson("0", "此手机号码已注册");
            }
            random = StringUtilily.GetRandomString(6);

            TuanDaiDB.CodeRecord codeRcord = new TuanDaiDB.CodeRecord();
            codeRcord.AddDate = DateTime.Now;
            codeRcord.Code = random;
            codeRcord.Id = Guid.NewGuid();
            codeRcord.Status = (int)ConstString.MSCodeStatus.Unused;

            codeRcord.token = strIP;
            codeRcord.Type = (int)ConstString.MSCodeType.PhoneCode;
            codeRcord.Type2 = (int)ConstString.MSCodeType2.RegPhoneValid;
            codeRcord.TypeValue = mobileNumber;
            codeRcord.UserId = null;
            db.CodeRecord.AddObject(codeRcord);

            int result = db.SaveChanges();
            if (result > 0)
            {
                var parameters = new Dictionary<string, object>();
                parameters.Add("ValidateCode", random);

                var msgSender = new BusinessDll.MessageSend();
                var sendResult = msgSender.SendMessage2(option: SendOption.Sms,
                    eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: mobileNumber);

                if (sendResult != "1")
                {
                    PrintJson("0", "发送失败：发送短信验证码异常！");
                }
                else
                {
                    PrintJson("1", "");
                }
            }
            else
            {
                PrintJson("-2", "注册失败");
            }
        }
        #endregion

        #region 私有方法
        private string GetRandomPassword(int num)
        {
            char[] Pattern = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };
            string result = "";
            int n = Pattern.Length;
            System.Random random = new Random(~unchecked((int)DateTime.Now.Ticks));
            for (int i = 0; i < num; i++)
            {
                int rnd = random.Next(0, n);
                result += Pattern[rnd];
            }
            return result;
        }
        #endregion
    }
}