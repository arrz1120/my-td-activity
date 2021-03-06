﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.LogSystem.LogClient;
using TuanDai.WXApiWeb.Common;
using TuanDai.WXSystem.Core;
using Dapper;

namespace TuanDai.WXApiWeb.Activity
{
    public partial class WXAuthor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string type = WEBRequest.GetQueryString("type");
            string code = "";
            switch (type.Trim().ToLower())
            {
                case "":
                    string ReturnUrl = WEBRequest.GetQueryString("ReturnUrl");
                    code = WEBRequest.GetQueryString("code");
                    string goBackUrl = ReturnUrl;
                    if (ReturnUrl.IndexOf("?") != -1)
                        goBackUrl += "&code=" + code;
                    else
                        goBackUrl += "?code=" + code;

                    Response.Redirect(goBackUrl);
                    break;
                //获取微细OpenId
                case "getopenid":
                    #region
                    Response.ContentType = "application/json";
                    try
                    {
                        code = WEBRequest.GetQueryString("code");
                        ThirdLoginSDK sdkApi = new ThirdLoginSDK();
                        sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
                        string wxOpenId = sdkApi.GetCookieOpenId(code);
                        TuanDai.LogSystem.LogClient.LogClients.TraceLog(TdConfig.ApplicationName,"getopenid","",wxOpenId);
                        this.PrintJson("1", wxOpenId);
                    }
                    catch (Exception ex)
                    {
                        this.PrintJson("-100", "程序异常:" + ex.Message);
                    }
                    finally
                    {
                        Response.End();
                    }
                    break;
                    #endregion
                //获取微信用户信息
                case "getuserinfor":
                    #region
                    Response.ContentType = "application/json";
                    try
                    {
                        DateTime beginTime = DateTime.Now;
                        code = WEBRequest.GetQueryString("code");
                        //写入openid 因为code被使用过一次后，就会失效，缓存的openid就取不到。
                        string openId = WEBRequest.GetQueryString("openid");
                        if (openId.IsNotEmpty())
                        {
                            GlobalUtils.WriteOpenIdToCookie(openId);
                        }

                        ThirdLoginSDK sdk = new ThirdLoginSDK();
                        sdk.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
                        //获取微信上用户信息
                        TuanDai.WXApiWeb.Common.ThirdLoginSDK.WXOAuthUser wxUserInfo = sdk.GetWXUserSubscribeInfor(code, openId.ToText());

                        var jsonStr = JsonHelper.ToJson(wxUserInfo);
                        this.PrintJson("1", jsonStr);
                        DateTime endTime = DateTime.Now;

                        LogClients.TraceLog("WXTouch", "微信授权时间差", openId, (endTime - beginTime).TotalMilliseconds.ToString());
                    }
                    catch (Exception ex)
                    {
                        this.PrintJson("-100", "程序异常:" + ex.Message);
                        LogClients.ErrorLog("WXTouch","微信授权错误","",ex.Message+ex.StackTrace);
                    }
                    finally
                    {
                        Response.End();
                    }
                    break;
                    #endregion
                //获取Token
                case "getaccesstoken":
                    #region
                    string token = WEBRequest.GetQueryString("Token");
                    string configToken = ConfigHelper.getConfigString("APIKey");
                    Response.ContentType = "application/json";
                    try
                    {
                        if (configToken != token)
                        {
                            this.PrintJson("99", "验证不通过!");
                            return;
                        }
                        //从同一个缓存中读取全局的Token
                        ThirdLoginSDK sdkApi = new ThirdLoginSDK();
                        sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
                        TuanDai.WXApiWeb.Common.ThirdLoginSDK.WXOAuth_Token accessToken = sdkApi.GetWXUserOpenIdByCgi(code);
                        var jsonStr = JsonHelper.ToJson(accessToken);
                        this.PrintJson("1", jsonStr);
                    }
                    catch (Exception ex)
                    {
                        this.PrintJson("-100", "程序异常:" + ex.Message);
                    }
                    finally
                    {
                        Response.End();
                    }
                    break;
                    #endregion
                //App中活动登录
                case "appajaxlogin":
                    #region
                    Response.ContentType = "application/json";
                    try
                    {
                        string appActivityToken = WEBRequest.GetFormString("appActivityToken");
                        if (!string.IsNullOrEmpty(appActivityToken))
                        {
                            TuanDai.PortalSystem.Model.UserBasicInfoInfo model = new TuanDai.PortalSystem.BLL.AppUserTokenRecBLL().GetAppActivityUser(appActivityToken);
                            if (model != null)
                            {
                                string DOMAINNAME = ConfigurationManager.AppSettings["CookieDomain"];
                                Tool.CookieHelper.WriteCookie("TDW_WapUserName", model.UserName);
                                string strLastLoginDate = DateTime.Now.ToString("yyyy-MM-dd") + model.UserName;
                                if (string.IsNullOrEmpty(CookieHelper.GetCookie("TDLastLoginDate")) || CookieHelper.GetCookie("TDLastLoginDate") != strLastLoginDate)
                                {
                                    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(model.Id, (int)ConstString.UserGrowthType.EveryDayFirstLogin, null, 0);
                                }

                                Tool.CookieHelper.WriteCookie(DOMAINNAME, "TDLastLoginDate", strLastLoginDate);
                                WebUserAuth.SignIn(model.Id.ToString());
                            }
                            else
                            {
                                WebUserAuth.SignOut();
                            }
                        }
                        this.PrintJson("1", "登录成功!");
                    }
                    catch (Exception ex)
                    {
                        this.PrintJson("-1", ex.Message);
                    }
                    finally
                    {
                        Response.End();
                    }
                    #endregion
                    break;
                //获取用户推送开关设置
                case "getwxpushswitch":
                    #region
                    token = WEBRequest.GetQueryString("Token");
                    configToken = ConfigHelper.getConfigString("APIKey");
                    string pushtype = WEBRequest.GetQueryString("PushType");
                    Response.ContentType = "application/json";
                    try
                    {
                        if (configToken != token)
                        {
                            this.PrintJson("99", "验证不通过!");
                            return;
                        }
                        string strSQL = "SELECT DISTINCT OpenId FROM dbo.UserWXNotice WHERE ISNULL(OpenId,'')!=''";
                        if (pushtype.ToLower() == "wexnotice")
                        {
                            strSQL += " and  IsWeXNotice=1";
                        }
                        else if (pushtype.ToLower() == "actnotice")
                        {
                            strSQL += " and  IsActivityNotice=1";
                        }
                        else
                        {
                            strSQL += " and 1=0";
                        }
                        Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
                        List<string> OpenIDList = PublicConn.QueryBySql<string>(strSQL, ref dyParams);
                        var jsonStr = JsonHelper.ToJson(OpenIDList);
                        this.PrintJson("1", jsonStr);
                    }
                    catch (Exception ex)
                    {
                        this.PrintJson("-100", "程序异常:" + ex.Message);
                    }
                    finally
                    {
                        Response.End();
                    }
                    #endregion
                    break;
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

         
        #endregion

        #region 内部对象
        [Serializable]
        internal class ResponseData
        {
            public string result { get; set; }
            public string msg { get; set; }
        }
        #endregion

    }
}