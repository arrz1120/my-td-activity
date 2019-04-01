<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="plainPay.aspx.cs" Inherits="TuanDai.WXApiWeb.PaymentPlatform.lianlian.plainPay" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>
    <% SortedDictionary<string, string> sParaTemp = getBaseParamDict();

            if (null == sParaTemp)
            {
                Response.Redirect("~/user/login.aspx");
                return;
            }
            string strb = "";
            foreach (var item in sParaTemp) {
                if (strb == "")
                    strb = item.Key + "=" + item.Value;
                else
                {
                    //if (item.Key == "risk_item")
                    //{
                    //    strb += "&" + item.Key + "=" + item.Value.Replace("\"" , "\\\"");
                    //}
                    //else
                    //{
                        strb += "&" + item.Key + "=" + item.Value;
                    //}
                }
            }
            string req_data = strb; // LLPay.PaymentUtil.DictToJson(sParaTemp);
            String sign = "";
            if ("RSA".Equals(partnerConfig.SignType))
            {
                sign = LLPay.RSAFromPkcs8.sign(req_data, partnerConfig.TraderPriKey, "utf-8");
            }
            else
            {
                req_data += "&key=" + partnerConfig.MD5Key;
                sign = LLPay.Md5Algorithm.GetInstance().MD5Digest(
                            Encoding.UTF8.GetBytes(req_data));
            }
            sParaTemp.Remove("risk_item");
            string idNo = userInfo.IdentityCard;//"623026199206016992";
           // sParaTemp.Add("risk_item", createRiskItemOld(user_id, acctName).Replace("\"", "\\\""));
            sParaTemp.Add("risk_item", createRiskItem(userid, acctName, idNo, userInfo.TelNo, userInfo.AddDate.Value.ToString("yyyyMMddHHmmss")).Replace("\"", "\\\""));
            sParaTemp.Add("sign", sign);
            string req_data1 = LLPay.PaymentUtil.DictToJson(sParaTemp);
            SaveRequestSign(sign);
            
            StringBuilder sbHtml = new StringBuilder();

            sbHtml.Append("<form id='payBillForm' action='https://yintong.com.cn/llpayh5/authpay.htm' method='post'>");
            sbHtml.Append("<input type='hidden' name='req_data' value='" + req_data1 + "' />");
            //submit按钮控件请不要含有name属性
            sbHtml.Append("<input type='submit' value='tijiao' style='display:none;'></form>");
            sbHtml.Append("<script>document.forms['payBillForm'].submit();</script>");
            string sHtmlText = sbHtml.ToString();
            Response.Write(sHtmlText);
           %>
</body>
</html>
