using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.Member.MemberCenter
{
    public partial class memberCenter : AppActivityBasePage
    {
        public MUserVipInfo vipInfo = new MUserVipInfo();//会员信息
        public int nextLevel = 1;//下个月预测等级
        public decimal currAvgDaily = 0;//当前月日均资产
        public decimal preAvgDaily = 0;//上月日均资产
        public bool IsSuper = false;//是否超级会员
        public string LevelEndDate;//超级会员结束时间
        public decimal nextLevelAsset = 0;//下一个等级需要的日均资产数

        public VipLevelPower vipLevelPower;
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            if (!IsPostBack && WebUserAuth.UserId.Value != null && WebUserAuth.UserId.Value != Guid.Empty)
            {
                vipInfo = MUserVipInfoBLL.GetUserVipInfoById(WebUserAuth.UserId.Value);
                var basicUserInfo = MUserVipInfoBLL.GetUserBasicInfoByUserId(WebUserAuth.UserId.Value);
                if (basicUserInfo.Level != null && basicUserInfo.Level == 2)
                {
                    IsSuper = true;
                    LevelEndDate = (basicUserInfo.LevelEndDate??DateTime.Now).ToString("yyyy-MM-dd");
                }
                vipInfo.HeadImage = basicUserInfo.HeadImage;
                vipInfo.CurrYYMM = DateTime.Now.Month.ToString();

                var dayNetAssets = MVipNetAssetsBLL.GetDayOfNetAssets(WebUserAuth.UserId.Value);
                var CurrDailyAssets =
                    dayNetAssets.Where(o => o.ReportDate >= new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1))
                        .ToList();
                if (CurrDailyAssets.Count > 0)
                {
                    currAvgDaily = CurrDailyAssets.Sum(o => o.NetAssets)/CurrDailyAssets.Count;
                }
                var PreDailyAssets =
                 dayNetAssets.Where(o => o.ReportDate < new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)).ToList();
                if (PreDailyAssets.Count > 0)
                {
                    preAvgDaily = PreDailyAssets.Sum(o => o.NetAssets) / PreDailyAssets.Count;
                }

                if (currAvgDaily >= 0 && currAvgDaily <= 10000)
                {
                    nextLevel = 1;
                }
                else if (currAvgDaily >= 10000 && currAvgDaily < 50000)
                {
                    nextLevel = 2;
                }
                else if (currAvgDaily >= 50000 && currAvgDaily < 100000)
                {
                    nextLevel = 3;
                }
                else if (currAvgDaily >= 100000 && currAvgDaily < 200000)
                {
                    nextLevel = 4;
                }
                else if (currAvgDaily >= 200000 && currAvgDaily < 500000)
                {
                    nextLevel = 5;
                }
                else if (currAvgDaily >= 500000 && currAvgDaily < 1000000)
                {
                    nextLevel = 6;
                }
                else if (currAvgDaily >= 1000000 && currAvgDaily < 3000000)
                {
                    nextLevel = 7;
                }
                else
                {
                    nextLevel = 8;
                }

                
                vipLevelPower = new VipLevelPower();
                if (vipInfo.Level == 1)
                {
                    vipLevelPower.TuanBiRatio = (decimal)1.0;
                    vipLevelPower.IsCash = false;
                    vipLevelPower.CashMoney = 0;
                    vipLevelPower.IsLoanDiscount = false;
                    vipLevelPower.Discount = 0;
                    vipLevelPower.IsBirthdayRedPacket = false;
                    vipLevelPower.RedPacketMoney = 0;
                    vipLevelPower.IsGift = false;
                    vipLevelPower.IsServiceTel = false;
                    vipLevelPower.IsAdvanceService = false;
                }
                else if (vipInfo.Level == 2)
                {
                    vipLevelPower.TuanBiRatio = (decimal)1.05;
                    vipLevelPower.IsCash = true;
                    vipLevelPower.CashMoney = 5;
                    vipLevelPower.IsLoanDiscount = false;
                    vipLevelPower.Discount = 0;
                    vipLevelPower.IsBirthdayRedPacket = false;
                    vipLevelPower.RedPacketMoney = 0;
                    vipLevelPower.IsGift = false;
                    vipLevelPower.IsServiceTel = false;
                    vipLevelPower.IsAdvanceService = false;
                }
                else if (vipInfo.Level == 3)
                {
                    vipLevelPower.TuanBiRatio = (decimal)1.1;
                    vipLevelPower.IsCash = true;
                    vipLevelPower.CashMoney = 10;
                    vipLevelPower.IsLoanDiscount = false;
                    vipLevelPower.Discount = 0;
                    vipLevelPower.IsBirthdayRedPacket = true;
                    vipLevelPower.RedPacketMoney = 18;
                    vipLevelPower.IsGift = false;
                    vipLevelPower.IsServiceTel = false;
                    vipLevelPower.IsAdvanceService = false;
                }
                else if (vipInfo.Level == 4)
                {
                    vipLevelPower.TuanBiRatio = (decimal)1.15;
                    vipLevelPower.IsCash = true;
                    vipLevelPower.CashMoney = 15;
                    vipLevelPower.IsLoanDiscount = true;
                    vipLevelPower.Discount = 7;
                    vipLevelPower.IsBirthdayRedPacket = true;
                    vipLevelPower.RedPacketMoney = 28;
                    vipLevelPower.IsGift = true;
                    vipLevelPower.IsServiceTel = false;
                    vipLevelPower.IsAdvanceService = false;
                }
                else if (vipInfo.Level == 5)
                {
                    vipLevelPower.TuanBiRatio = (decimal)1.2;
                    vipLevelPower.IsCash = true;
                    vipLevelPower.CashMoney = 25;
                    vipLevelPower.IsLoanDiscount = true;
                    vipLevelPower.Discount = (decimal)6.5;
                    vipLevelPower.IsBirthdayRedPacket = true;
                    vipLevelPower.RedPacketMoney = 48;
                    vipLevelPower.IsGift = true;
                    vipLevelPower.IsServiceTel = true;
                    vipLevelPower.IsAdvanceService = false;
                }
                else if (vipInfo.Level == 6)
                {
                    vipLevelPower.TuanBiRatio = (decimal)1.25;
                    vipLevelPower.IsCash = true;
                    vipLevelPower.CashMoney = 40;
                    vipLevelPower.IsLoanDiscount = true;
                    vipLevelPower.Discount = (decimal)5.5;
                    vipLevelPower.IsBirthdayRedPacket = true;
                    vipLevelPower.RedPacketMoney = 68;
                    vipLevelPower.IsGift = true;
                    vipLevelPower.IsServiceTel = true;
                    vipLevelPower.IsAdvanceService = false;
                }
                else if (vipInfo.Level == 7)
                {
                    vipLevelPower.TuanBiRatio = (decimal)1.3;
                    vipLevelPower.IsCash = true;
                    vipLevelPower.CashMoney = 60;
                    vipLevelPower.IsLoanDiscount = true;
                    vipLevelPower.Discount = (decimal)4.5;
                    vipLevelPower.IsBirthdayRedPacket = true;
                    vipLevelPower.RedPacketMoney = 98;
                    vipLevelPower.IsGift = true;
                    vipLevelPower.IsServiceTel = true;
                    vipLevelPower.IsAdvanceService = true;
                }
                else 
                {
                    vipLevelPower.TuanBiRatio = (decimal)1.35;
                    vipLevelPower.IsCash = true;
                    vipLevelPower.CashMoney = 100;
                    vipLevelPower.IsLoanDiscount = true;
                    vipLevelPower.Discount = (decimal)3.5;
                    vipLevelPower.IsBirthdayRedPacket = true;
                    vipLevelPower.RedPacketMoney = 128;
                    vipLevelPower.IsGift = true;
                    vipLevelPower.IsServiceTel = true;
                    vipLevelPower.IsAdvanceService = true;
                }

                if (nextLevel == 1)
                {
                    nextLevelAsset = 10000;
                }
                else if (nextLevel == 2)
                {
                    nextLevelAsset = 50000;
                }
                else if (nextLevel == 3)
                {
                    nextLevelAsset = 100000;
                }
                else if (nextLevel == 4)
                {
                    nextLevelAsset = 200000;
                }
                else if (nextLevel == 5)
                {
                    nextLevelAsset = 500000;
                }
                else if (nextLevel == 6)
                {
                    nextLevelAsset = 1000000;
                }
                else if (nextLevel == 7)
                {
                    nextLevelAsset = 3000000;
                }
                else
                {
                    nextLevelAsset = 3000000;
                }
            }
            else if (!WebUserAuth.IsAuthenticated)
            {
                Response.Redirect("/user/Login.aspx?ReturnUrl=/Member/MemberCenter/memberCenter.aspx");
            }
            
        }
    }
    /// <summary>
    /// VIP等级特权
    /// </summary>
    public class VipLevelPower
    {
        /// <summary>
        /// 团币系数
        /// </summary>
        public decimal TuanBiRatio;
        /// <summary>
        /// 是否拥有提现优惠券特权
        /// </summary>
        public bool IsCash;
        /// <summary>
        /// 优惠券金额
        /// </summary>
        public int CashMoney;
        /// <summary>
        /// 是否拥有借款打折特权
        /// </summary>
        public bool IsLoanDiscount;
        /// <summary>
        /// 借款打折数
        /// </summary>
        public decimal Discount;
        /// <summary>
        /// 是否拥有生日红包特权
        /// </summary>
        public bool IsBirthdayRedPacket;
        /// <summary>
        /// 红包金额
        /// </summary>
        public int RedPacketMoney;
        /// <summary>
        /// 是否拥有节日礼物赠送特权
        /// </summary>
        public bool IsGift;
        /// <summary>
        /// 是否拥有贵宾专线
        /// </summary>
        public bool IsServiceTel;
        /// <summary>
        /// 是否拥有高级专属服务
        /// </summary>
        public bool IsAdvanceService;
    }
}