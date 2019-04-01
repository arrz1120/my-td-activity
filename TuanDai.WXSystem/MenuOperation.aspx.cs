using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using System.Net;  
using Newtonsoft.Json;
using System.Data;
using System.Data.SqlClient; 
using Dapper;

namespace TuanDai.WXApiWeb
{
    public partial class MenuOperation : System.Web.UI.Page
    {
        protected string strAccessToken = "";
        protected string strQueryResult = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region 创建服务号菜单
        protected void btnCreateMenu_Click(object sender, EventArgs e)
        {
            FileStream fs1 = new FileStream(Server.MapPath("~/data/menu.txt"), FileMode.Open);
            StreamReader sr = new StreamReader(fs1, Encoding.UTF8);
            string menu = sr.ReadToEnd();
            sr.Close();
            fs1.Close();
            // string token = WeiXin.IsExistAccessToken();
            TuanDai.WXApiWeb.Common.ThirdLoginSDK.WXOAuth_Token wxToken = ReqAccessToken();
            if (wxToken == null)
            {
                Tool.JavaScript.Alert("创建失败：未找到Token值");
                return;
            }
            string token = wxToken.access_token;

            string result = GetPage(string.Format("https://api.weixin.qq.com/cgi-bin/menu/create?access_token={0}", token), menu);
            ResultMsg msg = JsonConvert.DeserializeObject<ResultMsg>(result);
            if ("0".Equals(msg.ErrCode))
            {
                Tool.JavaScript.Alert("菜单创建成功");
            }
            else
            {
                Tool.JavaScript.Alert(msg.ErrMsg);
            }
        }

        private TuanDai.WXApiWeb.Common.ThirdLoginSDK.WXOAuth_Token ReqAccessToken()
        {
            string configToken = ConfigHelper.getConfigString("APIKey");
           // string url = GlobalUtils.WebURL + "/Activity/WXAuthor.aspx?type=getaccesstoken&token=" + configToken;
            string url =  "http://m.tuandai.com/Activity/WXAuthor.aspx?type=getaccesstoken&token=" + configToken;
            TuanDai.WXApiWeb.Common.ThirdLoginSDK.WXOAuth_Token authToken = new TuanDai.WXApiWeb.Common.ThirdLoginSDK.WXOAuth_Token();
            string jsonStr = Tool.HttpUtils.HttpGet(url);

            ResponseData jsonObj = JsonConvert.DeserializeObject<ResponseData>(jsonStr);
            if (jsonObj.result != "1")
                return null;
            authToken = JsonConvert.DeserializeObject<TuanDai.WXApiWeb.Common.ThirdLoginSDK.WXOAuth_Token>(jsonObj.msg);
            authToken.errcode = jsonObj.result == "1" ? "0" : authToken.errcode;
            return authToken;
        }
        public string GetPage(string posturl, string postData)
        {
            Stream outstream = null;
            Stream instream = null;
            StreamReader sr = null;
            HttpWebResponse response = null;
            HttpWebRequest request = null;
            Encoding encoding = Encoding.UTF8;
            byte[] data = encoding.GetBytes(postData);
            // 准备请求...
            try
            {
                // 设置参数
                request = WebRequest.Create(posturl) as HttpWebRequest;
                CookieContainer cookieContainer = new CookieContainer();
                request.CookieContainer = cookieContainer;
                request.AllowAutoRedirect = true;
                request.Method = "POST";
                request.ContentType = "application/x-www-form-urlencoded";
                request.ContentLength = data.Length;
                outstream = request.GetRequestStream();
                outstream.Write(data, 0, data.Length);
                outstream.Close();
                //发送请求并获取相应回应数据
                response = request.GetResponse() as HttpWebResponse;
                //直到request.GetResponse()程序才开始向目标网页发送Post请求
                instream = response.GetResponseStream();
                sr = new StreamReader(instream, encoding);
                //返回结果网页（html）代码
                string content = sr.ReadToEnd();
                string err = string.Empty;
                Response.Write(content);
                return content;
            }
            catch (Exception ex)
            {
                WeiXin.WriteLogToFile("创建菜单异常", ex.Message);
                return "{\"errcode\":-1,\"errmsg\":\"fail\"}";
            }
        }
        #endregion


        //获取微信全局Token
        protected void btngGetToken_Click(object sender, EventArgs e)
        {
            try
            {

                string strSQL = " SELECT Access_Token, LastReqDate FROM dbo.WeiXinToken WHERE AppId=@AppId";
                DynamicParameters dyParams = new DynamicParameters();
                dyParams.Add("@AppId", GlobalUtils.AppId);
                WXAccessToken wxToken = PublicConn.QueryActivitySingle<WXAccessToken>(strSQL, ref dyParams);
                if (wxToken != null)
                {
                    strAccessToken = wxToken.Access_Token + "<br/>" + wxToken.LastReqDate;
                }
            }
            catch (Exception ex)
            {
                Tool.JavaScript.Alert(ex.Message);
            }
        }
        
        
        public class WXAccessToken {
            public string Access_Token { get; set; }
            public DateTime? LastReqDate { get; set; }
        }
        public class ResponseData
        {
            public string result { get; set; }
            public string msg { get; set; }
        } 
    }
}