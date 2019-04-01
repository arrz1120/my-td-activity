using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Kamsoft.Data.Dapper;
using Tool;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.Activity._20150901Vote
{
    public partial class Index : System.Web.UI.Page
    {
        protected string code { get; set; }
        protected string HostOpenId { get; set; }
        protected int VoterCount { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            code = WEBRequest.GetQueryString("code");
            if (!IsPostBack)
            {
                if (code.IsEmpty())
                {
                    HttpContext.Current.Response.Redirect(GlobalUtils.WebURL + "/Activity/20150901Vote/AuthIndex.aspx", true);

                    return;
                }
                ThirdLoginSDK sdkApi = new ThirdLoginSDK();
                sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
                HostOpenId = sdkApi.GetCookieOpenId(code);

                GetHadVoterCount();
            }
        } 

           /// <summary>
        /// 查询有多少人投票
        /// </summary>
        private void GetHadVoterCount()
        {
            const string querySql = @"select count(1) Total from (select OpenId from [dbo].[20150901_MountaineeringPhotoVoteRecord] group by OpenId) t";

            VoterCount = QueryList<int>(querySql, null).FirstOrDefault(); 
        }

         /// <summary>
        /// 根据语句查询列表
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="querySql"></param>
        /// <param name="dynimanParameters"></param>
        /// <returns></returns>
        private IList<T> QueryList<T>(string querySql, object dynimanParameters)
        {
            IList<T> returnList = new List<T>();
            //using (SqlConnection connection = new SqlConnection(BaseConfig.ActivityConnectionString))
            //{
            //    returnList = connection.Query<T>(querySql, dynimanParameters).ToList();
            //    connection.Close();
            //    connection.Dispose();
            //}

            return returnList;
        }

    }
}