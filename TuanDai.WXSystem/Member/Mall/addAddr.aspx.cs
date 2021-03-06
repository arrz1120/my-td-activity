﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;


namespace TuanDai.WXApiWeb.Member.Mall
{
    public partial class addAddr : UserPage
    {
        public List<AddressInfo> Addrlist = new List<AddressInfo>();//所有省份
        public Guid addressId = Guid.Empty;//地址id
        public string actionType = "1";//1新增 2修改
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            var addrId = Request.QueryString["addrid"];
            if (!string.IsNullOrEmpty(addrId))
            {
                addressId = Guid.Parse(addrId);
            }
                
            actionType = Request.QueryString["actionType"];
            GetProvince();
        }
        /// <summary>
        /// 取得所有省份
        /// </summary>
        protected void GetProvince()
        {
            string sql = @"SELECT m_ProId as ProId,m_ProName as ProName from t_Mall_Province with(nolock) ";
            var para = new Dapper.DynamicParameters();
            Addrlist = TuanDai.DB.TuanDaiDB.Query<AddressInfo>(TdConfig.DBRead, sql,
                ref para);
        }
    }

    public class AddressInfo
    {
        /// <summary>
        /// 名称
        /// </summary>
        public string ProName { get; set; }
        /// <summary>
        /// Id
        /// </summary>
        public int ProId { get; set; }
    }
}