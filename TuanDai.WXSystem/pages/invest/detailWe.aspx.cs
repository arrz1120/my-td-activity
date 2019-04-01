﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.CunGuanTong.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest
{
    public partial class detailWe : BasePage
    {
        protected Guid? projectId = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("//m.tuandai.com/pages/downOpenApp.aspx", true);
            return;
            this.projectId = WEBRequest.GetGuid("id");

            if (this.projectId != Guid.Empty)
            {
                string tdfrom = Request.QueryString["tdfrom"];
                string DOMAINNAME = ConfigurationManager.AppSettings["CookieDomain"];
                //第三方跳投标地址记录来源信
                if (!string.IsNullOrEmpty(tdfrom))
                {
                    if (!string.IsNullOrEmpty(CookieHelper.GetCookie("tdfrom")))
                    {
                        Tool.CookieHelper.ClearCookie("tdfrom");
                    }
                    Tool.CookieHelper.WriteCookie(DOMAINNAME, "tdfrom", tdfrom, 24 * 60 * 7);//保存7天
                }
                WeProductBLL bll = new WeProductBLL();
                //WeProductDetailInfo weInfo = bll.GetWeProductInfo(projectId.Value);
                WeProductDetailInfo weInfo = null;
                if (GlobalUtils.IsRedis && GlobalUtils.IsWePlanRedis)
                {
                    string err = string.Empty;
                    var weRedisInfo = TuanDai.RedisApi.Client.WePlanRedis.GetWePlanRedisByProductIdJson(projectId.Value,
                    out err, TdConfig.ApplicationName);
                    if (weRedisInfo != null)
                        weInfo = JsonConvert.DeserializeObject<WeProductDetailInfo>(weRedisInfo);
                    if (weInfo == null || !string.IsNullOrEmpty(err))
                        weInfo = new WeProductBLL().GetWeProductInfo(projectId.Value);
                }
                else
                {
                    weInfo = new WeProductBLL().GetWeProductInfo(projectId.Value);
                }
                string url;
                if (weInfo != null)
                {
                    if (weInfo.IsWeFQB)
                    {  //分期宝
                        url = string.Format("/pages/invest/WE/WeFqb_detail.aspx?id={0}&typeId={1}&IsPreSell={2}", this.projectId, weInfo.ProductTypeId, weInfo.IsPreSell ? 1 : 0);
                    }
                    else if (weInfo.IsFTB) //复投宝
                    {
                        url = string.Format("/pages/invest/WE/WeFtb_detail.aspx?id={0}&typeId={1}&IsPreSell={2}", this.projectId, weInfo.ProductTypeId, weInfo.IsPreSell ? 1 : 0);
                    }
                    else
                    { //普通We计划
                        url = string.Format("/pages/invest/WE/WE_detail.aspx?id={0}&typeId={1}&IsPreSell={2}", this.projectId, weInfo.ProductTypeId, weInfo.IsPreSell ? 1 : 0);
                    }
                    Response.Redirect(url);
                }
                else
                {
                    Response.Redirect(GlobalUtils.WebURL);
                }
            }
            else
            {
                Response.Redirect(GlobalUtils.WebURL);
            }
        }
    }
}