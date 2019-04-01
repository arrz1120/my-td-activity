using System;
using System.Data;
using System.Web;
using System.Collections.Generic;
using System.Data.Objects;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Text.RegularExpressions;
using BusinessDll;
using Dapper;
using LLPay;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using TuanDai.Enums;
using TuanDai.Enums.Sms;
using TuanDai.InfoSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.Model.Enums;
using System.Data.SqlClient;
using TuanDai.PortalSystem.DAL;
using TuanDai.SMS.Client;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// ajax_userBank 的摘要说明
    /// </summary>
    public class ajax_userBank : SafeHandlerBase
    {

        public void GetBankBin()
        {
            ResultModel result = new ResultModel();
            Dictionary<String, String> bankPath = new Dictionary<String, String>();
            bankPath.Add("01020000", "3");  // 中国工商银行
            bankPath.Add("01030000", "5");  // 中国农业银行
            bankPath.Add("01040000", "2");  // 中国银行
            bankPath.Add("01050000", "4");  // 中国建设银行        
            bankPath.Add("03100000", "7");  // 浦发银行
            bankPath.Add("01000000", "16"); // 中国邮政银行
            //bankPath.Add("03040000", "16"); // 华夏银行
            bankPath.Add("03050000", "8");  // 民生银行
            bankPath.Add("03060000", "14"); // 广东发展银行
            bankPath.Add("03070000", "15"); // 平安银行
            bankPath.Add("03030000", "10"); // 光大银行
            bankPath.Add("03080000", "1");  // 招商银行
            bankPath.Add("03090000", "9");  // 兴业银行
            bankPath.Add("03020000", "13"); // 中信银行
            bankPath.Add("03010000", "6");  // 交通银行
            bankPath.Add("04031000", "12");  // 北京银行

            string strCardNo = Context.Request["CardNo"];
            Guid userId = WebUserAuth.UserId.Value;

            if (string.IsNullOrEmpty(strCardNo))
            {
                result.status = 2;
                result.msg = "卡号不能为空";
            }
            SortedDictionary<string, string> sParaTemp = new SortedDictionary<string, string>();
            //var id = Guid.Parse("E27798C9-9301-4176-AC0B-6F3916F389EA");
            //var webSetting = db.WebSetting.FirstOrDefault(x => x.Id == id);
            var webSetting = new WebSettingBLL().GetWebSettingInfo("E27798C9-9301-4176-AC0B-6F3916F389EA");
            var partnerConfig = new PartnerConfig(webSetting.Param1Value, webSetting.Param2Value, webSetting.Param3Value, webSetting.Param4Value);
            string timestamp = PaymentUtil.GetCurrentDateTimeStr();

            //基本请求参数
            sParaTemp.Add("oid_partner", partnerConfig.OidPartner);
            sParaTemp.Add("sign_type", "RSA");

            //业务参数
            sParaTemp.Add("card_no", strCardNo); //卡号

            //加签
            string sign = PaymentUtil.AddSign(sParaTemp, partnerConfig.TraderPriKey, partnerConfig.MD5Key);
            sParaTemp.Add("sign", sign);

            var reqJson = PaymentUtil.DictToJson(sParaTemp);

            //LogEnum.Batchwithdraw.WriteLog("连连银行卡卡BIN查询-请求报文", "[" + reqJson + "]");
            string responseJSON = postJson("https://yintong.com.cn/traderapi/bankcardquery.htm", reqJson);
            //LogEnum.Batchwithdraw.WriteLog("连连银行卡卡BIN查询-响应报文", "[" + responseJSON + "]");

            SortedDictionary<string, string> sArray = JsonConvert.DeserializeObject<SortedDictionary<string, string>>(responseJSON);
            if (sArray.Count > 0)
            {
                //查询成功
                if (sArray["ret_code"].ToString().Trim() == "0000")
                {
                    string strBankCode = sArray["bank_code"].ToString().Trim();
                    string strBandPath;

                    if (!bankPath.ContainsKey(strBankCode))
                    {
                        strBandPath = "9999";
                    }
                    else
                        strBandPath = bankPath[strBankCode];

                    BankBin bankBin = new BankBin();
                    bankBin.card_no = strCardNo;
                    bankBin.bank_code = strBandPath;
                    bankBin.bank_name = sArray["bank_name"].ToString().Trim();
                    bankBin.card_type = sArray["card_type"].ToString().Trim();
                    bankBin.card_bound = BankNoExists(strCardNo, userId) ? "true" : "false";
                    result.status = 1;
                    result.msg = "查询成功";
                    result.model = bankBin;
                }
                else
                {
                    result.status = 0;
                    result.msg = "查询信息失败，连连返回错误号:" + sArray["ret_code"].ToString().Trim() + ",错误信息:" + sArray["ret_msg"].ToString().Trim();
                }
            }
            else
            {
                result.status = -1;
                result.msg = "未查询到信息";
            }

            var sbq = GetSupportBank();
            if (sbq == null)
            {
                result.status = -2;
                result.msg = "手机支付不支持该卡";
            }

            IsoDateTimeConverter timeConverter = new IsoDateTimeConverter();
            timeConverter.DateTimeFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss";
            string resultJson = Newtonsoft.Json.JsonConvert.SerializeObject(result, timeConverter);
            Context.Response.Write(resultJson);
        }
        /// <summary>
        /// 连连支付请求
        /// </summary>
        /// <returns></returns>
        private SupportBankQuery GetSupportBank()
        {
            //var setid = new Guid("E27798C9-9301-4176-AC0B-6F3916F389EA");
            var webSetting = new TuanDai.PortalSystem.BLL.WebSettingBLL().GetWebSettingInfo("E27798C9-9301-4176-AC0B-6F3916F389EA");

            SortedDictionary<string, string> sParaTemp = new SortedDictionary<string, string>();
            sParaTemp.Add("oid_partner", webSetting.Param1Value.Trim());
            sParaTemp.Add("api_version", "1.0");
            sParaTemp.Add("sign_type", "RSA");
            sParaTemp.Add("product_type", "1");
            sParaTemp.Add("pay_chnl", "10");
            var sign = PaymentUtil.AddSign(sParaTemp, webSetting.Param3Value, webSetting.Param2Value);
            sParaTemp.Add("sign", sign);
            var reqJson = PaymentUtil.DictToJson(sParaTemp);

            var url = "https://yintong.com.cn/queryapi/supportbankquery.htm";
            var responseJson = postJson(url, reqJson);
            var responseResult = JsonConvert.DeserializeObject<SupportBankQuery>(responseJson);

            //记录充值请求参数
            //BusinessDll.NetLog.WriteLoginHandler( "记录连连支付银行卡卡bin查询", "请求报文:" + reqJson + ";返回报文" + responseJson,"触屏版");

            if (responseResult.ret_code != "0000")
            {
                responseResult = null;
            }

            return responseResult;
        }


        /// <summary>
        /// pos方法
        /// </summary>
        private static string postJson(string serverUrl, string reqJson)
        {
            var http = (HttpWebRequest)WebRequest.Create(new Uri(serverUrl));
            http.Accept = "application/json";
            http.ContentType = "application/json";
            http.Method = "POST";

            ServicePointManager.ServerCertificateValidationCallback = new System.Net.Security.RemoteCertificateValidationCallback(CheckValidationResult);

            UTF8Encoding encodeing = new UTF8Encoding();

            Byte[] bytes = encodeing.GetBytes(reqJson);

            Stream newStream = http.GetRequestStream();
            newStream.Write(bytes, 0, bytes.Length);


            var response = http.GetResponse();

            var stream = response.GetResponseStream();
            var sr = new StreamReader(stream);
            var content = sr.ReadToEnd();

            newStream.Close();
            stream.Close();
            sr.Close();

            return content;
        }

        //验证服务器证书
        private static bool CheckValidationResult(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors errors)
        {
            return true;
        }

        public class BankBin
        {
            public string card_no { get; set; }
            public string bank_code { get; set; }
            public string bank_name { get; set; }
            public string card_type { get; set; }
            public string card_bound { get; set; }
        }

        public class BankMsg : BankBin
        {
            public string ret_code { get; set; }
            public string ret_msg { get; set; }
            public string sign_type { get; set; }
            public string sign { get; set; }
            public int bank_type { get; set; }
        }
        public class ResultModel
        {
            public int status { get; set; }
            public string msg { get; set; }
            public object model { get; set; }
        }
        /// <summary>
        /// 判断银行卡号是否已绑定到另一个用户
        /// </summary>
        /// <param name="bankNo"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        private bool BankNoExists(string bankNo, Guid userId)
        {
            //bool bankNoEx = db.UserBasicInfo.Any(p => p.BankAccountNo == bankNo && p.Id != userId);

            //if (bankNoEx)
            //{
            //    return true;
            //}
            int count = 0;
            string sqlBasic = "select count(0) from UserBasicInfo with(nolock) where BankAccountNo=@BankAccountNo and Id <> @Id";
            var para = new Dapper.DynamicParameters();
            para.Add("@BankAccountNo", bankNo);
            para.Add("@Id", userId);
            count = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.DBRead, sqlBasic, ref para);
            if (count > 0)
                return true;
            //var userModel = new UserBLL().WXGetUserBasicInfo("BankAccountNo=@BankAccountNo and Id <> @Id", new SqlParameter[] { new SqlParameter("@BankAccountNo", bankNo), new SqlParameter("@Id",userId) });
            //if (userModel != null)
            //    return true;

            //using (SqlConnection connection = PubConstant.CrateReadConnection())
            //{
            const string sql = "select count(1) from [dbo].[UserBankInfo] with(nolock) where [UserId] <> @UserId and BankNo = @BankNo";
            DynamicParameters param = new Dapper.DynamicParameters();
            param.Add("@UserId", userId);
            param.Add("@BankNo", bankNo);
            count = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.DBRead, sql, ref param);
            //    count = SqlMapper.Query<int>(connection, sql, param).FirstOrDefault();
            //    connection.Close();
            //    connection.Dispose();
            //}

            return count > 0;
        }
        /// <summary>
        /// 新增银行卡简单绑定
        /// </summary>
        public void addsimplebankaccount()
        {

            Guid userid = WebUserAuth.UserId.Value;
            //UserBasicInfo basicmodel = db.UserBasicInfo.FirstOrDefault(p => p.Id == userid);
            var basicmodel = new UserBLL().GetUserBasicInfoModelById(userid);
            if (basicmodel == null)
            {
                PrintJson("-1", "用户不存在");
            }

            if (basicmodel.IsValidateIdentity != true || basicmodel.IsValidateMobile != true)
            {
                PrintJson("-10", "绑定银行卡前需完成身份证验证和手机验证");
            }

            if (!string.IsNullOrWhiteSpace(basicmodel.BankAccountNo))
            {
                PrintJson("-4", "最多添加1张银行卡");
            }
            int userBankCount = 0;
            //using (SqlConnection connection = PubConstant.CrateReadConnection())
            //{
            string strSqlBank = @"SELECT Count(0) FROM UserBankInfo WITH(NOLOCK) WHERE UserId = @userId";
            DynamicParameters paramBank = new Dapper.DynamicParameters();
            paramBank.Add("@userId", basicmodel.Id);
            userBankCount = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.DBRead, strSqlBank, ref paramBank);
            //    userBankCount = connection.Query<int>(strSqlBank, paramBank).FirstOrDefault();
            //    connection.Close();
            //    connection.Dispose();
            //}

            if (userBankCount >= 1)
            {
                PrintJson("-4", "最多添加1张银行卡");
            }

            bool status = !string.IsNullOrEmpty(basicmodel.BankAccountNo) ? false : true;
            string account = Context.Request["account"];
            int bankType = Tool.SafeConvert.ToInt32(Context.Request["bankType"]);
            Regex reg = new Regex("^[\u4e00-\u9fa5]+$");
            //if (bankType == 9999)
            //{
            //    PrintJson("-2", "对不起！系统暂不支持该银行");   
            //}

            if (!string.IsNullOrWhiteSpace(account))
            {
                account = account.Replace(" ", "");
            }

            Regex numreg = new Regex("^[0-9]*$");
            if (!numreg.IsMatch(account))
            {
                PrintJson("-5", "银行卡号输入有误");
            }

            //UserBasicInfo bankUser = db.UserBasicInfo.FirstOrDefault(p => p.BankAccountNo == account && p.Id != userid);
            //var bankUser = new UserBLL().WXGetUserBasicInfo(" BankAccountNo = @BankAccountNo and Id <>@Id",
            //    new SqlParameter[]
            //    {
            //        new SqlParameter("@BankAccountNo", account), new SqlParameter("@Id", userid)
            //    });
            if (BankNoExists(account, userid))
            {
                PrintJson("-3", "新的银行账号已经绑定另一用户，不能再绑定。");
            }

            basicmodel.BankAccountNo = account;
            basicmodel.BankType = bankType;

            int iAuthenState = -1;   //-1代表不更新该字段
            if (basicmodel.IsValidateEmail && basicmodel.IsValidateIdentity && basicmodel.IsValidateMobile && basicmodel.IsSafeQuestion)
            {
                iAuthenState = 4;
            }
            int iResult = 0;
            //using (SqlConnection connection = PubConstant.CrateConnection())
            //{
            string strSql = @"BEGIN TRANSACTION
                                DECLARE @errorSum INT
                                SET @errorSum = 0
                                if not exists(select 1 from UserBankInfo where UserId=@userId)
                                begin
                                    INSERT INTO UserBankInfo(UserId,BankNo,BankType) VALUES(@userId, @bankNo, @bankType)
                                end
                                SET @errorSum  = @errorSum + @@error
                                INSERT INTO BankInfoLog([Id],[UserId],[BankNo],[RealName],[AddDate],[type],[UpdateUserId],[CardNo])
                                VALUES(NEWID(), @userId, @bankNo, @realName, @addDate, @type, @updateUserId, @cardNo)
                                SET @errorSum  = @errorSum + @@error
                                IF(@AuthenState = 4)
                                BEGIN
                                UPDATE UserBasicInfo SET AuthenState = 4 WHERE ID = @userId
                                SET @errorSum  = @errorSum + @@error
                                END
                                IF(@errorSum = 0)
                                BEGIN
                                COMMIT TRANSACTION
                                END
                                ELSE
                                BEGIN
                                ROLLBACK TRANSACTION
                                END";
            DynamicParameters param = new Dapper.DynamicParameters();
            param.Add("@userId", basicmodel.Id);
            param.Add("@bankNo", account);
            param.Add("@bankType", bankType);
            param.Add("@realName", basicmodel.RealName);
            param.Add("@addDate", DateTime.Now);
            param.Add("@type", 1);
            param.Add("@updateUserId", basicmodel.Id);
            param.Add("@cardNo", basicmodel.IdentityCard);
            param.Add("@AuthenState", iAuthenState);
            iResult = TuanDai.DB.TuanDaiDB.Execute(TdConfig.DBUserWrite, strSql, ref param);
            //    iResult = connection.Execute(strSql, param);
            //}
            string updateUserbasicinfoBank = "UPDATE dbo.UserBasicInfo SET BankAccountNo=@BankAccountNo,BankType=@BankType WHERE Id=@Id";
            var userbasicinfoBankParam = new Dapper.DynamicParameters();
            userbasicinfoBankParam.Add("@Id", basicmodel.Id);
            userbasicinfoBankParam.Add("@BankAccountNo", account);
            userbasicinfoBankParam.Add("@BankType", bankType);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.DBUserWrite, updateUserbasicinfoBank, ref userbasicinfoBankParam);
            if (iResult > 0)
            {
                if (status)
                {
                    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userid, (int)ConstString.UserGrowthType.BindBankCard, null, 0);
                }
                WebLog log = new WebLog();
                log.AddDate = DateTime.Now;
                log.BusinessId = userid.ToString();
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Add;
                log.UserId = userid.ToString();
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.BankAccount;
                log.Content1 = "新增银行卡绑定";
                log.Content2 = "银行账号为：" + account;
                log.Content5 = "银行类型：" + bankType.ToString();
                log.Id = Guid.NewGuid().ToString();
                WebLogInfo.WriteLoginHandler(log);

                #region 发送通知消息

                var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                if (isNewSmsRequest == "0")
                {
                    MessageSend ms = new MessageSend();
                    var dic = new Dictionary<string, object>();
                    dic.Add("UserName", basicmodel.RealName);
                    dic.Add("CurrentDate", DateTime.Now);
                    ms.SendMessage2(eventCode: MessageTemplates.ModifyBankAccount, parameters: dic,
                        mobile: basicmodel.TelNo, email: basicmodel.Email, userId: basicmodel.Id);
                }
                else
                {
                    SmsRequest modifyBankAccountSuccess = new SmsRequest();
                    modifyBankAccountSuccess.EventCode = MsgTemplatesType.ModifyBankAccountSuccess;
                    modifyBankAccountSuccess.PlatformSource = PlatformSource.WeiXin;
                    modifyBankAccountSuccess.UserId = userid;
                    modifyBankAccountSuccess.Mobile = basicmodel.TelNo;
                    modifyBankAccountSuccess.EmailAddress = basicmodel.Email;
                    modifyBankAccountSuccess.Parameters = new Dictionary<string, object>();
                    modifyBankAccountSuccess.Parameters.Add("ApplyDate", DateTime.Now);

                    string errorMessage = string.Empty;
                    SmsClient.SendMessage(modifyBankAccountSuccess, ref errorMessage);
                }


                #endregion

                var startDate = DateTime.Parse("2015-04-30 10:00:00");
                if (!string.IsNullOrEmpty(basicmodel.ExtenderKey))
                {
                    var extenderKey = basicmodel.ExtenderKey;
                    //var invitedUsers = db.UserBasicInfo.Where(x =>
                    //    x.ExtenderKey == extenderKey &&
                    //    x.IsValidateIdentity &&
                    //    x.BankAccountNo != null &&
                    //    x.AddDate >= startDate).Count();
                    var invitedUsers = GetInvitedUserCount(extenderKey, startDate);

                    //这种方式查询较慢,先注释掉.
                    //邀请人每邀请五个实名且绑定银行卡的用户可获得1个月VIP超级会员    
                    //第101位客户开始不奖励
                    //if (invitedUsers >= 5 && invitedUsers <= 100 && (invitedUsers % 5 == 0))
                    //{
                    //    //var user = db.UserBasicInfo.FirstOrDefault(x => x.ExtendKey == extenderKey);
                    //    //var user = new UserBLL().WXGetUserBasicInfo(" ExtendKey=@ExtendKey",
                    //    //    new SqlParameter[] { new SqlParameter("@ExtendKey",extenderKey) });
                    //    var user = new UserBLL().GetUserBasicInfoByExtendKey(extenderKey);
                    //    if (user != null)
                    //    {
                    //        //var parameters = new ObjectParameter("outStatus", 0);
                    //        //db.p_GiveMember(user.Id, 0, "邀请好友注册赢VIP超级会员", 1, null, parameters);
                    //        var para = new Dapper.DynamicParameters();
                    //        para.Add("@userid", user.Id);
                    //        para.Add("@type", 0);
                    //        para.Add("@desc", "邀请好友注册赢VIP超级会员");
                    //        para.Add("@months", 1);
                    //        para.Add("@handlerUserId", null);
                    //        para.Add("@outStatus", 0, DbType.Int32, ParameterDirection.Output);
                    //        PublicConn.ExecuteTD(PublicConn.DBWriteType.UserWrite, "p_GiveMember", ref para);
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
        /// <summary>
        /// 获取用户邀请注册人的数量（被邀请的人必须实行认证且绑定银行卡 2015-4-30号以后注册）
        /// </summary>
        /// <param name="extenderkey"></param>
        /// <param name="date"></param>
        /// <returns></returns>
        private int GetInvitedUserCount(string extenderkey, DateTime date)
        {
            string sql = "select count(0) from UserBasicInfo with(nolock) where ExtenderKey=@key and IsValidateIdentity = 1 and BankAccountNo is not null and AddDate > @date";
            var para = new Dapper.DynamicParameters();
            para.Add("@key", extenderkey);
            para.Add("@date", date);

            return TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.DBRead, sql, ref para);
        }

        protected class UserBankInfo
        {
            public Guid UserId { get; set; }
            public string BankNo { get; set; }
            public int? BankType { get; set; }

            public string BankName
            {
                get { return ToolStatus.ConvertToBankType(BankType); }
            }
        }

        internal class SupportBankQuery
        {
            public string ret_code { get; set; }

            public string ret_msg { get; set; }

            public List<SupportBankList> support_banklist { get; set; }
        }

        internal class SupportBankList
        {
            public string bank_code { get; set; }

            public string bank_name { get; set; }

            public string card_type { get; set; }

            public string single_amt { get; set; }

            public string day_amt { get; set; }

            public string month_amt { get; set; }

            public string bank_status { get; set; }
        }

    }
}