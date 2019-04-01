﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.ServiceModel.Channels;
using System.Web;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Web.Configuration;
using System.Web.UI;
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
using TuanDai.WXApiWeb.Common;
using System.Drawing;
using LLPay;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.IO;
using TuanDai.CunGuanTong.Client;
using TuanDai.CunGuanTong.Model;
using TuanDai.WXSystem.Core;
using Dapper;
using TuanDai.WXSystem.Core.Common;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// ajax_cgt 的摘要说明
    /// </summary>
    public class ajax_cgt : SafeHandlerBase
    {


        #region 修改交易密码，修改预留手机号
        public void ENTERPRISE_INFORMATION_UPDATE()
        {
            PrintJson("0", "不可修改");
            return;
            Guid userid = WebUserAuth.UserId.Value;
            string rtn = string.Empty;
            ENTERPRISE_INFORMATION_UPDATE_Request request = new ENTERPRISE_INFORMATION_UPDATE_Request();
            request.callbackUrl = "";
            request.platformUserNo = userid.ToString();
            rtn = UserClient.ENTERPRISE_INFORMATION_UPDATE_Req(request);
            PrintJson("1", System.Web.HttpUtility.UrlEncode(rtn));

        }

        /// <summary>
        /// 存管通修改交易密码
        /// </summary>
        public void ModifyCGTPwd()
        {
            PrintJson("0", "不可修改");
            return;
            Guid userid = WebUserAuth.UserId.Value;
            string rtn = string.Empty;
            TuanDai.CunGuanTong.Model.RESET_PASSWORD_Request request = new TuanDai.CunGuanTong.Model.RESET_PASSWORD_Request();
            request.callbackUrl = CgtCallBackConfig.GetCgtCallBackUrl(CgtCallBackConfig.CgtCallBackType.ModifyTradePwd);
            request.platformUserNo = userid.ToString();
            request.userDevice = userDevice.MOBILE;
            rtn = UserClient.RESET_PASSWORD_Req(request);
            PrintJson("1", System.Web.HttpUtility.UrlEncode(rtn));
        }

        /// <summary>
        /// 修改手机号
        /// </summary>
        public void ModifyPhone()
        {
            PrintJson("0", "不可修改");
            return;
            Guid userid = WebUserAuth.UserId.Value;
            MODIFY_MOBILE_Request request = new MODIFY_MOBILE_Request();
            string rtn = string.Empty;
            request.callbackUrl = CgtCallBackConfig.GetCgtCallBackUrl(CgtCallBackConfig.CgtCallBackType.ModifyMobile);
            request.platformUserNo = userid.ToString();
            request.modifyType = modifyType.MODIFYMOBILE;
            request.userDevice = userDevice.MOBILE;
            rtn = UserClient.MODIFY_MOBILE_Req(request);

            PrintJson("1", System.Web.HttpUtility.UrlEncode(rtn));

        } 
        #endregion

        #region 用户授权
        /// <summary>
        /// 用户授权
        /// </summary>
        public void USER_AUTHORIZATION()
        {
            PrintJson("0", "不可授权");
            return;
            Guid userid = WebUserAuth.UserId.Value;
            var type = Context.Request["TypeId"];
            if (type == null)
            {
                var user = new UserBLL().GetUserBasicInfoModelById(userid);
                if (user != null)
                    type = user.UserTypeId.ToString();

            }
            string TypeId = type.Trim();
            string rtn = string.Empty;
            USER_AUTHORIZATION_Request request = new USER_AUTHORIZATION_Request();

            List<string> strList = new List<string>();
            strList.Add(authList.REPAYMENT.ToString());
            strList.Add(authList.WITHDRAW.ToString());
            strList.Add(authList.CREDIT_ASSIGNMENT.ToString());
            strList.Add(authList.TENDER.ToString()); 

            request.authList = string.Join(",", strList);   

            request.callbackUrl = CgtCallBackConfig.GetCgtCallBackUrl(CgtCallBackConfig.CgtCallBackType.UserAuthorization);
            request.platformUserNo = userid.ToString();
            request.userDevice = userDevice.MOBILE;
            rtn = UserClient.USER_AUTHORIZATION_Req(request);

            PrintJson("cgt", System.Web.HttpUtility.UrlEncode(rtn));
        }
        #endregion


        #region 获取银行卡信息
        public class BankBin
        {
            public string card_no { get; set; }
            public string bank_code { get; set; }
            public string bank_name { get; set; }
            public string card_type { get; set; }
            public string card_bound { get; set; }
            public string bank_tel { get; set; }
        }

        public class BankMsg : BankBin
        {
            public string ret_code { get; set; }
            public string ret_msg { get; set; }
            public string sign_type { get; set; }
            public string sign { get; set; }
            public int bank_type { get; set; }
            /// <summary>
            /// 该卡是否存在
            /// </summary>
            public string card_bound { get; set; }
        }

        readonly Dictionary<String, int> _bankPath = new Dictionary<String, int>
    {
        {"03080000",1},// 招商银行
        {"01040000",2},// 中国银行
        {"01020000",3},// 中国工商银行
        {"01050000",4},// 中国建设银行   
        {"01030000",5},// 中国农业银行
        {"03010000",6},// 交通银行
        {"03100000",7},// 浦发银行
        {"03050000",8},// 民生银行
        {"03090000",9},// 兴业银行
        {"03030000",10},// 光大银行
        //{"01020000",11},
        {"04031000",12},//北京银行
        {"03020000",13},// 中信银行
        {"03060000",14},// 广东发展银行
        {"03070000",15},// 平安银行
        {"01000000",16}// 中国邮政银行
    };

        private BankMsg GetBankBinFromLL(string bankNo)
        {
            if (string.IsNullOrEmpty(bankNo))
            {
                return null;
            }

            try
            {
                //SortedDictionary<string, string> sParaTemp = new SortedDictionary<string, string>();
                //var id = Guid.Parse("E27798C9-9301-4176-AC0B-6F3916F389EA");//226F9524-74D7-416B-9244-01B39F7D07BB");
                //var webSetting = new WebSettingBLL().GetWebSettingInfo(id.ToString());
                ////db.WebSetting.FirstOrDefault(x => x.Id == id);
                //var partnerConfig = new PartnerConfig(webSetting.Param1Value, webSetting.Param2Value, webSetting.Param3Value,
                //    webSetting.Param4Value);

                ////基本请求参数
                //sParaTemp.Add("oid_partner", partnerConfig.OidPartner);
                //sParaTemp.Add("sign_type", "RSA");
                ////业务参数
                //sParaTemp.Add("card_no", bankNo); //卡号
                ////加签
                //string sign = PaymentUtil.AddSign(sParaTemp, partnerConfig.TraderPriKey, partnerConfig.MD5Key);
                //sParaTemp.Add("sign", sign);

                //var reqJson = PaymentUtil.DictToJson(sParaTemp);
                //string responseJson = postJson("https://yintong.com.cn/traderapi/bankcardquery.htm", reqJson);

                //var m = JsonConvert.DeserializeObject<BankMsg>(responseJson);
                //if (m != null && m.ret_code == "0000")
                //{
                //    //2-储蓄卡 3-信用卡
                //    m.card_type = (m.card_type == "2" ? "储蓄卡" : "信用卡");

                //    if (!_bankPath.ContainsKey(m.bank_code))
                //    {
                //        m.bank_type = 9999;
                //    }
                //    else
                //        m.bank_type = _bankPath[m.bank_code];
                //}

                //return m;
                var bank = TuanDai.Payment.Client.BankInfo.GetBankKaBin(WebUserAuth.UserId.Value, bankNo);
                BankMsg bm = new BankMsg();
                bm.card_type = bank.InsiderCode;
                bm.bank_name = bank.BankName;

                return bm;
            }
            catch (Exception)
            {
                return null;
            }
        }
        //验证服务器证书
        private static bool CheckValidationResult(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors errors)
        {
            return true;
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


        protected readonly Dictionary<int, string> BankNoTelDic = new Dictionary<int, string>{
                {1,"95588"},
                {2,"95533"},
                {3,"95566"},
                {4,"95599"},
                {5,"95555"},
                {6,"95595"},
                {7,"95561"},
                {8,"95528"},
                {9,"95580"},
                {10,"95528"},
                {11,"95577"},
                {12,"95558"},
                {13,"400-830-8003"},
                {14,"95568"}
            };

        protected readonly Dictionary<int, string> BankNoNameDic = new Dictionary<int, string>{
                {1,"中国工商银行"},
                {2,"中国建设银行"},
                {3,"中国银行"},
                {4,"中国农业银行"},
                {5,"招商银行"},
                {6,"光大银行"},
                {7,"兴业银行"},
                {8,"平安银行"},
                {9,"中国邮政储蓄银行"},
                {10,"上海浦东发展银行"},
                {11,"华夏银行"},
                {12,"中信银行"},
                {13,"广东发展银行"},
                {14,"中国民生银行"}
            };


        public void GetBankInfo()
        {
            string bankNo = Context.Request["CardNo"].Trim();
            Guid userId = WebUserAuth.UserId.Value;
            if (string.IsNullOrEmpty(bankNo)) return;
            BankMsg bank = null;
            if (GlobalUtils.IsBankService)
            {
                bank = new BankMsg();
                var javaBankService = new BankFromJavaService();
                var kabin = javaBankService.GetKaBinInfo(userId, bankNo);
                if (kabin != null && kabin.respData != null)
                {
                    bank.bank_name = kabin.respData.bankName;
                    bank.card_type = kabin.respData.insiderCode;
                }
                var exists = javaBankService.GetBankNoIsExists(userId, bankNo);
                if (exists != null && exists.respData != null)
                {
                    bank.card_bound = exists.respData.exists ? "true" : "false";
                }
            }

            else
            {
                bank = GetBankBinFromLL(bankNo);
                if (bank == null)
                {
                    PrintJson("0", "未输入卡号");
                    return;
                }
                if (bank != null)
                {
                    bank.bank_tel = GetBankTelNo(bank.bank_name);
                    bank.card_bound = TuanDai.Payment.Client.BankInfo.VerifyBank(userId, bankNo) > 0 ? "true" : "false";

                }
            }
            if (string.IsNullOrEmpty(bank.bank_name))
            {
                PrintJson("0", "未识别的卡号");
                return;
            }

            string jsonStr = JsonConvert.SerializeObject(bank);
            PrintJson("1", jsonStr);
        }

        protected string GetBankTelNo(string bankname)
        {
            string rtnstr = string.Empty;
            if (!string.IsNullOrEmpty(bankname))
            {
                if (BankNoNameDic.ContainsValue(bankname))
                {
                    int key = BankNoNameDic.Where(p => p.Value == bankname).FirstOrDefault().Key;
                    rtnstr = bankname + "服务电话：" + BankNoTelDic[key];
                }
            }
            return rtnstr;
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

            string phoneRegex = @"^1[3|4|5|7|8][0-9]\d{4,8}$";
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
                PrintJson("0", "此手机号码已注册");
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
            if (code != null)
            {
                var parameters = new Dictionary<string, object>();
                parameters.Add("ValidateCode", code.Code);

                var msgSender = new BusinessDll.MessageSend();
                var sendResult = msgSender.SendMessage2(option: SendOption.Sms,
                    eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: mobileNumber);

                if (sendResult != "1")
                {
                    //PrintJson("0", "发送失败：发送短信验证码异常！");
                    if (sendResult == "-5")
                        PrintJson("-5", "一天之内最多发送5次！");
                    else if (sendResult == "-3")
                        PrintJson("-3", "三分钟内不能重复发送！");
                    else if (sendResult == "0")
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

        #region 获取手机验证码
        public void GetPhoneCode()
        {
            string mobileNumber = HttpContext.Current.Request["mobilenumber"];
            string codetype = HttpContext.Current.Request["codetype"];
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

            //string[] buffer = { "qwewqw", "8werwer", "ewere0", "882dsfdsf", "8sdfdsf", "asdfasd889", "999dsfdfd", "vv8878788", "werewr8888", "877webbrwe" };

            //object s_buffer = Context.Session["tuandainame"];

            //if (s_buffer == null)
            //{
            //    PrintJson("0", "");
            //}
            //else
            //{
            //    if (!buffer.Contains(s_buffer.ToString()))
            //    {
            //        PrintJson("0", "");
            //    }
            //}

            string phoneRegex = @"^1[3|4|5|7|8][0-9]\d{4,8}$";
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
            Guid? tempuserId = null;
            MsCodeType2 codeval = new MsCodeType2();

            if (codetype == "login")
            {
                codeval = MsCodeType2.ValidPhone;
                var uu = new UserBLL().GetUserBasicInfoModelByTelNo(mobileNumber.Trim());
                if (uu != null)
                {
                    tempuserId = uu.Id;
                }
                else
                {
                    PrintJson("0", "用户不存在");
                    return;
                }
            }
            else
            {
                codeval = MsCodeType2.RegPhoneValid;
            }

            //var canSend = new CodeRecordBLL().IsCanSendNewCodeRecord(mobileNumber, MsCodeType.PhoneCode, codeval,
            //    null, 1, strIP);
            //if (!canSend.Success)
            //{
            //    PrintJson(canSend.Code.ToString(), canSend.Message);
            //}


            var code = new CodeRecordBLL().CreateCodeRecordInfo(tempuserId, strIP, MsCodeType.PhoneCode,
                codeval, mobileNumber);
            //int result = db.SaveChanges();
            //if (result > 0)
            if (code != null)
            {
                var parameters = new Dictionary<string, object>();
                parameters.Add("ValidateCode", code.Code);

                var msgSender = new BusinessDll.MessageSend();
                var sendResult = msgSender.SendMessage2(option: SendOption.Sms,
                    eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: mobileNumber);

                if (sendResult != "1")
                {
                    //PrintJson("0", "发送失败：发送短信验证码异常！");
                    if (sendResult == "-5")
                        PrintJson("-5", "一天之内最多发送5次！");
                    else if (sendResult == "-3")
                        PrintJson("-3", "三分钟内不能重复发送！");
                    else if (sendResult == "0")
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
                PrintJson("0", "此手机号码已注册");
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
            if (code != null)
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
                PrintJson("1", "手机号已注册，请更换");
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
                //解除绑定与退出
                if (userBll.WXUnBinderWeiXin(userId.ToText(), GlobalUtils.OpenId))
                {
                    WebUserAuth.SignOut();
                    //移除OpenId allen 2015-07-30
                    GlobalUtils.ClearOpenIdFromCookie();
                    PrintJson("1", "");
                    return;
                }
            }
            PrintJson("0", "");
        }
        #endregion

        #region 用户购买Vip
        /// <summary>
        /// 走存管通购买会员
        /// </summary>
        public void VERIFY_DEDUCT()
        {
            Guid userid = WebUserAuth.UserId.Value;
            //VERIFY_DEDUCT_Request request = new VERIFY_DEDUCT_Request();
            string month = Context.Request["Month"];
            string type = Context.Request["IType"];

            //获取平台账号
            string getsql = "select top 1 m_UserName from t_EnterpriseAccount where m_Type=31";
            Dapper.DynamicParameters dyParams2 = new Dapper.DynamicParameters();
            string platFromAccount = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<string>(TdConfig.ApplicationName, TdConfig.DBRead, getsql, ref dyParams2);
            platFromAccount = string.IsNullOrEmpty(platFromAccount) ? "" : platFromAccount.ToUpper();

            decimal amount = Tool.SafeConvert.ToDecimal(Context.Request["Money"], 0);
            if (new BankFromJavaService().GetAviMoney(userid) < amount)
            {
                PrintJson("0", "余额不足");
            }
            //request.amount = amount;
            //request.callbackUrl = ConfigHelper.getConfigString("CgtCallBackUrl") + "/H5/BuyTdVip.aspx?p=" + month + "_" + type + "_" + userid.ToString();
            //request.customDefine = "购买" + month + "个月会员费用";
            //request.platformUserNo = userid.ToString();
            //request.targetPlatformUserNo = platFromAccount;
            //request.userDevice = userDevice.MOBILE;
            //request.Month = month.ToInt(0);
            //request.requestNo = Guid.NewGuid().ToString();

            #region 新的购买会员
            //1、第一步：存管拿链接
            //string rtn = TuanDai.CunGuanTong.Client.FundClient.VERIFY_DEDUCT_Req(request);
            //{ "reqData": {"amount": 0,"customDefine": "string","expired": "string","platformUserNo": "string","redirectUrl": "string","requestNo": "string","targetPlatformUserNo": "string"},"serverName": "string","sourceDevice": "PC","systemName": "TDSYSTEM","version": 0}
            string postUrl = ConfigHelper.getConfigString("CgMemberServiceUrl", "http://172.16.0.60:9201") + "/recharge/verifyDeductReq";
            string err;
            ReqModel reqModel= new ReqModel();
            reqModel.serverName = "WXTouch";
            reqModel.sourceDevice = "2";
            reqModel.systemName = "TDSYSTEM";
            reqModel.version = 0;
            ReqData reqData = new ReqData();
            reqData.amount = amount;
            reqData.customDefine = "购买" + month + "个月会员费用";
            reqData.expired = DateTime.Now.AddMinutes(5).ToString("yyyyMMddHHmmss");
            reqData.platformUserNo = userid.ToString();
            reqData.redirectUrl = ConfigHelper.getConfigString("CgtCallBackUrl") + "/H5/BuyTdVip.aspx?p=" + month + "_" + type + "_" + userid.ToString();
            reqData.requestNo = Guid.NewGuid().ToString();
            reqData.targetPlatformUserNo = platFromAccount;
            reqModel.reqData = reqData;
            string postJson = JsonConvert.SerializeObject(reqModel);
            string rtn = "";
            string respJson = "";
            try
            {
                respJson = HttpClient.HttpUtil.HttpPostJson(TdConfig.ApplicationName, postUrl, postJson, out err);
                TuanDai.LogSystem.LogClient.LogClients.TraceLog(TdConfig.ApplicationName, "购买会员", userid.ToString(), respJson);
            }
            catch{ }
            
            if (!string.IsNullOrEmpty(respJson))
            {
                try
                {
                    rtn = JsonConvert.DeserializeObject<ResData>(respJson).respData;
                }
                catch (Exception ex)
                {
                    PrintJson("0", "存管返回出错");
                }
            }
            //2、第二步：插入中间表BuyVipStatus
            if (!string.IsNullOrEmpty(rtn))
            {
                string sql = "insert into dbo.BuyVipStatus( UserId ,RequestNo ,Status ,AddDate, BuyVipMonth, BuyVipMoney ) values(@userid,@requestno,0,getdate(),@month,@money);";
                var para = new Dapper.DynamicParameters();
                para.Add("@userid",userid);
                para.Add("@requestno", reqData.requestNo);
                para.Add("@month", month.ToInt(0));
                para.Add("@money", amount);

                if (TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBUserWrite, sql, ref para) > 0)
                {
                    //3、第三步：扣费
                    //sql = string.Empty;
                    //para = new DynamicParameters();
                    //sql = " Exec p_cgt_MemberRecharge_v1 @saleid,@userid,@rechargeMonth,@Month,@outStatus out";
                    //para.Add("@saleid", reqData.requestNo);
                    //para.Add("@userid", userid);
                    //para.Add("@rechargeMonth", amount);
                    //para.Add("@Month", month.ToInt(0));
                    //para.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
                    //TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBUserWrite, sql, ref para);
                    //int outStatus = para.Get<int?>("@outStatus") ?? 0;
                    //if (outStatus == 1)
                    //{
                    //    //4、第四步：前三步都成功返回前端链接
                    //    PrintJson("1", System.Web.HttpUtility.UrlEncode(rtn));
                    //}
                    //else
                    //{
                    //    PrintJson("0", "购买失败，团贷网扣费失败");
                    //}

                    postUrl = ConfigHelper.getConfigString("TdBaseCommonServiceUrl", "http://172.16.1.160:9020") + "/common/callCgtMemberRechargeV1";
                    postJson = "{\"month\": "+month+",\"outStatus\": 0,\"rechargeMonth\": "+amount+",\"saleid\": \""+reqData.requestNo+"\",\"userid\": \""+userid.ToString()+"\"}";
                    try
                    {
                        respJson = HttpClient.HttpUtil.HttpPostJson(TdConfig.ApplicationName, postUrl, postJson, out err);
                        TuanDai.LogSystem.LogClient.LogClients.TraceLog(TdConfig.ApplicationName, "购买会员1", userid.ToString(), respJson);
                    }
                    catch { }
                    
                    
                    bool r = false;
                    if (!string.IsNullOrEmpty(respJson))
                    {
                        try
                        {
                            r = JsonConvert.DeserializeObject<bool>(respJson);
                        }
                        catch (Exception ex) { }
                        
                    }
                    if (r)
                    {
                        //4、第四步：前三步都成功返回前端链接
                        PrintJson("1", System.Web.HttpUtility.UrlEncode(rtn));
                    }
                    else
                    {
                        PrintJson("0", "购买失败，团贷网扣费失败");
                    }
                }
                else
                {
                    PrintJson("0", "购买失败");
                }
            }
            else
            {
                PrintJson("0", "购买失败，获取存管失败");
            }
            #endregion

            PrintJson("0", "购买失败");
        }
        #endregion
        public void memberUpgradeToMySql(Guid UserId, int month)
        {
            try
            {
                //购买成功调用java服务
                if (ConfigurationManager.AppSettings["IsUserService"] == "1")
                {
                    TuandaiCommnetTool.BaseCommon.TaskAsyncHelper.RunAsync(() =>
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
                            string responseStr = TuanDai.HttpClient.HttpUtil.HttpPostJson(TdConfig.ApplicationName, serverUrl + "/user/" + UserId + "/memberUpgrade", "{\"month\": \"" + month + "\"}",
                                out postErr, null, 10, Encoding.UTF8, true);
                            if (!string.IsNullOrEmpty(postErr))
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "user-servive/memberUpgrade", "购买会员用户信息Post错误", postErr);
                            }
                            WXResponseMessage wrm = JsonConvert.DeserializeObject<WXResponseMessage>(responseStr);
                            if (wrm.code != "SUCCESS")
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "user-servive/memberUpgrade", "购买会员用户信息接口返回错误", wrm.message);
                            }
                        }
                        catch (Exception ex)
                        {
                            TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "user-servive/memberUpgrade", "购买会员用户信息接口返回错误", ex.Message);
                        }
                    });
                }


            }
            catch (Exception ex)
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "user-servive/memberUpgrade", "购买会员用户信息接口返回错误", ex.Message);
            }
        }
        
        #region 检测是否存量用户，是否开通存管
        /// <summary>
        /// 是否存量用户
        /// </summary>
        public void IsImportUser()
        {
            var userid = WebUserAuth.UserId.Value;
            if (userid == null || userid == Guid.Empty)
            {
                PrintJson("-99", "登录失效");
            }
            cgt_user_UserExt_Info cgtUser = new QueryClient().GetUserByPlatformUserNo(userid);
            if (cgtUser == null)
            {
                PrintJson("0", "非存量用户");
            }
            else
            {
                if (cgtUser.isImportUser)
                {
                    PrintJson("1", "存量用户");
                }
                else
                {
                    PrintJson("0", "非存量用户");
                }
            }
        }

        /// <summary>
        /// 是否已开通存管通
        /// </summary>
        public void IsOpenCgtUser()
        {
            var userid = WebUserAuth.UserId.Value;
            if (userid == null || userid == Guid.Empty)
            {
                PrintJson("-99", "登录失效");
            }

            cgt_user_UserExt_Info cgtUser = new QueryClient().GetUserByPlatformUserNo(userid);
            if (cgtUser == null)
            {
                PrintJson("0", "未开户");
            }
            else
            {
                if (cgtUser.accountStage > 1 && cgtUser.isBindCard == false)
                {
                    PrintJson("4", "已开户未绑卡");
                }
                switch (cgtUser.accountStage)
                {
                    case 1:
                        PrintJson("0", "未开户");
                        break;
                    case 2:
                        PrintJson("2", "已开户未激活");
                        break;
                    case 3:
                        PrintJson("3", "已开户已激活");
                        break;
                    default:
                        PrintJson("0", "未开户");
                        break;
                }
            }
        }

        /// <summary>
        /// 获取用户授权状态
        /// </summary>
        public void GetShowQuanStatus()
        {
            Guid userid = WebUserAuth.UserId.Value;
            string opertype = Context.Request["opertype"];
            string rtn = "0";
            string msg = string.Empty;
            var cgtmode = new QueryClient().GetUserByPlatformUserNo(userid);
            if (cgtmode == null || cgtmode.accountStage == 1)
            {
                rtn = "0";//未开通
                msg = "未开通";
            }
            else if (cgtmode.accountStage == 2)
            {
                rtn = "2";
                msg = "未激活";
                if (cgtmode.accountSubStage == 1)
                {
                    string errorMessage = string.Empty;
                    string respData = string.Empty;
                    QueryClient cli = new QueryClient();
                    bool isCli = cli.QUERY_USER_INFORMATION_API(userid, ref errorMessage, ref respData);
                    if (isCli)
                    {
                        //QUERY_USER_INFORMATION                
                        QUERY_USER_INFORMATION_Response model = Newtonsoft.Json.JsonConvert.DeserializeObject<QUERY_USER_INFORMATION_Response>(respData);
                        if ((model != null) && (model.isImportUserActivate))
                        {
                            bool result = TuanDai.CunGuanTong.Client.UserClient.USER_INFORMATION_CHECK(userid, ref errorMessage);
                            if (result)
                            {
                                rtn = "1";
                                msg = "已激活";
                            }
                        }
                    }
                }
                else if (cgtmode.accountSubStage > 1 && cgtmode.accountSubStage < 5)
                {
                    //港澳提醒
                    rtn = "-" + cgtmode.accountSubStage;//未开通
                    msg = "证件有问题";
                }
                else if (cgtmode.accountSubStage == 5)
                {
                    //零要素用户提醒
                    rtn = "-9";
                    msg = "三要素信息有误";
                }
            }
            else if (cgtmode.accountStage == 3)
            {
                //充值提现时判断有没绑卡，完善银行卡
                if (opertype == "tixian")
                {
                    var usermode = new UserBLL().GetUserBasicInfoModelById(userid);
                    if (!cgtmode.isBindCard)
                    {
                        rtn = "5";
                        msg = "未绑卡";
                    } 
                    else
                    {
                        rtn = "1";
                        msg = "已授权";
                    }
                }
                else if (opertype == "recharge") //充值时判断是否绑卡，预留手机号正确
                {
                    if (!cgtmode.isBindCard)
                    {
                        rtn = "5";
                        msg = "未绑卡";
                    }
                    else if (!cgtmode.isAllowRechare)
                    {
                        rtn = "-10";
                        msg = "预留手机号和银行卡不匹配";
                    }
                    else
                    {
                        rtn = "1";
                        msg = "已授权";
                    }
                }
                else if (opertype == "other")
                {
                    if (!cgtmode.isBindCard)
                    {
                        rtn = "5";
                        msg = "未绑卡";
                    }
                    else
                    {
                        rtn = "1";
                        msg = "已授权";
                    }
                }
                else
                {
                    if (!cgtmode.isCreditAssignment || !cgtmode.isTender)
                    {
                        rtn = "3";
                        msg = "未授权";
                    }
                    else
                    {
                        rtn = "1"; //普通用户不需要授权啦 modify 2017-2-15
                        msg = "已授权";
                    }
                }
            }
            string DOMAINNAME = ConfigurationManager.AppSettings["CookieDomain"];
            var jsonObj = new
            {
                msg = msg,
                murl = GlobalUtils.WebURL,
                isOpenCGT = GlobalUtils.IsOpenCGT ? 1 : 0,
                isOpenCgtSub = GlobalUtils.IsOpenCgtSub ? 1 : 0,
                isOpenCgtSubWe = GlobalUtils.IsOpenCgtSubWe ? 1 : 0,
                isOpenCgtTrans = GlobalUtils.IsOpenCgtTrans ? 1 : 0,
                domainName = DOMAINNAME
            };
            PrintJson(rtn, JsonHelper.ToJson(jsonObj));
        }
        #endregion
         

        #region 开通存管
        /// <summary>
        /// 会员激活   10200
        /// </summary>
        public void ACTIVATE_IMPORT_USER()
        {
            Guid userid = WebUserAuth.UserId.Value;
            if (userid == null || userid == Guid.Empty) {
                PrintJson("-99", "您还未登录！");
                return;
            }
            var usermode = new UserBLL().GetUserBasicInfoModelById(userid);
            if (usermode != null)
            {

                
                if (usermode.UserTypeId == 1)
                {
                    string respData = string.Empty;
                    string errorMessage = string.Empty;
                    QueryClient cli = new QueryClient();
                    bool isCli = cli.QUERY_USER_INFORMATION_API(userid, ref errorMessage, ref respData);
                    if (isCli)
                    {
                        //QUERY_USER_INFORMATION                
                        QUERY_USER_INFORMATION_Response model = Newtonsoft.Json.JsonConvert.DeserializeObject<QUERY_USER_INFORMATION_Response>(respData);
                        if ((model != null) && (model.isImportUserActivate))
                        {
                            bool result = TuanDai.CunGuanTong.Client.UserClient.USER_INFORMATION_CHECK(userid, ref errorMessage);
                            if (result)
                            {
                                PrintJson("-1", "当前用户已激活");
                                return;
                            }
                        }
                    }

                    //ACTIVATE_IMPORT_USER_Request request = new ACTIVATE_IMPORT_USER_Request();

                    //request.callbackUrl = CgtCallBackConfig.GetCgtCallBackUrl(CgtCallBackConfig.CgtCallBackType.ActivateImportUser);
                    //request.platformUserNo = userid.ToString();
                    //request.userDevice = userDevice.MOBILE;
                    //rtn = UserClient.ACTIVATE_IMPORT_USER_Req(request);
                    //PrintJson("1", System.Web.HttpUtility.UrlEncode(rtn));

                    CgtServiceActivateInfo requestActivateModel = new CgtServiceActivateInfo();
                    requestActivateModel.platformUserNo = userid.ToString();
                    requestActivateModel.callbackUrl = CgtCallBackConfig.GetCgtCallBackUrl(CgtCallBackConfig.CgtCallBackType.ActivateImportUser);
                    requestActivateModel.onePassport = "TRUE";
                    requestActivateModel.requestNo = Guid.NewGuid().ToString();
                    CgtServiceRequest<CgtServiceActivateInfo> cgtActivateRequest = new CgtServiceRequest<CgtServiceActivateInfo>();
                    cgtActivateRequest.reqData = requestActivateModel;
                    string jsonStrActivate = JsonConvert.SerializeObject(cgtActivateRequest);
                    string apiUrlActivate = "/account/memberActiveReq";
                    string errorStrActivate = string.Empty;
                    string resultBackActivate = new CgtTool().HttpPostForCgtApi(userid.ToString(), apiUrlActivate, jsonStrActivate, ref errorStrActivate);
                    string message = string.Empty;
                    if (!string.IsNullOrEmpty(resultBackActivate))
                    {
                        CgtServiceResponse<string> backModel = JsonConvert.DeserializeObject<CgtServiceResponse<string>>(resultBackActivate);
                        if ((backModel != null) && !string.IsNullOrEmpty(backModel.respData))
                        {
                            PrintJson("1", System.Web.HttpUtility.UrlEncode(backModel.respData));
                            return;
                        }
                        if ((backModel != null) && !string.IsNullOrEmpty(backModel.message))
                        {
                            TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_cgt_ACTIVATE_IMPORT_USER",userid.ToString(),backModel.message);
                            PrintJson("-2", "激活存管接口出错");
                            return;
                        }

                    }
                
                }
                else
                {
                    PrintJson("-1", "暂时不支持企业用户");
                }
            }
            PrintJson("0", "操作失败，请重试");     
        }
        /// <summary>
        /// 注册并激活  10100
        /// </summary>
        public void PERSONAL_REGISTER()
        {
            Guid userid = WebUserAuth.UserId.Value;
            string realName = Context.Request["realName"].Trim();
            string cardNo = Context.Request["cardNo"].Trim();
            string bankno = Context.Request["bankNo"].Trim();
            string telno = Context.Request["telNo"].Trim();
            string bkName = Context.Request["bkName"].Trim();
            string cardType = Context.Request["cardType"];

            if (userid == null || userid == Guid.Empty)
            {
                PrintJson("-99", "您还未登录！");
                return;
            }
            if (Tool.IdentityCard.CheckIDCard(cardNo) && cardType != "1")
            {
                PrintJson("-101", "证件类型错误！");
                return;
            }

            
            UserBLL userbll=new UserBLL(); 

            var usermode = userbll.GetUserBasicInfoModelById(userid);
            if (usermode != null)
            {
                var user = userbll.GetUserBasicInfoModelByIdentityCard(cardNo);

                if (user != null && user.Id != userid)
                {
                    PrintJson("-3", "验证失败：此证件已被使用");
                    return;
                }

                var isOpen = new CgtTool().GetonePassportStatus(userid.ToString(), cardNo, realName);
                if (isOpen == null)
                {
                    PrintJson("-3", "验证失败：加载失败，请重试");
                    return;
                }
                if (isOpen.Value)
                {
                    PrintJson("-3", "验证失败：身份证已使用过");
                    return;
                }
                
                var isBankNoExists = new BankFromJavaService().GetBankNoIsExists(userid, bankno);
                if (isBankNoExists != null && isBankNoExists.respData != null &&  isBankNoExists.respData.exists)
                {
                    PrintJson("-4", "验证失败：该银行卡已绑定过其他账号");
                    return;
                }
                if (isBankNoExists == null || isBankNoExists.respData == null)
                {
                    PrintJson("-4", "验证失败：银行卡号未识别");
                    return;
                }

                if (usermode.UserTypeId == 1)
                {
                    var psersionalRequsetModel = new CgtServiceRegisterInfo();
                    psersionalRequsetModel.callbackUrl = CgtCallBackConfig.GetCgtCallBackUrl(CgtCallBackConfig.CgtCallBackType.PersonalRegister); 
                    psersionalRequsetModel.platformUserNo = userid.ToString();
                    psersionalRequsetModel.authList = "TENDER";
                    psersionalRequsetModel.userLimitType = "ID_CARD_NO_UNIQUE";
                    psersionalRequsetModel.onePassport = "TRUE";
                    psersionalRequsetModel.userRole = "INVESTOR";
                    psersionalRequsetModel.checkType = "LIMIT";
                    psersionalRequsetModel.requestNo = Guid.NewGuid().ToString();
                    psersionalRequsetModel.bankcardNo = bankno;
                    psersionalRequsetModel.mobile = telno;
                    psersionalRequsetModel.idCardNo = cardNo;
                    psersionalRequsetModel.realName = realName;
                    switch (cardType)
                    {
                        case "1":
                            psersionalRequsetModel.idCardType = "PRC_ID";
                            break;
                        case "2":
                            psersionalRequsetModel.idCardType = "COMPATRIOTS_CARD";
                            break;
                        case "3":
                            psersionalRequsetModel.idCardType = "PERMANENT_RESIDENCE";
                            break;
                        case "4":
                            psersionalRequsetModel.idCardType = "PASSPORT";
                            break;
                    }
                    CgtServiceRequest<CgtServiceRegisterInfo> cgtRequest = new CgtServiceRequest<CgtServiceRegisterInfo>();
                    cgtRequest.reqData = psersionalRequsetModel;
                    string jsonStrRegister = JsonConvert.SerializeObject(cgtRequest);
                    string apiUrlRegister = "/account/personRegisterReq";
                    string errorStrRegister = string.Empty;
                    string resultBackRegister = new CgtTool().HttpPostForCgtApi(userid.ToString(), apiUrlRegister, jsonStrRegister, ref errorStrRegister);
                    if (!string.IsNullOrEmpty(resultBackRegister))
                    {
                        CgtServiceResponse<string> backModelRegister = JsonConvert.DeserializeObject<CgtServiceResponse<string>>(resultBackRegister);
                        if ((backModelRegister != null) && !string.IsNullOrEmpty(backModelRegister.respData))
                        {
                            //正常开通
                            PrintJson("1", System.Web.HttpUtility.UrlEncode(backModelRegister.respData));
                            return;
                        }
                        if ((backModelRegister != null) && !string.IsNullOrEmpty(backModelRegister.message))
                        {
                            TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_cgt_PERSONAL_REGISTER", userid.ToString(), backModelRegister.message);
                            PrintJson("0", "开通失败");
                            return; ;
                        }
                    }        

                    return;
                }
                else
                {
                    PrintJson("-1", "暂时不支持企业账户");
                } 
            }
            PrintJson("0", "操作失败，请重试");
        }
        /// <summary>
        /// 一账通关联接口  10101   10201
        /// </summary>
        public void OnePassportAuth()
        {
            Guid userId = WebUserAuth.UserId.Value;
            GetCgtAccountStageResponse model = new GetCgtAccountStageResponse();
            model = new CgtTool().CgtAccountStage(userId.ToString(), 1);
            if (model == null)
            {
                PrintJson("-1", "获取存管信息失败");
                return;
            };
            if (string.IsNullOrEmpty(model.onepassportNo))
            {
                PrintJson("-2", "没有一账通账号");
                return;
            }

            CgtServiceOnePassportAuthInfo onePassportModel = new CgtServiceOnePassportAuthInfo();
            onePassportModel.authList = "TENDER";
            onePassportModel.platformUserNo = userId.ToString();
            onePassportModel.redirectUrl = "";//callbackUrlForCgt + callbackApiUrlForCgt;
            onePassportModel.requestNo = Guid.NewGuid().ToString();
            onePassportModel.type = (model.status == 10101 ? "REGISTER_AUTH" : "AUTH");
            onePassportModel.userRole = "INVESTOR";
            onePassportModel.onePassportNo = model.onepassportNo;
            CgtServiceRequest<CgtServiceOnePassportAuthInfo> cgtOnePassportRequest = new CgtServiceRequest<CgtServiceOnePassportAuthInfo>();
            cgtOnePassportRequest.reqData = onePassportModel;
            string jsonStrOnePass = JsonConvert.SerializeObject(cgtOnePassportRequest);
            string apiUrlOnePass = "/user/onePassportAuthReq";
            string errorStrOnePass = string.Empty;
            
            string resultBackOnePass = new CgtTool().HttpPostForCgtApi(userId.ToString(), apiUrlOnePass, jsonStrOnePass, ref errorStrOnePass);
            if (!string.IsNullOrEmpty(resultBackOnePass))
            {
                CgtServiceResponse<string> backModel = JsonConvert.DeserializeObject<CgtServiceResponse<string>>(resultBackOnePass);
                if ((backModel != null) && !string.IsNullOrEmpty(backModel.respData))
                {
                    PrintJson("1", System.Web.HttpUtility.UrlEncode(backModel.respData));
                    return;
                }
                if ((backModel != null) && !string.IsNullOrEmpty(backModel.message))
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_cgt_OnePassportAuth",userId.ToString(),backModel.message);
                    PrintJson("-3", "存管接口出错");
                }
            }
        }
        /// <summary>
        /// 个人绑卡
        /// </summary>
        public void PERSONAL_BIND_BANKCARD()
        {
            Guid userid = WebUserAuth.UserId.Value;
            string realName = Context.Request["realName"].Trim();
            string cardNo = Context.Request["cardNo"].Trim();
            string bankno = Context.Request["bankNo"].Trim();
            string telno = Context.Request["telNo"].Trim();
            string bkName =   Context.Request["bkName"].Trim();
            string bktype =WEBRequest.GetFormString("bktype");
            if (userid == null || userid == Guid.Empty)
            {
                PrintJson("-99", "您还未登录！");
                return;
            }

            //this.PreSaveUserCardInfo(userid, realName, cardNo, bankno);
            var usermode = new UserBLL().GetUserBasicInfoModelById(userid);
            if (usermode != null)
            {
                string rtn = string.Empty;
                if (usermode.UserTypeId == 1)
                {
                    //PERSONAL_BIND_BANKCARD_Request request = new PERSONAL_BIND_BANKCARD_Request();

                    //request.callbackUrl = CgtCallBackConfig.GetCgtCallBackUrl(CgtCallBackConfig.CgtCallBackType.PersonalBindBankCard,"?p=" + bankno + "|" + bktype);
                    //request.platformUserNo = userid.ToString();
                    //request.bankcardNo = bankno;
                    //request.checkType = "LIMIT";
                    //request.mobile = telno;
                    //request.userDevice = userDevice.MOBILE;
                    //rtn = UserClient.PERSONAL_BIND_BANKCARD_Req(request);

                    rtn = new CgtTool().CgtPersonBindBankcard(userid.ToString(), bankno, telno);
                    if (string.IsNullOrEmpty(rtn))
                    {
                        PrintJson("-2", "绑卡存管接口失败");
                    }
                    PrintJson("1", System.Web.HttpUtility.UrlEncode(rtn));
                    return;
                }
                else
                {
                    //BankMsg bankmsg = GetBankBinFromLL(bankno);
                    //ENTERPRISE_BIND_BANKCARD_Request request = new ENTERPRISE_BIND_BANKCARD_Request();
                    //request.bankcardNo = cardNo;
                    //request.bankcode = GetBankCode(bankmsg.bank_name);
                    //request.callbackUrl = mUrl + "/member/cgt/beforeInvest3.aspx";
                    //request.platformUserNo = userid.ToString();
                    //rtn = UserClient.ENTERPRISE_BIND_BANKCARD_Req(request);
                    PrintJson("-1", "暂时不支持企业账户");  
                } 
            }
            PrintJson("0", "操作失败，请重试"); 
        }
        //完善银行卡信息
        public void CompleteBankInfo()
        {
            Guid userid = WebUserAuth.UserId.Value;
            string code = Context.Request["code"];
            int result = 1;
            var basicmodel = new UserBLL().GetUserBasicInfoModelById(userid);
            if (!code.IsEmpty())
            {
                result = new CodeRecordBLL().CheckCodeRecord(code, "", MsCodeType.PhoneCode, MsCodeType2.ModifyBankAccount, userid);
            }
            if (basicmodel == null)
            {
                PrintJson("-1", "用户不存在");
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
                #region
                string province = Context.Request["province"];
                string cityName = Context.Request["cityName"];
                string bankName = Context.Request["bankName"];
                if (GlobalUtils.IsBankService)
                {
                    string returnMsg = new BankFromJavaService().CompleteBankInfo(province, cityName, bankName, userid);
                    if (returnMsg.Contains("更新银行卡信息成功"))
                    {
                        PrintJson("1", "操作成功");
                    }
                }
                else
                {
                    int bankType = basicmodel.BankType ?? 0;

                    basicmodel.BankProvice = province;
                    basicmodel.BankCity = cityName;
                    basicmodel.OpenBankName = bankName;

                    BankInfoInfo newbank = new BankInfoInfo();
                    newbank.Id = Guid.NewGuid();
                    newbank.UserId = basicmodel.Id;
                    newbank.BankAccountNo = basicmodel.BankAccountNo;
                    newbank.BankProvice = province;
                    newbank.BankCity = cityName;
                    newbank.BankType = bankType;
                    newbank.OpenBankName = bankName;
                    newbank.IsDefault = true;
                    if (!string.IsNullOrEmpty(basicmodel.otherBankName))
                    {
                        newbank.otherBankName = basicmodel.otherBankName;
                    }
                    newbank.Status = 1;
                    var isUpdateBankInfo = new BankInfoBLL().AddBankInfo(newbank);
                    if (!isUpdateBankInfo)
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
                    bankLog.BankNo = basicmodel.BankAccountNo;
                    bankLog.CardNo = basicmodel.IdentityCard;
                    var isAddBankInfoLog = new BankInfoLogBLL().AddBankInfoLog(bankLog);
                    if (isAddBankInfoLog)
                    {
                        if (basicmodel.IsValidateIdentity && basicmodel.IsValidateMobile)
                        {
                            basicmodel.AuthenState = 4;
                        }
                        var isUpdate = new UserBLL().UpdateUserBasicInfoForBank(basicmodel);
                        if (isUpdate)
                        {
                            //修改Tuandai.Payment库中银行卡信息
                            var sPay =
                                TuanDai.Payment.Client.BankInfo.UpdateBankInfo(new TuanDai.Payment.Models.PayRoute.
                                    BankCardInfo()
                                {
                                    BankProvice = province,
                                    BankCity = cityName,
                                    OpenBankName = bankName,
                                    UserId = userid.ToString()
                                });

                            TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userid,
                                (int) ConstString.UserGrowthType.BindBankCard, null, 0);
                            WebLog log = new WebLog();
                            log.AddDate = DateTime.Now;
                            log.BusinessId = userid.ToString();
                            log.BusinessTypeId = (int) ConstString.LogBusinessType.Add;
                            log.UserId = userid.ToString();
                            log.UserTypeId = (int) ConstString.LogUserType.WebUser;
                            log.HandlerTypeId = (int) ConstString.LogType.BankAccount;
                            log.Content1 = "完善银行卡信息";
                            log.Content2 = "银行账号为：" + basicmodel.BankAccountNo;
                            log.Content3 = "省：" + province;
                            log.Content4 = "市：" + cityName;
                            log.Content5 = "银行类型：" + bankType.ToString();
                            log.Content6 = "银行名称：" + bankName;
                            log.Id = Guid.NewGuid().ToString();
                            WebLogInfo.WriteLoginHandler(log);

                            PrintJson("1", "操作成功");
                        }
                    }
                }
                #endregion
            }
            PrintJson("0", "操作失败"); 
        }
        #endregion


        #region 个人更新预留手机号
        /// <summary>
        /// 个人更新预留手机号
        /// </summary>
        public void MODIFY_MOBILE_Req()
        {
            Guid userid = WebUserAuth.UserId.Value;
            //string realName = Context.Request["realName"];
            //string cardNo = Context.Request["cardNo"];
            //string bankno = Context.Request["bankNo"];
            string telno = Context.Request["telNo"];
            //string bkName = Context.Request["bkName"];

            var usermode = new UserBLL().GetUserBasicInfoModelById(userid);
            if (usermode != null)
            {
                string rtn = string.Empty;
                if (usermode.UserTypeId == 1)
                {
                    MODIFY_MOBILE_Request request = new MODIFY_MOBILE_Request();
                    request.callbackUrl = CgtCallBackConfig.GetCgtCallBackUrl(CgtCallBackConfig.CgtCallBackType.ModifyMobile);
                    request.platformUserNo = userid.ToString();
                    request.mobile = telno;
                    request.userDevice = userDevice.MOBILE;
                    request.modifyType = modifyType.CHECKTYPEUPDATE;
                    rtn = UserClient.MODIFY_MOBILE_Req(request);
                    PrintJson("1", System.Web.HttpUtility.UrlEncode(rtn));

                }
                else
                {
                    //BankMsg bankmsg = GetBankBinFromLL(bankno);
                    //ENTERPRISE_BIND_BANKCARD_Request request = new ENTERPRISE_BIND_BANKCARD_Request();
                    //request.bankcardNo = cardNo;
                    //request.bankcode = GetBankCode(bankmsg.bank_name);
                    //request.callbackUrl = mUrl + "/member/cgt/beforeInvest3.aspx";
                    //request.platformUserNo = userid.ToString();
                    //rtn = UserClient.ENTERPRISE_BIND_BANKCARD_Req(request);
                    PrintJson("-1", "暂时不支持企业账户");
                }

            }
            PrintJson("0", "操作失败，请重试");
        }
        #endregion 


        #region 内部Model
        public class CgtServiceRegisterInfo : TuanDai.CunGuanTong.Model.PERSONAL_REGISTER_Request
        {
            public string onePassport { get; set; }
            public new string userRole { get; set; }

            public new string idCardType { get; set; }


        }
        public class regMode
        {
            public string from { get; set; }
            public string mobileNumber { get; set; }
            public string verificationCode { get; set; }
            public string TelNo { get; set; }
            public string ExtendKey { get; set; }
            public string uname { get; set; }
            public string ucard { get; set; }
            public string ubnakno { get; set; }
            public string uprovince { get; set; }
            public string ucity { get; set; }
            public string uopenname { get; set; }
            public string umobile { get; set; }

            public string registerType { get; set; }
            public string bankLicense { get; set; }
            public string businessLicense { get; set; }
            public string contact { get; set; }
            public string contactPhone { get; set; }
            public string creditCode { get; set; }
            public string enterpriseName { get; set; }
            public string legal { get; set; }
            public string legalIdCardNo { get; set; }
            public string orgNo { get; set; }
            public string taxNo { get; set; }
            public string unifiedCode { get; set; }
        }
        #endregion

        //{ "reqData": {"amount": 0,"customDefine": "string","expired": "string","platformUserNo": "string","redirectUrl": "string","requestNo": "string","targetPlatformUserNo": "string"},"serverName": "string","sourceDevice": "PC","systemName": "TDSYSTEM","version": 0}

        protected class ReqModel
        {
            public ReqData reqData { get; set; }

            public string serverName { get; set; }
            public string sourceDevice { get; set; }

            public string systemName { get; set; }

            public int version { get; set; }
        }
        protected class ReqData
        {
            public decimal amount { get; set; }

            public string customDefine { get; set; }

            public string expired { get; set; }
            public string platformUserNo { get; set; }
            public string redirectUrl { get; set; }

            public string requestNo { get; set; }

            public string targetPlatformUserNo { get; set; }
        }
        protected class ResData
        {
            public string code { get; set; }
            public string respData { get; set; }
        }
    }
}