﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Tool;
using System.Data.SqlClient;
using BusinessDll;
using TuanDai.InfoSystem.Model;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// ajax_userbasicInfo 的摘要说明
    /// </summary>
    public class ajax_userbasicInfo : SafeHandlerBase
    {
        public void WXUpdateUserBasicInfo()
        {
            Guid userid = WebUserAuth.UserId.Value;
            UserBLL bll = new UserBLL();
            UserBasicInfoInfo BasciInfo = bll.GetUserBasicInfoModelById(userid);
            UserBasicInfoExtInfo ExtInfo = bll.GetUserBasicInfoExtInfo(userid);
            bool? completeStatus = false;
            if (ExtInfo != null)
            {
                completeStatus = ExtInfo.IsCompletePersonalInfo;
            }
            else
            {
                ExtInfo = new UserBasicInfoExtInfo();
            }
            //string nickName = WEBRequest.GetFilterHTMLString("NickName");//昵称
            //string oldnickName = BasciInfo.NickName;
            ExtInfo.Graduation = HttpContext.Current.Request["Graduation"];//最高学历
            ExtInfo.University = StripHTML(HttpContext.Current.Request["University"]);//毕业院校
            ExtInfo.Marriage = HttpContext.Current.Request["Marriage"];//婚姻状况
            ExtInfo.Address = StripHTML(HttpContext.Current.Request["Address"]);//居住地址
            ExtInfo.OfficeDomain = HttpContext.Current.Request["OfficeDomain"];//公司行业
            ExtInfo.OfficeScale = HttpContext.Current.Request["OfficeScale"];//公司规模
            ExtInfo.Position = StripHTML(HttpContext.Current.Request["Position"]);//职位
            ExtInfo.Salary = HttpContext.Current.Request["Salary"];//月收入
            ExtInfo.IsHaveHouse = Tool.SafeConvert.ToBoolean(HttpContext.Current.Request["IsHaveHouse"]);//是否购房
            ExtInfo.IsHaveCar = Tool.SafeConvert.ToBoolean(HttpContext.Current.Request["IsHaveCar"]);//是否购车
            ExtInfo.IsCompletePersonalInfo = true;
            ExtInfo.ContactName = StripHTML(HttpContext.Current.Request["ContactName"]);//紧急联系人姓名
            ExtInfo.ContactTelNo = StripHTML(HttpContext.Current.Request["ContactTelNo"]);
            ExtInfo.ContactRelationShip = HttpContext.Current.Request["ContactRelationShip"];  

            //if (string.IsNullOrEmpty(nickName))
            //{
            //    PrintJson("0", "请输入昵称");
            //    return;
            //}
            //if (bll.IsKeywordContainsInTitle(nickName))
            //{
            //    PrintJson("0", "昵称中存在敏感字符");
            //    return;
            //}
            //string nickNameRegex = "^[a-zA-Z0-9_\u4e00-\u9fa5]{2,12}$";
            //if (!System.Text.RegularExpressions.Regex.IsMatch(nickName, nickNameRegex))
            //{
            //    PrintJson("-7", "昵称必须为：2-12个中文、字母、数字、下划线！");
            //}
            //string commonRegex = "^[a-zA-Z0-9_\u4e00-\u9fa5]{2,30}";
            //if (!System.Text.RegularExpressions.Regex.IsMatch(ExtInfo.University, commonRegex))
            //{
            //    PrintJson("-10", "毕业院校必须为：2-30个中文、字母、数字、下划线！");
            //}
            //if (!System.Text.RegularExpressions.Regex.IsMatch(ExtInfo.Address, commonRegex))
            //{
            //    PrintJson("-11", "住址必须为：2-30个中文、字母、数字、下划线！");
            //}
            //if (!System.Text.RegularExpressions.Regex.IsMatch(ExtInfo.Position, commonRegex))
            //{
            //    PrintJson("-12", "职位必须为：2-30个中文、字母、数字、下划线！");
            //}
            //string contractNameRegex = "^[a-zA-Z_\u4e00-\u9fa5]{2,12}";
            //if (!System.Text.RegularExpressions.Regex.IsMatch(ExtInfo.ContactName, contractNameRegex))
            //{
            //    PrintJson("-8", "紧急联系人必须为：2-12个中文、字母、下划线！");
            //}
            //string contractTelNoRegex = "^[0-9-]{7,13}";
            //if (!System.Text.RegularExpressions.Regex.IsMatch(ExtInfo.ContactTelNo, contractTelNoRegex))
            //{
            //    PrintJson("-9", "联系人电话必须为：7-13位电话号码！");
            //}
            
            //SqlParameter[] paramDatas = new SqlParameter[] { new SqlParameter("@NickName", nickName), new SqlParameter("@Id", BasciInfo.Id) };
            //UserBasicInfoInfo model = bll.WXGetUserBasicInfo("NickName=@NickName and Id!=@Id", paramDatas);
            //if (model != null)
            //if (IsNickNameExists(nickName,BasciInfo.Id))
            //{
            //    PrintJson("0", "昵称已经被使用");
            //    return;
            //}
            if (string.IsNullOrEmpty(ExtInfo.Graduation))
            {
                PrintJson("0", "请选择最高学历");
                return;
            }
            if (string.IsNullOrEmpty(ExtInfo.University))
            {
                PrintJson("0", "请输入毕业学校");
                return;
            }
            if (string.IsNullOrEmpty(ExtInfo.Marriage))
            {
                PrintJson("0", "请选择婚姻状况");
                return;
            }
            if (string.IsNullOrEmpty(ExtInfo.Address))
            {
                PrintJson("0", "请输入居住地址");
                return;
            }
            if (string.IsNullOrEmpty(ExtInfo.OfficeDomain))
            {
                PrintJson("0", "请选择公司行业");
                return;
            }
            if (string.IsNullOrEmpty(ExtInfo.OfficeScale))
            {
                PrintJson("0", "请选择公司规模");
                return;
            }
            if (string.IsNullOrEmpty(ExtInfo.Position))
            {
                PrintJson("0", "请输入您的职位信息");
                return;
            }
            if (string.IsNullOrEmpty(ExtInfo.Salary))
            {
                PrintJson("0", "请选择月收入");
                return;
            }
            if (string.IsNullOrEmpty(ExtInfo.IsHaveHouse.ToString()))
            {
                PrintJson("0", "请选择是否购房");
                return;
            }
            if (string.IsNullOrEmpty(ExtInfo.IsHaveCar.ToString()))
            {
                PrintJson("0", "请选择是否购车");
                return;
            }
            //BasciInfo.NickName = nickName;
            
            int result = bll.WXUpdateUserBasicInfo(ExtInfo, BasciInfo);
            if (result > 0)
            {
                if (completeStatus != true)
                {
                    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userid,(int)ConstString.UserGrowthType.CompleteInfomation,null,0);
                }
                //if (nickName != oldnickName)
                //{
                //    WebLog log = new WebLog();
                //    log.AddDate = DateTime.Now;
                //    log.BusinessId = userid.ToString();
                //    log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                //    log.UserId = userid.ToString();
                //    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                //    log.HandlerTypeId = (int)ConstString.LogType.EditNickName;
                //    log.Content1 = "修改会员昵称：修改之前为 " + oldnickName + ",修改之后" + nickName;
                //    log.Id = Guid.NewGuid().ToString();
                //    WebLogInfo.WriteLoginHandler(log);
                //    //首次修改昵称加团币
                //    VipGetTuanBiTaskBLL.FirstMobifyNickName(userid);
                //}
                PrintJson("1", "修改成功");
            }
            else
            {
                PrintJson("-1", "修改失败");
            }
            //UpdateUserBasicInfo(BasciInfo, ExtInfo, strNickName);
        }
       
        /// <summary>
        /// 去除HTML标记
        /// </summary>
        /// <param name="strHtml">包括HTML的源码 </param>
        /// <returns>已经去除后的文字</returns>
        protected string StripHTML(string strHtml)
        {
            string[] aryReg ={
            @"<script[^>]*?>.*?</script>",
            @"<(\/\s*)?!?((\w+:)?\w+)(\w+(\s*=?\s*(([""'])(\\[""'tbnr]|[^\7])*?\7|\w+)|.{0})|\s)*?(\/\s*)?>",
            @"([\r\n])[\s]+",
            @"&(quot|#34);",
            @"&(amp|#38);",
            @"&(lt|#60);",
            @"&(gt|#62);", 
            @"&(nbsp|#160);", 
            @"&(iexcl|#161);",
            @"&(cent|#162);",
            @"&(pound|#163);",
            @"&(copy|#169);",
            @"&#(\d+);",
            @"-->",
            @"<!--.*\n"
            };
            string[] aryRep = { "", "", "", "\"", "&", "<", ">", " ", "\xa1", "\xa2", "\xa3", "\xa9", "", "\r\n", "" };
            string newReg = aryReg[0];
            string strOutput = strHtml;
            for (int i = 0; i < aryReg.Length; i++)
            {
                System.Text.RegularExpressions.Regex regex = new System.Text.RegularExpressions.Regex(aryReg[i], System.Text.RegularExpressions.RegexOptions.IgnoreCase);
                strOutput = regex.Replace(strOutput, aryRep[i]);
            }
            strOutput.Replace("<", "");
            strOutput.Replace(">", "");
            strOutput.Replace("\r\n", "");

            return strOutput;
        }
    }
}