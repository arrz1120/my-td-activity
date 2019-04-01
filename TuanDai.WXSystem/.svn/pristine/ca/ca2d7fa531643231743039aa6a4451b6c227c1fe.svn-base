using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.WXSystem.Core;

namespace TuanDai.WXApiWeb.Member.withdrawal
{
    /// <summary>
    /// 确认提现界面
    /// Allen 2015-09-25
    /// </summary>
    public partial class withdrawal_confirm : UserPage
    {
        protected decimal withDrawMoney = 0; //用户提现金额
        protected decimal couponAmount = 0;//提现卷金额
        protected decimal currentMoeny = 0;//帐户可用余额
        protected int drawType = 2;
        protected void Page_Load(object sender, EventArgs e)
        {
            string jsonStr = WEBRequest.GetFormString("jsondata");

            FormPostData formObj = JsonHelper.ToObject<FormPostData>(jsonStr);
            if (formObj == null)
            {
                Response.Redirect("drawmoney.aspx");
                return;
            }
            withDrawMoney = formObj.Amount;
            couponAmount = formObj.CouponAmount;
            drawType = formObj.DrawType;
            if (drawType != 1 && drawType != 2)
                drawType = 2;

            UserBLL userbll = new UserBLL();
            Guid userId = WebUserAuth.UserId.Value;
            currentMoeny = userbll.GetDrawAviAmount(userId);
            //CalcWithDrawMoney(userbll, userId, drawType);
        }
        //计算用户可提现金额
        private decimal CalcWithDrawMoney(UserBLL userbll, Guid userId, int drawType)
        {
            decimal maxAviMoney = userbll.GetDrawAviAmount(userId);
            decimal wxAviMoney = userbll.GetWeiXinAviAmount(userId);
            decimal cadAviMoney = 0;
            if (maxAviMoney < 0)
            {
                wxAviMoney = 0;
                cadAviMoney = 0;
            }
            var _wxAviMoney = wxAviMoney + (wxAviMoney * (decimal)0.15);
            //如果提现金额小于或等于微信提现金额
            if (_wxAviMoney >= maxAviMoney)
            {
                wxAviMoney = maxAviMoney;
                cadAviMoney = 0;
            }
            else
            {
                wxAviMoney = _wxAviMoney;
                cadAviMoney = maxAviMoney - _wxAviMoney;
            }
            if (drawType == 1)
                return wxAviMoney;
            else
                return cadAviMoney;
        }

        
    }
    public class FormPostData
    {
        public decimal Amount { get; set; }
        public decimal CouponAmount { get; set; }
        //提现类型
        public int DrawType { get; set; }
    }
}