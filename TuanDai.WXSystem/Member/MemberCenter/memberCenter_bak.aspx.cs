using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.VipSystem.Model;
using TuanDai.VipSystem.BLL;
using BusinessDll;
using Tool;

namespace TuanDai.WXApiWeb.Member.MemberCenter
{
    public partial class memberCenter_bak : AppActivityBasePage
    {
        protected TuanDai.VipSystem.Model.UserInfo model = null;
        protected Guid UserId;
        protected List<UserPrivilegeInfo> list = null;
        protected List<ActivityInfo> activityList = null;
        protected List<Guid> recordList = null;
        protected List<BannerInfo> topList = null;
        protected List<BannerInfo> bottomList = null;
        protected int count = 0;
        protected string percent = "0";
        protected string strAction = string.Empty;
        protected string redType = string.Empty;//红包类型 
        protected List<ActInfo> listAct = null;
        protected TuanDai.PortalSystem.Model.UserBasicInfoInfo userModel;
        protected Dictionary<int, string> dicPriv = new Dictionary<int, string>(); //用户特权状态
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!WebUserAuth.IsAuthenticated)
            {
                if (GlobalUtils.IsWeiXinBrowser)
                {
                    Response.Redirect("/WeiXinIndex.aspx");
                }
                else
                {
                    Response.Redirect("/Index.aspx");
                }
            }
            if (!IsPostBack)
            { 
                InitData();
            }
        }

        protected void InitData()
        {
            ActivityBLL activitybll = new ActivityBLL();
            if (WebUserAuth.IsAuthenticated)
            {
                this.UserId = WebUserAuth.UserId.Value;

                TuanDai.PortalSystem.BLL.UserBLL userbll = new TuanDai.PortalSystem.BLL.UserBLL();
                userModel = userbll.GetUserBasicInfoModelById(UserId);


                UserGrowthBLL userGrowthbll = new UserGrowthBLL();
                TuanDai.VipSystem.BLL.UserBLL vipuserbll = new TuanDai.VipSystem.BLL.UserBLL();
                //List<int> typeList = userGrowthbll.GetUserRecord(UserId);
                //UserValidInfo Validmodel = vipuserbll.GetUserValidInfo(UserId);

                this.model = vipuserbll.GetUserInfo(this.UserId);

                this.GetUserPrivileges(this.model.Level);

                this.list = new UserPrivilegeBLL().GetUserPrivilegeInfo(this.UserId);
                this.recordList = activitybll.QueryActivityReceiveRecord(this.UserId);
                this.strAction = this.GetAction();
                if (this.model != null)
                {
                    this.percent = this.model.Growth == 0 || this.model.CurLevelMaxGrowth == 0 ? "0" : (Convert.ToDecimal(this.model.Growth) / this.model.CurLevelMaxGrowth * 100).ToString("0.00");
                }
                if (list != null)
                {
                    this.count = list.Select(p => p.TypeId).Distinct().Count();
                }
                else
                {
                    this.count = 0;
                }
            }
            this.activityList = activitybll.GetActivityList();
            this.GetActivityInfo(); 
        }

        #region 领取红包判断
        protected bool IsGetRed(string obj, int type)
        {
            if (this.list != null)
            {
                UserPrivilegeInfo privilege = this.list.Where(p => p.TypeId == 1 && p.Remark.Contains(obj) && this.model.Level>=p.Level).FirstOrDefault();
                if (privilege != null && privilege.IsReceive)
                {
                    return true;
                }
                if (privilege != null && privilege.IsReceive == false)
                {
                     return false;
                } 
            }
            return true;
        } 
        protected string GetAction()
        {
            if (!IsGetRed("88", 2))
            {
                this.redType = "1";                
                return "88元的投资礼包";
            }
            if (!IsGetRed("158", 3))
            {
                this.redType = "2";
                return "158元的投资礼包";
            }
            if (!IsGetRed("228", 4))
            {
                this.redType = "3";
                return "228元的投资礼包";
            }
            return string.Empty;
        }
        #endregion


        /// <summary>
        /// 获取活动信息
        /// </summary>
        protected void GetActivityInfo()
        {
            List<ActInfo> listActInfo = new List<ActInfo>();
            ActInfo objActInfo = null;
            int index = 0;
            foreach (var item in this.activityList.Where(p => p.TypeId == 1))
            {
                objActInfo = new ActInfo();
                objActInfo.Index = (index++).ToString();
                objActInfo.ImgPath = item.ActivityImage;
                objActInfo.ActivityId = item.Id.ToString();
                objActInfo.LimitLevel = item.LimitLevel;
                objActInfo.SubType = "2";

                if (item.SubTypeId == 2)
                {
                    if (item.Status == 0 || (item.EndDate != null && item.EndDate <= DateTime.Now))
                    {
                        objActInfo.StatusDesc = "已结束";
                        objActInfo.Status = 2; 
                    }
                    else
                    {
                        objActInfo.StatusDesc = "进行中";
                        objActInfo.Status = 1; 
                    }
                }
                else
                {
                    if (this.recordList != null && this.recordList.Contains(item.Id))
                    {
                        objActInfo.StatusDesc = "已经领取";
                        objActInfo.Status = 2;
                    }
                    else if (item.Status == 0 || (item.EndDate != null && item.EndDate <= DateTime.Now))
                    {
                        objActInfo.StatusDesc = "已结束";
                        objActInfo.Status = 2; 
                    }
                    else if (item.StartDate > DateTime.Now)
                    {
                        objActInfo.StatusDesc = "敬请期待";
                        objActInfo.Status = 3; 
                    }
                    else if (item.SurplusQuantity == 0)
                    {
                        objActInfo.StatusDesc = "已经领完";
                        objActInfo.Status = 2; 
                    }
                    else if (this.model != null)
                    {
                        objActInfo.StatusDesc = "马上领取";
                        objActInfo.Status = 1;
                        objActInfo.SubType = "1";  
                    }
                    else
                    {
                        objActInfo.StatusDesc = "马上领取";
                        objActInfo.Status = 1;
                        objActInfo.SubType = "1";
                    }
                }
                objActInfo.Url = item.WXLinkUrl;
                if (objActInfo.Url.ToText().IsEmpty())
                {
                    objActInfo.Url = item.LinkUrl;
                } 
                listActInfo.Add(objActInfo);
            }
            var list = from item in listActInfo
                       orderby item.Index ascending
                       select item;
            this.listAct = list.ToList();

        }

        protected void GetUserPrivileges(int curLevel) {
            for (int i = 1; i <= 8; i++) {
                dicPriv.Add(i,  "_gray"); 
            }
            if (curLevel == 2) {
                dicPriv[1] = "";
            }
            else if (curLevel == 3 || curLevel==4)
            {
                dicPriv[1] = "";
                dicPriv[6] = "";
            }
            else if (curLevel == 5)
            {
                dicPriv[1] = "";
                dicPriv[5] = "";
                dicPriv[6] = "";               
            }
            else if (curLevel == 6)
            {
                dicPriv[1] = "";
                dicPriv[5] = "";
                dicPriv[6] = "";              
                dicPriv[8] = "";
            }
            else if (curLevel == 7)
            {
                dicPriv[1] = "";
                dicPriv[2] = "";
                dicPriv[4] = "";               
                dicPriv[5] = "";
                dicPriv[6] = "";
                dicPriv[7] = "";
                dicPriv[8] = ""; 
                
            }
            else if (curLevel ==8)
            {
                dicPriv[1] = "";
                dicPriv[2] = "";
                dicPriv[3] = "";
                dicPriv[4] = "";
                dicPriv[5] = "";
                dicPriv[6] = "";
                dicPriv[7] = "";
                dicPriv[8] = "";
            }
        }
    }

    #region 私有Model
    public class ActInfo
    {
        public string ImgPath { get; set; }
        public string Index { get; set; }
        /// <summary>
        /// 1:进行中  2:已结束 3：未开始
        /// </summary>
        public int Status { get; set; }
        public string StatusDesc { get; set; }

        public string Url { get; set; }
        public string SubType { get; set; }
        public string ActivityId { get; set; }
        public string LimitLevel { get; set; }
    }
    #endregion


}