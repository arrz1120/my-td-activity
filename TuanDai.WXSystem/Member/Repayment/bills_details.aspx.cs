using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Management;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using Tool;
using TuanDai.WXApiWeb.pages.aboutus;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    /// <summary>
    /// 我的账单
    /// Allen 2015-06-29
    /// </summary>
    public partial class bills_details : UserPage
    {       
        protected WXMyBillDetialInfo model { get; set; }
        protected IList<ProjectAdImageInfo> BannerList;   //首页头部广告图
        protected static WebSettingInfo webset = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            webset = new WebSettingBLL().GetWebSettingInfo("71E1B58D-449F-4C61-85A6-115C10630554");
            if (webset == null)
            {
                webset = new WebSettingInfo();
                webset.Param1Value = "2018-05-01";
            }
            if (!IsPostBack)
            {
                this.GetData();
            }
        }

        private void GetData()
        {
            Guid userId = WebUserAuth.UserId.Value;
            ProjectBLL bll = new ProjectBLL();
            Guid id= Tool.SafeConvert.ToGuid(Tool.WEBRequest.GetQueryString("Id")).Value;
            model = bll.WXGetMyBillDetailInfo(id, userId);
            if (string.IsNullOrEmpty(model.Title) && model.FundProjectId.HasValue)
            {
                model.Title = GetZXTitleBySubId(model.FundProjectId.Value);
            }
            
            BannerList = new AdImageBLL().GetTuanDaiHot((int)ConstString.AdImageType.WEBImage, 1);
        } 

        //获取标题
        public static string GetBillTitle(WXMyBillDetialInfo item)
        {
            
                
            if (item.BillType == 4)
            {
                if (item.BillDesc == "申购借出")
                {
                    if (!item.Title.IsEmpty())
                        return item.Title.ToText();
                    else
                        return item.BillDesc;
                }
                else
                {
                    return item.BillDesc; 
                }
            }
            else if (item.BillType == 45)
            {
                if (item.PayOutAmount.HasValue && item.PayOutAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "投资智享转让";
                    }
                    return "投资智享计划";
                }
                else if (item.InAmount.HasValue && item.InAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让回款";
                    }
                    return "智享计划回款";
                }
                else
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让相关";
                    }
                    return "智享计划相关";
                }
            }
            else if (item.BillType == 46)
            {
                if (item.PayOutAmount.HasValue && item.PayOutAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让回购";
                    }
                    return "智享计划回购";
                }
                else if (item.InAmount.HasValue && item.InAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让";
                    }
                    return "智享计划转让";
                }
                else
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让相关";
                    }
                    return "智享计划相关";
                }
            }
            else
                return item.BillDesc;
        }

        protected static string GetBillDesc(WXMyBillDetialInfo item)
        {
            if (item.BillType == 45)
            {
                if (item.PayOutAmount.HasValue && item.PayOutAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "投资智享转让";
                    }
                    return "投资智享计划";
                }
                else if (item.InAmount.HasValue && item.InAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让回款";
                    }
                    return "智享计划回款";
                }
                else
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让相关";
                    }
                    return "智享计划相关";
                }
            }
            else if (item.BillType == 46)
            {
                if (item.PayOutAmount.HasValue && item.PayOutAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让回购";
                    }
                    return "智享计划回购";
                }
                else if (item.InAmount.HasValue && item.InAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让";
                    }
                    return "智享计划转让";
                }
                else
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让相关";
                    }
                    return "智享计划相关";
                }
            }
            else
            {
                return item.BillDesc;
            }
        }
        //获取交易类型
        public static string GetBillType(WXMyBillDetialInfo item)
        {

            string billType = Tool.EnumHelper.GetDescriptionFromEnumValue(typeof(ConstString.FundDetailType1),
                item.BillType);
            if (item.BillDate > DateTime.Parse(webset.Param1Value))
            {
                if (billType.Contains("We计划相关"))
                {
                    billType = "We自动服务相关";
                }
                if (billType.Contains("复投宝"))
                {
                    billType = "We+自动服务";
                }
                if (billType.Contains("智享计划"))
                {
                    billType = "智享转让";
                }
            }
            return billType;
        }
        /// <summary>
        /// 根据申购Id查询智享计划的标题
        /// </summary>
        /// <param name="SubId"></param>
        /// <returns></returns>
        private string GetZXTitleBySubId(Guid SubId)
        {
            string sql = @"select p.title from Subscribe s with(nolock) 
                            inner join Project p with(nolock) on s.ProjectId=p.id
                            where s.id=@Id";
            var para = new Dapper.DynamicParameters();
            para.Add("@Id",SubId);

            return TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<string>(TdConfig.ApplicationName, "/BD/zxread", sql, ref para);
        }
    }
}