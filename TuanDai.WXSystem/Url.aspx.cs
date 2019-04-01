using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Newtonsoft.Json;
using TuanDai.InfoSystem.Client_New;
using TuanDai.InfoSystem.Model;
using Dapper;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using RequestContentApi = TuanDai.DQSystemAPI.Contract.RequestContentApi;

namespace TuanDai.WXApiWeb
{
    public partial class Url : System.Web.UI.Page
    { 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetLongUrl(); 
            }
        }

        public void GetLongUrl()
        {
            Guid webSetId = Guid.Parse("28670136-C253-4B88-962F-F99E81806D5E"); 
            WebSettingInfo webSettingEntity = new WebSettingBLL().GetWebSettingInfo(webSetId.ToString());
            string url = webSettingEntity.Param1Value;
            try
            {
                string shortUrlKey=string.Empty;
                int functonType=0;
                int shareToolType=0;
                GetSharedAddressKey(ref  shortUrlKey, ref  functonType, ref  shareToolType); //获取段地址的key、功能类型、分享类型
                if (functonType>0 && shareToolType>0)
                {
                    string sharedUrl = GetSharedAddress(functonType, shareToolType);//获取分享设置表中对应功能、分享类型的url
                    if (!string.IsNullOrEmpty(sharedUrl))
                        url = sharedUrl;
                }
                //ShortUrlService serviceShortUrl = new ShortUrlService();
                ShortUrlRequest requestShortUrl = new ShortUrlRequest();
                requestShortUrl.ShortUrlKey = shortUrlKey;
                TuanDai.InfoSystem.Model.RequestContentApi reqApi = new TuanDai.InfoSystem.Model.RequestContentApi();
                reqApi.Data = JsonConvert.SerializeObject(requestShortUrl);
                ReplyContentApi repApi = null;
                InfoSystemClient_New client = new InfoSystemClient_New();
                string errorMsg = "";

                repApi = client.getlongurl(reqApi, out errorMsg);

                List<UserExtendShortUrl> shortUrList = new List<UserExtendShortUrl>();
                if (errorMsg == "" && repApi.Data != null && repApi.ReturnCode == 1)
                {
                    shortUrList = JsonConvert.DeserializeObject<List<UserExtendShortUrl>>(repApi.Data.ToString());
                }
                if (shortUrList.Count <= 0)
                    Response.Redirect(url);

                string resultUrl = string.Empty;
                UserExtendShortUrl shortUrEntity = shortUrList.FirstOrDefault();
                if (shortUrEntity != null && !string.IsNullOrEmpty(shortUrEntity.LongUrl))
                    resultUrl = url + shortUrEntity.LongUrl;
                if (!string.IsNullOrEmpty(resultUrl))
                {
                    Response.Redirect(resultUrl, false);

                }
                else
                {
                    Response.Redirect(url, false);

                }

            }
            catch (Exception ex)
            {
                SysLogHelper.WriteErrorLog("GetLongUrl应用系统错误:" + ex.TargetSite.Name, ex.ToString());
                Response.Redirect(url, false);
            }
            finally
            {
                Response.End();
            } 
        }

        private string GetSharedAddress(int functonType, int shareToolType)
        {
            string sql = @"SELECT ShareUrl FROM dbo.SharedSetting(NOLOCK) WHERE FunctionType=@FunctionType AND ShareToolType=@ShareToolType AND IsEnabled=1 AND IsGenerateShortUrl=1";

            DynamicParameters whereParams = new DynamicParameters();
            whereParams.Add("@FunctionType", functonType);
            whereParams.Add("@ShareToolType", shareToolType);
            List<string> list = new List<string>();

            list = PublicConn.QueryActivityBySql<string>(sql, ref whereParams);

            if (list.Count > 0)
                return list[0];
            return string.Empty;
        }

        private void GetSharedAddressKey(ref string sharedKey, ref int functonType, ref int shareToolType) 
        {
            /*http://localhost:8020/url.aspx/9FyJ02/1-2*/
            string subStr = HttpContext.Current.Request.Url.OriginalString.Substring(HttpContext.Current.Request.Url.OriginalString.LastIndexOf("/") + 1);
            if (subStr.IndexOf("-")>-1)
            {
                string [] arrayStr = subStr.Split(new char[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                int fType = 0;
                int.TryParse(arrayStr[0], out fType);
                functonType = fType;

                int sType = 0;
                int.TryParse(arrayStr[1],out sType);
                shareToolType = sType;

                string key = HttpContext.Current.Request.Url.OriginalString.Substring(HttpContext.Current.Request.Url.OriginalString.IndexOf("aspx/")+5);
                sharedKey = key.Substring(0,key.IndexOf("/"));
            }
            else
            {
                sharedKey = subStr;
            }
        }
    }
}