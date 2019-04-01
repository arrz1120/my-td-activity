using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    /// <summary>
    /// 债权转让--转让详情页
    /// Allen 2016-02-23
    /// </summary>
    public partial class my_debt_detail : UserPage
    {
        protected Guid TransterId = Guid.Empty;
        protected TransferRecord mTransferRecord = new TransferRecord();
        protected int pageCount = 0;
        protected long LastSecond = 0;//剩余时间
        protected string CurTabName { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            TransterId = WEBRequest.GetGuid("subid");
            CurTabName = WEBRequest.GetQueryString("tab");
            if (TransterId == Guid.Empty)
            {
                Response.Redirect("/Member/my_account.aspx");
                return;
            }
            if (!IsPostBack)
            {
                LoadData();
            }
        }
        protected void LoadData() {
            Guid userid = WebUserAuth.UserId.Value; 
            if (userid != Guid.Empty && TransterId != Guid.Empty)
            {
                int count = 0;
                SubscribeBLL bll = new SubscribeBLL();
                mTransferRecord = bll.GetTransferRecord(TransterId, 1, 8, out count);

                double divide = count / 8;
                double floor = System.Math.Floor(divide);
                if (count % GlobalUtils.PageSize != 0)
                    floor++;
                pageCount = Convert.ToInt32(floor);//总页数
                DateTime EndTransferDate = DateTime.Parse(mTransferRecord.AddDate.ToString("yyyy-MM-dd") + " 23:59:59");
                if (DateTime.Now > EndTransferDate)
                    this.LastSecond = 0;
                else
                {
                    this.LastSecond = Convert.ToInt32((EndTransferDate - DateTime.Now).TotalSeconds);
                } 
            }
        }

        //进度表的百分比两个数相除,向下取保留小数
        public  string ProcessBar(decimal arg1, decimal arg2, int Digit)
        {
            if (arg1 == 0)
            {
                return "0.0";
            }
            decimal result = arg1 / arg2 * 100;
            if (result > 0 && result < 0.1M)
            {
                return "0.1";
            }
            if (result.ToString().IndexOf(".") > -1)
            {
                return result.ToString().Substring(0, result.ToString().IndexOf('.') + Digit + 1);
            }
            else
            {
                return result.ToString();
            }
        }
    }
}