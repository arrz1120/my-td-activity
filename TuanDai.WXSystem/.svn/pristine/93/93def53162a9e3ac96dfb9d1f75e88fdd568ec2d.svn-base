using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using Tool;
using TuanDai.PortalSystem.BLL;
using Newtonsoft.Json;

namespace TuanDai.WXApiWeb.pages.invest.WE
{
    /// <summary>
    /// We计划之常见问题
    /// Allen 2015-07-22
    /// </summary>
    public partial class We_Question : BasePage
    {
        public bool IsWeFQB;
        public bool IsWeNewHand;//新手标复投宝
        protected WeProductDetailInfo model = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            IsWeNewHand = WEBRequest.GetString("isWeNewHand","0") == "1";
            IsWeFQB = WEBRequest.GetString("isWeFQB","0") == "1";
            if (IsWeFQB || IsWeNewHand)
            {
                Guid? productId = Tool.SafeConvert.ToGuid(WEBRequest.GetQueryString("productid"));
                WeProductBLL bll = new WeProductBLL();
                //model = bll.GetWeProductInfo(productId.Value);
                if (GlobalUtils.IsRedis && GlobalUtils.IsWePlanRedis)
                {
                    string err = string.Empty;
                    var weRedisInfo = TuanDai.RedisApi.Client.WePlanRedis.GetWePlanRedisByProductIdJson(productId.Value,
                    out err, TdConfig.ApplicationName);
                    if (weRedisInfo != null)
                        model = JsonConvert.DeserializeObject<WeProductDetailInfo>(weRedisInfo);
                    if (model == null || !string.IsNullOrEmpty(err))
                        model = new WeProductBLL().GetWeProductInfo(productId.Value);
                }
                else
                {
                    model = new WeProductBLL().GetWeProductInfo(productId.Value);
                }
                if (model == null)
                    model = new WeProductDetailInfo();
            }
        }
    }
}