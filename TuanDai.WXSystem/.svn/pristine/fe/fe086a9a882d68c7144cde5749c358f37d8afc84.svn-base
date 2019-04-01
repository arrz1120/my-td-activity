using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.WXApiWeb.Common;
using TuanDai.WXSystem.Core;
using Tool;
using System.Data;
using Kamsoft.Data.Dapper;
using TuanDai.PortalSystem.Model.Enums; 

namespace TuanDai.WXApiWeb.Activity.ExperienceGold
{
    /// <summary>
    /// 体验金微信活动--注册界面
    /// Allen 2015-08-08
    /// </summary>
    public partial class Index : BasePage
    {
        protected string SourceFrom = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Tool.WEBRequest.GetQueryString("action");
            SourceFrom = Tool.WEBRequest.GetQueryString("sjcode");

            if (action == "RegisterUser")
            {
                RegisterUser();
            }
            
        }

        #region 输出内容方法
        /// <summary>
        /// 打印json
        /// </summary>
        /// <param name="state"></param>
        /// <param name="msg"></param>
        protected void PrintJson(string strstate, string strmsg)
        {
            var objData = new ResponseData() { result = strstate, msg = strmsg };
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
        [Serializable]
        internal class ResponseData
        {
            public string result { get; set; }
            public string msg { get; set; }
        }
        #endregion

        public void RegisterUser()
        {
            Response.ContentType = "application/json";
            try
            {
                string mobileNumber = Tool.WEBRequest.GetFormString("mobilenumber");
                string validateCode = Tool.WEBRequest.GetFormString("verificationCode");
                string sourceFrom = string.IsNullOrEmpty(Tool.WEBRequest.GetFormString("from")) ? Tool.CookieHelper.GetCookie("tdfrom") : Tool.WEBRequest.GetFormString("from");
                string StoreNo = Tool.WEBRequest.GetFormString("StoreNo");//商家编号
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
                SqlParameter[] paramData = new SqlParameter[] { new SqlParameter("@TelNo", mobileNumber) };
                UserBasicInfoInfo model = bll.WXGetUserBasicInfo("TelNo=@TelNo", paramData);
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
                string result = BusinessDll.Users.UserIsRegByIP(RealIP);
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
                Guid userid = Guid.NewGuid();
                string newPassWord = GetRandomPassword(8);
                var  userbasicEntity = WXRegister.AddUserInfo(userid,  StoreNo != "" ? "sj" : sourceFrom, newPassWord, mobileNumber, "", "", "", "", 0);
                if (userbasicEntity != null)
                {
                    if (StoreNo.IsNotEmpty())
                    {
                        #region
                        try
                        {
                            SqlParameter[] parameters = {
                            Kamsoft.Data.SqlHelper.MakeInParam("@StoreNo", SqlDbType.VarChar, StoreNo),
                            Kamsoft.Data.SqlHelper.MakeInParam("@UserId", SqlDbType.UniqueIdentifier, userid),
                            Kamsoft.Data.SqlHelper.MakeInParam("@RealName", SqlDbType.NVarChar, "")};

                            //int row = Kamsoft.Data.SqlHelper.ExecuteNonQuery(TuanDai.Config.BaseConfig.ConnectionString,
                            //     CommandType.StoredProcedure, "p_Marketing_StoreUser_Insert", parameters);
                            int row = 1;
                            if (row == 0)
                            {
                                //2014-09-09 添加重试机制 并且添加日志
                                System.Threading.Thread.Sleep(100);//休眠0.1秒 重试一次
                                //row = Kamsoft.Data.SqlHelper.ExecuteNonQuery(TuanDai.Config.BaseConfig.ConnectionString,
                                //  CommandType.StoredProcedure, "p_Marketing_StoreUser_Insert", parameters);
                                if (row == 0)//重试失败 记录错误日志
                                {
                                    BusinessDll.NetLog.WriteTraceLogHandler("商家推广注册", string.Format("商家推荐码StoreNo：{0}；UserName：{1},ErrorInfo:{2}", StoreNo, "", "存储过程p_Marketing_StoreUser_Insert执行失败"), "触屏版");
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            BusinessDll.NetLog.WriteLoginHandler("商家推广注册", string.Format("商家推荐码StoreNo：{0}；UserName：{1},ErrorMsg:{2}", StoreNo, "", ex.Message), "触屏版");
                        }
                        #endregion
                    }
                    //BusinessDll.RegisterIp.WriteLoginHandler(userbasicEntity.Id);
                    //发送密码短信通知 
                   // var msgSender = new BusinessDll.MessageSend();
                    string smsContent = string.Format("恭喜您，注册成功！请前往团宝箱领取礼品;团贷网用户名:{0}，密码:{1}, 登录www.tuandai.com免费领取收益奖金.", mobileNumber, newPassWord);
                    //msgSender.AsyncSendNoteHandler("Note", null, mobileNumber, smsContent);
                     
                    GetExperienceGold(userbasicEntity.Id); 
                    PrintJson("1", "");
                    return;
                }
                PrintJson("0", "注册失败!");
            }
            catch (Exception ex)
            {
                PrintJson("-1", "注册失败，请重试!");
                BusinessDll.NetLog.WriteLoginHandler("体验金活动注册报错", Tool.ExceptionHelper.GetExceptionMessage(ex), "触屏版");
            }
            finally
            {
                Response.End();
            }
        }

        #region 私有方法
        private delegate void GetExperienceGoldDelegate(Guid userId);

        //自动领取体验金
        private void GetExperienceGold(Guid userId)
        {
            //using (SqlConnection connection = new SqlConnection(TuanDai.Config.BaseConfig.ConnectionString))
            //{

            //    //发送团宝箱后,自动标记已领取,不然后面不好做投资             
            //    string strSQL = "select Id from UserPrize WHERE ActivityCode='20150510' AND TypeId=16 and IsReceive=0 AND prizeName='注册送体验金活动' and UserId=@UserId";
            //    var dyParams = new DynamicParameters();
            //    dyParams.Add("@UserId", userId);

            //    Guid? prizeId = connection.Query<Guid?>(strSQL, dyParams).FirstOrDefault();
            //    if (prizeId != null && prizeId.HasValue)
            //    {

            //        UserBLL userbll = new UserBLL();
            //        int outStatus = -1;
            //        userbll.GetUserPrize(userId, prizeId.Value, 2, out  outStatus);
            //    }
            //    connection.Close();
            //    connection.Dispose();
            //}
        }
        #endregion


    }
}