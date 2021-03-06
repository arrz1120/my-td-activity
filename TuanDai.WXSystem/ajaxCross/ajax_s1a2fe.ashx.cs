﻿using System;
using System.Web; 
using System.Linq;
using System.Web.SessionState;
using Newtonsoft.Json;
using Tool;
using System.Text;
using System.Data.Objects;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using TuanDai.Enums;
using TuanDai.Enums.Sms;
using TuanDai.InfoSystem.Client_New;
using Tuandai.ServiceStackRedis;
using TuanDai.SMS.Client;
using TuanDai.UserInfo.Client;
using TuanDai.UserInfo.Model;
using TuanDai.WXApiWeb;
using BusinessDll;
using System.Text.RegularExpressions;
using TuanDai.InfoSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.Model.Enums;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;
using TuanDai.WXSystem.Core;
using ZooKeeperNet;


namespace TuanDai.WXApiWeb.ajaxCross
{

    /// <summary>
    /// ajax_safe 的摘要说明
    /// </summary>
    public class ajax_s1a2fe : SafeHandlerBase
    {
        //定义一个私有成员变量，用于Lock   
        private static object lockobj = new object();

        /// <summary>
        /// 验证身份证
        /// </summary>
        public void setidcard()
        {
            lock (lockobj)
            {
                string realname = Context.Request["realname"];
                string idcard = Context.Request["idcard"];
                string CredTypeId = Context.Request["CredTypeId"];
                Guid userId = WebUserAuth.UserId.Value; 
                
                UserBasicInfoInfo model = new UserBLL().GetUserBasicInfoModelById(userId);

                if (model == null)
                {
                    PrintJson("-1", "验证失败：用户信息错误，请重新登录");
                }

                if (model.AuthenState == 2 || model.IsValidateIdentity)//如果已经完成验证
                    PrintJson("-2", "验证失败：已经验证，不能重复验证");

                string IdentityCardRegex = "(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)";//验证身份证
                if (model.UserTypeId == 1 && CredTypeId == "1" && System.Text.RegularExpressions.Regex.IsMatch(idcard, IdentityCardRegex) == false)//个人
                {
                    PrintJson("-6", "验证失败：身份证格式不正确，请重新输入");
                }

                var user = new UserBLL().GetUserBasicInfoModelByIdentityCard(idcard);
                if (user != null)
                    PrintJson("-3", "验证失败：此证件已被使用");

                #region 团贷网征信系统实名认证 
                string IsValidateIdentity = ConfigurationManager.AppSettings["IsValidateIdentity"];
                if (IsValidateIdentity == "1")//团贷网征信系统实名认证开关
                {
                    if (model.UserTypeId == 1 && CredTypeId == "1")
                    {
                        //调用征信系统验证真实姓名和身份证号码
                        //Guid setid = Guid.Parse("A8CCC0CF-BA90-446B-945C-80EBABB77139");
                        //WebSetting set = db.WebSetting.FirstOrDefault(p => p.Id == setid);
                        var set = new WebSettingBLL().GetWebSettingInfo("A8CCC0CF-BA90-446B-945C-80EBABB77139");
                        if (set != null && set.Param1Value != null)//没有配置则不限制
                        {
                            int time1 = Tool.SafeConvert.ToInt32(set.Param1Value, 0);
                            int time2 = Tool.SafeConvert.ToInt32(set.Param2Value, 0);
                            int time3 = Tool.SafeConvert.ToInt32(set.Param3Value, 0);
                            List<WebLog> loglist = new List<WebLog>();
                            try
                            {
                               //loglist=new WebLogService().GetListWebLogInfo(UserId: TuanDai.WXApiWeb.WebUserAuth.UserId.ToString());
                                RequestContentApi requestApi = new RequestContentApi();
                                ReplyContentApi replayApi = null;

                                WebLogRequest _webLogRequest = new WebLogRequest
                                {
                                    UserId = WebUserAuth.UserId.Value.ToString()
                                };

                                string errorMessage;
                                requestApi.Data = JsonConvert.SerializeObject(_webLogRequest);
                                InfoSystemClient_New client = new InfoSystemClient_New();
                                replayApi = client.selectwhere(requestApi, out errorMessage);

                                if (replayApi != null && replayApi.DataCode == 1 && replayApi.Data != null && !string.IsNullOrEmpty(replayApi.Data.ToString()))
                                {

                                    loglist = JsonConvert.DeserializeObject<List<WebLog>>(replayApi.Data.ToString());
                                }
                            }
                            catch (Exception ex) { 
                               
                            }
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
                if (CredTypeId == "1")
                {
                    if (model.UserTypeId == 1)
                    {
                        model.sex = GetSexFromIdCard(idcard);
                        string ageTemp = model.IdentityCard.Substring(6, 8);
                        DateTime dt = Convert.ToDateTime(ageTemp.Substring(0, 4) + "-" + ageTemp.Substring(4, 2) + "-" + ageTemp.Substring(6, 2));
                        model.Birthday = dt;
                    }
                }

                model.CredTypeId = Convert.ToInt32(CredTypeId);
                model.IsValidateIdentity = true;
                if (model.IsValidateIdentity && model.IsValidateMobile)
                {
                    model.AuthenState = 4;
                }
                string strSQL = @"update dbo.UserBasicInfo set  RealName=@RealName, IdentityCard=@IdentityCard, sex=@sex,Birthday=@Birthday,
                                  CredTypeId=@CredTypeId,IsValidateIdentity=@IsValidateIdentity, AuthenState=@AuthenState
                                  where Id=@userId";
                var dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@RealName ", model.RealName);
                dyParams.Add("@IdentityCard", model.IdentityCard);
                dyParams.Add("@sex", model.sex);
                dyParams.Add("@Birthday", model.Birthday);
                dyParams.Add("@CredTypeId", model.CredTypeId);
                dyParams.Add("@IsValidateIdentity", model.IsValidateIdentity);
                dyParams.Add("@AuthenState", model.AuthenState);
                dyParams.Add("@userId", model.Id);
                string errorString = string.Empty;
                int result= DB.TuanDaiDB.ExecuteThrowException(TdConfig.DBUserWrite, strSQL, ref dyParams, ref errorString);
                if (result > 0)
                {
                    #region 用户信息加密
                    UpdateUserInfoClient client = new UpdateUserInfoClient();
                    UpdateUserBasicInfoRequest request = new UpdateUserBasicInfoRequest();
                    request.UserId = userId;
                    request.RealName = model.RealName;
                    request.IdentityCard = model.IdentityCard;
                    request.Birthday = model.Birthday.Value.ToShortTimeString();
                    string errorInfo = string.Empty;
                    bool res = client.UpdateUserBasicInfo(request, ref errorInfo);
                    if (!res || !string.IsNullOrEmpty(errorInfo))
                    {
                        TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "UpdateUserInfoClient.UpdateUserBasicInfo", "用户信息加密错误", errorInfo);
                    }
                    #endregion

                    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userId,(int)ConstString.UserGrowthType.RealNameValid,null,0);

                    //调用第三方渠道
                    try
                    {
                        TuanDai.PortalSystem.BLL.ThirdPartyChannel.RealNameCallBack(userId, realname);
                    }
                    catch (Exception ex)
                    {
                        new TuanDai.LogSystem.LogClient.LogClients().WriteErrorLog(
                            "TuanDai.PortalSystem.BLL.ThirdPartyChannel.RealNameCallBack",
                            "", "", ex.Message);
                    }

                    WebLog log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.BusinessId = model.Id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                    log.HandlerTypeId = (int)ConstString.LogType.EditIdentityCard;
                    log.UserId = model.Id.ToString();
                    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                    log.Content1 = "实名认证:身份证号码：" + idcard + ";真实姓名：" + realname + "；证件类型：" + CredTypeId;
                    log.Id = Guid.NewGuid().ToString();
                    WebLogInfo.WriteLoginHandler(log);
                }

                if (result > 0)
                {
                    if (model.IsValidateIdentity && model.IsValidateMobile)
                    { 
                        string sql1 = "select * from UserRegisterFrom with(nolock) where UserId=@UserId";
                        dyParams = new Dapper.DynamicParameters();
                        dyParams.Add("@UserId", model.Id);
                        var UserFrom = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<UserRegisterFromInfo>(TdConfig.DBRead, sql1, ref dyParams);
                        if (UserFrom != null)
                        {
                            if (UserFrom.RegisterFrom.StartsWith("bwy_"))
                            {
                                string oid = "10000009";
                                string sn = UserFrom.RegisterFrom.Split('_')[1];
                                string postResult = HttpUtils.HttpPost("http://www.bangwoya.com/callback/callback.php", string.Format("oid={0}&sn={1}&uid={2}", oid, sn, model.UserName));
                            }
                        }
                    }
                    
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
        private static int GetSexFromIdCard(string IdCard)
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

        /// <summary>
        /// 修改购标时是否验证交易密码的设置
        /// </summary>
        public void EditIsTenderNeedPayPwd()
        {
            Guid UserId = WebUserAuth.UserId.Value;
            bool IsTenderNeedPayPwd2 = Tool.SafeConvert.ToBoolean(Context.Request["IsTenderNeedPayPwd"], false);

            if (GlobalUtils.IsOpenCGT)
            {
                var reqMode = new TuanDai.CgtCallbackUrl.Model.ModelRequest.UpdatePayPwdStatusRequest
                {
                    IsTenderNeedPayPassword = IsTenderNeedPayPwd2,
                    UserId = UserId,
                };
                    
                string url = CgtCallBackConfig.GetCgtTradePwdUrl(reqMode, CgtCallBackConfig.CgtCallBackType.ModifyTradePwdStatus);
                PrintJson("8888", url);
            }
            else
            {
                //string IsTenderNeedPayPwd = Context.Request["IsTenderNeedPayPwd"];
                string payPwd = Tool.Encryption.MD5(Context.Request["payPwd"]);
                if (UserId == Guid.Empty)
                {
                    PrintJson("-99", "");
                    return;
                }
                //UserBasicInfo mode = db.UserBasicInfo.First(p => p.Id == UserId);
                var mode = new UserBLL().GetUserBasicInfoModelById(UserId);

                //UserSetting usersetting = db.UserSettings.FirstOrDefault(p => p.UserId == UserId);
                var usBll = new UserSettingBLL();
                var usersetting = usBll.GetUserSettingInfo(UserId);
                if (usersetting != null)
                {
                    if (usersetting.PayPwdErrorDate.HasValue)
                    {
                        DateTime date1 = Convert.ToDateTime(usersetting.PayPwdErrorDate.Value.ToString("yyyy/MM/dd"));
                        DateTime date2 = Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd"));
                        if (date1 == date2 && usersetting.PayPwdErrorCount >= 5)
                        {
                            PrintJson("-5", "交易密码已错误5次，请24小时后再进行此操作");
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
                    usersetting.UserId = UserId;
                    usersetting.IsTenderNeedPayPassword = false;
                    usersetting.IsAllowChangePwd = true;
                    usersetting.PayPwdErrorCount = 0;
                    usersetting.PayPwdErrorDate = null;
                    usBll.AddUserSettingInfo(usersetting);
                    //db.UserSettings.AddObject(usersetting);
                    //db.SaveChanges();
                }
                if (payPwd != mode.PayPwd)
                {
                    //记录登录错误次数
                    if (usersetting.PayPwdErrorCount == null)
                    {
                        usersetting.PayPwdErrorCount = 0;
                    }
                    usersetting.PayPwdErrorCount += 1;
                    usersetting.PayPwdErrorDate = DateTime.Now;
                    //db.SaveChanges();
                    usBll.UpdateUserSettingInfo(usersetting);
                    PrintJson("-1", (5 - usersetting.PayPwdErrorCount).ToString());
                }
                else
                {
                    //清除错误记录
                    usersetting.PayPwdErrorCount = 0;
                    usersetting.PayPwdErrorDate = null;
                }

                usersetting.IsTenderNeedPayPassword = IsTenderNeedPayPwd2;
                var isupdate = usBll.UpdateUserSettingInfo(usersetting);
                if (isupdate)
                    PrintJson("1", "");
                else
                    PrintJson("0", "");
            }
        }


        /// <summary>
        /// 修改交易密码
        /// </summary>
        public void UpdatePayPwd()
        {
            var inputOldPwd = this.Context.Request.Form["oldpwd"].ToString();
            var inputNewPwd = this.Context.Request.Form["newpwd"].ToString();

            #region 解密
            if (!string.IsNullOrEmpty(inputOldPwd))
            {
                try
                {
                    inputOldPwd = DESC.DecryptFromHexes(inputOldPwd, GlobalUtils.DesKey);
                }
                catch
                {
                    PrintJson("-1", "非法请求");
                    return;
                }
            }
            if (!string.IsNullOrEmpty(inputNewPwd))
            {
                try
                {
                    inputNewPwd = DESC.DecryptFromHexes(inputNewPwd, GlobalUtils.DesKey);
                }
                catch
                {
                    PrintJson("-1", "非法请求");
                    return;
                }
            }
            #endregion

            if (!WebUserAuth.IsAuthenticated)
            {
                PrintJson("-99","登录已失效");
            }
            var userId = WebUserAuth.UserId.Value;
            //UserBasicInfo model = db.UserBasicInfo.FirstOrDefault(p => p.Id == userId);
            var model = new UserBLL().GetUserBasicInfoModelById(userId);
            bool status = model.PayPwd == model.Pwd ? true : false;
            var result = UserSecurityBLL.ResetPayPwdViaPayPwd(userId, inputOldPwd, inputNewPwd);
            if (result.Success)
            {
                var user = result.GetParameter<UserBasicInfoInfo>("User");
                if (status)
                {
                    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userId, (int)ConstString.UserGrowthType.ModifyPayPwd, null, 0);
                }
                //记录修改操作日志.
                var log = new WebLog();
                log.AddDate = DateTime.Now;
                log.BusinessId = user.Id.ToString();
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                log.UserId = user.Id.ToString();
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.ChangePayPassword;
                log.Content1 = "修改交易密码";
                log.Id = Guid.NewGuid().ToString();
                BusinessDll.WebLogInfo.WriteLoginHandler(log);

                var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                if (isNewSmsRequest == "0")
                {
                    //发送消息通知.
                    var messageSender = new MessageSend();
                    var parameters = new Dictionary<string, object>();
                    parameters.Add("CurrentDate", DateTime.Now);
                    parameters.Add("User", user);
                    messageSender.SendMessage2(eventCode: MessageTemplates.ModifyTradersPassword,
                        parameters: parameters, mobile: user.TelNo, email: user.Email, userId: user.Id);
                }
                else
                {
                    SmsRequest modifyTradersPasswordRequest = new SmsRequest();
                    modifyTradersPasswordRequest.EventCode = MsgTemplatesType.ModifyTradersPassword;
                    modifyTradersPasswordRequest.PlatformSource = PlatformSource.WeiXin;
                    modifyTradersPasswordRequest.UserId = user.Id;
                    modifyTradersPasswordRequest.EmailAddress = user.Email;
                    modifyTradersPasswordRequest.Mobile = user.TelNo;

                    string errorMessage = string.Empty;
                    SmsClient.SendMessage(modifyTradersPasswordRequest, ref errorMessage);
                }
                
                
            }
            this.PrintJson(result.Code.ToString(), result.Message);
        }

        /// <summary>
        /// 简易修改交易密码
        /// </summary>
        public void SimpleUpdatePayPwd()
        {
            var inputNewPwd = this.Context.Request.Form["newpwd"].ToString();
            var userId = WebUserAuth.UserId.Value;
            UserBasicInfoInfo model = new UserBLL().GetUserBasicInfoModelById(userId);
            var inputOldPwd = model.PayPwd;
            
            #region 解密
            if (!string.IsNullOrEmpty(inputNewPwd))
            {
                try
                {
                    inputNewPwd = DESC.DecryptFromHexes(inputNewPwd, GlobalUtils.DesKey);
                }
                catch
                {
                    PrintJson("-1", "非法请求");
                    return;
                }
            }
            #endregion
            bool status = model.PayPwd == model.Pwd ? true : false;
            var result = UserSecurityBLL.ResetPayPwdViaPayPwd_Reg(userId, inputOldPwd, inputNewPwd);
            if (result.Success)
            {
                var user = result.GetParameter<UserBasicInfoInfo>("User");
                if (status)
                {
                    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userId, (int)ConstString.UserGrowthType.ModifyPayPwd, null, 0);
                }
                //记录修改操作日志.
                var log = new WebLog();
                log.AddDate = DateTime.Now;
                log.BusinessId = user.Id.ToString();
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                log.UserId = user.Id.ToString();
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.ChangePayPassword;
                log.Content1 = "修改交易密码";
                log.Id = Guid.NewGuid().ToString();
                BusinessDll.WebLogInfo.WriteLoginHandler(log);

                var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                if (isNewSmsRequest == "0")
                {
                    //发送消息通知.
                    var messageSender = new MessageSend();
                    var parameters = new Dictionary<string, object>();
                    parameters.Add("CurrentDate", DateTime.Now);
                    parameters.Add("User", user);
                    messageSender.SendMessage2(eventCode: MessageTemplates.ModifyTradersPassword,
                        parameters: parameters, mobile: user.TelNo, email: user.Email, userId: user.Id);
                }
                else
                {
                    SmsRequest modifyTradersPasswordRequest = new SmsRequest();
                    modifyTradersPasswordRequest.EventCode = MsgTemplatesType.ModifyTradersPassword;
                    modifyTradersPasswordRequest.PlatformSource = PlatformSource.WeiXin;
                    modifyTradersPasswordRequest.UserId = user.Id;
                    modifyTradersPasswordRequest.EmailAddress = user.Email;
                    modifyTradersPasswordRequest.Mobile = user.TelNo;

                    string errorMessage = string.Empty;
                    SmsClient.SendMessage(modifyTradersPasswordRequest, ref errorMessage);
                }
            }
            this.PrintJson(result.Code.ToString(), result.Message);
        }
        /// <summary>
        /// 注册的时候设置修改交易密码
        /// </summary>
        public void Register_UpdatePayPwd()
        {
            var inputOldPwd = this.Context.Request.Form["oldpwd"].ToString();
            var inputNewPwd = this.Context.Request.Form["newpwd"].ToString();
            if (inputOldPwd.IsEmpty())
            {
                UserBLL bll = new UserBLL();
                UserBasicInfoInfo info = bll.GetUserBasicInfoModelById(WebUserAuth.UserId.Value);
                if (info != null)
                    inputOldPwd = info.PayPwd;
            }
            var userId = WebUserAuth.UserId.Value;
            var result = UserSecurityBLL.ResetPayPwdViaPayPwd_Reg(userId, inputOldPwd, inputNewPwd);
            if (result.Success)
            {
                TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userId,(int)ConstString.UserGrowthType.ModifyPayPwd,null,0);
                var user = result.GetParameter<UserBasicInfoInfo>("User");
                if (user != null)
                {
                    //记录修改操作日志.
                    var log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.BusinessId = user.Id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                    log.UserId = user.Id.ToString();
                    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                    log.HandlerTypeId = (int)ConstString.LogType.ChangePayPassword;
                    log.Content1 = "注册认证流程修改交易密码";
                    log.Id = Guid.NewGuid().ToString();
                    BusinessDll.WebLogInfo.WriteLoginHandler(log);

                    var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                    if (isNewSmsRequest == "0")
                    {
                        //发送消息通知.
                        var messageSender = new MessageSend();
                        var parameters = new Dictionary<string, object>();
                        parameters.Add("CurrentDate", DateTime.Now);
                        parameters.Add("User", user);
                        messageSender.SendMessage2(eventCode: MessageTemplates.ModifyTradersPassword,
                            parameters: parameters, mobile: user.TelNo, email: user.Email, userId: user.Id);
                    }
                    else
                    {
                        SmsRequest modifyTradersPasswordRequest = new SmsRequest();
                        modifyTradersPasswordRequest.EventCode = MsgTemplatesType.ModifyTradersPassword;
                        modifyTradersPasswordRequest.PlatformSource = PlatformSource.WeiXin;
                        modifyTradersPasswordRequest.UserId = user.Id;
                        modifyTradersPasswordRequest.EmailAddress = user.Email;
                        modifyTradersPasswordRequest.Mobile = user.TelNo;

                        string errorMessage = string.Empty;
                        SmsClient.SendMessage(modifyTradersPasswordRequest, ref errorMessage);
                    }
                }
            }
            this.PrintJson(result.Code.ToString(), result.Message);
        }

        /// <summary>
        /// 个人中心-修改银行账号发送当前登录用户手机验证码
        /// </summary>
        public void getUsersMSCodeEditBank()
        {
            string vtype = Context.Request["vtype"];
            string message = getUsersMSCode(MsCodeType.PhoneCode, MsCodeType2.ModifyBankAccount, vtype);
            PrintJson(message, "");
        }
        /// <summary>
        /// 个人中心-提现发送当前登录用户手机验证码
        /// </summary>
        public void getUsersMSCode()
        {
            string vtype = Context.Request["vtype"];
            string message = getUsersMSCode(MsCodeType.PhoneCode, MsCodeType2.DrawMoney, vtype);
            PrintJson(message, "");
        }

        /// <summary>
        /// 给当前登录用户发送手机验证码
        /// </summary>
        /// <param name="type"></param>
        /// <param name="type2"></param>
        /// <returns></returns>
        private string getUsersMSCode(MsCodeType type, MsCodeType2 type2, string vtype)
        {
            Guid userid = WebUserAuth.UserId.Value;
            //UserBasicInfo model = db.UserBasicInfo.FirstOrDefault(p => p.Id == userid);
            var model = new UserBLL().GetUserBasicInfoModelById(userid);
            if (model == null)
                return "-1";

            //string random = StringUtilily.GetRandomString(6);
            //string telcontent = "您好，团贷网提醒您：您申请的手机验证码为:" + random + ",请在页面中提交验证码完成验证。";
            string telNo = model.TelNo; 
            //CodeRecord codeRecord = new CodeRecord();
            //codeRecord.Id = Guid.NewGuid();
            //codeRecord.UserId = userid;
            //codeRecord.Code = random;
            //codeRecord.AddDate = DateTime.Now; ;
            //codeRecord.Status = 0;
            //codeRecord.Type = type;
            //codeRecord.Type2 = type2;//
            //codeRecord.token = token;
            //codeRecord.TypeValue = telNo;
            //db.CodeRecord.AddObject(codeRecord);
            //if (db.SaveChanges() > 0)
            string strIP = Tool.WebFormHandler.GetIP();
            var canSend = new CodeRecordBLL().IsCanSendNewCodeRecord(telNo, MsCodeType.PhoneCode, type2, null, 1, strIP);
            if (!canSend.Success)
            {
                PrintJson("-1", canSend.Message);
            }
            var code = new CodeRecordBLL().CreateCodeRecordInfo(userid, "", type, type2, telNo);
            if(code != null)
            {
                var parameters = new Dictionary<string, object>();
                parameters.Add("ValidateCode", code.Code);
                var msgSender = new BusinessDll.MessageSend();
                if (vtype == "0")
                {
                    var sendResult = msgSender.SendMessage2(option: SendOption.Sms,
                    eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: telNo, content: code.Code);
                    if (sendResult != "1")
                    {
                        return "-2";
                    }
                    else
                    {
                        return "1";
                    }
                }
                else
                {
                    var sendResult = msgSender.SendMessage2(option: SendOption.Voice,
                    eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: telNo, content: code.Code);

                    if (sendResult != "1")
                    {
                        return "-2";
                    }
                    else
                    {
                        return "1";
                    }
                }
            }
            else
            {
                return "-2";
            }
        }
        /// <summary>
        /// 新增银行卡绑定
        /// </summary>
        public void addbankaccount()
        {
            lock (lockobj)
            {
                Guid userid = WebUserAuth.UserId.Value;
                string code = Context.Request["code"];
                int result = 1;
                //UserBasicInfo basicmodel = db.UserBasicInfo.FirstOrDefault(p => p.Id == userid);
                var basicmodel = new UserBLL().GetUserBasicInfoModelById(userid);
                if (!code.IsEmpty())
                {
                    result = new CodeRecordBLL().CheckCodeRecord(code, "", MsCodeType.PhoneCode,
                        MsCodeType2.ModifyBankAccount, userid);
                        //BusinessDll.Users.checkCodeRecord(code, 2, 10, userid);
                }
                if (basicmodel == null)
                {
                    PrintJson("-1", "用户不存在");

                }
                if (!string.IsNullOrWhiteSpace(basicmodel.BankAccountNo))
                {
                    PrintJson("-4", "最多添加1张银行卡");
                }
                if (result != 1)
                {
                    if (result == -1)
                    {
                        PrintJson("-2", "验证码错误");
                    }
                    else if (result == -2 || result == -3)
                    {
                        PrintJson("-2", "验证码已过期,请重新获取输入");
                    }
                    else if (result == 0)
                    {
                        PrintJson("-2", "系统异常，请刷新页面重试");
                    }
                }
                else
                {
                    string province = Context.Request["province"];
                    string account = Context.Request["account"];
                    string cityName = Context.Request["cityName"];
                    string bankName = Context.Request["bankName"];
                    int bankType = int.Parse(Context.Request["bankType"]);
                    string otherBankName = string.Empty;
                    if (bankType == 9999)
                        otherBankName = Context.Request["otherBankName"];

                    if (!string.IsNullOrWhiteSpace(account))
                    {
                        account = account.Replace(" ", "");
                    }
                    //UserBasicInfo bankUser = db.UserBasicInfo.FirstOrDefault(p => p.BankAccountNo == account && p.Id != userid);
                    //var bankUser = new UserBLL().WXGetUserBasicInfo("BankAccountNo=@BankAccountNo AND Id != @Id",
                    //    new SqlParameter[] { new SqlParameter("@BankAccountNo", account), new SqlParameter("@Id", userid) });
                    //if (bankUser != null)
                    //{
                    //    PrintJson("-3", "新的银行账号已经绑定另一用户，不能再绑定。");
                    //}
                    if (IsBankNoExists(account, userid))
                    {
                        PrintJson("-3", "新的银行账号已经绑定另一用户，不能再绑定。");
                    }

                    basicmodel.BankAccountNo = account;
                    basicmodel.BankProvice = province;
                    basicmodel.BankCity = cityName;
                    basicmodel.BankType = bankType;
                    basicmodel.OpenBankName = bankName;
                    if (!string.IsNullOrEmpty(otherBankName))
                    {
                        basicmodel.otherBankName = otherBankName;
                    }

                    BankInfoInfo newbank = new BankInfoInfo();

                    newbank.Id = Guid.NewGuid();
                    newbank.UserId = basicmodel.Id;
                    newbank.BankAccountNo = account;
                    newbank.BankProvice = province;
                    newbank.BankCity = cityName;
                    newbank.BankType = bankType;
                    newbank.OpenBankName = bankName;
                    newbank.IsDefault = true;
                    if (!string.IsNullOrEmpty(otherBankName))
                    {
                        newbank.otherBankName = otherBankName;
                    }
                    newbank.Status = 1;
                    newbank.AddData = DateTime.Now;
                    //db.BankInfo.AddObject(newbank);
                    var isAddBankInfo = new BankInfoBLL().AddBankInfo(newbank);
                    if (!isAddBankInfo)
                    {
                        PrintJson("0", "操作失败");
                    }
                    BankInfoLogInfo bankLog = new BankInfoLogInfo();
                    bankLog.Id = Guid.NewGuid();
                    bankLog.Province = province;
                    bankLog.City = cityName;
                    bankLog.OpenName = bankName;
                    bankLog.type = 1;
                    bankLog.RealName = basicmodel.RealName;
                    bankLog.UpdateUserId = userid;
                    bankLog.AddDate = DateTime.Now;
                    bankLog.UserId = userid;
                    bankLog.BankNo = account;
                    bankLog.CardNo = basicmodel.IdentityCard;
                    //db.BankInfoLog.AddObject(bankLog);
                    var isAddBankInfoLog = new BankInfoLogBLL().AddBankInfoLog(bankLog);
                    if (!isAddBankInfoLog)
                    {
                        PrintJson("0", "操作失败");
                    }
                    if (basicmodel.IsValidateIdentity && basicmodel.IsValidateMobile)
                    {
                        basicmodel.AuthenState = 4;
                    }
                    var isUpdate = new UserBLL().UpdateUserBasicInfoForBank(basicmodel);

                    //if (db.SaveChanges() > 0)
                    if (isUpdate)
                    {
                        #region 用户银行卡信息加密
                        UpdateUserInfoClient client = new UpdateUserInfoClient();
                        UpdateBankInfoRequest request = new UpdateBankInfoRequest();
                        request.BankCity = cityName;
                        request.BankName = bankName;
                        request.BankNo = account;
                        request.BankProvice = province;
                        request.BankType = bankType.ToString();
                        request.OpenBankName = bankName;
                        request.UserId = userid;
                        string errorInfo = string.Empty;
                        var res = client.UpdateBankInfoByUserId(request, ref errorInfo);
                        if (!res || !string.IsNullOrEmpty(errorInfo))
                        {
                            TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "UpdateUserInfoClient.UpdateBankInfoByUserId","用户银行卡信息加密报错",errorInfo);
                        }
                        #endregion

                        TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userid, (int)ConstString.UserGrowthType.BindBankCard, null, 0);
                        WebLog log = new WebLog();
                        log.AddDate = DateTime.Now;
                        log.BusinessId = userid.ToString();
                        log.BusinessTypeId = (int)ConstString.LogBusinessType.Add;
                        log.UserId = userid.ToString();
                        log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                        log.HandlerTypeId = (int)ConstString.LogType.BankAccount;
                        log.Content1 = "新增银行卡绑定";
                        log.Content2 = "银行账号为：" + account;
                        log.Content3 = "省：" + province;
                        log.Content4 = "市：" + cityName;
                        log.Content5 = "银行类型：" + bankType.ToString();
                        log.Content6 = "银行名称：" + bankName;
                        log.Id = Guid.NewGuid().ToString();
                        WebLogInfo.WriteLoginHandler(log);
                        string content2 = "恭喜您的银行卡绑定成功,更新后的银行账号为：" + account;
                        var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                        if (isNewSmsRequest == "0")
                        {
                            BusinessDll.MessageSend ms = new BusinessDll.MessageSend();
                            ms.SendMessage(basicmodel, content2, "恭喜您的银行卡绑定成功!", "chk2");
                        }
                        else
                        {
                            TuanDai.SMS.Client.SmsRequest smsRequest = new SmsRequest();
                            smsRequest.PlatformSource = PlatformSource.WeiXin;
                            smsRequest.SendOption = MsgSendOption.Sms;
                            string errorString = string.Empty;
                            SmsClient.SendMessage(smsRequest, ref errorString);
                        }

                        var startDate = DateTime.Parse("2015-04-30 10:00:00");
                        if (!string.IsNullOrEmpty(basicmodel.ExtenderKey))
                        {
                            var extenderKey = basicmodel.ExtenderKey; 
                            //影响存管上线速度,先注释掉 allen 2017-03-13
                            //var invitedUsers = GetInvitedUserCount(extenderKey, startDate);
                            ////邀请人每邀请五个实名且绑定银行卡的用户可获得1个月VIP超级会员    
                            ////第101位客户开始不奖励
                            //if (invitedUsers >= 5 && invitedUsers <= 100 && (invitedUsers % 5 == 0))
                            //{
                            //    //为推荐人添加团宝箱记录领取Vip.
                            //    //var user = db.UserBasicInfo.FirstOrDefault(x => x.ExtendKey == extenderKey);
                            //    var user = new UserBLL().GetUserBasicInfoByExtendKey(extenderKey);
                            //    if (user != null)
                            //    {
                            //        var beginDate = user.LevelBeginDate ?? DateTime.Now;
                            //        var endDate = user.LevelEndDate ?? DateTime.Now;
                            //        var newDate = endDate.AddDays(30);
                            //        user.LevelBeginDate = beginDate;
                            //        user.LevelEndDate = newDate;
                            //        user.Level = 2;
                            //        new UserBLL().UpdateUserBasicInfoForLevel(user);
                            //        //db.SaveChanges();

                            //        var history = new MemberStatusHistoryInfo();
                            //        history.Id = Guid.NewGuid();
                            //        history.UserId = user.Id;
                            //        history.BeginDate = endDate;
                            //        history.EndDate = newDate;
                            //        history.Level = 2;
                            //        history.adddate = DateTime.Now;
                            //        history.Type = 3;
                            //        history.Desc = "邀请好友注册赢VIP超级会员";
                            //        new MemberStatusHistoryBLL().AddMemberStatusHistory(history);
                            //        //db.MemberStatusHistory.AddObject(history);
                            //        //db.SaveChanges();
                            //    }
                            //}
                        }

                        PrintJson("1", "操作成功");
                    }
                    else
                    {
                        PrintJson("0", "操作失败");
                    }

                }
            }
        }
        /// <summary>
        /// 判断银行卡号是否已绑定到另一个用户
        /// </summary>
        /// <param name="bankNo"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        private bool IsBankNoExists(string bankNo, Guid userId)
        {
            
            return false;
        }
        public void checkpwdandgetfee()
        {
            Guid userid = WebUserAuth.UserId.Value;
            decimal amount = Tool.SafeConvert.ToDecimal(Context.Request.Form["amount"], 0);
            //UserBasicInfo basicinfo = dbread.UserBasicInfo.FirstOrDefault(p => p.Id == userid);
            var basicinfo = new UserBLL().GetUserBasicInfoModelById(userid);
            if (basicinfo == null)
            {
                PrintJson("0", "对不起，您还未登录");
                return;
            }
            //Guid setid = Guid.Parse("1f9f7cf7-267e-4f88-b3a4-f2775401ca0f");
            //WebSetting setmodel = dbread.WebSetting.First(p => p.Id == setid);
            var setmodel = new WebSettingBLL().GetWebSettingInfo("1f9f7cf7-267e-4f88-b3a4-f2775401ca0f");
            decimal handfee = 0;
            if (basicinfo.Level == (int)ConstString.UserType.NormalUser)
            {
                handfee = amount * decimal.Parse(setmodel.Param1Value) * decimal.Parse("0.01");
            }
            else
            {
                handfee = amount * decimal.Parse(setmodel.Param2Value) * decimal.Parse("0.01");
                if (handfee >= decimal.Parse(setmodel.Param3Value))
                {
                    handfee = decimal.Parse(setmodel.Param3Value);
                }
            }
            PrintJson("1", handfee.ToString()); 
        }
        /// <summary>
        /// 检测交易密码
        /// </summary>
        public void CheckTranPwd()
        {
            Guid userid = WebUserAuth.UserId.Value;
            UserBLL userBll = new UserBLL();
            UserBasicInfoInfo model = userBll.GetUserBasicInfoModelById(userid);
            if (model == null)
            {
                PrintJson("-99", "登陆超时");
            }
            if ((model.uStatus ?? 0) != 1)
            {
                PrintJson("-10", "用户已被冻结");
            }
            if ((string.IsNullOrEmpty(model.PayPwd) || model.PayPwd == model.Pwd))
            {
                PrintJson("-252", "请先设置交易密码");
            }
            //验证交易密码
            var usersetting = new UserSettingBLL().GetUserSettingInfo(userid);
            if (usersetting != null)
            {
                #region 验证交易密码
                
                    if (usersetting.PayPwdErrorDate.HasValue)
                    {
                        DateTime date1 = Convert.ToDateTime(usersetting.PayPwdErrorDate.Value.ToString("yyyy/MM/dd"));
                        DateTime date2 = Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd"));
                        if (date1 == date2 && usersetting.PayPwdErrorCount >= 5)
                        {
                            PrintJson("-151", "交易密码已错误5次，请24小时后再进行此操作");
                        }
                        if (date1 != date2 && usersetting.PayPwdErrorCount > 1)
                        {
                            usersetting.PayPwdErrorCount = 0;
                            usersetting.PayPwdErrorDate = null;
                        }
                    }
                    string PayPwd = Tool.Encryption.MD5(Context.Request["TranPwd"]);
                    if (PayPwd != model.PayPwd)
                    {
                        //记录登录错误次数
                        if (usersetting.PayPwdErrorCount == null)
                        {
                            usersetting.PayPwdErrorCount = 0;
                        }
                        usersetting.PayPwdErrorCount += 1;
                        usersetting.PayPwdErrorDate = DateTime.Now;
                        new UserSettingBLL().UpdateUserSettingInfo(usersetting);
                        //db.SaveChanges();
                        PrintJson("-15", "交易密码错误还剩下：" + (5 - usersetting.PayPwdErrorCount).ToString() + "次");
                    }
                    else
                    {
                        //清除错误记录
                        usersetting.PayPwdErrorCount = 0;
                        usersetting.PayPwdErrorDate = null;
                        //db.SaveChanges();
                        new UserSettingBLL().UpdateUserSettingInfo(usersetting);
                    }
                
                #endregion
            }

            PrintJson("1", "交易密码验证通过");
        }

        /// <summary>
        /// 个人中心提现
        /// </summary>
        public void drawdespoint()
        {
            Guid userid = WebUserAuth.UserId.Value;
            //IQueryable<BankInfo> BankList = db.BankInfo.Where(p => p.UserId == userid).OrderByDescending(p => p.AddData);
            
            //BankInfo bankmodel = BankList.FirstOrDefault();
            //var bankmodel = new BankInfoBLL().GetBankInfoByUserId(userid);
            string prizeId = Tool.WEBRequest.GetString("prizeId");
            Guid Id = Guid.Empty;
            if (!string.IsNullOrEmpty(prizeId))
            {
                Id = Guid.Parse(prizeId);
            }
            //if (bankmodel != null)
            //{
            //    if (Convert.ToInt32(bankmodel.Status) == 2)
            //    {
            //        PrintJson("-300", "您好，银行卡在审核中不允许提现！");
            //        return;
            //    } 
            //}


            //string pwd = Context.Request["pwd"];
            decimal couponAmount = 0;
            Guid? coupon_itemid = null;
            if (!string.IsNullOrWhiteSpace(Context.Request["couponAmount"]))
            {
                couponAmount = decimal.Parse(Context.Request["couponAmount"]);
            }
            var model = new UserBLL().GetUserBasicInfoModelById(userid);

            if (model.BankType == null || model.OpenBankName == null || model.BankAccountNo == null || model.BankProvice == null || model.BankCity == null)
            {
                PrintJson("-51", "银行卡信息不存在");
            }
            if (!model.IsValidateIdentity)
            {
                PrintJson("-52", "未通过实名认证");
            }
            if (model.uStatus == 0)
            {
                PrintJson("-10", "您的账户被冻结");
            }
            string PhoneCode = Context.Request["checkcode"];
            int checkcode = DrawMoneyCheckUserCode(PhoneCode);
            if (checkcode == -1)
            {
                PrintJson("-11", "验证码错误");
            }
            else if (checkcode == -3)
            {
                PrintJson("-11", "验证码已过期,请重新获取输入");
            }
            else if (checkcode == 0)
            {
                PrintJson("-11", "未登录");
            }
            else if (checkcode == -2)
            {
                PrintJson("-11", "系统繁忙，请重试");
            }
            decimal amount = decimal.Parse(Context.Request["amount"].Trim());
            if (amount <= 0)
            {
                PrintJson("-26", "提现金额有误");
            }
            //Guid setid = Guid.Parse("1f9f7cf7-267e-4f88-b3a4-f2775401ca0f");
            //WebSetting setmodel = db.WebSetting.First(p => p.Id == setid);
            var setmodel = new WebSettingBLL().GetWebSettingInfo("1f9f7cf7-267e-4f88-b3a4-f2775401ca0f");
            if (model.Level == (int)ConstString.UserType.VipUser)
            {
                if (amount > decimal.Parse(setmodel.Param5Value))
                {
                    PrintJson("-24", "提现金额超出最大限额");
                }
            }
            else
            {
                if (amount > decimal.Parse(setmodel.Param4Value))
                {
                    PrintJson("-24", "提现金额超出最大限额");
                }
            }

            //获取优惠券
            if (couponAmount > 0)
            {
                //UserPrize modelitem = db.UserPrize.OrderBy(p => p.ExpirationDate).FirstOrDefault(p => p.TypeId == 2 && p.UserId == userid && (p.IsUsed ?? 0) == 0 && p.IsReceive == true && (p.ExpirationDate.HasValue && p.ExpirationDate > DateTime.Now || p.ExpirationDate.HasValue == false) && p.PrizeValue == couponAmount);
                
                //if (modelitem == null)
                //{
                //    PrintJson("-49", "优惠券不存在");
                //}
                //else
                //{
                //    coupon_itemid = modelitem.Id;
                //}
                if (Id == Guid.Empty)
                {
                    PrintJson("-49", "优惠券不存在");
                }
                else
                {
                    var prizeModel = new UserBLL().WXGetUserPrizeById(Id, userid);
                    if (prizeModel == null)
                    {
                        PrintJson("-49", "优惠券不存在");
                    }
                    else
                    {
                        coupon_itemid = Id;
                    }
                    
                }
            }
             
            string message = "";
            int drawType = WEBRequest.GetFormInt("drawType", 2);

            UserBLL  userbll= new UserBLL();
            //计算可提现金额
            decimal aviMoney = userbll.GetDrawAviAmount(userid);
            // CalcWithDrawMoney(userbll, userid, drawType); 
            if (aviMoney < amount)
            {
                PrintJson("-1", "提现金额大于可用资金");
            }
            else
            {
               // int outStatus = userbll.UserWithDraw(userid, coupon_itemid, amount);
               // message = outStatus.ToString();
                /*
                @UserId uniqueidentifier,
                @Type 1发标，2提现
                @BusinessNo nvarchar(100),
                @OutStatus int output
                */
                var withdrawId = Guid.NewGuid();
                int outStatus = 0;
                int userActionOutStatus = 0;
                try
                {
                    var paramter = new Dapper.DynamicParameters();
                    paramter.Add("@UserId", userid);
                    paramter.Add("@Type", 2);
                    paramter.Add("@BusinessNo", withdrawId);
                    paramter.Add("@OutStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
                    TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, "/BD/useractionwrite", "p_UserActionInsert", ref paramter, System.Data.CommandType.StoredProcedure);
                    userActionOutStatus = paramter.Get<int>("OutStatus");
                    if (userActionOutStatus == 1)
                    {
                        var param = new Dapper.DynamicParameters();
                        param.Add("@amount", amount);
                        param.Add("@userid", userid);
                        param.Add("@coupon_itemid", coupon_itemid);
                        param.Add("@withdrawIdDefault", withdrawId);
                        param.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
                        TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBFundWrite, "WithDrawDespositInit", ref param, System.Data.CommandType.StoredProcedure);
                        outStatus = param.Get<int>("@outStatus");
                    }
                }
                catch (Exception ex)
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "drawdespoint", withdrawId.ToString(), "提现执行存储过程发生错误，错误:" + ex.Message);
                }
                finally
                {
                    System.Threading.Tasks.Task.Run(() =>
                    {
                        var paramter = new Dapper.DynamicParameters();
                        paramter.Add("@UserId", userid);
                        paramter.Add("@Type", 2);
                        paramter.Add("@BusinessNo", withdrawId);
                        paramter.Add("@OutStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
                        var _ourtStatus = TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, "/BD/useractionwrite", "p_UserActionUpdate", ref paramter, System.Data.CommandType.StoredProcedure);

                        TuanDai.LogSystem.LogClient.LogClients.TraceLog(TdConfig.ApplicationName, "drawdespoint", withdrawId.ToString(), "提现执行用户记录(p_UserActionUpdate)存储过程返回记录，返回记录:" + _ourtStatus.ToString());
                    });
                }

                if (userActionOutStatus != 1)
                {
                    TuanDai.LogSystem.LogClient.LogClients.TraceLog(TdConfig.ApplicationName, "drawdespoint", withdrawId.ToString(), "提现执行用户记录(p_UserActionInsert)存储过程返回记录，错误:" + userActionOutStatus.ToString());

                    PrintJson("-11", "操作过于频繁,请稍后在试");
                    return;
                } 

                WebLog log1 = new WebLog();
                log1.AddDate = DateTime.Now;
                log1.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                log1.HandlerTypeId = (int)ConstString.LogType.DrawdesPoint;
                log1.UserId = userid.ToString();
                log1.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log1.Content2 = "触屏版用户提现";
                log1.Content1 = "用户提现,用户:" + userid.ToString() + "|金额:" + amount.ToString() + "|状态:" + outStatus;
                log1.Id = Guid.NewGuid().ToString();
                BusinessDll.WebLogInfo.WriteLoginHandler(log1);
                message = outStatus.ToString();
                //发送提现微信端通知 allen 2015-08-04
                if (outStatus == 1) {
                    this.SendWithDrewAlert(WebUserAuth.UserId.Value);
                } 
            } 

            PrintJson(message, "");
        }
        //计算用户可提现金额
        private decimal CalcWithDrawMoney(UserBLL userbll,Guid userId,int drawType)
        {
            decimal maxAviMoney = userbll.GetDrawAviAmount(userId);
             decimal  wxAviMoney = userbll.GetWeiXinAviAmount(userId);
             decimal cadAviMoney = 0;
            if (maxAviMoney < 0)
            {
                wxAviMoney = 0;
                cadAviMoney = 0;
            }
            var _wxAviMoney = wxAviMoney + (wxAviMoney * (decimal)0.15);
            //如果提现金额小于或等于微信提现金额
            if (_wxAviMoney >= maxAviMoney)
            {
                wxAviMoney = maxAviMoney;
                cadAviMoney = 0;
            }
            else
            {
                wxAviMoney = _wxAviMoney;
                cadAviMoney = maxAviMoney - _wxAviMoney;
            }
            if (drawType == 1)
                return wxAviMoney;
            else
                return cadAviMoney;
        }
        //发送提现提醒通知
        private void SendWithDrewAlert(Guid userId)
        {
            try
            {
                //为了不出现读写数据库不同步问题,此处改为直接使用写库 
                BusinessDll.WXTemplateMessage wxSend = new WXTemplateMessage(WXTemplateMessage.PlatFormType.WeiXin, WebUserAuth.UserId.Value);
                string strSQL = "SELECT TOP 1 * FROM AppWithdrewFund with(NOLOCK) WHERE UserId=@UserId ORDER BY  AppDate DESC ";

                var dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@UserId", userId); 
                var fundInfo = PublicConn.QuerySingleWrite<WXAppWithdrewFund>(strSQL, ref dyParams); 
                if (fundInfo != null)
                {
                    wxSend.SendWithDraw(fundInfo.AppDate.Value, fundInfo.ActualWithdrawDeposit ?? 0, fundInfo.HandingCharge ?? 0);
                } 
            }
            catch { }
        }
        /// <summary>
        /// 提现验证用户手机验证码
        /// </summary>
        /// <param name="code">手机验证码</param>
        /// <returns></returns>
        private int DrawMoneyCheckUserCode(string code)
        {
            Guid userid = WebUserAuth.UserId.Value;
            if (string.IsNullOrEmpty(code) || userid == Guid.Empty)
                return 0;

            var paramter = new Dapper.DynamicParameters();
            paramter.Add("@UserId", userid);
            paramter.Add("@Type", MsCodeType.PhoneCode);
            paramter.Add("@Type2", MsCodeType2.DrawMoney);
            paramter.Add("@Code", code);
            paramter.Add("@ResultCode", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            var commandText = @"
                            begin tran
                            begin try
                              declare @Id uniqueidentifier
                              declare @RecordCode varchar(10)
                                declare @OutTime datetime 
                              declare @Status int 
                              select top 1 @Id=Id,@RecordCode=Code,@Status=[Status],@OutTime=AddDate from  coderecord  with(updlock) where 1=1 and UserId=@UserId and Type=@Type and Type2=@Type2 order by AddDate desc
                              
                                if DATEADD(mi,-5,@OutTime)>getdate()
                                begin
                                  set  @ResultCode=-2;
                                  rollback tran
                                  return
                                end

                                if ISNULL(@RecordCode,'')='' or @RecordCode!=@Code
                              begin
                                set  @ResultCode=-1;
                                rollback tran
                                return
                              end

                              --如果已经使用
                              if ISNULL(@Status,-100)=-100 or @Status=1
                              begin
                                set  @ResultCode=-3;
                                rollback tran
                                return
                              end

                              if isnull(@Id,'00000000-0000-0000-0000-000000000000')='00000000-0000-0000-0000-000000000000'
                              begin
                                set  @ResultCode=-2;
                                rollback tran
                                return
                              end

                              update dbo.CodeRecord set Status=1 where id=@Id
                              set  @ResultCode=1;
                              commit
                            end try
                            begin catch
                              set @ResultCode=-2;
                              rollback tran
                              return
                            end catch";
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBUserWrite, commandText, ref paramter);
            return paramter.Get<int>("ResultCode");
        }

        /// <summary>
        /// 验证当前登录用户发送手机验证码(内部方法)
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        private string checkUsersMSCode(string PhoneCode)
        {
            string code = PhoneCode;
            Guid userId = WebUserAuth.UserId.Value;
            if (string.IsNullOrEmpty(code))
                return "-3";
            Guid userid = userId;

            //CodeRecord codeRecord = db.CodeRecord.OrderByDescending(p => p.AddDate).FirstOrDefault(p => p.UserId == userid && p.Status == 0 && p.Type2 == 8);
            //int result = BusinessDll.Users.checkCodeRecord(code, 2, 8, userid);
            int result = new CodeRecordBLL().CheckCodeRecord(code, "", MsCodeType.PhoneCode, MsCodeType2.DrawMoney,
                userid);
            //  if (result != 1)
            return result.ToString();
            // codeRecord.Status = 1;
            // return db.SaveChanges() > 0 ? "2" : "-1";
        }

        /// <summary>
        /// 手机绑定验证发送手机验证码
        /// </summary>
        /// <param name="type"></param>
        /// <param name="type2"></param>
        /// <returns></returns>
        public void getMobileMSCode()
        {
            string phoneNum = Context.Request["phoneNum"];
            string vtype = Context.Request["vtype"];//0短信，1语音
            Guid userid = WebUserAuth.UserId.Value;
            //UserBasicInfo model = db.UserBasicInfo.FirstOrDefault(p => p.TelNo == phoneNum);
            var model = new UserBLL().GetUserBasicInfoModelByTelNo(phoneNum);
            if (model != null)
                PrintJson("-20", "此号码已使用，请更换");


            //string random = StringUtilily.GetRandomString(6);
            string telNo = phoneNum;
            string strIP = Tool.WebFormHandler.GetIP();

            //CodeRecord codeRecord = new CodeRecord();
            //codeRecord.Id = Guid.NewGuid();
            //codeRecord.UserId = userid;
            //codeRecord.Code = random;
            //codeRecord.AddDate = DateTime.Now; ;
            //codeRecord.Status = 0;
            //codeRecord.Type = (int)ConstString.MSCodeType.PhoneCode;
            //codeRecord.Type2 = (int)ConstString.MSCodeType2.ValidPhone;
            //codeRecord.token = token;
            //codeRecord.TypeValue = telNo;
            //db.CodeRecord.AddObject(codeRecord);
            //if (db.SaveChanges() > 0)
            var canSend = new CodeRecordBLL().IsCanSendNewCodeRecord(phoneNum, MsCodeType.PhoneCode, MsCodeType2.ValidPhone, null, 1, strIP);
            if (!canSend.Success)
            {
                PrintJson("-1", canSend.Message);
            }
            var code = new CodeRecordBLL().CreateCodeRecordInfo(userid, "", MsCodeType.PhoneCode, MsCodeType2.ValidPhone,telNo);
            if(code != null)
            {

                var parameters = new Dictionary<string, object>();
                parameters.Add("ValidateCode", code.Code);

                var msgSender = new BusinessDll.MessageSend();

                if (vtype == "0")
                {
                    msgSender.SendMessage2(option: SendOption.Sms, eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: phoneNum);
                }
                else
                {
                    msgSender.SendMessage2(option: SendOption.Voice, eventCode: MessageTemplates.ValidateCode, mobile: phoneNum, content: code.Code);
                }

                PrintJson("1", "发送验证码成功");

            }
            else
            {
                PrintJson("0", "发送验证码失败");
            }
        }

        private bool GetCheckInfoByCookie(string userid, string checkInfo)
        {
            string key = Tool.Encryption.MD5(userid.ToString() + "_" + checkInfo);
            string cookieCode = CookieHelper.GetCookie(key);
            if (cookieCode.Equals(Tool.Encryption.MD5(checkInfo)))
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// 个人中心-绑定手机号码-验证验证码
        /// </summary>
        public void msgcheckcode2()
        {
            lock (lockobj)
            {
                Guid userid = WebUserAuth.UserId.Value;
                string code = Context.Request["code"];
                string tel = Context.Request.Form["tel"].Trim();
                string phoneRegex = @"^(?:13\d|14\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$";
                if (!Regex.IsMatch(tel, phoneRegex))
                {
                    PrintJson("-7", "手机号码格式不正确");
                    return;
                }
                //UserBasicInfo model = db.UserBasicInfo.First(p => p.Id == userid);
                var model = new UserBLL().GetUserBasicInfoModelById(userid);
                bool IsValidateMobile = model.IsValidateMobile;
                //var checkMondel = new UserBLL().WXGetUserBasicInfo(" Id<>@Id and (TelNo=@TelNo or UserName=@TelNo)",
                //    new SqlParameter[] { new SqlParameter("@Id", userid), new SqlParameter("@TelNo", tel) });
                //if (db.UserBasicInfo.Any(p => p.Id != userid && (p.TelNo == tel || p.UserName == tel)))
                //if(checkMondel != null)
                var checkModel = new UserBLL().GetUserBasicInfoModelByTelNo(tel);
                if (checkModel != null && checkModel.Id != model.Id)
                {
                    PrintJson("-7", "此号码已存在，请更换号码");
                    return;
                }

                //CodeRecord recordmodel = db.CodeRecord.Where(p => p.UserId == userid && p.Type == (int)ConstString.MSCodeType.PhoneCode && p.Type2 == (int)ConstString.MSCodeType2.ValidPhone && p.Status == 0).OrderByDescending(p => p.AddDate).FirstOrDefault();
                int codeResult = new CodeRecordBLL().CheckCodeRecord(code, tel, MsCodeType.PhoneCode,
                    MsCodeType2.ValidPhone, userid);//BusinessDll.Users.checkCodeRecord(code, (int)ConstString.MSCodeType.PhoneCode, (int)ConstString.MSCodeType2.ValidPhone, userid);
                if (codeResult != 1)
                    PrintJson(codeResult.ToString(), "");

                bool isValidate = model.IsValidateMobile;
                string oldTelNo = model.TelNo;
                model.TelNo = tel;
                model.IsValidateMobile = true;
                if (model.IsValidateIdentity && model.IsValidateMobile)
                {
                    model.AuthenState = 4;
                }
                var isupdate = new UserBLL().UpdateUserBasicInfoForTel(model);
                //if (db.SaveChanges() > 0)
                if(isupdate)
                {
                    #region 用户信息加密
                    UpdateUserInfoClient client = new UpdateUserInfoClient();
                    UpdateUserBasicInfoRequest request = new UpdateUserBasicInfoRequest();
                    request.UserId = userid;
                    request.Birthday = null;
                    request.TelNo = tel;
                    string errorInfo = string.Empty;
                    bool res = client.UpdateUserBasicInfo(request, ref errorInfo);
                    if (!res || !string.IsNullOrEmpty(errorInfo))
                    {
                        TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "UpdateUserInfoClient.UpdateUserBasicInfo", "用户信息加密错误", errorInfo);
                    }
                    #endregion

                    if (!IsValidateMobile)
                    {
                        TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userid, (int)ConstString.UserGrowthType.BindMobile, null, 0);
                    }
                    WebLog log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.BusinessId = model.Id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                    log.HandlerTypeId = (int)ConstString.LogType.EditPhone;
                    log.UserId = model.Id.ToString();
                    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                    log.Content1 = "用户重置手机号码，旧手机号码：" + oldTelNo + "；新手机号码：" + tel;
                    log.Id = Guid.NewGuid().ToString();
                    WebLogInfo.WriteLoginHandler(log);

                    //改用新的发短信，邮件，系统消息
                    MessageSend ms = new MessageSend();
                    var dic = new Dictionary<string, object>();
                    dic.Add("CurrentDate", DateTime.Now);
                    dic.Add("User", model);
                    ms.SendMessage2(eventCode: MessageTemplates.ModifyMobile, parameters: dic,
                                      mobile: model.TelNo, email: model.Email, userId: model.Id);


                    PrintJson("1", "");
                }
                else PrintJson("0", "");
            }
        }

        public void CheckPhoneCode()
        {
            lock (lockobj)
            {
                string tel = Context.Request.Form["phoneNum"].Trim();
                string code = Context.Request["code"];
                int codeResult = new CodeRecordBLL().CheckCodeRecord(code, tel, MsCodeType.PhoneCode,
                    MsCodeType2.RegPhoneValid,null);//BusinessDll.Users.checkCodeRecord(code, (int)ConstString.MSCodeType.PhoneCode, (int)ConstString.MSCodeType2.RegPhoneValid, 0);
                if (codeResult != 1)
                    PrintJson(codeResult.ToString(), "");
                else
                    PrintJson("1", "验证码通过");
            }
        }
        /// <summary>
        /// 绑定手机号码
        /// </summary>
        public void BindMobilePhone()
        {
            if (Context.Request.UrlReferrer== null || !Context.Request.UrlReferrer.ToString().Contains(".tuandai.com"))
            {
                PrintJson("-911", "非法请求");
                return;
            }
            string tel = Context.Request.Form["phoneNum"].Trim();
            string phoneRegex = @"^(?:13\d|14\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$";
            if (!Regex.IsMatch(tel, phoneRegex))
            {
                PrintJson("-7", "手机号码格式不正确");
                return;
            } 
            var model = new UserBLL().GetUserBasicInfoModelByTelNo(tel);
            if (model == null) //该手机号码未注册
            {
                GetCodeByMobile();
            }
            else
            {                 //该手机号码已注册
                PrintJson("-38", "已存在的用户");
            }
        }
        /// <summary>
        /// 手机注册验证码
        /// </summary>
        public void GetCodeByMobile()
        {
            string phoneNum = Context.Request.Form["phoneNum"].Trim();
            string vtype = Context.Request["vtype"];//0短信，1语音
            //string random = StringUtilily.GetRandomString(6);
            string telNo = phoneNum;
            string strIP = Tool.WebFormHandler.GetIP();
            string phoneRegex = "^(13|14|15|17|18)[0-9]{9}$";
            if (!Regex.IsMatch(phoneNum, phoneRegex))
            {
                PrintJson("0", "手机号码格式不正确");
                return;
            }
            //CodeRecord codeRecord = new CodeRecord();
            //codeRecord.Id = Guid.NewGuid();
            //codeRecord.UserId = null;
            //codeRecord.Code = random;
            //codeRecord.AddDate = DateTime.Now; ;
            //codeRecord.Status = 0;
            //codeRecord.Type = (int)ConstString.MSCodeType.PhoneCode;
            //codeRecord.Type2 = (int)ConstString.MSCodeType2.RegPhoneValid;//通过手机注册
            //codeRecord.token = token;
            //codeRecord.TypeValue = telNo;
            //db.CodeRecord.AddObject(codeRecord);
            //if (db.SaveChanges() > 0)
            var canSend = new CodeRecordBLL().IsCanSendNewCodeRecord(phoneNum, MsCodeType.PhoneCode, MsCodeType2.RegPhoneValid, null, 1, strIP);
            if (!canSend.Success)
            {
                PrintJson("-1", canSend.Message);
            }

            CodeRecordInfo codeRecordInfo = new CodeRecordBLL().CreateCodeRecordInfo(null, strIP, MsCodeType.PhoneCode, MsCodeType2.RegPhoneValid, telNo);
            if(codeRecordInfo != null)
            {

                var parameters = new Dictionary<string, object>();
                parameters.Add("ValidateCode", codeRecordInfo.Code);

                var msgSender = new BusinessDll.MessageSend();

                if (vtype == "0")
                {
                    msgSender.SendMessage2(option: SendOption.Sms, eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: phoneNum);
                }
                else
                {
                    msgSender.SendMessage2(option: SendOption.Voice, eventCode: MessageTemplates.ValidateCode, mobile: phoneNum, content: codeRecordInfo.Code);
                }

                PrintJson("1", "发送验证码成功");

            }
            else
            {
                PrintJson("0", "发送验证码失败");
            }
        }

        #region 忘记密码通过手机找回密码

        /// <summary>
        /// 重置登录密码.
        /// </summary>
        public void ResetLoginPwd()
        {
            var inputOldPwd = this.Context.Request.Form["oldpwd"].ToString();
            var inputNewPwd = this.Context.Request.Form["newpwd"].ToString();

            #region 解密
            if (!string.IsNullOrEmpty(inputOldPwd))
            {
                try
                {
                    inputOldPwd = DESC.DecryptFromHexes(inputOldPwd, GlobalUtils.DesKey);
                }
                catch
                {
                    PrintJson("-1", "非法请求");
                    return;
                }
            }
            if (!string.IsNullOrEmpty(inputNewPwd))
            {
                try
                {
                    inputNewPwd = DESC.DecryptFromHexes(inputNewPwd, GlobalUtils.DesKey);
                }
                catch
                {
                    PrintJson("-1", "非法请求");
                    return;
                }
            }
            #endregion

            var userId = WebUserAuth.UserId.Value;
            if (userId == Guid.Empty)
            {
                PrintJson("-99", "登录已失效！");
            }
            var result = UserSecurityBLL.ResetLoginPwd(userId, inputOldPwd, inputNewPwd);
            if (result == null)
            {
                PrintJson("0", "重置失败，请重试！");
            }
            if (result != null && result.Success)
            {
                var user = result.GetParameter<UserBasicInfoInfo>("User");
                if (user != null)
                {
                    //记录修改操作日志.
                    var log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.BusinessId = user.Id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                    log.UserId = user.Id.ToString();
                    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                    log.HandlerTypeId = (int)ConstString.LogType.ChangePassword;
                    log.Content1 = "修改登录密码";
                    log.Id = Guid.NewGuid().ToString();
                    BusinessDll.WebLogInfo.WriteLoginHandler(log);

                    var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                    if (isNewSmsRequest == "0")
                    {
                        //发送消息通知.
                        var messageSender = new MessageSend();
                        var parameters = new Dictionary<string, object>();
                        parameters.Add("CurrentDate", DateTime.Now);
                        parameters.Add("User", user);
                        messageSender.SendMessage2(eventCode: MessageTemplates.ResetLoginPasswordSuccess,
                            parameters: parameters, mobile: user.TelNo, email: user.Email, userId: user.Id);
                    }
                    else
                    {
                        SmsRequest modifUserLoginPasswordRequest = new SmsRequest();
                        modifUserLoginPasswordRequest.EventCode = MsgTemplatesType.ModifyUserLoginPassword;
                        modifUserLoginPasswordRequest.PlatformSource = PlatformSource.WeiXin;
                        modifUserLoginPasswordRequest.EmailAddress = user.Email;
                        modifUserLoginPasswordRequest.UserId = user.Id;
                        modifUserLoginPasswordRequest.Mobile = user.TelNo;

                        string errorMessage = string.Empty;
                        SmsClient.SendMessage(modifUserLoginPasswordRequest, ref errorMessage);
                    }
                }
            }

            PrintJson(result.Code.ToString(), result.Message);
        }


        //通过手机验证码找回密码
        public void GetResetPasswordMobileCode()
        {
            string mobilePhone = Context.Request.Form["mobilePhone"];
            string type = Context.Request.Form["vtype"];
            //UserBasicInfo model = db.UserBasicInfo.FirstOrDefault(p => p.TelNo == mobilePhone);
            var model = new UserBLL().GetUserBasicInfoModelByTelNo(mobilePhone);
            if (model == null)
            {
                PrintJson("-1", "您输入的手机号未在团贷网注册!");
            }
            //UserSetting usersetting = db.UserSettings.FirstOrDefault(p => p.UserId == model.Id);
            var usersetting = new UserSettingBLL().GetUserSettingInfo(model.Id);
            if (usersetting != null)
            {
                if (usersetting.IsAllowChangePwd == false)
                {
                    PrintJson("-2", "账号已被锁定不允许找回密码，请联系客服");
                }
            }
            //UserBasicDetail userDetials=db.UserBasicDetails.FirstOrDefault(p => p.UserId == model.Id);
            var userDetials = new UserBLL().GetUserBasicDetailByUserId(model.Id);
            if (userDetials != null) {
                if ((userDetials.FailedPasswordCount??0) == 5) {
                    PrintJson("-4", "账号已被冻结不允许找回密码");
                }
            }

            DateTime CurrentDate = DateTime.Now.Date;
            //if (db.CodeRecord.Count(p => p.UserId == model.Id && p.Type == 2 && p.Type2 == 1 && p.AddDate >= CurrentDate) >= 5)
            //{
            //    PrintJson("-3", "验证码发送失败，一个手机号每天只能发送5次，请联系客服");
            //}
            var result = new CodeRecordBLL().IsCanSendNewCodeRecord(mobilePhone, MsCodeType.PhoneCode,  MsCodeType2.ForgotPassword, model.Id);
            if (!result.Success)
            {
                PrintJson(result.Code.ToString(), result.Message);
            }

            string telNo = model.TelNo;
            string token = Encryption.MD5(model.Id.ToString());
            //string random = StringUtilily.GetRandomString(6);
            //CodeRecord codeRecord = new CodeRecord();
            //codeRecord.Id = Guid.NewGuid();
            //codeRecord.UserId = model.Id;
            //codeRecord.Code = random;
            //codeRecord.AddDate = DateTime.Now; ;
            //codeRecord.Status = 0;
            //codeRecord.Type = 2;
            //codeRecord.Type2 = 1;//
            //codeRecord.token = token;
            //codeRecord.TypeValue = telNo;
            //db.CodeRecord.AddObject(codeRecord);

            //if (db.SaveChanges() > 0)
            var code = new CodeRecordBLL().CreateCodeRecordInfo(model.Id, "", MsCodeType.PhoneCode, MsCodeType2.ForgotPassword, telNo);
            if(code != null)
            {
                if (ConfigHelper.getConfigString("IsTestOrDev", "0") == "1")
                {
                    PrintJson("1", "已发送，1分钟后可重新获取。");
                }
                else
                {
                    var parameters = new Dictionary<string, object>();
                    parameters.Add("ValidateCode", code.Code);

                    var msgSender = new BusinessDll.MessageSend();

                    if (type == "0")
                        msgSender.SendMessage2(option: SendOption.Sms, eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: telNo);
                    else
                        msgSender.SendMessage2(option: SendOption.Voice, eventCode: MessageTemplates.ValidateCode, mobile: telNo, content: code.Code);

                    PrintJson("1", "已发送，1分钟后可重新获取。");
                }
                
            }
            else
            {
                PrintJson("0", "验证码发送失败，请重试。");
            }
        }

        /// <summary>
        /// 手机找回密码：检查验证码
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public void CheckResetPasswordMobileCode()
        {
            string code = Context.Request.Form["code"];
            string mobile = Context.Request.Form["mobile"];
            if (string.IsNullOrEmpty(mobile))
            {
                PrintJson("0", "请输入手机号码");
            }
            if (string.IsNullOrEmpty(code))
            {
                PrintJson("0", "请输入短信验证码");
            }
            var model = new TuanDai.PortalSystem.BLL.UserBLL().GetUserBasicInfoModelByTelNo(mobile);
            if (model == null) {
                PrintJson("0", "手机号未注册");
                return;
            }
            int result = new CodeRecordBLL().CheckCodeRecord(code,mobile, MsCodeType.PhoneCode, MsCodeType2.ForgotPassword, model.Id, true);//
            if (result == 1)
            {
                //Context.Session["ResetTelNo"] = mobile + "|" + code;
                string err = "";
                RedisServerStack.StringSet<string>(TdConfig.ApplicationName, "/redis/web", mobile + "_wxupwd", "pass", ref err, DateTime.Now.AddMinutes(10));
                if (!string.IsNullOrEmpty(err))
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName,"wap写入修改密码redis出错",mobile,err);
                }
                CookieHelper.WriteCookie("shellben1x", Tool.DESC.EncryptTripleDES(mobile+"|"+code));
            }

            PrintJson(result.ToString(), "");
        }

        /// <summary>
        /// 通过手机验证码重置密码
        /// </summary>
        public void ResetPasswordByMobile()
        {
            
            string err = "";
            string ResetTelNo = Tool.DESC.DecryptTripleDES(CookieHelper.GetCookie("shellben1x")).Split('|')[0];
            string redis = RedisServerStack.StringGet<string>(TdConfig.ApplicationName, "/redis/web", ResetTelNo + "_wxupwd", ref err);
            if (!string.IsNullOrEmpty(err))
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "wap获取修改密码redis出错", ResetTelNo, err);
            }
            if (redis != "pass")
            {
                PrintJson("0", "非法请求");
                return;
            }
            string password = Context.Request.Form["password"].ToText();
            if (string.IsNullOrEmpty(password))
            {
                PrintJson("0", "新密码为空");
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

            if (password.IsEmpty())
            {
                PrintJson("0", "新密码为空");
                return;
            }
            string telno = ResetTelNo;
            string code =Tool.DESC.DecryptTripleDES(CookieHelper.GetCookie("shellben1x")).Split('|')[1];

            var codeinfo = new CodeRecordBLL().GetCodeRecordInfo(null, null, null, telno, "", code, null, null, null, "");
            if (codeinfo == null)
            {
                PrintJson("0", "验证码已过期");
                return;
            }

            var basicinfomodel = new UserBLL().GetUserBasicInfoModelByTelNo(telno);
            if (basicinfomodel == null)
            {
                PrintJson("0", "手机号未注册");
                return;
            }
            //if (Tool.Encryption.MD5(password) == basicinfomodel.PayPwd)
            //{
            //    PrintJson("-2", "");
            //}

            basicinfomodel.Pwd = Tool.Encryption.MD5(password);
            basicinfomodel.OldPwdStatus = true;
            basicinfomodel.is_Edit = true;
            //int sresult = db.SaveChanges();
            //var isupdate = new UserBLL().UpdateUserBasicInfoById(basicinfomodel.Id, basicinfomodel.Pwd,
            //    basicinfomodel.is_Edit?1:0);
            //if (isupdate)
            //{
                

                if (ConfigurationManager.AppSettings["IsUserService"] == "1")
                {
                    
                        try
                        {
                            string zkErrorMessage = "";
                            string serverUrl = TuanDai.ZKHelper.ZooKClient.GetValueForZK("/url/UserServiceApiUrl", ref zkErrorMessage);
                            if (!string.IsNullOrEmpty(zkErrorMessage))
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "UserServiceApiUrl", "获取UserServiceApiUrl失败", zkErrorMessage);
                            }
                            if (string.IsNullOrEmpty(serverUrl))
                                serverUrl = ConfigurationManager.AppSettings["UserServiceApiUrl"];

                            string postErr = "";
                            WXRequestModifyPassword rbi = new WXRequestModifyPassword();
                            rbi.newPassword = password;
                            rbi.platform = "TUANDAI_WAP";
                            rbi.userId = basicinfomodel.Id.ToString();
                            string responseStr = HttpClient.HttpUtil.HttpPostJson(TdConfig.ApplicationName, serverUrl + "/user/resetPassword", JsonConvert.SerializeObject(rbi),
                                out postErr, null, 10, Encoding.UTF8, true);
                            if (!string.IsNullOrEmpty(postErr))
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "user-servive/modifyLoginPassword", "修改用户登录密码Post错误", postErr);
                            }
                            WXResponseMessage wrm = JsonConvert.DeserializeObject<WXResponseMessage>(responseStr);
                            if (wrm.code != "SUCCESS")
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName,
                                    "user-servive/modifyLoginPassword", "修改用户登录密码接口返回错误", wrm.message);
                                err = wrm.message;
                            }
                            else
                            {
                                ResetPasswordByMobileClear(telno);
                            }
                        }
                        catch (Exception ex)
                        {
                            TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "user-servive/modifyLoginPassword", "修改用户登录密码程序出错", ex.Message);
                            PrintJson("0", "系统异常");
                            return;
                        }
                    if (!string.IsNullOrEmpty(err))
                    {
                        PrintJson("0", err);
                        return;
                    }
                    
                //}

                WebLog log = new WebLog();
                log.AddDate = DateTime.Now;
                log.BusinessId = basicinfomodel.Id.ToString();
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                log.UserId = basicinfomodel.Id.ToString();
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.ChangePassword;
                log.Content1 = "通过手机验证码重置密码";
                log.Id = Guid.NewGuid().ToString();
                WebLogInfo.WriteLoginHandler(log);
                var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                if (isNewSmsRequest == "0")
                {
                    //改用新的发短信，邮件，系统消息
                    MessageSend ms = new MessageSend();
                    var parameters = new Dictionary<string, object>();
                    parameters.Add("CurrentDate", DateTime.Now);
                    parameters.Add("User", basicinfomodel);
                    //修改登录密码成功的时候提示
                    ms.SendMessage2(eventCode: MessageTemplates.RetrieveLoginPasswordSuccess, parameters: parameters, mobile: basicinfomodel.TelNo, email: basicinfomodel.Email, userId: basicinfomodel.Id);
                }
                else
                {
                    SmsRequest modifUserLoginPasswordRequest = new SmsRequest();
                    modifUserLoginPasswordRequest.EventCode = MsgTemplatesType.ModifyUserLoginPassword;
                    modifUserLoginPasswordRequest.PlatformSource = PlatformSource.WeiXin;
                    modifUserLoginPasswordRequest.EmailAddress = basicinfomodel.Email;
                    modifUserLoginPasswordRequest.UserId = basicinfomodel.Id;
                    modifUserLoginPasswordRequest.Mobile = basicinfomodel.TelNo;

                    string errorMessage = string.Empty;
                    SmsClient.SendMessage(modifUserLoginPasswordRequest, ref errorMessage);
                }

                WebUserAuth.SignOut();
                PrintJson("1", "修改成功");
            }
            
            
            PrintJson("0", "修改失败");
        }
        private void ResetPasswordByMobileClear(string telNo)
        {
            try
            {
                string err = string.Empty;
                //清除redis
                RedisServerStack.KeyRemove(TdConfig.ApplicationName, "/redis/web", telNo + "_wxupwd", ref err);
                //清除cookie
                CookieHelper.ClearCookie("shellben1x");
            }
            catch (Exception ex)
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ResetPasswordByMobileClear",
                    telNo, ex.Message + "|" + ex.StackTrace);
            }
        }
        #endregion

        /// <summary>
        /// 获取城市
        /// </summary>
        public void getcity()
        {
            string province = Context.Request.Form["province"];
            //T_Province pmodel = dbread.T_Province.First(p => p.ProName == province);
            //IQueryable<T_City> citylist = dbread.T_City.Where(p => p.ProID == pmodel.ProID);
            var pmodel = new T_ProvinceBLL().GetProvinceByProName(province);
            var citylist = new T_ProvinceBLL().GetCityListByProId(pmodel.ProID);
            System.Text.StringBuilder list = new System.Text.StringBuilder();
            int index = 1;
            foreach (T_CityInfo model in citylist)
            {
                list.Append("{\"CityName\":\"");
                list.Append(model.CityName);
                list.Append("\"}");
                if (index < citylist.Count())
                {
                    list.Append(",");
                }
                index++;
            }

            string strjson = "{\"result\":\"1\",\"list\":[" + list.ToString() + "]}";
            this.Context.Response.Write(strjson);
            this.Context.Response.End();
        }

        /// <summary>
        /// 根据当前银行卡号获取限额
        /// </summary>
        public void GetBankCardBin()
        {
            string BankAccountNo = Context.Request.Form["BankAccountNo"];
            //var id = Guid.Parse("E27798C9-9301-4176-AC0B-6F3916F389EA");
            //var webSetting = db.WebSetting.FirstOrDefault(x => x.Id == id);
            var webSetting = new WebSettingBLL().GetWebSettingInfo("E27798C9-9301-4176-AC0B-6F3916F389EA");
            LLPay.PartnerConfig partnerConfig = new LLPay.PartnerConfig(webSetting.Param1Value, webSetting.Param2Value, webSetting.Param3Value, webSetting.Param5Value);

            string url = "https://yintong.com.cn/traderapi/bankcardquery.htm";

            SortedDictionary<string, string> sParaTemp = new SortedDictionary<string, string>();
            sParaTemp.Add("oid_partner", partnerConfig.OidPartner);
            sParaTemp.Add("sign_type", "RSA");
            sParaTemp.Add("card_no", BankAccountNo);
            sParaTemp.Add("pay_type", "D");
            sParaTemp.Add("flag_amt_limit", "1");

            string strb = "";
            foreach (var item in sParaTemp)
            {
                if (strb == "")
                {
                    strb = item.Key + "=" + item.Value;
                }
                else
                {
                    strb += "&" + item.Key + "=" + item.Value;
                }
            }
            string req_data = strb;
            String sign = LLPay.RSAFromPkcs8.sign(req_data, partnerConfig.TraderPriKey, "utf-8");
            BankCardInfo info = new BankCardInfo();
            info.oid_partner = partnerConfig.OidPartner;
            info.sign_type = "RSA";
            info.sign = sign;
            info.card_no = BankAccountNo;
            info.pay_type = "D";
            info.flag_amt_limit = "1";



            string json = Tool.HttpUtils.HttpPost(url, Newtonsoft.Json.JsonConvert.SerializeObject(info));
            BankCardBin bankcard = new BankCardBin();
            bankcard = Newtonsoft.Json.JsonConvert.DeserializeObject<BankCardBin>(json);

            if (!bankcard.single_amt.IsEmpty() && !bankcard.day_amt.IsEmpty())
            {
                PrintJson("1", "<img src=\"/imgs/images/ico_warn.png\" class=\"mr5\"/>每笔最高额度" + bankcard.single_amt + "元，每日最高额度" + bankcard.day_amt + "元。");
            }
            else
            {
                PrintJson("0", "<img src=\"/imgs/images/ico_warn.png\" class=\"mr5\"/>查询失败，请重试!");
            }
        }
        /// <summary>
        /// 发送重置交易密码的验证码
        /// </summary>
        public void GetResetPayPwdMobileCode()
        {
            string mobilePhone = Context.Request.Form["mobilePhone"];
            string type = Context.Request.Form["vtype"];
            //UserBasicInfo model = db.UserBasicInfo.FirstOrDefault(p => p.TelNo == mobilePhone);
            var model = new UserBLL().GetUserBasicInfoModelByTelNo(mobilePhone);
            if (model == null)
            {
                PrintJson("-1", "您输入的手机号未在团贷网注册!");
            }
            //UserSetting usersetting = db.UserSettings.FirstOrDefault(p => p.UserId == model.Id);
            var usersetting = new UserSettingBLL().GetUserSettingInfo(model.Id);
            if (usersetting != null)
            {
                if (usersetting.PayPwdErrorCount >= 5)
                {
                    PrintJson("-2", "交易密码输错已达5次，请联系客服");
                }
            }
            DateTime CurrentDate = DateTime.Now.Date;
            //if (db.CodeRecord.Count(p => p.UserId == model.Id && p.Type == 2 && p.Type2 == 1 && p.AddDate >= CurrentDate) >= 5)
            //{
            //    PrintJson("-3", "验证码发送失败，一个手机号每天只能发送5次，请联系客服");
            //}
            var result = new CodeRecordBLL().IsCanSendNewCodeRecord(mobilePhone, MsCodeType.PhoneCode, MsCodeType2.TradePassword, model.Id);
            if (!result.Success)
            {
                PrintJson(result.Code.ToString(), result.Message);
            }
            string telNo = model.TelNo;
            string token = Encryption.MD5(model.Id.ToString());
            //string random = StringUtilily.GetRandomString(6);
            //CodeRecord codeRecord = new CodeRecord();
            //codeRecord.Id = Guid.NewGuid();
            //codeRecord.UserId = model.Id;
            //codeRecord.Code = random;
            //codeRecord.AddDate = DateTime.Now; ;
            //codeRecord.Status = 0;
            //codeRecord.Type = 2;
            //codeRecord.Type2 = 14;//
            //codeRecord.token = token;
            //codeRecord.TypeValue = telNo;
            //db.CodeRecord.AddObject(codeRecord);

            //if (db.SaveChanges() > 0)
            var code = new CodeRecordBLL().CreateCodeRecordInfo(model.Id, "", MsCodeType.PhoneCode, MsCodeType2.TradePassword, mobilePhone);
            if(code != null)
            {
                var parameters = new Dictionary<string, object>();
                parameters.Add("ValidateCode", code.Code);

                var msgSender = new BusinessDll.MessageSend();

                if (type == "0")
                    msgSender.SendMessage2(option: SendOption.Sms, eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: telNo);
                else
                    msgSender.SendMessage2(option: SendOption.Voice, eventCode: MessageTemplates.ValidateCode, mobile: telNo, content: code.Code);

                PrintJson("1", "已发送，3分钟后可重新获取。");
            }
            else
            {
                PrintJson("0", "验证码发送失败，请重试。");
            }
        }
        /// <summary>
        /// 重置交易密码.
        /// </summary>
        public void ResetPayPwdViaMobile()
        {
            var inputCode = this.Context.Request.Form["code"].ToString();
            var inputNewPwd = this.Context.Request.Form["newpwd"].ToString();
            var userId = BusinessDll.WebUserAuth.UserId.Value;
            var result = UserSecurityBLL.ResetPayPwdViaMobile(userId, inputCode, inputNewPwd);
            if (result.Success)
            {
                var user = result.GetParameter<UserBasicInfoInfo>("User");

                //记录修改操作日志.
                var log = new WebLog();
                log.AddDate = DateTime.Now;
                log.BusinessId = user.Id.ToString();
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                log.UserId = user.Id.ToString();
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.ChangePayPassword;
                log.Content1 = "修改交易密码";
                log.Id = Guid.NewGuid().ToString();
                BusinessDll.WebLogInfo.WriteLoginHandler(log);

                var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                if (isNewSmsRequest == "0")
                {
                    //发送消息通知.
                    var messageSender = new MessageSend();
                    var parameters = new Dictionary<string, object>();
                    parameters.Add("CurrentDate", DateTime.Now);
                    parameters.Add("User", user);
                    messageSender.SendMessage2(eventCode: MessageTemplates.ModifyTradersPassword,
                        parameters: parameters, mobile: user.TelNo, email: user.Email, userId: user.Id);
                }
                else
                {
                    SmsRequest modifyTradersPasswordRequest = new SmsRequest();
                    modifyTradersPasswordRequest.EventCode = MsgTemplatesType.ModifyTradersPassword;
                    modifyTradersPasswordRequest.PlatformSource = PlatformSource.Pc;
                    modifyTradersPasswordRequest.UserId = user.Id;
                    modifyTradersPasswordRequest.EmailAddress = user.Email;
                    modifyTradersPasswordRequest.Mobile = user.TelNo;

                    string errorMessage = string.Empty;
                    SmsClient.SendMessage(modifyTradersPasswordRequest, ref errorMessage);
                }
            }
            this.PrintJson(result.Code.ToString(), result.Message);
        }

        /// <summary>
        /// 申请债权转让验证码
        /// </summary>
        public void GetCodeByZQZR()
        {
            Guid userId = WebUserAuth.UserId.Value;
            if (userId == Guid.Empty)
            {
                PrintJson("-99", "还没有登录");
                return;
            }
            string phoneNum = new UserBLL().GetUserBasicInfoModelById(userId).TelNo;
            if (string.IsNullOrEmpty(phoneNum))
            {
                PrintJson("-2", "未绑定手机号码，无法发送");
                return;
            }
            string strIP = Tool.WebFormHandler.GetIP();
            
            var canSend = new CodeRecordBLL().IsCanSendNewCodeRecord(phoneNum, MsCodeType.PhoneCode, MsCodeType2.SubScribeTransferCode, null, 1, strIP,8);
            if (!canSend.Success)
            {
                PrintJson(canSend.Code.ToString(), canSend.Message);
            }

            CodeRecordInfo codeRecordInfo = new CodeRecordBLL().CreateCodeRecordInfo(userId, strIP, MsCodeType.PhoneCode, MsCodeType2.SubScribeTransferCode, phoneNum);
            if (codeRecordInfo != null)
            {

                var parameters = new Dictionary<string, object>();
                parameters.Add("ValidateCode", codeRecordInfo.Code);
                var msgSender = new BusinessDll.MessageSend();
                msgSender.SendMessage2(option: SendOption.Sms, eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: phoneNum);
                PrintJson("1", "发送验证码成功");

            }
            else
            {
                PrintJson("0", "发送验证码失败");
            }
        }
        public void SetUserWxNotice()
        {
            var openId = this.Context.Request.Form["openId"].ToString();
            var name = this.Context.Request.Form["name"].ToString();
            var status = this.Context.Request.Form["status"].ToString();
            string sql = "select count(1) from UserWXNotice with(nolock) where OpenId=@OpenId";
            Dapper.DynamicParameters para = new Dapper.DynamicParameters();
            para.Add("@OpenId", openId);
            var count =
                TuanDai.DB.TuanDaiDB.Query<int>(TdConfig.DBRead, sql, ref para).FirstOrDefault();
            var rowCount = 0;
            Guid userId = WebUserAuth.UserId.Value;
            if (count > 0)
            {
                para = new Dapper.DynamicParameters();
                para.Add("@UpdateDate", DateTime.Now);
                para.Add("@OpenId", openId);
                if (userId==Guid.Empty)
                   para.Add("@UserId", null);
                else
                    para.Add("@UserId", userId);
                sql = "Update UserWXNotice Set UpdateDate = @UpdateDate,UserId=@UserId ";
                if (name == "IsFundNotice")
                {
                    sql += ",IsFundNotice=@IsFundNotice ";
                    para.Add("@IsFundNotice", status);
                }
                else if (name == "IsPersonalMsgNotice")
                {
                    sql += ",IsPersonalMsgNotice=@IsPersonalMsgNotice ";
                    para.Add("@IsPersonalMsgNotice", status);
                }
                else if (name == "IsWeXNotice")
                {
                    sql += ",IsWeXNotice=@IsWeXNotice ";
                    para.Add("@IsWeXNotice", status);
                }
                else if (name == "IsActivityNotice")
                {
                    sql += ",IsActivityNotice=@IsActivityNotice ";
                    para.Add("@IsActivityNotice", status);
                }
                    
                sql += " Where OpenId=@OpenId";

                rowCount = PublicConn.ExecuteTD(PublicConn.DBWriteType.UserWrite, sql, ref para); 
            }
            else
            {
                para = new Dapper.DynamicParameters();
                para.Add("@UpdateDate", DateTime.Now);
                para.Add("@AddDate", DateTime.Now);
                para.Add("@Id", Guid.NewGuid());
                para.Add("@OpenId", openId); 
                if (userId == Guid.Empty)
                    para.Add("@UserId", null);
                else
                    para.Add("@UserId", userId);

                sql =
                    @"INSERT INTO dbo.UserWXNotice( Id ,UserId , OpenId ,IsFundNotice ,IsPersonalMsgNotice ,IsWeXNotice ,IsActivityNotice ,AddDate ,UpdateDate)
VALUES  ( @Id , @UserId , @OpenId , @IsFundNotice , @IsPersonalMsgNotice , @IsWeXNotice ,@IsActivityNotice , @AddDate ,@UpdateDate )";
                if (name == "IsFundNotice")
                {
                    para.Add("@IsFundNotice", 1);
                    para.Add("@IsPersonalMsgNotice", 0);
                    para.Add("@IsWeXNotice", 0);
                    para.Add("@IsActivityNotice", 0);
                }
                else if (name == "IsPersonalMsgNotice")
                {
                    para.Add("@IsPersonalMsgNotice", 1);
                    para.Add("@IsFundNotice", 0);
                    para.Add("@IsWeXNotice", 0);
                    para.Add("@IsActivityNotice", 0);
                }
                else if (name == "IsWeXNotice")
                {
                    para.Add("@IsWeXNotice", 1);
                    para.Add("@IsFundNotice", 0);
                    para.Add("@IsPersonalMsgNotice", 0);
                    para.Add("@IsActivityNotice", 0);
                }
                else if (name == "IsActivityNotice")
                {
                    para.Add("@IsActivityNotice", 1);
                    para.Add("@IsFundNotice", 0);
                    para.Add("@IsPersonalMsgNotice", 0);
                    para.Add("@IsWeXNotice", 0);
                }
                else
                {
                    para.Add("@IsActivityNotice", 0);
                    para.Add("@IsFundNotice", 0);
                    para.Add("@IsPersonalMsgNotice", 0);
                    para.Add("@IsWeXNotice", 0);
                }

                rowCount = PublicConn.ExecuteTD(PublicConn.DBWriteType.UserWrite, sql, ref para);
            }
            if (rowCount > 0)
                PrintJson("1", "更新成功");
            else
                PrintJson("0", "更新失败");
        }

        /// <summary>
        /// 发送手机验证码.
        /// </summary>
        public void SendMobileValidateCode()
        {
            var eventType = Context.Request["eventType"];
            var sendType = Context.Request["sendType"];
            var userId = WebUserAuth.UserId.Value;

            var result = UserSecurityBLL.SendVerifyCodeToCurrentLoginUser(userId, MsCodeType.PhoneCode, eventType.ToEnum<MsCodeType2>());
            if (result.Success) result = this.SendMessage(result, sendType.ToEnum<TuanDai.Common.Enums.VerifySendType>());

            this.PrintJson(result.Code.ToString(), result.Message);
        }

        /// <summary>
        /// 校验手机验证码.
        /// </summary>
        public void CheckMobileValidateCode()
        {
            var code = Context.Request.Form["Code"];
            var type = this.Context.Request.Form["type"];
            var userId = WebUserAuth.UserId.Value;

            var result = UserSecurityBLL.CheckMobileValidateCode(userId, code, type.ToEnum<MsCodeType2>());
            if (result.Success)
            {
                this.WriteCheckInfoToCookie(userId.ToString(), code);
            }
            this.PrintJson(result.Code.ToString(), result.Message);
        }

        /// <summary>
        /// 写入验证信息到cookie
        /// </summary>
        /// <param name="userid">用户ID</param>
        /// <param name="checkInfo">验证信息,如果是验证码则写验正码，如果是安全问题答案则写安全问题答案</param>
        private void WriteCheckInfoToCookie(string userid, string checkInfo)
        {
            string key = Tool.Encryption.MD5(userid.ToString() + "_" + checkInfo);
            CookieHelper.WriteCookie(ConfigurationManager.AppSettings["CookieDomain"], key, Tool.Encryption.MD5(checkInfo), 10);
        }

        /// <summary>
        /// 校验验证信息通过Cookies
        /// </summary>
        /// <param name="userid">用户ID</param>
        /// <param name="checkInfo">验证信息</param>
        /// <returns>通过验证</returns>
        private bool VerifyCheckInfoByCookie(string userid, string checkInfo)
        {
            string key = Tool.Encryption.MD5(userid.ToString() + "_" + checkInfo);
            string cookieCode = CookieHelper.GetCookie(key);
            if (cookieCode.Equals(Tool.Encryption.MD5(checkInfo)))
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// 向新手机发送手机验证码.
        /// </summary>
        public void SendNewMobileValidateCode()
        {
            var mobile = Context.Request["phoneNum"];
            var sendType = Context.Request["type"];
            var userId = WebUserAuth.UserId.Value;

            var result = UserSecurityBLL.SendVerifyCodeToNewBindTel(mobile, userId);
            if (result.Success) result = this.SendMessage(result, sendType.ToEnum<TuanDai.Common.Enums.VerifySendType>());

            this.PrintJson(result.Code.ToString(), result.Message);
        }

        #region 个人安全中心 手机验证模块开始
        /// <summary>
        /// 个人中心-手机验证模块
        /// 通过验证码修改手机号码
        /// 第一次绑定手机与换手机重新绑定手机
        /// </summary>
        public void ModifyPhoneByVerifyCode()
        {
            lock (lockobj)
            {
                string telNo = Context.Request.Form["tel"].Trim();
                string checkcode = Context.Request.Form["checkcode"];
                string originalCode = Context.Request.Form["originalcode"];
                Guid userid = WebUserAuth.UserId.Value;

                bool originalCodeIsValided = VerifyCheckInfoByCookie(userid.ToString(), originalCode);
                var processResult = UserSecurityBLL.ModifBindTelNoByVerifyCode(telNo, userid, checkcode, originalCodeIsValided);

                if (processResult.Success)
                {
                    #region 用户信息加密
                    UpdateUserInfoClient client = new UpdateUserInfoClient();
                    UpdateUserBasicInfoRequest request = new UpdateUserBasicInfoRequest();
                    request.UserId = userid;
                    request.TelNo = telNo;
                    string errorInfo = string.Empty;
                    bool res = client.UpdateUserBasicInfo(request, ref errorInfo);
                    if (!res || !string.IsNullOrEmpty(errorInfo))
                    {
                        TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "UpdateUserInfoClient.UpdateUserBasicInfo", "用户信息加密错误", errorInfo);
                    }
                    #endregion

                    UserBasicInfoInfo model = processResult.GetParameter<UserBasicInfoInfo>("UserBasicInfo");
                    bool isValidateMobile = processResult.GetParameter<bool>("IsValidateMobile");
                    string oldTelNo = processResult.GetParameter<string>("OldTelNo");
                    string newTelNo = processResult.GetParameter<string>("NewTelNo");
                    if (GlobalUtils.IsUserService)
                    {
                        TuandaiCommnetTool.BaseCommon.TaskAsyncHelper.RunAsync(() =>
                        {
                            string zkErrorMessage = "";
                            string serverUrl = TuanDai.ZKHelper.ZooKClient.GetValueForZK("/url/UserServiceApiUrl", ref zkErrorMessage);
                            if (!string.IsNullOrEmpty(zkErrorMessage))
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "UserServiceApiUrl", "获取UserServiceApiUrl失败", zkErrorMessage);
                            }
                            if (string.IsNullOrEmpty(serverUrl))
                                serverUrl = GlobalUtils.JavaUserInfoUrl;

                            string postErr = "";
                            WXRequestModifyTelNo rbi = new WXRequestModifyTelNo();
                            rbi.oldTelNo = oldTelNo;
                            rbi.newTelNo = newTelNo;
                            rbi.userId = model.Id;
                            string responseStr = HttpClient.HttpUtil.HttpPostJson(TdConfig.ApplicationName, serverUrl + "/user/" + model.Id + "/modifyTelNo", JsonConvert.SerializeObject(rbi),
                                out postErr, null, 10, Encoding.UTF8, true);
                            if (!string.IsNullOrEmpty(postErr))
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "user-servive/modifyBasicInfo", "修改用户手机号Post错误", postErr);
                            }
                            WXResponseMessage wrm = JsonConvert.DeserializeObject<WXResponseMessage>(responseStr);
                            if (wrm.code != "SUCCESS")
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "user-servive/modifyBasicInfo", "修改用户手机号接口返回错误", wrm.message);
                            }
                        });
                    }
                    if (model != null)
                    {
                        //好帮贷互通开关 1：开
                        string isInterworking = System.Configuration.ConfigurationManager.AppSettings["IsInterworking"];
                        if (isInterworking == "1")
                        {
                            string result = IHao8D.UpdateTelNo(model.UserName, model.TelNo);
                            if (result == "1" || result == "-3") //修改成功或用户未关联或未启用关联
                            {
                                WebLog log = new WebLog();
                                log.AddDate = DateTime.Now;
                                log.BusinessId = model.Id.ToString();
                                log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                                log.HandlerTypeId = (int)ConstString.LogType.EditPhone;
                                log.UserId = model.Id.ToString();
                                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                                log.Content1 = "用户重置手机号码，旧手机号码：" + oldTelNo + "；新手机号码：" + newTelNo;
                                log.Id = Guid.NewGuid().ToString();
                                BusinessDll.WebLogInfo.WriteLoginHandler(log);

                                //改用新的发短信，邮件，系统消息 
                                SmsRequest modifyMobileSmsRequest = new SmsRequest();
                                modifyMobileSmsRequest.EventCode = MsgTemplatesType.ModifyMobile;
                                modifyMobileSmsRequest.PlatformSource = PlatformSource.Pc;
                                modifyMobileSmsRequest.UserId = userid;
                                modifyMobileSmsRequest.Mobile = newTelNo;
                                modifyMobileSmsRequest.EmailAddress = model.Email;
                                string errorString = string.Empty;
                                SmsClient.SendMessage(modifyMobileSmsRequest, ref errorString);
                                if (!string.IsNullOrEmpty(errorString))
                                {
                                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "Ajax_UserSecurity/ModifyPhoneByVerifyCode", Newtonsoft.Json.JsonConvert.SerializeObject(modifyMobileSmsRequest), errorString);
                                }

                                //如果用户是彩票网站跳转过来，则跳转至彩票网站
                                if (string.IsNullOrEmpty(oldTelNo) && model.IsValidateEmail && model.IsValidateIdentity &&
                                    model.IsValidateMobile && model.IsSafeQuestion)
                                {
                                    string caipiaoReturnUrl = CookieHelper.GetCookie("caipiaoReturnUrl");
                                    if (!string.IsNullOrEmpty(caipiaoReturnUrl))
                                    {
                                        PrintJson("100", caipiaoReturnUrl);
                                        return;
                                    }
                                }

                                PrintJson("1", "");

                            }
                            else if (result == "0")
                            {
                                UserSecurityBLL.RollBackModifBindTelNoByVerifyCode(oldTelNo, userid, isValidateMobile);
                                PrintJson("-5", "");
                            }
                            else PrintJson("-4", "");
                        }
                        else
                        {
                            WebLog log = new WebLog();
                            log.AddDate = DateTime.Now;
                            log.BusinessId = model.Id.ToString();
                            log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                            log.HandlerTypeId = (int)ConstString.LogType.EditPhone;
                            log.UserId = model.Id.ToString();
                            log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                            log.Content1 = "用户重置手机号码，旧手机号码：" + oldTelNo + "；新手机号码：" + newTelNo;
                            log.Id = Guid.NewGuid().ToString();
                            BusinessDll.WebLogInfo.WriteLoginHandler(log);

                            //改用新的发短信，邮件，系统消息 
                            SmsRequest modifyMobileSmsRequest = new SmsRequest();
                            modifyMobileSmsRequest.EventCode = MsgTemplatesType.ModifyMobile;
                            modifyMobileSmsRequest.PlatformSource = PlatformSource.Pc;
                            modifyMobileSmsRequest.UserId = userid;
                            modifyMobileSmsRequest.Mobile = newTelNo;
                            modifyMobileSmsRequest.EmailAddress = model.Email;
                            string errorString = string.Empty;
                            SmsClient.SendMessage(modifyMobileSmsRequest, ref errorString);
                            if (!string.IsNullOrEmpty(errorString))
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "Ajax_UserSecurity/ModifyPhoneByVerifyCode", Newtonsoft.Json.JsonConvert.SerializeObject(modifyMobileSmsRequest), errorString);
                            }

                            //如果用户是彩票网站跳转过来，则跳转至彩票网站
                            if (string.IsNullOrEmpty(oldTelNo) && model.IsValidateEmail && model.IsValidateIdentity &&
                                model.IsValidateMobile && model.IsSafeQuestion)
                            {
                                string caipiaoReturnUrl = CookieHelper.GetCookie("caipiaoReturnUrl");
                                if (!string.IsNullOrEmpty(caipiaoReturnUrl))
                                {
                                    PrintJson("100", caipiaoReturnUrl);
                                    return;
                                }
                            }

                            PrintJson("1", "");
                        }
                    }
                }

                this.PrintJson(processResult.Code.ToString(), processResult.Message);

            }
        }
        #endregion 个人安全中心，手机验证模块结束

        /// <summary>
        /// 发送消息.
        /// </summary>
        /// <param name="result"></param>
        /// <param name="sendType"></param>
        /// <returns></returns>
        private ProcessResult SendMessage(ProcessResult result, TuanDai.Common.Enums.VerifySendType sendType)
        {
            var record = result.GetParameter<TuanDai.PortalSystem.Model.CodeRecordInfo>("CodeRecordInfo");
            if (record == null) return result;

            var messageSender = new BusinessDll.MessageSend();
            string sendResult = string.Empty;
            switch (sendType)
            {
                case TuanDai.Common.Enums.VerifySendType.Sms:
                    var parameters = new Dictionary<string, object>();
                    parameters.Add("ValidateCode", record.Code);
                    sendResult = messageSender.SendMessage2(eventCode: MessageTemplates.ValidateCode,
                        option: SendOption.Sms, parameters: parameters, mobile: record.TypeValue);
                    break;

                case TuanDai.Common.Enums.VerifySendType.Voice:
                    sendResult = messageSender.SendMessage2(eventCode: MessageTemplates.ValidateCode,
                        option: SendOption.Voice, mobile: record.TypeValue, content: record.Code);
                    break;
            }

            if (sendResult != "1")
            {
                result.Success = false;
                result.Code = -2;
                result.Message = "发送失败";
                return result;
            }

            return result;
        }

        public class BankCardInfo
        {
            public string oid_partner { get; set; }
            public string sign_type { get; set; }
            public string sign { get; set; }
            public string card_no { get; set; }
            public string pay_type { get; set; }
            public string flag_amt_limit { get; set; }
        }

        public class BankCardBin
        {
            public string ret_code { get; set; }
            public string ret_msg { get; set; }
            public string sign_type { get; set; }
            public string sign { get; set; }
            public string bank_code { get; set; }
            public string bank_name { get; set; }
            public int card_type { get; set; }
            public string single_amt { get; set; }
            public string day_amt { get; set; }
            public string month_amt { get; set; }
        }
    }


}