using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.WXApiWeb.Common;
using Tool;
using TuanDai.WXSystem.Core;
using System.Text.RegularExpressions;
using TuanDai.PortalSystem.BLL;
using System.Data.SqlClient;
using TuanDai.PortalSystem.Model;
using BusinessDll;  
using TuanDai.PortalSystem.Model.Enums;

namespace TuanDai.WXApiWeb.Activity.GodWealth
{
    public partial class Gift : BasePage
    {
        protected string SelfOpenId = "";
        protected string GodShowName = "";
        //当前红包状态 0：未领取  1:已领取未使用 2:红包已使用 3:红包已过期
        protected string RedPackedStatus = "1";

        protected void Page_Load(object sender, EventArgs e)
        {
            string action = WEBRequest.GetQueryString("action");
            if (action == "")
            {
                if (!IsPostBack)
                {
                    InitFormData();
                }
            }
            else if (action == "GetPhoneRegCode")
            {
                GetPhoneRegCode();
            }
            else if (action == "RegisterUser") {
                RegisterUser();
            }
            else if (action == "CheckPhoneNum") {
                CheckPhoneNum();
            }
        }

        protected void InitFormData()
        {
            ThirdLoginSDK sdkApi = new ThirdLoginSDK();
            sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
            SelfOpenId = sdkApi.GetCookieOpenId("");

            WealthPage.GodWealthRecordInfo wealthInfo = WealthPage.GetUserGodWealthInfo(SelfOpenId);
            if (wealthInfo != null)
            {
                GodShowName = wealthInfo.ShowName;
            }
            RedPackedStatus = WealthPage.CheckRedPacketStatus().ToString();
        }

        #region 发送验证码
        //发送短信验证码
        protected void GetPhoneRegCode() {
            Response.ContentType = "application/json";
            try
            {
                string mobileNumber = WEBRequest.GetFormString("mobilenumber");
                if (string.IsNullOrEmpty(mobileNumber))
                {
                    PrintJson("-1", "手机号码不能为空");
                    return;
                }
                string phoneRegex = @"^1[3|4|5|8][0-9]\d{4,8}$";
                if (!Regex.IsMatch(mobileNumber, phoneRegex))
                {
                    PrintJson("-1", "手机号码格式不正确");
                    return;
                }
                string sVerCode = Tool.WEBRequest.GetFormString("validatecode");
                if (sVerCode == "" || sVerCode.Length != 4)
                {
                    PrintJson("-1", "图形码不能为空");
                    return;
                }

                string valued = HttpContext.Current.Session["webcheckcodereg"] == null ? "" : HttpContext.Current.Session["webcheckcodereg"].ToString();
                BusinessDll.NetLog.WriteTraceLog("接收到验证码", "Session-Code:" + valued + " InputCode:" + sVerCode, "触屏版");

                HttpContext.Current.Session["webcheckcodereg"] = null;
                if (sVerCode.ToLower() != valued.ToLower())
                {
                    PrintJson("-1", "发送失败：请重新输入图形验证码");
                    return;
                }

                //JunTeEntities db = new JunTeEntities();
                //string strIP = Tool.WebFormHandler.GetIP();
                //if (strIP != "121.13.249.210")
                //{
                //    DateTime enddate = DateTime.Parse(DateTime.Now.AddDays(-1).ToShortDateString());
                //    int count = db.CodeRecord.Where(p => (p.token == strIP || p.TypeValue == mobileNumber) && p.AddDate >= enddate).Count();
                //    if (count > 5)
                //    {
                //        PrintJson("-1", "发送失败：验证码获取太频繁！");
                //        return;
                //    }
                //} 

                //string random = StringUtilily.GetRandomString(6);

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
                if (false)
                {
                    //var parameters = new Dictionary<string, object>();
                    //parameters.Add("ValidateCode", random);

                    //var msgSender = new BusinessDll.MessageSend();
                    //var sendResult = msgSender.SendMessage2(option: SendOption.Sms,
                    //    eventCode: TuanDai.PortalSystem.Model.Enums.MessageTemplates.ValidateCode, parameters: parameters, mobile: mobileNumber);

                    //if (sendResult != "1")
                    //{
                    //    PrintJson("0", "发送失败：发送短信验证码异常！");
                    //}
                    //else
                    //{
                    //    PrintJson("1", "");
                    //}
                }
                else
                {
                    PrintJson("0", "发送失败！");
                }
            }
            catch (Exception ex)
            {
                BusinessDll.NetLog.WriteLoginHandler("财神爷活动发送验证码报错", Tool.ExceptionHelper.GetExceptionMessage(ex), "触屏版");
                PrintJson("0", "发送失败");
            }
            finally {
                Response.End();
            }
        }
        #endregion

        protected void CheckPhoneNum() { 
              Response.ContentType = "application/json";
              try
              {
                  string mobileNumber = WEBRequest.GetFormString("mobilenumber");
                  PrintJson("1","");
              }
              finally {
                  Response.End();
              }
        }

        #region 用户注册
        //用户注册
        protected void RegisterUser()
        {

            Response.ContentType = "application/json";
            try
            {
                string mobileNumber = Tool.WEBRequest.GetFormString("mobilenumber");
                string validateCode = Tool.WEBRequest.GetFormString("verificationCode");
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
                    return;
                }

                int codeResult = BusinessDll.Users.CheckCodeRecord(ConstString.MSCodeType.PhoneCode, ConstString.MSCodeType2.RegPhoneValid, mobileNumber, validateCode);
                if (codeResult != 1)
                {
                    PrintJson("0", "注册失败：验证码错误或已过期,请重新获取输入");
                    return;
                }

                UserBLL bll = new UserBLL();
                SqlParameter[] paramData = new SqlParameter[] { new SqlParameter("@TelNo", mobileNumber) };
                UserBasicInfoInfo model = bll.WXGetUserBasicInfo("TelNo=@TelNo ", paramData);
                if (model != null)
                {
                    // 使用现有帐号自动登录 
                    WebUserAuth.SignIn(model.Id.ToString());
                    PrintJson("1", "");
                    return;
                }

                Guid userid = Guid.NewGuid();
                string newPassWord = GetRandomPassword(8);
                var userbasicEntity = WXRegister.AddUserInfo(userid, "wx_godwealth", newPassWord, mobileNumber, "", "", "", "", 0);
                if (userbasicEntity != null)
                { 
                    //发送密码短信通知 
                    //var msgSender = new BusinessDll.MessageSend();
                    string smsContent = string.Format("恭喜您，注册成功！团贷网用户名:{0}，密码:{1}, 登录www.tuandai.com免费领取红包.", mobileNumber, newPassWord);
                    //msgSender.AsyncSendNoteHandler("Note", null, mobileNumber, smsContent);

                    PrintJson("1", "");
                    return;
                }
                PrintJson("0", "注册失败");
            }
            catch (Exception ex)
            {
                BusinessDll.NetLog.WriteLoginHandler("财神爷活动新用户注册报错", Tool.ExceptionHelper.GetExceptionMessage(ex), "触屏版");
                PrintJson("0", "注册失败");
            }
            finally
            {
                Response.End();
            }
        }
        #endregion



        #region 私有方法
        /// <summary>
        /// 打印json
        /// </summary>
        /// <param name="state"></param>
        /// <param name="msg"></param>
        protected void PrintJson(string strstate, string strmsg)
        {
            var objData = new { result = strstate, msg = strmsg };
            var jsonStr = JsonHelper.ToJson(objData);
            Response.ClearContent();
            Response.Write(jsonStr);
        }
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