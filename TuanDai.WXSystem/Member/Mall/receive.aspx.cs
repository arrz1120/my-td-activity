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
    public partial class receive : UserPage
    {
        public Guid ProductId;//商品SKUID
        public int Num = 1;//购买数量
        public MVipProduct VipProduct;//商品信息
        public string ValueStr = string.Empty;//商品属性
        public int PriceValue;//商品的售价 团币
        public List<MUserShippingAddresses> ShippingAddress = new List<MUserShippingAddresses>();
        public string DefAddressId = string.Empty;//默认地址ID
        public string DefAddress = string.Empty;//默认地址
        public string DefTelNo = string.Empty;//默认电话
        public string DefName = string.Empty;//默认收件人姓名
        public MUserShippingAddressesBLL bll = new MUserShippingAddressesBLL();
        public Guid OrderId;

        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            string productid = Tool.WEBRequest.GetString("productid"); ;
            if (!string.IsNullOrEmpty(productid))
                ProductId = Guid.Parse(productid);
            else
                Response.Redirect("myProduct.aspx");

            Num = Tool.WEBRequest.GetInt("num", 1);
            OrderId = Tool.WEBRequest.GetGuid("orderid");
            var userId = WebUserAuth.UserId.Value;

            this.VipProduct = MVipProductBLL.GetVipProductDetail(ProductId);
            this.ValueStr = string.Join(",", VipProduct.ProductValues.Select(en => en.ValueStr).ToArray());
            this.PriceValue = VipProduct.ProductValues.FirstOrDefault().PriceValue;
            //如果有选择非默认地址
            string addrId = Tool.WEBRequest.GetQueryString("addrid");
            if (!string.IsNullOrEmpty(addrId))
            {
                var addr = bll.GetMUserShippingAddressesById(Guid.Parse(addrId));
                if (addr != null)
                {
                    this.DefAddressId = addr.Id.ToString();
                    this.DefAddress = bll.GetPrivinceById(Convert.ToString(addr.Privince)) +
                                      bll.GetCityById(Convert.ToString(addr.City)) +
                                      bll.GetAreaById(Convert.ToString(addr.Area)) + addr.Address;
                    this.DefTelNo = addr.CellPhone;
                    DefName = addr.ShipTo;
                }
            }
            else
            {
                //获取用户默认地址或者没有默认地址时使用其中一条有的地址
                ShippingAddress = bll.GetMUserShippingAddressesByUserId(userId);
                if (this.ShippingAddress != null && this.ShippingAddress.Count > 0)
                {
                    var addr = this.ShippingAddress.OrderByDescending(o => o.IsDefault).FirstOrDefault();
                    this.DefAddressId = addr.Id.ToString();
                    this.DefAddress = bll.GetPrivinceById(Convert.ToString(addr.Privince)) +
                        bll.GetCityById(Convert.ToString(addr.City)) +
                        bll.GetAreaById(Convert.ToString(addr.Area)) + addr.Address;
                    this.DefTelNo = addr.CellPhone;
                    DefName = addr.ShipTo;
                }
            }
        }
    }
}