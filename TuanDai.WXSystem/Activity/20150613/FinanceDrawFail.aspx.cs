using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.Activity
{
    public partial class FinanceDrawFail : System.Web.UI.Page
    {
        protected string errorMsg = "";
        protected string type="";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { 
                 type=Context.Request["type"];
                if (!string.IsNullOrEmpty(type))
                {
                    switch (type)
                    {
                        case "-1":
                            errorMsg = "投资红包兑换活动未开始!";
                            break;
                        case "-2":
                            errorMsg = "投资红包兑换活动已结束!";
                            break;
                        case "-3":
                            errorMsg = "请检查兑换密码输入是否有误!";
                            break;
                        case "-4":
                            errorMsg = "本券已被使用!";
                            break;
                        case "-5":
                            errorMsg = "一个用户只能兑换一次!";
                            break;
                    }
                }
                else{
                    errorMsg = "领取失败!";
                }
            }
        }
    }
}