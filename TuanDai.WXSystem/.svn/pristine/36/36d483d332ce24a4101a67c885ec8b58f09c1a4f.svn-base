using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.UserPrizeNew.ServiceClient.Models;

namespace TuanDai.WXApiWeb.Member.UserPrize
{
    public partial class Index : UserPage
    {
        protected decimal Prize1 = 0;//现金红包
        protected decimal Prize2 = 0;//投资红包
        protected int Prize3 = 0;//提现劵
        protected int Prize7 = 0;//加息券
        protected string Prize6 = string.Empty;//精美礼品
        protected decimal Prize8 = 0;//体验金
        protected decimal Prize9 = 0;//免费债转券
        protected decimal Prize10 = 0;//京东券
        /// <summary>
        /// 最快过期的一张体现劵过期时间
        /// </summary>
        protected DateTime? NearPrizeReflectExpirationDate = null;
        protected List<WXUserPrizeListInfo> UserPrizeList;
        UserBLL bll = new UserBLL();
        private Guid UserId = Guid.Empty;
        protected bool isNeedViewGift = false;//是否未看过实物奖品

        protected void Page_Load(object sender, EventArgs e)
        {
            string err = "";
            UserId = WebUserAuth.UserId.Value;
            var prizeClient = new TuanDai.UserPrizeNew.Client.UserPrizeQueryClient(TdConfig.ApplicationName);
            var list = prizeClient.GetUserPrizeUnusedCountByType(UserId, out err);
            if (list != null && list.Count > 0)
            {
                Prize1 =
                    list.Where(o => o.typeId == 4 || o.typeId == 11 || o.typeId == 13 || o.typeId == 14)
                        .Sum(o => o.prizeValue);
                Prize2 = list.Where(o => o.typeId == 3).Sum(o => o.prizeValue);
                Prize8 = list.Where(o => o.typeId == 16).Sum(o => o.prizeValue);
                Prize3 = list.Where(o => o.typeId == 2).Count() > 0
                    ? list.Where(o => o.typeId == 2).FirstOrDefault().prizeCount
                    : 0;
                Prize7 = list.Where(o => o.typeId == 18).Count() > 0
                    ? list.Where(o => o.typeId == 18).FirstOrDefault().prizeCount
                    : 0;
                Prize9 = list.Exists(o => o.typeId == 20) ? list.First(o => o.typeId == 20).prizeCount : -1;
                Prize10 = list.Exists(o => o.typeId == 21) ? list.First(o => o.typeId == 21).prizeCount: 0;
                Prize10 += list.Exists(o => o.typeId == 23) ? list.First(o => o.typeId == 23).prizeCount : 0;

                if (Prize9 == -1)
                {
                    var used = prizeClient.GetUserPrizeHistoryByUser(new GetUserPrizeHistoryByUserRequest {userId = UserId, pageIndex = 1, pageSize = 1, typeId = new List<int> {20} }, out err);
                    if (string.IsNullOrEmpty(err) && used != null)
                    {
                        Prize9 = used.totalCount > 0 ? 0 : -1;//如果有已过期或已使用的 prize9为0，为-1时不显示tab
                    }
                }
            }
            Prize6 = GetPrize6();
        }
        /// <summary>
        /// 精美礼品
        /// </summary>
        /// <returns></returns>
        private string GetPrize6()
        {
            
            UserPrizeList = bll.WXGetUserPrize(UserId, "9").ToList();
            UserPrizeList.AddRange(bll.WXGetUserPrize(UserId, "22").ToList());
            string viewGiftStatus = Tool.CookieHelper.GetCookie("ViewGiftStatus"); //0:未看过 1:已看过
            if (UserPrizeList.Count > 0)
            {
                //只显示未领取的礼品  Allen 2015-10-26
                WXUserPrizeListInfo prizeInfo = UserPrizeList.Where(p => p.IsReceive == false && (p.ReceiveEndDate == null || p.ReceiveEndDate.HasValue && p.ReceiveEndDate > DateTime.Now)).FirstOrDefault();
                if (prizeInfo != null)
                {
                    string name = prizeInfo.PrizeName;
                    if (name.Length > 8)
                        name = name.Substring(0, 8) + "...";

                    if (viewGiftStatus == "0" || viewGiftStatus == "")
                    {
                        isNeedViewGift = true;
                        Tool.CookieHelper.WriteCookie("ViewGiftStatus", "0", 3 * 24 * 60);
                    }
                    return name;
                }
                isNeedViewGift = false;
                return string.Empty;
            }
            else
            {
                isNeedViewGift = false;
                return string.Empty;
            }
        }
    }
}