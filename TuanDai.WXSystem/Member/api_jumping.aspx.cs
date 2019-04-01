using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using BusinessDll; 
using Newtonsoft.Json;
using Tool;
using TuanDai.Enums;
using TuanDai.Enums.Sms;
using TuanDai.PortalSystem.BLL; 
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.Model.Enums;
using Dapper;
using TuanDai.SMS.Client;

namespace TuanDai.WXApiWeb.Member
{
    public partial class api_jumping : System.Web.UI.Page
    {
        private string _app;
        private string _telNo;
        private string _appUserId;
        private string _pid;

        #region 第三方平台和团贷网之间的约定常量

        private const string RenRenLiKey = "tuandaiandrrl"; //人人利双方约定key
        //private const string RenRenLiCustId = "ce3ed65e244b620c7231e45f1fd387";//商务编号 测试
        private const string RenRenLiCustId = "5769601bf92767f5b708fa6dff4cd4";//正式


        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            _app = Context.Request["app"].ToLower();
            //跳转过来的动作 project:标的详情
            string action = Context.Request["action"].ToLower();

            string url = "~/";
            if (!string.IsNullOrEmpty(_app) && !string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "project": //标的申购
                        url = Project();
                        break;
                    case "account"://账户
                    case "drawmoney": //提现
                    case "recharge": //充值
                    case "list":
                        url = Goto(action);
                        break;
                    default:
                        url = GlobalUtils.WebURL;
                        break;
                }
            }
            Response.Redirect(url);
        }

        #region 跳转方法

        private string JumpBase(string telNo, string projUrl)
        {
            //如果用户已经登录
            if (WebUserAuth.UserId.HasValue && WebUserAuth.UserId.Value != Guid.Empty)
            {
                //是否同一用户
                bool userEx = UserExists(telNo, WebUserAuth.UserId.Value);
                if (userEx)
                {
                    return projUrl;
                }
                else
                {
                    WebUserAuth.SignOut();
                    GlobalUtils.ClearOpenIdFromCookie();
                }
            }

            //如果用户没有登录
            //判断用户是否存在
            TdUserInfo user = GetUserInfo(telNo);
            //如果用户存在 自动登录
            string result = String.Empty;
            if (user != null)
            {
                //是否平台用户
                if (user.RegisterFrom.StartsWith(_app))
                {
                    result = AutoLogin(telNo, user);
                }
                //自动登录失败 或 不是平台用户 跳转到登录页面
                if (!string.IsNullOrEmpty(result) || !user.RegisterFrom.StartsWith(_app))
                {
                    CookieHelper.WriteCookie("Wap_UserName", telNo, 1);
                    return GlobalUtils.WebURL + "/user/Login.aspx?ReturnUrl=" + projUrl;
                }
            }
            else //如果用户不存在  自动注册
            {
                result = UserInsertByPhone(telNo);
                if (!string.IsNullOrEmpty(result))
                {
                    return GlobalUtils.WebURL + "/user/Register.aspx?tdfrom=" + _app +
                           "&phone=" + telNo +
                           "&ReturnUrl=" +
                           projUrl;
                }
            }
            return projUrl;
        }


        private string Goto(string action)
        {
            try
            {
                bool data = SecurityValidation();
                if (!data)
                {
                    return GlobalUtils.WebURL;
                }
                string url = string.Empty;
                switch (action)
                {
                    case "account": //账户首页
                        url = GlobalUtils.WebURL + "/Member/my_account.aspx";
                        break;
                    case "drawmoney": //提现
                        url = GlobalUtils.WebURL + "/Member/withdrawal/drawmoney.aspx";
                        break;
                    case "recharge": //充值
                        url = GlobalUtils.WebURL + "/Member/Bank/Recharge.aspx";
                        break;
                    case "list":
                        url = GlobalUtils.WebURL + "/pages/invest/invest_list.aspx";
                        break;
                    default:
                        url = GlobalUtils.WebURL;
                        break;
                }

                return JumpBase(_telNo, url);
            }
            catch (Exception ex)
            {
                string actName = string.Empty;
                switch (action)
                {
                    case "account": //账户首页
                        actName = "账户首页";
                        break;
                    case "drawmoney": //提现
                        actName = "提现";
                        break;
                    case "recharge": //充值
                        actName = "充值";
                        break;
                    case "list":
                        actName = "投资列表";
                        break;
                    default:
                        break;
                }
                SysLogHelper.WriteErrorLog(_app + actName + "接口出错", ExceptionHelper.GetExceptionMessage(ex));
                return GlobalUtils.WebURL;
            }
        }

        /// <summary>
        /// 标的申购
        /// </summary>
        private string Project()
        {
            try
            {
                bool data = SecurityValidation();

                string url;
                Guid projId = Guid.Parse(_pid);
                WeProductBLL bll = new WeProductBLL();
                //WeProductDetailInfo weProductDetailtInfo = bll.GetWeProductInfo(projId);
                WeProductDetailInfo weProductDetailtInfo = null;
                if (GlobalUtils.IsRedis && GlobalUtils.IsWePlanRedis)
                {
                    string err = string.Empty;
                    var weRedisInfo = TuanDai.RedisApi.Client.WePlanRedis.GetWePlanRedisByProductIdJson(projId,
                    out err, TdConfig.ApplicationName);
                    if (weRedisInfo != null)
                        weProductDetailtInfo = JsonConvert.DeserializeObject<WeProductDetailInfo>(weRedisInfo);
                    if (weProductDetailtInfo == null || !string.IsNullOrEmpty(err))
                        weProductDetailtInfo = new WeProductBLL().GetWeProductInfo(projId);
                }
                else
                {
                    weProductDetailtInfo = new WeProductBLL().GetWeProductInfo(projId);
                }
                if (weProductDetailtInfo != null)
                {
                    if (weProductDetailtInfo.IsWeFQB)
                    {
                        url = string.Format("/pages/invest/WE/WeFqb_detail.aspx?id={0}", projId);
                    }
                    else if (weProductDetailtInfo.IsFTB)
                    {
                        url = string.Format("/pages/invest/WE/WeFtb_detail.aspx?id={0}", projId);
                    }
                    else {
                        url = string.Format("/pages/invest/WE/WE_detail.aspx?id={0}", projId);
                    }
                    url += "&typeId=" + weProductDetailtInfo.ProductTypeId + "&IsPreSell=" + (weProductDetailtInfo.IsPreSell ? 1 : 0).ToString();
                }
                else
                {
                    url = GlobalUtils.WebURL;
                }
                //url = "/pages/invest/detail.aspx?id=" + data[2];
                if (!data)
                {
                    return url;
                }

                return JumpBase(_telNo, url);
            }
            catch (Exception ex)
            {
                SysLogHelper.WriteErrorLog(_app + "标的申购出错", ExceptionHelper.GetExceptionMessage(ex));
                return GlobalUtils.WebURL;
            }
        }

        #endregion

        #region 安全验证

        /// <summary>
        /// 安全验证
        /// </summary>
        /// <returns></returns>
        private bool SecurityValidation()
        {
            bool result = false; //验证结果，手机号，标ID

            #region 八青社

            if (_app == "baqingshe")
            {
                string data = Request["data"];

                try
                {
                    BqsRequestProject request = JsonConvert.DeserializeObject<BqsRequestProject>(data);

                    _pid = request.product_id;
                    if (SecurityValidation(request.appid, request.access_token, request.signature))
                    {
                        //获取用户信息
                        Tuple<string, string> bqsUser = GetBqsUserPhoneNo(request.access_token);
                        if (bqsUser != null)
                        {
                            result = true;
                            _appUserId = bqsUser.Item1;
                            _telNo = bqsUser.Item2;
                        }
                    }
                }
                catch (Exception ex)
                {
                    NetLog.WriteLoginHandler("八青社请求验证失败：" + data, ex.Message);
                }
            }

            #endregion

            #region 人人利

            else if (_app == "renrenli")
            {
                string sign = Context.Request["Access_tokens"];
                if (string.IsNullOrEmpty(sign)) return result;

                try
                {
                    sign = Tool.Cryptography.DESDecrypt(sign); //token加密方式：手机号+"_"+当前时间+"_"+RenRenLiKey
                    string[] signs = sign.Split('_');
                    if (signs.Length != 3) return false;
                    if (signs[2] != RenRenLiKey) return false;
                    if (!signs[0].IsPhone()) return false;
                    //请求的时间判断
                    DateTime dt = DateTime.Parse(signs[1]);
                    if ((DateTime.Now - dt).TotalSeconds > 100) //如果请求时间大于10s，则失败，不允许自动登录
                        return false;

                    _telNo = signs[0];
                    result = true;
                }
                catch (Exception ex)
                {
                    NetLog.WriteLoginHandler("希财网解密失败：" + sign, ex.Message);
                }
            }
            #endregion

            return result;
        }

        #region 安全验证辅助方法

        /// <summary>
        /// 安全验证
        /// </summary>
        /// <param name="appid">传过来的团贷网提供的Appid</param>
        /// <param name="tempStr">传过来的请求标示</param>
        /// <param name="signature">通信秘钥</param>
        /// <returns></returns>
        private bool SecurityValidation(string appid, string tempStr, string signature)
        {
            if (string.IsNullOrEmpty(appid) || string.IsNullOrEmpty(tempStr) || string.IsNullOrEmpty(signature))
                return false;

            if (appid != TdToBjsAppid) return false;

            string sign = Cryptography.GetMd5(TdToBjsAppid + "-" + TdToBjsKey + "-" + tempStr);
            if (sign == signature || sign == HttpUtility.UrlEncode(signature)) return true;

            return false;
        }

        /// <summary>
        /// 获取当前时间毫秒时间戳
        /// </summary>
        /// <returns></returns>
        private long DateTimeToTimestamp(DateTime? dt = null)
        {
            return
                (long)((dt ?? DateTime.UtcNow) - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
        }

        #endregion

        #endregion

        #region 判断用户是否存在

        /// <summary>
        /// 根据手机号判断用户是否存在
        /// </summary>
        /// <param name="telNo"></param>
        /// <returns></returns>
        private bool UserExists(string telNo, Guid? userid = null)
        {
            string sql = "select count(1) from UserBasicInfo with(nolock) where TelNo=@TelNo";
            DynamicParameters pars = new DynamicParameters();
            pars.Add("TelNo", telNo);
            if (userid.HasValue)
            {
                sql += " and Id=@UserId";
                pars.Add("UserId", userid);
            }
            //int? r = TuanDaiDB.QueryFirstOrDefault<int?>(TuanDai.DB.ConnectionType.PCUserRead, sql, ref pars);
            //return r.HasValue && r > 0;
            int? r = PublicConn.QuerySingle<int?>(sql, ref pars);
              
            return r.HasValue && r > 0;
        }

        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <param name="appName"></param>
        /// <param name="telNo"></param>
        /// <returns></returns>
        private TdUserInfo GetUserInfo(string telNo)
        {
            if (string.IsNullOrEmpty(Context.Request["app"].Trim()) || string.IsNullOrEmpty(telNo.Trim())) return null;

            string sql =
                @"SELECT a.*,b.RegisterFrom
                  from UserBasicInfo as a with(nolock) 
                  left join UserRegisterFrom as b with(nolock) on a.Id=b.UserId
                  where TelNo=@TelNo";
            //DynamicParameters pars = new DynamicParameters();
            //pars.Add("TelNo", telNo);
            //List<TdUserInfo> users = TuanDaiDB.Query<TdUserInfo>(ConnectionType.PCProjectRead, sql, ref pars);
            //if (users == null || users.Count == 0) return null;
            //return users[0];

            DynamicParameters pars = new DynamicParameters();
            pars.Add("TelNo", telNo);
            List<TdUserInfo> users;

            users = PublicConn.QueryBySql<TdUserInfo>(sql, ref pars); 

            if (users == null || users.Count == 0) return null;
            return users[0];
        }

        public class TdUserInfo : UserBasicInfoInfo
        {
            public string RegisterFrom { get; set; }
        }

        #endregion

        #region 自动登录

        private string AutoLogin(string telNo, TdUserInfo model)
        {
            if (model == null)
            {
                return "没有找到用户信息";
            }

            if (string.IsNullOrEmpty(telNo.Trim()))
            {
                return "手机号不能为空";
            }
            if ((model.uStatus ?? 0) == 1)
            {

                WebUserAuth.SignIn(model.Id.ToString());
                //登录时判断超级会员是否过期
                model.Level = BusinessDll.Users.JudgeUserLevel(model.Level.Value, model.LevelEndDate);

                model.LastLoginDate = DateTime.Now;

                string userIP = Tool.WebFormHandler.GetIP();
                TuanDai.InfoSystem.Model.LoginLog loginLogEntity = new TuanDai.InfoSystem.Model.LoginLog();
                loginLogEntity.Id = Guid.NewGuid().ToString();
                loginLogEntity.UserId = model.Id.ToString();
                loginLogEntity.IpAddress = userIP;
                loginLogEntity.LoginDate = model.LastLoginDate;
                loginLogEntity.DeviceType = "WeiXin";
                loginLogEntity.DeviceName = Request["app"].ToLower() + "自动登录";
                //TuanDai.InfoSystem.WcfClient.LoginLogService logApi = new TuanDai.InfoSystem.WcfClient.LoginLogService();
                //logApi.AddLoginLog(loginLogEntity);
                TuanDai.WXApiWeb.SysLogHelper.AddLoginLog(loginLogEntity);

                UserBLL userbll = new UserBLL();
                //保存用户最后登录时间
                userbll.WXUpdateUserLastLoginDate(model);
                //记录注册IP
                //BusinessDll.RegisterIp.WriteLoginHandler(model.Id);

                userbll.AsyncLoginEnd(model.Id, 1, userIP, "", "", model.ThirdPartyId, model.ThirdPartyType);

                //登录成功后移除第三方写的Cookie
                CookieHelper.ClearCookie("ThirdLoginUserInfo");
                CookieHelper.ClearCookie("WXLoginType");
                return string.Empty;
            }
            else
            {
                return "登录失败，用户状态不能登录";
            }
        }

        #endregion

        #region 自动注册

        private string UserInsertByPhone(string phone)
        {
            string pwd = new UserBLL().GetRandomPassword(8);//随机密码
            if (!phone.IsPhone()) { return "手机号码格式不正确"; }

            string strIp = Tool.WebFormHandler.GetIP();
            string[] ips = strIp.Split(',');
            string realIp = ips.Length > 1 ? ips[1] : ips[0];
            string result = Users.UserIsRegByIP(realIp);
            if (result != "1")
            {
                string dt = result.Split('|')[1];
                return "注册失败：为防止恶意注册，请在" + dt + "后重新注册";
            }

            Guid userid = Guid.NewGuid();
            //var model = WXRegister.AddUserInfo(userid, _app, pwd, phone, "", "",
            //    "", "", 0, realIp);


            string from = _app;
            if (!string.IsNullOrEmpty(_appUserId))
                from += "_" + _appUserId;
            #region 写用户信息
            UserRegisterInfo registerUser = new UserRegisterInfo();
            registerUser.Id = userid;
            registerUser.ExtenderKey = "";
            registerUser.UserName = string.Format("{0}wx{1}", phone, DateTime.Now.ToString("yyMMdd")); //针对重复注册特殊处理
            registerUser.Pwd = pwd;
            registerUser.Email = string.Empty;
            registerUser.TelNo = phone;
            registerUser.ThirdPartyId = string.Empty;
            registerUser.ThirdPartyType = (int)ConstString.ThirdPartyType.TuandaiUser;
            registerUser.RegisterFrom = from;
            registerUser.RegisterIP = realIp;
            registerUser.OpenId = GlobalUtils.OpenId;
            registerUser.NickName = registerUser.UserName;
            string msg = string.Empty;
            var userBasicInfoInfo = new UserBLL().RegiserUser(registerUser, ref msg);
            if (userBasicInfoInfo != null && !string.IsNullOrEmpty(userBasicInfoInfo.ExtenderKey))
            {
                //记录日志
                SysLogHelper.WriteErrorLog("会员推广_AddUserInfo", "UserName：" + userBasicInfoInfo.UserName + "；ExtendKey:" + userBasicInfoInfo.ExtenderKey);
            }
            #endregion

            if (userBasicInfoInfo != null)
            {
                RegisterUserHandler.AsyncAfterRegister(_app, userBasicInfoInfo);

                if ((userBasicInfoInfo.uStatus ?? 0) == 1)
                {
                    var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                    if (isNewSmsRequest == "0")
                    {
                        //改用新的发短信，邮件，系统消息
                        var messageSender = new MessageSend();
                        //var parameters = new Dictionary<string, object>();
                        //parameters.Add("User", model);
                        //parameters.Add("CurrentDate", DateTime.Now);
                        //parameters.Add("ExtenderKey", model.ExtenderKey);
                        //messageSender.SendMessage2(eventCode: MessageTemplates.RegisterSuccess, parameters: parameters, mobile: model.TelNo, email: model.Email, userId: model.Id);

                        //将生成的密码已短信方式发送给用户
                        var parameters = new Dictionary<string, object>();
                        parameters.Add("PassWord", pwd);
                        messageSender.SendMessage2(option: SendOption.Sms, eventCode: MessageTemplates.BindMobile,
                            parameters: parameters, mobile: userBasicInfoInfo.TelNo);
                    }
                    else
                    {
                        SmsRequest rechargeSuccessSmsRequest = new SmsRequest();
                        rechargeSuccessSmsRequest.EventCode = MsgTemplatesType.BindMobile;
                        rechargeSuccessSmsRequest.PlatformSource = PlatformSource.WeiXin;
                        rechargeSuccessSmsRequest.UserId = userBasicInfoInfo.Id;
                        rechargeSuccessSmsRequest.EmailAddress = userBasicInfoInfo.Email;
                        rechargeSuccessSmsRequest.Mobile = userBasicInfoInfo.TelNo;
                        rechargeSuccessSmsRequest.Parameters = new Dictionary<string, object>();
                        rechargeSuccessSmsRequest.Parameters.Add("PassWord", pwd);

                        string errorMessage = string.Empty;
                        SmsClient.SendMessage(rechargeSuccessSmsRequest, ref errorMessage);
                    }

                    try
                    {
                        TuanDai.InfoSystem.Model.LoginLog loginLogEntity = new TuanDai.InfoSystem.Model.LoginLog();
                        loginLogEntity.Id = Guid.NewGuid().ToString();
                        loginLogEntity.UserId = userBasicInfoInfo.Id.ToString();
                        loginLogEntity.IpAddress = Tool.WebFormHandler.GetIP();
                        loginLogEntity.LoginDate = DateTime.Now;
                        loginLogEntity.DeviceType = "WeiXin";
                        loginLogEntity.DeviceName = _app + "自动注册登录";
                        //LoginLogService logApi = new LoginLogService();
                        //logApi.AddLoginLog(loginLogEntity);
                        TuanDai.WXApiWeb.SysLogHelper.AddLoginLog(loginLogEntity);
                    }
                    catch (Exception ex)
                    {
                        NetLog.WriteLoginHandler("写入注册成功登录日志出错", Tool.ExceptionHelper.GetExceptionMessage(ex));
                    }
                }

                #region 注册成功后自动登录

                if (GlobalUtils.IsWeiXinBrowser)
                {
                    string strOpenId = TuanDai.WXApiWeb.Common.WeiXinApi.GetUserWXOpenId(userBasicInfoInfo.Id);
                    if (strOpenId.IsNotEmpty())
                       GlobalUtils.WriteOpenIdToCookie(strOpenId.ToText()); 
                }
                WebUserAuth.SignIn(userid.ToString());

                #endregion
            }
            else
            {
                return "添加用户失败";
            }
            return string.Empty;
        }
        #region 注册异步操作

        /// <summary>
        /// 第三方平台登录或注册后回调通用请求
        /// </summary>
        public class ThirdPartyUserLoginRequest
        {
            /// <summary>
            /// 用户ID
            /// </summary>
            public Guid? UserId { get; set; }

            /// <summary>
            /// 第三方平台的用户标示
            /// </summary>
            public string Tid { get; set; }

            /// <summary>
            /// 用户名
            /// </summary>
            public string UserName { get; set; }

            /// <summary>
            /// 手机号
            /// </summary>
            public string TelNo { get; set; }

            /// <summary>
            /// 登录来源
            /// </summary>
            public string LoginFrom { get; set; }

            /// <summary>
            /// 类型 标示是注册(0)还是登录(1)
            /// </summary>
            public string LoginType { get; set; }

            /// <summary>
            /// 其他备用
            /// </summary>
            public string Remark1 { get; set; }

            /// <summary>
            /// 其他备用
            /// </summary>
            public string Remark2 { get; set; }

            /// <summary>
            /// 其他备用
            /// </summary>
            public string Remark3 { get; set; }
        }

        public class RegisterUserHandler
        {
            public static void AsyncAfterRegister(string dec, UserBasicInfoInfo model)
            {
                System.Threading.Tasks.Task.Run(() => AsyncAfterRegisterAction(dec, model));
            }

            private static void AsyncAfterRegisterAction(string dec, UserBasicInfoInfo model)
            {
                //所有第三方回调接口，如果有第三方需要回调，可以在API项目中增加
                //ThirdPartyUserLoginRequest req = new ThirdPartyUserLoginRequest {
                //    LoginType = "0",
                //    TelNo = model.TelNo,
                //    Tid = "",
                //    LoginFrom = dec,
                //    UserId = model.Id,
                //    UserName = model.UserName
                //};
                //var url = ConfigurationManager.AppSettings["OtherApiWebUrl"] + "/ThirdPartyCommon/PostUserRegisterCallBack";
                //HttpUtils.HttpPostJson(url, JsonConvert.SerializeObject(req));
            }
        }

        #endregion
        #endregion

        #region 八青社接口  参考http://open.jr360.com/A_Account.html#index_1、购买

        private const string BjsPlatformCode = "tuandaiwang"; //八青社给团贷网标示
        private const string BjsKey = "3795dd52-3ad9-47cf-9fe7-67d69566c1bh"; //八青社给团贷网的通信秘钥

        private const string TdToBjsAppid = "baqingshe"; //团贷网给八青社的Appid
        private const string TdToBjsKey = "9958E689-411C-48F1-8DAB-B214E7383EA4"; //团贷网给八青社的通信秘钥

        #region 查询八青社用户信息

        private class GetBqsUserPhoneNoRequest
        {
            public string platformCode { get; set; }
            public string requestId { get; set; }
            public string signature { get; set; }
            public string requestTimeMills { get; set; }
            public string bjsUserToken { get; set; }
            public string ext { get; set; }
        }

        private class GetBqsUserPhoneNoResponse
        {
            public string bjsUserId { get; set; }
            // 手机号码
            public string phoneNumber { get; set; }
            // 编码
            public string code { get; set; }
            // 消息
            public string msg { get; set; }
            // 请求唯一标示，与参数中requestId 一至
            public string requestId { get; set; }
        }

        private class RefreshBjsUserTokenRequest
        {
            public string platformCode { get; set; }
            public string requestId { get; set; }
            public string signature { get; set; }
            public string requestTimeMills { get; set; }
            public string refreshUserToken { get; set; }
            public string ext { get; set; }
        }

        private class RefreshBjsUserTokenResponse
        {
            public string bjsUserId { get; set; }
            // 手机号码
            public string phoneNumber { get; set; }
            public string bjsUserToken { get; set; }
            // 八金社用户token有效时间 一般300秒；
            public int effectiveTime { get; set; }
            // 八金社用户refreshToken，没有实效性，只有调用刷新token接口或获取token接口会换取新的。
            public string bjsUserRefreshToken { get; set; }
            // 编码
            public string code { get; set; }
            // 消息
            public string msg { get; set; }
            // 请求唯一标示，与参数中requestId 一至
            public string requestId { get; set; }
        }

        /// <summary>
        /// 刷新八金社用户token
        /// </summary>
        /// <param name="bjsUserToken"></param>
        /// <returns></returns>
        private Tuple<string, string> RefreshBjsUserToken(string bjsUserToken)
        {
            try
            {
                RefreshBjsUserTokenRequest request = new RefreshBjsUserTokenRequest {
                    platformCode = BjsPlatformCode,
                    requestId = Guid.NewGuid().ToString(),
                    requestTimeMills = DateTimeToTimestamp().ToString(),
                    refreshUserToken = bjsUserToken,
                    ext = ""
                };
                request.signature = Cryptography.GetMd5(request.platformCode + "-" + BjsKey + "-" + request.requestId);

                string url = "http://api2.bajinshe.com/json/v2/external/UserService/refreshUserToken/gzip";
                string resp = HttpUtils.HttpPostJson(url, JsonConvert.SerializeObject(request));

                RefreshBjsUserTokenResponse response = JsonConvert.DeserializeObject<RefreshBjsUserTokenResponse>(resp);
                if (response == null) return null;
                if (response.code == "10000")
                    return new Tuple<string, string>(response.bjsUserId, response.phoneNumber);

            }
            catch (Exception ex)
            {
                SysLogHelper.WriteErrorLog("刷新八青社用户信息接口时出错", Tool.ExceptionHelper.GetExceptionMessage(ex));
            }
            return null;
        }

        /// <summary>
        /// 获取八青社用户手机号
        /// </summary>
        /// <param name="bjsUserToken"></param>
        /// <returns>用户ID，手机号</returns>
        private Tuple<string, string> GetBqsUserPhoneNo(string bjsUserToken)
        {
            try
            {
                GetBqsUserPhoneNoRequest request = new GetBqsUserPhoneNoRequest {
                    platformCode = BjsPlatformCode,
                    requestId = Guid.NewGuid().ToString(),
                    requestTimeMills = DateTimeToTimestamp().ToString(),
                    bjsUserToken = bjsUserToken,
                    ext = ""
                };
                request.signature =
                    Tool.Cryptography.GetMd5(request.platformCode + "-" + BjsKey + "-" + request.requestId);

                string url = "http://api2.bajinshe.com/json/v2/external/UserService/queryUserInfo/gzip";
                string resp = Tool.HttpUtils.HttpPostJson(url, JsonConvert.SerializeObject(request));

                GetBqsUserPhoneNoResponse response = JsonConvert.DeserializeObject<GetBqsUserPhoneNoResponse>(resp);
                if (response == null) return null;
                if (response.code == "10000")
                    return new Tuple<string, string>(response.bjsUserId, response.phoneNumber);

                //token 非法或者过期
                if (response.code == "10006")
                {
                    return RefreshBjsUserToken(bjsUserToken);
                }
            }
            catch (Exception ex)
            {
                SysLogHelper.WriteErrorLog("查询八青社用户信息接口时出错", Tool.ExceptionHelper.GetExceptionMessage(ex));
            }
            return null;
        }

        #endregion

        private class BqsRequestBase
        {
            /// <summary>
            /// 八金社平台方标识 。由P2P 系统分配。
            /// </summary>
            public string appid { get; set; }

            /// <summary>
            /// 平台访问秘钥签名。生成规则：md5加密（“appid”＋“-”＋“key”＋“-”＋“access_token”）
            /// </summary>
            public string signature { get; set; }

            /// <summary>
            /// 八金社平台订单号
            /// </summary>
            public string orderNum { get; set; }

            /// <summary>
            /// 合法token	八金社平台用户token,即bjsUserToken，因为要兼容以前版本，因此此参数沿用原来的参数名：access_token
            /// </summary>
            public string access_token { get; set; }

            /// <summary>
            /// 交易金额
            /// </summary>
            public string money { get; set; }


            /// <summary>
            /// 描述信息
            /// </summary>
            public string desc { get; set; }

            /// <summary>
            /// 版本信息，无业务含义
            /// </summary>
            public string version { get; set; }

            public string ext { get; set; }
        }

        private class BqsRequestProject : BqsRequestBase
        {
            /// <summary>
            /// 有效产品ID	P2P平台产品Id
            /// </summary>
            public string product_id { get; set; }

            /// <summary>
            /// 摘要信息
            /// </summary>
            public string abstractInfo { get; set; }
        }

        #endregion

    }
}