﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest
{
    /// <summary>
    /// 标的分享页
    /// </summary>
    public partial class investShare : BasePage
    {
        protected Guid productId = Guid.Empty;
        protected WeProductDetailInfo model = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("//m.tuandai.com/pages/downOpenApp.aspx", true);
            return;
            productId = WEBRequest.GetGuid("id");
            if (productId == null || productId == Guid.Empty)
            {
                Response.Redirect("/pages/invest/WE/WE_list.aspx");
                return;
            }
            if (!IsPostBack)
            {
                if (!this.GetData())
                {
                    Response.Redirect(GlobalUtils.MTuanDaiURL + "/pages/invest/WE/WE_list.aspx");
                    return;
                }
            }
        }

        private bool GetData()
        {
            if (productId == null || productId == Guid.Empty)
                return false;

            WeProductBLL bll = new WeProductBLL();
            //model = bll.GetWeProductInfo(productId);
            if (GlobalUtils.IsRedis && GlobalUtils.IsWePlanRedis)
            {
                string err = string.Empty;
                var weRedisInfo = TuanDai.RedisApi.Client.WePlanRedis.GetWePlanRedisByProductIdJson(productId,
                    out err, TdConfig.ApplicationName);
                if (weRedisInfo != null)
                    model = JsonConvert.DeserializeObject<WeProductDetailInfo>(weRedisInfo);
                if (model == null || !string.IsNullOrEmpty(err))
                    model = new WeProductBLL().GetWeProductInfo(productId);
            }
            else
            {
                model = new WeProductBLL().GetWeProductInfo(productId);
            }
            if (model == null)
                return false; 
            return true;
        }

        protected string GetWePlanYearRate()
        {
            string strFormat = "{0}<span class='c-fd6040 f14px'>{1}%</span>";
            return string.Format(strFormat, CommUtils.GetFloatDivideStr(model.YearRate ?? 0, 1), CommUtils.GetFloatDivideStr(model.YearRate ?? 0, 2));
        }
    }
}