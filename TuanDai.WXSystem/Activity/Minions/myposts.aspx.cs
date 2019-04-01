using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.WXSystem.Core;

namespace TuanDai.WXApiWeb.Activity.Minions
{
    public partial class myposts : System.Web.UI.Page
    {
        protected WXNickInfo model;
        protected void Page_Load(object sender, EventArgs e)
        {
            string jsonData = Tool.WEBRequest.GetFormString("jsondata");
            if (jsonData.IsNotEmpty())
            {
                model = JsonHelper.ToObject<WXNickInfo>(jsonData);
            }
            if (model == null) {
                model = new WXNickInfo() { HeadImg = "images/tx1.png", NickName = "我是团粉" };
            }
        }
    }
    public class WXNickInfo {
        public string HeadImg { get; set; }
        public string NickName { get; set; }
    }
}