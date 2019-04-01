using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Objects; 
using Tool;
using BusinessDll;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using System.Web.Services;
using System.Text;


namespace TuanDai.WXApiWeb.Member.withdrawal
{
    /// <summary>
    /// 提现记录
    /// </summary>
    public partial class withdrawal_record : UserPage
    {

        protected List<WXAppWithdrewFund> dataList = null;
        protected int pageCount = 0;
        private int pageSize = 15;
        protected decimal totalMoney = 0;//成功提现金额
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                GetData();
            }
        }
        private void GetData() {
            ProjectBLL bll = new ProjectBLL();
            int recordCount=0;
            dataList = bll.WXGetUserWithdrewFund(WebUserAuth.UserId.Value, pageSize, 1,-1, out recordCount);
            //totalMoney = dataList.Where(o => o.type == 1 && o.Status == 2).Sum(o => o.Amount).ToDecimal(0);
            var fundAccount = new FundAccountBLL().GetFundAccountInfoById(WebUserAuth.UserId.Value);
            if(fundAccount != null)
                totalMoney = fundAccount.TotalWithdrawDeposit ?? 0;
            double divide = recordCount / pageSize;
            double floor = System.Math.Floor(divide);
            if (recordCount % pageSize != 0)
                floor++;
            pageCount = Convert.ToInt32(floor);//总页数
        }

        public static string GetDeviceType(object o)
        {
            int deviceType = SafeConvert.ToInt32(o, 1);
            string str = "ico-pc";
            switch (deviceType)
            {
                case 1:
                    str = "ico-pc";
                    break;
                case 2:
                    str = "ico-android";
                    break;
                case 3:
                    str = "ico-apple";
                    break;
                case 5:
                    str = "ico-weixin";
                    break;
            }
            return str;
        }
        public static string GetStatusIcon(object o)
        {
            int status = int.Parse(o.ToString());
            string str = "";
            switch (status)
            {
                case 0:
                    str = "<i class='ico-inline ico-state03'></i>提现处理中";
                    break;
                case 1:
                    str = "<i class='ico-inline ico-state02'></i>提现失败";
                    break;
                case 2:
                    str = "<i class='ico-inline ico-state01'></i>提现成功";
                    break;
                case 12:
                    str = "<i class='ico-inline ico-state03'></i>未验密";
                    break;
                case 3:
                    str = "<i class='ico-inline ico-state03'></i>正在审核";
                    break;
                case 4:
                case 8:
                case 9:
                case 10:
                case 13:
                    str = "<i class='ico-inline ico-state02'></i>审核失败";
                    break;
                case 6:
                    str = "<i class='ico-inline ico-state02'></i>取消提现";
                    break;
                case 7:
                    str = "<i class='ico-inline ico-state04'></i>审核成功";
                    break;
                case 11:
                    str = "<i class='ico-inline ico-state02'></i>暂不审核";
                    break;
                default:
                    str = "<i class='ico-inline ico-state02'></i>提现失败";
                    break;
            }
            return str;
        }
        
    }
}