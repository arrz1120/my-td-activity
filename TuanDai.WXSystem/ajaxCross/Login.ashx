﻿<%@ WebHandler Language="C#"  Class="TuanDai.WXApiWeb.ajaxCross.Login" %>
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Web.Configuration;
using NetDimension.Json;
using Newtonsoft.Json.Serialization;
using Tool;
using BusinessDll;
using System.Text;
using TuanDai.Enums;
using TuanDai.Enums.Sms;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.DAL;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.Model.Enums;
using System.Data.SqlClient;
using System.Data.Objects;
using TuanDai.InfoSystem.Model;
using TuanDai.SMS.Client;
using TuanDai.UserInfo.Client;
using TuanDai.UserInfo.Model;
using TuanDai.WXApiWeb.Common;
using System.Drawing;
using Kamsoft.Data.Dapper;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// Login 的摘要说明
    /// </summary>
    public class Login : SafeHandlerBase
    {


        #region 注册
        public void Register()
        {
            string from = HttpContext.Current.Request["from"];//注册来源
            string password = HttpContext.Current.Request["password"];//密码
            //string openId = HttpContext.Current.Request["openid"]; //微信号OpendId
            string mobileNumber = HttpContext.Current.Request["mobilenumber"];//手机号码
            string verificationCode = HttpContext.Current.Request["verificationCode"];//验证码
            string TelNo = HttpContext.Current.Request["telno"];//邀请人手机号码
            string ExtendKey = HttpContext.Current.Request["extendKey"];//邀请码

            //第三方跳投标地址记录来源信息
            if (!string.IsNullOrEmpty(CookieHelper.GetCookie("tdfrom")))
            {
                from = CookieHelper.GetCookie("tdfrom");
                CookieHelper.ClearCookie("tdfrom");
            }
            if (from.ToText().IsEmpty())
            {
                //非活动推广时记录到是在微信中注册的.
               if(GlobalUtils.IsWeiXinBrowser)
                   from = "tuandai_wxtouch"; 
            }
            
            Register(from, password, mobileNumber, verificationCode, TelNo, ExtendKey);
        }
        private void Register(string from, string password, string mobileNumber, string verificationCode, string TelNo, string ExtendKey)
        {
            string pattern1 = "^.*?[\\d]+.*$";
            string pattern2 = "^.*?[A-Za-z].*$";
            string pattern3 = "^.{6,16}$";
            if (string.IsNullOrEmpty(password))
            {
                PrintJson("0", "密码不能为空");
                return;
            }
            else
            {
                try
                {
                    password = DESC.DecryptFromHexes(password, GlobalUtils.DesKey);
                }
                catch
                {
                    PrintJson("0", "非法请求");
                    return;
                }
            }
            if (!Regex.IsMatch(password, pattern1) && !Regex.IsMatch(password, pattern2) && Regex.IsMatch(password, pattern3))
            {
                PrintJson("0", "密码格式不正确,密码必须由字符和数字组成,且长度为6-16之间");
                return;
            }
            if (string.IsNullOrEmpty(mobileNumber))
            {
                PrintJson("0", "手机号码不能为空");
                return;
            }
            if (string.IsNullOrEmpty(verificationCode))
            {
                PrintJson("0", "手机验证码不能为空");
                return;
            }

            UserBLL bll = new UserBLL();
            var userName = bll.StrGetUserName();
            //SqlParameter[] paramData = new SqlParameter[] { new SqlParameter("@TelNo", mobileNumber), new SqlParameter("@UserName", userName) };
            //UserBasicInfoInfo model = bll.WXGetUserBasicInfo("TelNo=@TelNo or UserName=@UserName", paramData);
            var model = bll.GetUserBasicInfoModelByTelNo(mobileNumber);
            //if (model == null)
            //{
            //    model = bll.GetUserBasicInfoModelByTelNo(userName);
            //}
            if (model != null && model.UserTypeId == 9)
            {
                PrintJson("0", "手机号已注册，可直接登录");
                return;
            }
            if (model != null)
            {
                PrintJson("0", "手机号已注册，可直接登录");
                return;
            }

            //UserBasicInfoInfo userBasicEntity = bll.WXGetUserBasicInfo("OpenId=" + openId.Quoted());  
            //if (userBasicEntity != null)
            //{
            //    string msg = (userBasicEntity.IsBindOpenId.HasValue && userBasicEntity.IsBindOpenId.Value==false) || !userBasicEntity.IsBindOpenId.HasValue ? "此帐号已存在不需要再注册,请绑定微信号" : "您的微信号已绑定请更换微信号再注册";
            //    string status = "0";
            //    PrintJson(status, msg);
            //    return;
            //}
            MemberRegister(from, userName, password, mobileNumber, verificationCode, TelNo, ExtendKey);
        }
        #region 注册、绑定微信号
        private void MemberRegister(string from, string userName, string password, string mobileNumber, string verificationCode, string TelNo, string ExtendKey)
        {
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
            //int codeResult = BusinessDll.Users.CheckCodeRecord(ConstString.MSCodeType.PhoneCode, ConstString.MSCodeType2.RegPhoneValid, mobileNumber, verificationCode);
            int codeResult = new CodeRecordBLL().CheckCodeRecord(verificationCode, mobileNumber, MsCodeType.PhoneCode, MsCodeType2.RegPhoneValid, null);
            if (codeResult != 1)
            {
                PrintJson("0", "注册失败：验证码错误或已过期,请重新获取输入");
            }
            string ExtenderKey = "";
            if (!string.IsNullOrEmpty(TelNo))
            {
                UserBLL bll = new UserBLL();
                var model = bll.GetUserBasicInfoModelByTelNo(TelNo);
                if (model != null && !string.IsNullOrEmpty(model.ExtendKey))
                {
                    ExtenderKey = model.ExtendKey;
                }
            }
            else
            {
                ExtenderKey = ExtendKey;
            }
            Guid userid = Guid.NewGuid();
            var userbasicEntity = WXRegister.AddUserInfo(userid, from, password, mobileNumber, ExtenderKey, "", "", "", 0, RealIP);
            if (userbasicEntity != null)
            {
                TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userid, (int)ConstString.UserGrowthType.EveryDayFirstLogin, null, 0);
                
                WebLog log = new WebLog();
                log.AddDate = DateTime.Now;
                log.BusinessId = userbasicEntity.Id.ToString();
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Add;
                log.UserId = userid.ToString();
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.InformSetting;
                log.Content1 = "触屏版注册当前URL：" + HttpContext.Current.Request.RawUrl + "上次URL：" +
                               HttpContext.Current.Request.UrlReferrer;
                log.Id = Guid.NewGuid().ToString();
                WebLogInfo.WriteLoginHandler(log);

                #region 注册后登录调用java接口单点登录
                try
                {
                    string PassportWebUrl = GlobalUtils.PassportWebUrl;
                    if (!PassportWebUrl.Contains("http"))
                    {
                        PassportWebUrl = "http:" + PassportWebUrl;
                    }
                    string posturl = PassportWebUrl + "/app/getToken";

                    //随机6位数
                    int num = new Random().Next(100000, 1000000);
                    //加密前
                    string postParmBeforeJM = "{\"userId\":\"" + userbasicEntity.Id.ToString() +
                                      "\",\"rvk\":\"" + num + "\",reqFrom:\"2\"}";
                    //公钥
                    //string pulickKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCEi/Uf1Pp6ozypXlgh1Sik6Qzkc0alKTw7mcqf5yNQcpaQgS2RuASOmzRJXAro/ezAOYqczJZpeP8erpiLGMR6jcQWYG+6Ykp2G/tvxBHNexYcZtC6xNkIScAAO4ybdUQUotIvOMQ1tTfjD0IFcBhAfyosvlKr4EuevNv/MJQrGwIDAQAB";
                    string pulickKey = ConfigHelper.getConfigString("JavaLoginPublicKey");
                    
                    //加密后
                    string postParmAfterJM = TuanDai.WXSystem.Core.Common.RSAJiaMi.encrypt(Encoding.UTF8.GetBytes(postParmBeforeJM), pulickKey, "utf-8");
                    //Java返回Json
                    string responseString = Tool.HttpUtils.HttpPost(posturl,"{\"data\":\"" + postParmAfterJM + "\"}" ,"application/json");
                    //序列化
                    JavaResponseResult jRes = new JavaResponseResult();
                    if (!string.IsNullOrEmpty(responseString))
                        jRes = JsonConvert.DeserializeObject<JavaResponseResult>(responseString);
                    if (jRes.success)
                    {
                        string getUrl = PassportWebUrl + "/app/mlogin?token=" + jRes.models.visitToken + "&rvk=" + num +
                                        "&rdr=0&ret=";
                        //Tool.HttpUtils.HttpGet(getUrl);
                        PrintJson("1",getUrl);
                    }
                }
                catch (WebException ex)
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "RegisterEndLogin", "注册后登录", ex.Message);
                    PrintJson("1", "");
                }
                #endregion

                PrintJson("1", "");
            }
            PrintJson("0", "注册失败");
        }

        #endregion
        
        #endregion

        #region 登录
        public void LoginSubmit()
        {
            string userName = WEBRequest.GetFilterHTMLString("username");
            string password = HttpContext.Current.Request["password"];

            string code = HttpContext.Current.Request["verificationCode"];
            LoginSubmit(userName, password, code);
        }
        private void LoginSubmit(string userName, string password, string code)
        {
            if (string.IsNullOrEmpty(userName))
            {
                PrintJson("-1", "用户名不能为空");
                return;
            }
            else
            {
                try
                {
                    userName = DESC.DecryptFromHexes(userName, GlobalUtils.DesKey);
                }
                catch
                {
                    PrintJson("-1", "非法请求");
                    return;
                }
            }

            //string isNumRegex = @"^\d+(\.)?\d*$";
            //string phoneRegex = @"^(?:13\d|15\d|18\d)\d{5}(\d{3}|\*{3})$";
            //if (Regex.IsMatch(userName, isNumRegex) && !Regex.IsMatch(userName, phoneRegex))
            //{
            //    PrintJson("-1", "手机号码格式不正确");
            //    return;
            //}
            if (string.IsNullOrEmpty(password))
            {
                PrintJson("-1", "密码不能为空");
                return;
            }
            else
            {
                try
                {
                    password = DESC.DecryptFromHexes(password, GlobalUtils.DesKey);
                }
                catch
                {
                    PrintJson("-1", "非法请求");
                    return;
                }
            }
            //if (password.Length < 6 && password.Length > 16)
            //{
            //    PrintJson("-1", "密码长度必须为在6-16个字符");
            //    return;
            //}
            UserBLL userBll = new UserBLL();
            //集成第三方登录 Allen 2015-07-04
            string thirdParty = WEBRequest.GetString("ThirdParty");
            int IsThirdPartyId = 0;

            if (!string.IsNullOrWhiteSpace(thirdParty))
            {
                thirdParty = thirdParty.ToLower();
                IsThirdPartyId = 1;
            }

            LoginResult loginResult = userBll.Login(userName, password, thirdParty, IsThirdPartyId);
            if (loginResult == null)
            {
                PrintJson("-2", "请求服务端时出错");
                return;
            }
            string returnUrl = WEBRequest.GetString("returnUrl");
            switch (loginResult.ResultStatus)
            {
                case 1:
                    {
                        #region
                        UserBasicInfoInfo userBasicObj = userBll.GetUserBasicInfoModelById(loginResult.UserId);
                        if (userBasicObj == null)
                        {
                            PrintJson("-1", "用户名或密码不正确");
                            return;
                        }
                        
                        Tool.CookieHelper.WriteCookie("TDW_WapUserName", userBasicObj.UserName);

                        string DOMAINNAME = ConfigurationManager.AppSettings["CookieDomain"];
                        
                        #region Modify By HuangJianQin 2016-02-16 老代码，会造成一个客户有多个账户（在同一台电脑登录）时，其他的账户漏发成长值。在cookie里加上用户名
                        string strLastLoginDate = DateTime.Now.ToString("yyyy-MM-dd") + userBasicObj.UserName;
                        if (string.IsNullOrEmpty(CookieHelper.GetCookie("TDLastLoginDate")) || CookieHelper.GetCookie("TDLastLoginDate") != strLastLoginDate)
                        {
                            TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userBasicObj.Id, (int)ConstString.UserGrowthType.EveryDayFirstLogin, null, 0);
                        }

                        Tool.CookieHelper.WriteCookie(DOMAINNAME, "TDLastLoginDate", strLastLoginDate);
                        #endregion
                        
                        //在微信上访问时才要写入
                        if (GlobalUtils.IsWeiXinBrowser)
                        {
                            string OpenId = GlobalUtils.OpenId;
                            if (OpenId.IsNotEmpty())
                            {
                                Action doBinderWX = new Action(delegate()
                                {
                                    //userBll.WXBinderWeiXin(userBasicObj.Id.ToString(), OpenId);
                                    //登录成功后绑定oppenId
                                    string errMsg = string.Empty;
                                    TuanDai.SMS.Client.MessageSetClient.UpdateMsgSetInfoWeixinOpenId(loginResult.UserId,
                                        OpenId, ref errMsg);
                                   
                                });
                                doBinderWX.BeginInvoke(null, null);
                                 
                                //首次绑定服务号
                                VipGetTuanBiTaskBLL.FirstBindServiceAccount(userBasicObj.Id);
                            }
                            else
                            {
                                OpenId = WeiXinApi.GetUserWXOpenId(userBasicObj.Id);
                                GlobalUtils.WriteOpenIdToCookie(OpenId.ToText());
                            }
                        }
                        WebUserAuth.SignIn(userBasicObj.Id.ToString());

                        // 保存登录日志  
                        string strIP = Tool.WebFormHandler.GetIP(); 
                        try
                        {
                            Action writeLog = new Action(() => AddUserLoginLog(userBasicObj.Id, strIP));
                            writeLog.BeginInvoke(null, null); 
                        }
                        catch { } 

                        //登录成功发短信通知 
                        if (userBasicObj != null)
                        {
                            try
                            {
                                var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                                if (isNewSmsRequest == "0")
                                {
                                    var parameters = new Dictionary<string, object>();
                                    parameters.Add("CurrentDate", DateTime.Now);
                                    parameters.Add("User", userBasicObj);
                                    parameters.Add("ClientIP", strIP);
                                    var messageSender = new MessageSend();
                                    messageSender.SendMessage2(eventCode: MessageTemplates.LoginSuccess, parameters: parameters,
                                          mobile: userBasicObj.TelNo, email: userBasicObj.Email, userId: userBasicObj.Id);
                                }
                                else
                                {
                                    SmsRequest loginSuccessSmsRequest = new SmsRequest();
                                    loginSuccessSmsRequest.EventCode = MsgTemplatesType.LoginSuccess;
                                    loginSuccessSmsRequest.PlatformSource = PlatformSource.WeiXin;
                                    loginSuccessSmsRequest.UserId = userBasicObj.Id;
                                    loginSuccessSmsRequest.EmailAddress = userBasicObj.Email;
                                    loginSuccessSmsRequest.Mobile = userBasicObj.TelNo;
                                    string errorMessage = string.Empty;
                                    SmsClient.SendMessage(loginSuccessSmsRequest, ref errorMessage);
                                }
                                
                            }
                            catch { }
                        }
                        //加上生日祝福跳转 Allen 2015-08-27
                        //string birthDayUrl = "";
                        //if (CheckUserBirthDay(userBasicObj, ref birthDayUrl))
                        //{
                        //    returnUrl = birthDayUrl;
                        //}
                        PrintJson("1", returnUrl);
                        return;
                        #endregion
                    }
                case 3:
                    PrintJson("0", loginResult.FailedPwdCount.ToString()); //密码错误
                    return;
                case 4: //账户冻结
                    UserBasicInfoInfo userObj = userBll.GetUserBasicInfoModelById(loginResult.UserId);
                    if (userObj.uStatus == 0)
                    {
                        PrintJson("0", "0");
                        return;
                    }
                    else
                    {
                        //UserBasicDetail model = db.UserBasicDetails.FirstOrDefault(p => p.UserId == loginResult.UserId);
                        var model = new UserBLL().GetUserBasicDetailByUserId(loginResult.UserId);
                        PrintJson("-2", "因连续输错5次密码，您的账户已被冻结。解冻时间：" + Convert.ToDateTime(model.FailedPasswordDate).AddDays(1).ToString("yyyy-MM-dd日 HH:mm") + "");
                        return;
                    }
            }
            if (loginResult.ResultStatus == 2)
            {
                PrintJson("-3", "用户不存在");
            }
        } 
        private void AddUserLoginLog(Guid userId,string clientIP) {
            TuanDai.WXApiWeb.SysLogHelper.AddLoginLog(new TuanDai.InfoSystem.Model.LoginLog
            {
                DeviceName = "微信端",
                DeviceType = "WeiXin",
                Id = Guid.NewGuid().ToString(),
                IpAddress = clientIP,
                LoginDate = DateTime.Now,
                UserId = userId.ToString(),
                MachineCode = "",
                Version = "",
                Channel = ""
            });
        }
        //判断是否绑定过第三帐户
        public void CheckThirdLoginBind()
        {
            string userName = WEBRequest.GetFilterHTMLString("username");
            UserBLL bll = new UserBLL();
            UserBasicInfoInfo userInfor = bll.GetUserBasicInfoModelByUserName(userName);
            if (userInfor != null && userInfor.ThirdPartyId.IsNotEmpty())
            {
                PrintJson("-1", "对不起，账户“" + userName + "”已经绑定其他第三方帐号，不允许再重新绑定。");
                return;
            }
            PrintJson("1", "");
        }
        //检查用户是否当天生日
        private bool CheckUserBirthDay(UserBasicInfoInfo userBasicObj, ref string returnUrl)
        {
            try
            {
                if (userBasicObj == null || userBasicObj.Birthday.HasValue == false)
                    return false;
                if (userBasicObj.IsValidateIdentity && userBasicObj.Birthday.Value.ToString("MM-dd") == DateTime.Today.ToString("MM-dd"))
                {
                    //using (SqlConnection connection = new SqlConnection(TuanDai.Config.BaseConfig.ActivityConnectionString))
                    //{
                    //    connection.Open();
                    string strSQL = " select count(1) from Activity_UserBirthday with(nolock) where UserId=@UserId and [Year]=@Year";
                    var dyParams = new Dapper.DynamicParameters();
                    dyParams.Add("@UserId", userBasicObj.Id);
                    dyParams.Add("@Year", DateTime.Today.Year);
                    //int icount = connection.Query<int>(strSQL, dyParams).FirstOrDefault();
                    int icount = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.DBActivityWrite, strSQL,
                        ref dyParams);
                    if (icount == 0)
                    {
                        returnUrl = GlobalUtils.ActivityWebsiteUrl + "/weixin/birthday/index.aspx";
                        return true;
                    }
                    //}
                }
                return false;
            }
            catch
            {
                return false;
            }
        }
        #endregion

        #region 获取手机验证码
        public void GetPhoneRegCode()
        {
            string mobileNumber = HttpContext.Current.Request["mobilenumber"];
            if (string.IsNullOrEmpty(mobileNumber))
            {
                PrintJson("0", "手机号码不能为空");
                return;
            }
            //string validcode = HttpContext.Current.Request["ValidCode"];
            //string strCode = HttpContext.Current.Session["webcheckcode"] == null ? "" : HttpContext.Current.Session["webcheckcode"].ToString();   
            //HttpContext.Current.Session["webcheckcode"] = null;  
                   
            //string validcode = Encryption.MD5(HttpContext.Current.Request["ValidCode"].ToText().ToLower());
            //string strCode = CookieHelper.GetCookie("tuandai005") == null ? "" : CookieHelper.GetCookie("tuandai005").ToString();
            //CookieHelper.ClearCookie("tuandai005");
            //if (string.IsNullOrEmpty(validcode) || validcode.ToLower() != strCode.ToLower())
            //{
            //    PrintJson("0", "图形验证码错误");
            //    return;
            //}

            string[] buffer = { "qwewqw", "8werwer", "ewere0", "882dsfdsf", "8sdfdsf", "asdfasd889", "999dsfdfd", "vv8878788", "werewr8888", "877webbrwe" };

            object s_buffer = Context.Session["tuandainame"];

            if (s_buffer == null)
            {
                PrintJson("0", "");
            }
            else
            {
                if (!buffer.Contains(s_buffer.ToString()))
                {
                    PrintJson("0", "");
                }
            }

            string phoneRegex = @"^1[1|2|3|4|5|6|7|8|9][0-9]\d{4,8}$";
            if (!Regex.IsMatch(mobileNumber, phoneRegex))
            {
                PrintJson("0", "手机号码格式不正确");
                return;
            }

            string strIP = Tool.WebFormHandler.GetIP();
            DateTime enddate = DateTime.Parse(DateTime.Now.AddDays(-1).ToShortDateString());
            //int count = db.CodeRecord.Where(p => (p.token == strIP && p.TypeValue == mobileNumber) && p.AddDate >= enddate).Count();
            //if (count > 5 && (strIP != "121.13.249.210" || strIP != "113.91.166.242"))
            //{
            //    PrintJson("0", "发送失败：验证码获取太频繁！");
            //}
            var canSend = new CodeRecordBLL().IsCanSendNewCodeRecord(mobileNumber, MsCodeType.PhoneCode, MsCodeType2.RegPhoneValid,
                null, 1, strIP);
            if (!canSend.Success)
            {
                PrintJson(canSend.Code.ToString(), canSend.Message);
            }
            

            //UserBasicInfo ubInfo = db.UserBasicInfo.FirstOrDefault(p => p.TelNo == mobileNumber);
            var ubInfo = new UserBLL().GetUserBasicInfoModelByTelNo(mobileNumber);
            //string random = "";
            if (ubInfo != null)
            {
                PrintJson("0", "手机号已注册，可直接登录");
            }
            //random = StringUtilily.GetRandomString(6);

            //CodeRecord codeRcord = new CodeRecord();
            //codeRcord.AddDate = DateTime.Now;
            //codeRcord.Code = random;
            //codeRcord.Id = Guid.NewGuid();
            //codeRcord.Status = (int)ConstString.MSCodeStatus.Unused;

            //codeRcord.token = strIP;
            //codeRcord.Type = (int)ConstString.MSCodeType.PhoneCode;
            //codeRcord.Type2 = (int)ConstString.MSCodeType2.RegPhoneValid;
            //codeRcord.TypeValue = mobileNumber;
            //codeRcord.UserId = null;
            //db.CodeRecord.AddObject(codeRcord);
            var code = new CodeRecordBLL().CreateCodeRecordInfo(null, strIP, MsCodeType.PhoneCode,
                MsCodeType2.RegPhoneValid, mobileNumber);
            //int result = db.SaveChanges();
            //if (result > 0)
            if(code != null)
            {
                var parameters = new Dictionary<string, object>();
                parameters.Add("ValidateCode", code.Code);

                var msgSender = new BusinessDll.MessageSend();
                var sendResult = "0";
                if (ConfigHelper.getConfigString("IsTestOrDev","0") == "1")
                {
                    sendResult = "1";
                }
                else
                {
                    sendResult = msgSender.SendMessage2(option: SendOption.Sms,
                    eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: mobileNumber);
                }
                

                if (sendResult != "1")
                {
                    //PrintJson("0", "发送失败：发送短信验证码异常！");
                    if(sendResult == "-5")
                        PrintJson("-5", "一天之内最多发送5次！");
                    else if (sendResult == "-3")
                        PrintJson("-3", "1分钟内不能重复发送！");
                    else if(sendResult == "0")
                        PrintJson("0", "系统繁忙，请稍候重试！");
                    else
                        PrintJson("0", "系统繁忙，请稍候重试！");
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

        #region 获取手机语音验证码
        public void GetPhoneRegVoiceCode()
        {
            string mobileNumber = HttpContext.Current.Request["mobilenumber"];
            if (string.IsNullOrEmpty(mobileNumber))
            {
                PrintJson("0", "手机号码不能为空");
                return;
            }
            //string validcode = HttpContext.Current.Request["ValidCode"];
            //string strCode = HttpContext.Current.Session["webcheckcode"] == null ? "" : HttpContext.Current.Session["webcheckcode"].ToString();
            //HttpContext.Current.Session["webcheckcode"] = null;
            //if (string.IsNullOrEmpty(validcode) || validcode.ToLower() != strCode.ToLower())
            //{
            //    PrintJson("0", "图形验证码错误");
            //    return;
            //}

            string[] buffer = { "qwewqw", "8werwer", "ewere0", "882dsfdsf", "8sdfdsf", "asdfasd889", "999dsfdfd", "vv8878788", "werewr8888", "877webbrwe" };

            object s_buffer = Context.Session["tuandainame"];

            if (s_buffer == null)
            {
                PrintJson("0", "");
            }
            else
            {
                if (!buffer.Contains(s_buffer.ToString()))
                {
                    PrintJson("0", "");
                }
            }

            string phoneRegex = "^(13|14|15|17|18)[0-9]{9}$";
            if (!Regex.IsMatch(mobileNumber, phoneRegex))
            {
                PrintJson("0", "手机号码格式不正确");
                return;
            }

            string strIP = Tool.WebFormHandler.GetIP();
            DateTime enddate = DateTime.Parse(DateTime.Now.AddDays(-1).ToShortDateString());
            //int count = db.CodeRecord.Where(p => (p.token == strIP && p.TypeValue == mobileNumber) && p.AddDate >= enddate).Count();
            //if (count > 5 && (strIP != "121.13.249.210" || strIP != "113.91.166.242"))
            //{
            //    PrintJson("0", "发送失败：验证码获取太频繁！");
            //}
            var canSend = new CodeRecordBLL().IsCanSendNewCodeRecord(mobileNumber, MsCodeType.PhoneCode, MsCodeType2.RegPhoneValid,
                null, 1, strIP);
            if (!canSend.Success)
            {
                PrintJson(canSend.Code.ToString(), canSend.Message);
            }

            //UserBasicInfo ubInfo = db.UserBasicInfo.FirstOrDefault(p => p.TelNo == mobileNumber);
            var ubInfo = new UserBLL().GetUserBasicInfoModelByTelNo(mobileNumber);
            string random = "";
            if (ubInfo != null)
            {
                PrintJson("0", "手机号已注册，可直接登录");
            }
            //random = StringUtilily.GetRandomString(6);
            


            //CodeRecord codeRcord = new CodeRecord();
            //codeRcord.AddDate = DateTime.Now;
            //codeRcord.Code = random;
            //codeRcord.Id = Guid.NewGuid();
            //codeRcord.Status = (int)ConstString.MSCodeStatus.Unused;

            //codeRcord.token = strIP;
            //codeRcord.Type = (int)ConstString.MSCodeType.PhoneCode;
            //codeRcord.Type2 = (int)ConstString.MSCodeType2.RegPhoneValid;
            //codeRcord.TypeValue = mobileNumber;
            //codeRcord.UserId = null;
            //db.CodeRecord.AddObject(codeRcord);

            //int result = db.SaveChanges();
            //if (result > 0)
            var code = new CodeRecordBLL().CreateCodeRecordInfo(null, strIP, MsCodeType.PhoneCode,
                MsCodeType2.RegPhoneValid, mobileNumber);
            if(code != null)
            {
                var msgSender = new BusinessDll.MessageSend();
                msgSender.SendMessage2(option: SendOption.Voice, eventCode: MessageTemplates.ValidateCode, mobile: mobileNumber, content: code.Code);
                PrintJson("1", "");
            }
            else
            {
                PrintJson("-2", "注册失败");
            }
        }
        #endregion

        #region 验证用户名
        /// <summary>
        /// 检查用户名是否存在
        /// </summary>
        public void CheckUserName()
        {
            string sUserName = HttpContext.Current.Request["username"];
            UserBLL userBll = new UserBLL();
            //SqlParameter[] paramDatas = new SqlParameter[] { new SqlParameter("@UserName", sUserName), new SqlParameter("@TelNo", sUserName) };
            //UserBasicInfoInfo model = userBll.WXGetUserBasicInfo("UserName=@UserName or TelNo=@TelNo", paramDatas);
            var model = userBll.GetUserBasicInfoModelByTelNo(sUserName);
            if (model != null)
                PrintJson("1", "手机号已注册，可直接登录");
            else
                PrintJson("0", "");
        }
        #endregion

        #region 退出登录解除绑定微信
        public void logout()
        {
            Guid userId = WebUserAuth.UserId ?? Guid.Empty;
            UserBLL userBll = new UserBLL();
            UserBasicInfoInfo userBasicObj = userBll.GetUserBasicInfoModelById(userId);
            if (userBasicObj != null)
            {
                try
                {
                    TuanDai.WXApiWeb.WebUserAuth.SignOut();
                    //移除OpenId allen 2015-07-30
                    TuanDai.WXApiWeb.GlobalUtils.ClearOpenIdFromCookie();
                }
                catch (Exception ex)
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog("WXTouch","退出报错",ex.Message,"");
                }
                
                //解除绑定与退出
                //if (userBll.WXUnBinderWeiXin(userId.ToText(), GlobalUtils.OpenId))
                //{
                //    WebUserAuth.SignOut();
                //    //移除OpenId allen 2015-07-30
                //    GlobalUtils.ClearOpenIdFromCookie();
                //    PrintJson("1", "");
                //    return;
                //}
                PrintJson("1", "");
                return;
            }
            
            PrintJson("0", "");
        }
        #endregion

        #region 用户购买Vip
        // 用户购买Vip  Allen 2015-07-31
        public void UpgradeUserVip()
        {
            Guid? userId = WebUserAuth.UserId;
            if (userId==null||userId==Guid.Empty)
            {
                PrintJson("-3", "您还未登录!");
                return;
            }
            
            int month = WEBRequest.GetFormInt("Month", 0);
            int iType = WEBRequest.GetFormInt("IType", 0);
            if (month <= 0 || iType == 0)
            {
                PrintJson("-2", "参数异常!");
                return;
            }
            #region 验证交易密码
            var user = new UserBLL().GetUserBasicInfoModelById(userId.Value);
            string PayPwd = Tool.Encryption.MD5(WEBRequest.GetString("Pwd"));
            if (string.IsNullOrEmpty(PayPwd))
            {
                this.PrintJson("-5", "交易密码不能为空");
            }
            UserSettingDAL usDal = new UserSettingDAL();
            UserSettingInfo usersetting = usDal.GetUserSettingInfo(userId.Value);
            if (usersetting != null)
            {
                if (usersetting.PayPwdErrorDate.HasValue)
                {
                    DateTime date1 = Convert.ToDateTime(usersetting.PayPwdErrorDate.Value.ToString("yyyy/MM/dd"));
                    DateTime date2 = Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd"));
                    if (date1 == date2 && usersetting.PayPwdErrorCount >= 5)
                    {
                        this.PrintJson("-5", "交易密码已错误5次，请24小时后再进行此操作");
                    }
                    if (date1 != date2 && usersetting.PayPwdErrorCount > 1)
                    {
                        usersetting.PayPwdErrorCount = 0;
                        usersetting.PayPwdErrorDate = null;
                    }
                }

            }
            else
            {
                usersetting = new UserSettingInfo();
                usersetting.Id = Guid.NewGuid();
                usersetting.UserId = userId.Value;
                usersetting.IsTenderNeedPayPassword = false;
                usersetting.IsAllowChangePwd = true;
                usersetting.PayPwdErrorCount = 0;
                usersetting.PayPwdErrorDate = null;
                usDal.AddUserSettingInfo(usersetting);
            }

            if (user.PayPwd != PayPwd)
            {
                //记录登录错误次数
                if (usersetting.PayPwdErrorCount == null)
                {
                    usersetting.PayPwdErrorCount = 0;
                }
                usersetting.PayPwdErrorCount += 1;
                usersetting.PayPwdErrorDate = DateTime.Now;
                usDal.UpdateUserSettingInfo(usersetting);
                if (usersetting.PayPwdErrorCount >= 5)
                {
                    this.PrintJson("-6", "今日交易密码已错误5次，请24小时后再进行此操作！");
                }
                else
                {
                    this.PrintJson("-7", "交易密码错误，今日还有" + (5 - usersetting.PayPwdErrorCount) + "次机会，错误5次将锁定24小时！");
                }
                return;
            }
            else
            {
                //清除错误记录
                usersetting.PayPwdErrorCount = 0;
                usersetting.PayPwdErrorDate = null;
                usDal.UpdateUserSettingInfo(usersetting);
            }
            #endregion
            string ErrMsg = "";
            UserBLL bll = new UserBLL();
            bool isSuc = bll.WXUserByVIP(userId.Value, month, iType, out  ErrMsg);
            if (isSuc)
            {
                //必须是购买时才有成长值
                if (iType == 1)
                {
                    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userId.Value, (int)ConstString.UserGrowthType.BuyOneMonthVIP, null, 100 * month);
                }
                PrintJson("1", "恭喜您，升级成功，会员期限延长至:" + ErrMsg);
                return;
            }
            else
            {
                PrintJson("0", ErrMsg);
                return;
            }
        }

        //兑换vip
        public void RechargeVip()
        {
            string strpwd = Context.Request["pwd"];
            Guid? userid = WebUserAuth.UserId;
            if (userid == null || userid == Guid.Empty)
            {
                PrintJson("-3", "您还未登录!");
                return;
            }
            if (strpwd.IsEmpty())
            {
                PrintJson("-4", "参数传入异常!");
                return;
            }
            //ObjectParameter outStatus = new ObjectParameter("outStatus", 0);
            //db.p_MemberVoucherHander("", userid, strpwd, outStatus);
            //PrintJson(outStatus.Value.ToString(), "");
            var paras = new Dapper.DynamicParameters();
            paras.Add("@cardid","");
            paras.Add("@userid", userid);
            paras.Add("@cardpwd", strpwd);
            paras.Add("@outStatus", 0,DbType.Int32,ParameterDirection.Output);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.DBUserWrite, "p_MemberVoucherHander", ref paras,CommandType.StoredProcedure);
            PrintJson(paras.Get<int>("@outStatus").ToString(), "");
        }
        #endregion

        /// <summary>
        /// 检查手机是否存在
        /// </summary>
        public void CheckPhone()
        {
            Uri uri = Context.Request.UrlReferrer;
            if (uri == null)
            {
                PrintJson("True", "");
            }
            string requestUrl = uri.AbsoluteUri.ToLower();
            if (requestUrl.LastIndexOf("register.aspx") <= 0 && requestUrl.LastIndexOf("register.html") <= 0 && requestUrl.LastIndexOf("registerapp.aspx") <= 0)
            {
                PrintJson("True", "");
            }
            string CheckPhone = Context.Request["mobilenumber"];
            if (string.IsNullOrWhiteSpace(CheckPhone))
            {
                PrintJson("True", "");
            }
            //JunTeEntities db2 = JunTeEntities.Read();
            //UserBasicInfo model = db2.UserBasicInfo.FirstOrDefault(p => p.TelNo == CheckPhone || p.UserName == CheckPhone);
            var model = new UserBLL().GetUserBasicInfoModelByTelNo(CheckPhone);
            string returnMessage = model != null ? "True" : "False";
            string msg = "";
            if (model != null && model.UserTypeId == 9)
                msg = "手机号已注册，可直接登录";
            if(model != null)
                msg = "手机号已注册，可直接登录";
            string[] buffer = { "qwewqw", "8werwer", "ewere0", "882dsfdsf", "8sdfdsf", "asdfasd889", "999dsfdfd", "vv8878788", "werewr8888", "877webbrwe" };
            Random r = new Random();
            Context.Session["tuandainame"] = buffer[r.Next(0, 9)];
            PrintJson(returnMessage, msg);
        }
        
        protected class JavaResponseResult
        {
            public bool success { get; set; }

            public JavaToken models { get; set; }
        }

        protected class JavaToken
        {
            public string visitToken { get; set; }
        }
    }
}
