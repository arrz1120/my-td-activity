using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Objects;
using Tool;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using System.Data.SqlClient;

namespace TuanDai.WXApiWeb.Member.Bank
{
    public partial class Rechagehistory : UserPage
    {

        protected List<WXAccountRechare> dataList = null;
        protected int pageCount = 0;
        private int pageSize = 15;
        protected decimal TotalRecharge = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetBindItem();
            }
        }

        private void GetBindItem()
        { 
            ProjectBLL bll = new ProjectBLL();
            int recordCount = 0;
            dataList = bll.WXGetUserAccountRechare(-1,WebUserAuth.UserId.Value, pageSize, 1, out recordCount);
            double divide = recordCount / pageSize;
            double floor = System.Math.Floor(divide);
            if (recordCount % pageSize != 0)
                floor++;
            pageCount = Convert.ToInt32(floor);//总页数  

            this.GetTotalRecharge();
        }
        protected void GetTotalRecharge()
        {
            string strSQL = "select isnull(TotalRecharge,0) as TotalRecharge from FundAccountInfo where UserId=@userId";

            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@userId", WebUserAuth.UserId.Value);
            TotalRecharge = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<decimal>(TdConfig.DBRead, strSQL, ref dyParams);
        }

        public  static string GetStatusIcon(object o)
        {
            int status = int.Parse(o.ToString());
            string str = ""; 
            switch (status)
            {
                case 0:
                    str = "<i class='ico-inline ico-state03'></i>正在处理";
                    break;
                case 1:
                    str = "<i class='ico-inline ico-state02'></i>充值失败";
                    break;
                case 2:
                    str = "<i class='ico-inline ico-state01'></i>充值成功";
                    break;
                case 3:
                    str = "<i class='ico-inline ico-state04'></i>等待审核";
                    break;
                case 4:
                    str = "<i class='ico-inline ico-state02'></i>审核失败";
                    break;
                case 5:
                    str = "<i class='ico-inline ico-state04'></i>审核成功";
                    break;
                case 6:
                    str = "<i class='ico-inline ico-state04'></i>暂未付款";
                    break;
                case 7:
                    str = "<i class='ico-inline ico-state04'></i>取消付款";
                    break;
                default:
                    str = "<i class='ico-inline ico-state04'></i>等待审核";
                    break;
            }
            return str;
        }
        public static string GetDeviceType(object o) {
            int deviceType = SafeConvert.ToInt32(o, 1);
             string str = "ico-pc";
             switch (deviceType)
             {
                 case 1:
                     str="ico-pc";
                     break;
                 case 2:
                     str="ico-android";
                     break;
                case 3:
                     str="ico-apple";
                     break;
                case 5:
                     str="ico-weixin";
                     break;
             } 
             return str;
        }
    }
}