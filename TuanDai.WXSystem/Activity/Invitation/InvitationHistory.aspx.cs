using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using BusinessDll; 
using System.Text;
using System.Data.Objects;

namespace TuanDai.WXApiWeb.Activity.Invitation
{
    public partial class InvitationHistory : UserPage
    {
        /// <summary>
        /// 抽奖总次数.
        /// </summary>
        protected int totalChances { get; set; }

        /// <summary>
        /// 已经抽奖次数.
        /// </summary>
        protected int usedChances { get; set; }

        /// <summary>
        /// 得到的云币数.
        /// </summary>
        protected int coinCount { get; set; }

        /// <summary>
        /// 是否已经登录.
        /// </summary>
        protected bool isAuthenticated { get; set; }

        /// <summary>
        /// 邀请的实名绑卡用户数.
        /// </summary>
        protected int invitedUsers { get; set; }

        /// <summary>
        /// 已获得的VIP超级会员月份数.
        /// </summary>
        protected int gotVipMonths { get; set; }

        /// <summary>
        /// 现金奖励列表.
        /// </summary>
        protected IQueryable<UserPrizeViewModel> prizes { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (WebUserAuth.IsAuthenticated)
            {
                //var database = JunTeEntities.Read();
                //var userId = WebUserAuth.UserId.Value;
                //var user = database.UserBasicInfo.First(p => p.Id == userId);

                ////获取本人获得的奖励分红.
                //var startDate = DateTime.Parse("2015-04-30 10:00:00");
                //this.prizes = (from p in database.UserPrize
                //               join u in database.UserBasicInfo on p.TargetProductId equals u.Id
                //               where p.UserId == userId && p.ActivityCode == "Invitation_20150416" &&
                //               p.TypeId == 11 && p.CreateDate >= startDate
                //               orderby p.CreateDate descending
                //               select new UserPrizeViewModel()
                //               {
                //                   Name = u.NickName,
                //                   Date = p.CreateDate,
                //                   Amount = p.PrizeValue
                //               });

                ////查询总抽奖次数.
                //var builder = new StringBuilder();
                //builder.Append("select count(0) from FundAccountInfo f");
                //builder.Append(" left join UserBasicInfo u on f.UserId = u.Id");
                //builder.AppendFormat(" where f.TotalInvest >= {0}", 1000);
                //builder.AppendFormat(" and u.ExtenderKey = '{0}'", user.ExtendKey);
                //builder.Append(" and u.AddDate >= dateadd(day,-30,getdate())");
                //builder.AppendFormat(" and u.AddDate >= '{0}'", startDate.ToString());

                //this.totalChances = database.ExecuteStoreQuery<int>(builder.ToString()).FirstOrDefault();

                ////查询已经抽奖次数和获得云购币数.
                //var prizeList = database.UserPrize.Where(x =>
                //    x.UserId == userId &&
                //    x.ActivityCode == "Invitation_20150416" &&
                //    x.TypeId == 10 &&
                //    x.CreateDate >= startDate).ToList();

                //this.usedChances = prizeList.Count;
                //this.coinCount = Convert.ToInt32(prizeList.Sum(x => x.PrizeValue));

                ////获取本人邀请的实名绑卡用户总数.
                //this.invitedUsers = database.UserBasicInfo.Where(x =>
                //    x.ExtenderKey == user.ExtendKey &&
                //    x.IsValidateIdentity &&
                //    x.BankAccountNo != null &&
                //    x.AddDate >= startDate).Count();
                
                //if (this.invitedUsers == 0)
                //{
                //    //string url = SourceType == "app" ? "InvitationHistory_None.aspx?type=App" : "InvitationHistory_None.aspx";
                //    Response.Redirect("InvitationHistory_None.aspx");
                //}
                ////获取本人已经获得的VIP超级会员总月份数.
                //this.gotVipMonths = database.MemberStatusHistory.Where(x =>
                //    x.UserId == user.Id &&
                //    x.Type == 3 &&
                //    x.Level == 2 &&
                //    x.Desc == "邀请好友注册赢VIP超级会员" &&
                //    x.adddate >= startDate).Count();
            }
        }

        public class TwoCode
        {
            public string[] code { get; set; }
            public string base64 { get; set; }
        }

        public class UserPrizeViewModel
        {
            public string Name { get; set; }
            public DateTime Date { get; set; }
            public Decimal Amount { get; set; }
        }
    }
}