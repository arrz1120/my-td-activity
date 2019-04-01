using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessDll;
using System.Data; 
using Tool;
using NetDimension.Json;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Dapper;

namespace TuanDai.WXApiWeb.Member.UserPrize
{
    public partial class Gift_Address : UserPage
    {
        protected string PrizeId = string.Empty;
        Guid userid = WebUserAuth.UserId.Value;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                PrizeId = WEBRequest.GetString("PrizeId", "");
                //Response.Redirect(GlobalUtils.WebURL + "/Member/UserPrize/Gift_Address.aspx?PrizeId="+PrizeId);
                BindInfo(); 
            }
            catch (Exception ex)
            {
                SysLogHelper.WriteErrorLog("获取商城默认地址失败", "异常:" + ex.Message);
            }
        }

        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <param name="type">0:省 1：市 2：县</param>
        /// <returns></returns>
        private List<AddressInfo> GetList(string type, int id)
        {
            List<AddressInfo> list = null;

            string sqlText = string.Empty;
            DynamicParameters dyParams = new DynamicParameters();
            if (type == "0")
            {
                sqlText = @"SELECT m_ProId AS ProId,m_ProName AS ProName FROM dbo.t_Mall_Province";
                list = PublicConn.QueryBySql<AddressInfo>(sqlText, ref dyParams);
            }
            else if (type == "1")
            {
                sqlText = @"SELECT m_CityID AS ProId,m_CityName AS ProName FROM dbo.t_Mall_City WHERE m_ProId=@m_ProId";
                dyParams = new DynamicParameters();
                dyParams.Add("@m_ProId", id);
                list = PublicConn.QueryBySql<AddressInfo>(sqlText, ref dyParams);
            }
            else if (type == "2")
            {
                sqlText = @"SELECT m_Id AS ProId,m_DisName AS ProName FROM dbo.t_Mall_District WHERE m_CityID=@m_CityID";
                dyParams = new DynamicParameters();
                dyParams.Add("@m_CityID", id);
                list = PublicConn.QueryBySql<AddressInfo>(sqlText, ref dyParams);
            }
            return list;
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
        /// <summary>
        /// 商城返回地址
        /// </summary>
        public class MallInfo
        {
            public string m_UserId { get; set; }
            public string m_FullName { get; set; }
            public string m_Arddress { get; set; }
            public string m_MobilePhone { get; set; }
            public string m_AddressId { get; set; }
            public string m_ProId { get; set; }
            public string m_CityId { get; set; }
            public string m_DisId { get; set; }

        }

        /// <summary>
        /// 根据UserID取得上次的收货信息
        /// </summary>
        public void BindInfo()
        {
            if (userid!=Guid.Empty)
            {
                ProductReceiveAddress address = new LogisticBLL().getProductReceiveAddressByUserId(userid.ToString());
                if (address != null)
                {
                    this.sel_city1.Items.Clear();
                    List<AddressInfo> ProvinceList = GetList("0", 0);
                    this.sel_city1.DataSource = ProvinceList;
                    this.sel_city1.DataTextField = "ProName";
                    this.sel_city1.DataValueField = "ProId";
                    this.sel_city1.DataBind();

                    this.sel_city2.Items.Clear();
                    List<AddressInfo> CityList = GetList("1", int.Parse(address.Privince));
                    this.sel_city2.DataSource = CityList;
                    this.sel_city2.DataTextField = "ProName";
                    this.sel_city2.DataValueField = "ProId";
                    this.sel_city2.DataBind();

                    this.sel_city3.Items.Clear();
                    List<AddressInfo> DistrictList = GetList("2", int.Parse(address.City));
                    this.sel_city3.DataSource = DistrictList;
                    this.sel_city3.DataTextField = "ProName";
                    this.sel_city3.DataValueField = "ProId";
                    this.sel_city3.DataBind();
                    this.sel_city1.Value = address.Privince;
                    this.sel_city2.Value = address.City;
                    this.sel_city3.Value = address.Area;
                    this.txt_address.Value = address.Address;
                    this.txt_name.Value = address.UserName;
                    this.txt_phone.Value = address.TelNo;
                }
                else
                {
                    this.sel_city1.Items.Clear();
                    List<AddressInfo> ProvinceList = GetList("0", 0);
                    this.sel_city1.DataSource = ProvinceList;
                    this.sel_city1.DataTextField = "ProName";
                    this.sel_city1.DataValueField = "ProId";
                    this.sel_city1.DataBind();

                    this.sel_city2.Items.Clear();
                    List<AddressInfo> CityList = GetList("1", ProvinceList.FirstOrDefault().ProId);
                    this.sel_city2.DataSource = CityList;
                    this.sel_city2.DataTextField = "ProName";
                    this.sel_city2.DataValueField = "ProId";
                    this.sel_city2.DataBind();

                    this.sel_city3.Items.Clear();
                    List<AddressInfo> DistrictList = GetList("2", CityList.FirstOrDefault().ProId);
                    this.sel_city3.DataSource = DistrictList;
                    this.sel_city3.DataTextField = "ProName";
                    this.sel_city3.DataValueField = "ProId";
                    this.sel_city3.DataBind();
                }
               
            }
        }
    }
}