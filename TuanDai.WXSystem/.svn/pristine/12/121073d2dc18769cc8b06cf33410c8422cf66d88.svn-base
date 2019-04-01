using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.Member.Mall
{
    public partial class addrList : UserPage
    {
        /// <summary>
        /// 地址列表
        /// </summary>
        public List<MUserShippingAddresses> Alist = new List<MUserShippingAddresses>();
        public MUserShippingAddressesBLL bll = new MUserShippingAddressesBLL();
        public string backurlstring = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            GetAddressList();
            backurlstring = Tool.WEBRequest.GetQueryString("backurl");
        }
        /// <summary>
        /// 获取地址列表
        /// </summary>
        protected void GetAddressList()
        {
            Alist = bll.GetMUserShippingAddressesByUserId(Guid.Parse(WebUserAuth.UserId.ToString()));
        }
    }
}