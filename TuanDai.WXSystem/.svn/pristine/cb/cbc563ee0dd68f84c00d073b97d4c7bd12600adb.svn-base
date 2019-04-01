using BusinessDll;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.UserPrize
{
    public partial class ViewLogistics : UserPage
    {
        protected Guid orderId;
        protected List<LogisticDetail> listLsDt;
        /// <summary>
        /// 物流公司名称
        /// </summary>
        protected string Express = "";
        /// <summary>
        /// 运单号
        /// </summary>
        protected string ExpressNumber = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["orderId"]))
                {
                    orderId = Guid.Parse(Request.QueryString["orderId"]);
                }
            }
            GetLsDt();
        }

        public void GetLsDt()
        {
            LogisticBLL OptLogistic = new LogisticBLL();
            ProductReceiveAddress objPRA = null;
            string ExpressCode = string.Empty;
            try
            {
                objPRA = OptLogistic.getProductReceiveAddressByOrderId(orderId.ToString());

                listLsDt = OptLogistic.getListLogisticDetailbyOrderId(orderId.ToString());

                ExpressCode = OptLogistic.getExpressCodeByExpress(objPRA.Express);

                if (string.IsNullOrEmpty(objPRA.Express) || string.IsNullOrEmpty(objPRA.ExpressNumber) || string.IsNullOrEmpty(ExpressCode))
                {
                    return;
                }

                List<BusinessDll.Trace> LSTrace = null;
                if (listLsDt != null)
                {
                    foreach (var li in listLsDt)
                    {
                        if (!string.IsNullOrWhiteSpace(li.Express))
                            Express = li.Express;
                        if (!string.IsNullOrWhiteSpace(li.ExpressNumber))
                            ExpressNumber = li.ExpressNumber;
                    }

                    LSTrace = new KdApiSearch().getOrderTracesByJson(ExpressCode, objPRA.ExpressNumber);
                    if (LSTrace != null && LSTrace.Count > 0)
                    {
                        LogisticDetail objLsDt = null;
                        foreach (Trace item in LSTrace)
                        {
                            objLsDt = new LogisticDetail();
                            objLsDt.Description = item.AcceptStation;
                            objLsDt.CreateDate = item.AcceptTime;
                            listLsDt.Insert(0, objLsDt);
                        }
                    }
                    else
                    {
                        LogisticDetail objLsDt = new LogisticDetail();
                        objLsDt.Description = "如有疑问请至物流公司官网查询详情！";
                        objLsDt.CreateDate = DateTime.Now;
                        listLsDt.Insert(0, objLsDt);
                    }
                }
            }
            catch (Exception ex)
            {
                NetLog.WriteTraceLogHandler("获取物流信息失败_GetLsDt()", ex.Message + "|" + ex.StackTrace);
                LogisticDetail objLsDt = new LogisticDetail();
                objLsDt.Description = "领取成功,获取不到更多的物流信息！";
                objLsDt.CreateDate = DateTime.Now;
                if (listLsDt == null)
                {
                    listLsDt = new List<LogisticDetail>();
                }
                listLsDt.Insert(0, objLsDt);
            }
            

        }

        protected string GetStatusDesc(string Status)
        {
            switch (Status)
            {
                case "1":
                    return "已确认";
                case "2":
                    return "已发货";
                default:
                    return Status;
            }
        }
    }
}