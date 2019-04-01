using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceModel.Channels;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NetDimension.Json;
using TuanDai.DQSystemAPI.Client;
using TuanDai.DQSystemAPI.Contract;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using Tool;  
using System.Data.SqlClient;
using Dapper;
using Tuandai.ServiceStackRedis;
using TuanDai.WXSystem.Core;
using TuanDai.RedisApi.Client; 

namespace TuanDai.WXApiWeb
{
    /// <summary>
    /// 微信平台首页
    /// Allen 2015-05-19
    /// </summary>
    public partial class Index : BasePage
    {
        protected decimal UserEarnAmount { get; set; }//用户收益 
        protected IList<ProjectAdImageInfo> BannerList;   //首页头部广告图
        protected NewsRequestResult nrr;//公告列表
        protected int totalPeople = 746672;
        protected string imgUrl1 = "/wap/images/index/ico-nav1.png";
        protected string imgUrl2 = "/wap/images/index/ico-nav2.png";
        protected string imgUrl3 = "/wap/images/index/ico-nav3.png";
        protected string imgUrl4 = "/wap/images/index/ico-nav4.png";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.InitData();
            }

            if (DateTime.Now >= DateTime.Parse(ConfigHelper.getConfigString("HdZnq2018Start", "2018-07-01 00:00:00")) && DateTime.Now <= DateTime.Parse(ConfigHelper.getConfigString("HdZnq2018End", "2018-07-18 23:59:59")))
            {
                imgUrl1 = "/wap/images/index/six.png";
                imgUrl2 = "/wap/images/index/zhou.png";
                imgUrl3 = "/wap/images/index/nian.png";
                imgUrl4 = "/wap/images/index/qing.png";
            }
        }

        #region 获取数据
        private void InitData()
        {
            GetBannerList();
            GetNoticelist();
            
        }

        //获取亲新团贷网公告
        private void GetNoticelist() {
            string newsApi = GlobalUtils.NewsApiUrl + "/wap/tuandai-newest-notice.html";
            try
            {
                string apiResponse = HttpUtils.HttpGet(newsApi);
                if (!string.IsNullOrEmpty(apiResponse))
                    nrr =
                        JsonConvert.DeserializeObject<NewsRequestResult>(apiResponse);
            }
            catch (Exception ex)
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "获取公告", "获取公告", "获取首页公告错误" + ex.Message);
            }

            
            try
            {
                string err = "";
                var people = RedisServerStack.StringGet<TotalUser>(TdConfig.ApplicationName, "/redis/web",
                    "WEB_SITE_DATA", ref err);
                if (people != null)
                {
                    totalPeople = people.totalUser;
                }
                else
                {
                    string totalUserApiUrl = ConfigurationManager.AppSettings["TotalUserApiUrl"];
                    //http://allstation-data-service.paiconf.com/  http://10.100.12.51:42003/
                    string apiResponse = HttpUtils.HttpGet(totalUserApiUrl+"allstation-bigdata-service/website_data/adddate", 5);
                    if (!string.IsNullOrEmpty(apiResponse))
                    {
                        var res = JsonConvert.DeserializeObject<ResponseTotalUser>(apiResponse);
                        if (res != null && res.data != null)
                        {
                            totalPeople = res.data.totalUser;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "获取投资人数", "获取投资人数", "获取投资人数错误" + ex.Message);
            }
        }

        //获取头部广告图
        private void GetBannerList() {
            
            BannerList = new List<ProjectAdImageInfo>();
            List<TempImage> bl = null;
            List<TempImage> bannerRedisList = null;
            try
            {
                string err = "";
                //var bl = RedisServerStack.HashGet<List<TempImage>>(TdConfig.ApplicationName, "/redis/web", "DefaultInfoAd","touch_index", ref err);

                string returnJson = Tool.HttpUtils.HttpGet(GlobalUtils.BannerApiUrl + "/interActive/position/advertises?advertise_position=touch_index", 2);

                if (!string.IsNullOrEmpty(returnJson))
                {
                    var ir = JsonConvert.DeserializeObject<ImageRequestResult>(returnJson);
                    bl = ir.data;
                    TuandaiCommnetTool.BaseCommon.TaskAsyncHelper.RunAsync(() =>
                    {
                        try
                        {
                            RedisServerStack.HashSet<List<TempImage>>(TdConfig.ApplicationName, "/redis/web", "mBanner",
                                "touch_index", bl,
                                ref err);
                        }
                        catch (Exception ex)
                        {
                            TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "写入广告图redis", "写入广告图redis", "写入广告图redis错误：" + ex.Message);
                        }

                    });
                }
                else
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "接口获取广告图", "接口获取广告图", "接口获取广告图错误");
                }
                if ((bl == null || bl.Count == 0))
                {
                    bannerRedisList = RedisServerStack.HashGet<List<TempImage>>(TdConfig.ApplicationName,
                        "/redis/web", "mBanner",
                        "touch_index", ref err);
                    if (bannerRedisList != null && bannerRedisList.Count > 0)
                        bl = bannerRedisList;
                }
                if (bl != null && bl.Count > 0)
                {
                    foreach (var item in bl)
                    {
                        if (item.startTime <= DateTime.Now && DateTime.Now <= item.endTime)
                        {
                            ProjectAdImageInfo ai = new ProjectAdImageInfo();
                            ai.Link = item.url;
                            ai.ImageUrl = item.picUrl;
                            ai.AddDate = item.startTime;
                            ai.Title = item.title;
                            ai.Desc = item.title;
                            BannerList.Add(ai);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                #region 广告图接口异常处理
                string err = "";
                bannerRedisList = RedisServerStack.HashGet<List<TempImage>>(TdConfig.ApplicationName,
                        "/redis/web", "mBanner",
                        "touch_index", ref err);
                if ((bl == null || bl.Count == 0) && bannerRedisList != null)
                {
                    bl = bannerRedisList;
                }
                if (bl != null && bl.Count > 0)
                {
                    foreach (var item in bl)
                    {
                        if (item.startTime <= DateTime.Now && DateTime.Now <= item.endTime)
                        {
                            ProjectAdImageInfo ai = new ProjectAdImageInfo();
                            ai.Link = item.url;
                            ai.ImageUrl = item.picUrl;
                            ai.AddDate = item.startTime;
                            ai.Title = item.title;
                            ai.Desc = item.title;
                            BannerList.Add(ai);
                        }
                    }
                }
                #endregion

                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "接口获取广告图", "接口获取广告图", "接口获取广告图错误" + ex.Message);
            }
        } 
     
        #endregion


        #region 实体对象

        public class TotalUser
        {
            public int totalUser { get; set; }
        }
        public class ResponseTotalUser
        {
            public TotalUser data { get; set; }

            public string msg { get; set; }
        }
        protected class TempImage
        {
            public string title { get; set; }
            public string picUrl { get; set; }
            public string url { get; set; }
            public DateTime startTime { get; set; }
            public DateTime endTime { get; set; }
            public int orderNum { get; set; }
        }
        protected class ImageRequestResult
        {
            /// <summary>
            /// 200-成功   400-失败  500-系统繁忙
            /// </summary>
            public int code { get; set; }

            public List<TempImage> data { get; set; }
        }
        
        protected class NewsRequestResult
        {
            /// <summary>
            /// 200-成功   400-失败  500-系统繁忙
            /// </summary>
            public int code { get; set; }

            public NewsDetail data { get; set; }
        }
        /// <summary>
        /// 公告详细
        /// </summary>
        protected class NewsDetail
        {
            public string title { get; set; }

            public string publicTime { get; set; }

            public string detailUrl { get; set; }

            public string listUrl { get; set; }

            public string invest_people_total { get; set; }
        }
        #endregion

    }
}