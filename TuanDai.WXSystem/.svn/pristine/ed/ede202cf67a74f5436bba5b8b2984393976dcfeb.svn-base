using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using BusinessDll;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class binding_bannkcard : UserPage
    {
        protected Guid userId;
        protected int? vailStatus = 0;
        protected UserBasicInfoInfo userModel;
        protected void Page_Load(object sender, EventArgs e)
        {
            List<T_ProvinceInfo> provincelist = new T_ProvinceBLL().GetProvinceList();
            this.sel_city1.DataSource = provincelist;
            this.sel_city1.DataTextField = "ProName";
            this.sel_city1.DataValueField = "ProName";
            this.sel_city1.DataBind();

            this.sel_city2.Items.Clear();

            T_ProvinceInfo promodel = new T_ProvinceBLL().GetProvinceByProName("北京市");
            List<T_CityInfo> citylist = new T_ProvinceBLL().GetCityListByProId(promodel.ProID);
            this.sel_city2.DataSource = citylist;
            this.sel_city2.DataTextField = "CityName";
            this.sel_city2.DataValueField = "CityName";
            this.sel_city2.DataBind();

            userId = WebUserAuth.UserId.Value;
            if (!this.IsPostBack)
            {
                UserBLL bll = new UserBLL();
                userModel = bll.GetUserBasicInfoModelById(userId);
                if (userModel != null)
                {
                    if (userModel.IsValidateIdentity && userModel.IsValidateMobile)
                    {
                        if (userModel.IsValidateIdentity == false || userModel.IsValidateMobile == false)
                        {
                            vailStatus = 0;
                        }
                        else
                        {
                            vailStatus = 4;
                        }
                        if (string.IsNullOrEmpty(userModel.PayPwd) || userModel.PayPwd.ToLower() == userModel.Pwd.ToLower())//如果没有修改交易密码
                        {
                            vailStatus = 12;
                        }
                    }
                }
            }
        }
    }
}