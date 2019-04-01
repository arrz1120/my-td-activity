﻿<%@ WebHandler Language="C#"  Class="TuanDai.WXApiWeb.ajaxCross.ajax_mall" %>
using System.Data;
using BusinessDll;
using BusinessDll.Model;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Tool;
using TuanDai.PortalSystem.Model;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;
using TuanDai.VipSystem.Model.Entities;
using TuanDai.ZKHelper;
using TuanDai.UserPrizeNew.Client;
using TuanDai.UserPrizeNew.ServiceClient.Models;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// ajax_mall 的摘要说明(商城)
    /// </summary>
    public class ajax_mall : SafeHandlerBase
    {
        string baseUrlString = System.Configuration.ConfigurationManager.AppSettings["OtherApiWebUrl"];  //第三方接口地址

        /// <summary>
        /// 获取商品列表
        /// </summary>
        public void GetProductList()
        {
            int pageIndex = Tool.SafeConvert.ToInt32(GetRequestData("pageIndex"), 1);
            int pageSize = Tool.SafeConvert.ToInt32(GetRequestData("pageSize"), 8);
            //是否实物奖品 1是实物,0虚拟 -1所有
            int goodsType = Tool.SafeConvert.ToInt32(GetRequestData("goodsType"), -1);
            //0团币数量,1兑换数量,2上架时间
            int sortFiled = Tool.SafeConvert.ToInt32(GetRequestData("sortFiled"), 0);
            //1升序 0降序
            int order = Tool.SafeConvert.ToInt32(GetRequestData("order"), 0);
            bool? interior = null;
            string[] subType = null;
            if (!string.IsNullOrEmpty(GetRequestData("type")))
            {
                subType = GetRequestData("type").Split(',');
            }
            if (!string.IsNullOrEmpty(GetRequestData("inter")))
            {
                int _inter = Tool.SafeConvert.ToInt32(GetRequestData("inter"), 0);
                if (_inter == 1) interior = true;
            }
            bool? IsGood = null;
            if (goodsType == 1)
            {
                IsGood = true;
            }
            else if (goodsType == 0)
            {
                IsGood = false;
            }
            string SortBy = string.Empty;
            SortAction action = SortAction.Desc;
            if (sortFiled == 0)
            {
                if (order == 0)
                {
                    SortBy = "PriceValue";
                    action = SortAction.Desc;
                }
                else
                {
                    SortBy = "PriceValue";
                    action = SortAction.Asc;
                }

            }
            else if (sortFiled == 1)
            {
                if (order == 0)
                {
                    SortBy = "SaleCounts";
                    action = SortAction.Desc;
                }
                else
                {
                    SortBy = "SaleCounts";
                    action = SortAction.Asc;
                }
            }
            else
            {
                if (order == 0)
                {
                    SortBy = "UpsellingDate";
                    action = SortAction.Desc;
                }
                else
                {
                    SortBy = "UpsellingDate";
                    action = SortAction.Asc;
                }
            }

            ProductViewQuery param = new ProductViewQuery()
            {
                PageIndex = pageIndex,
                PageSize = pageSize,
                Upselling = true,
                Type = 1,
                IsGoods = IsGood,
                SortBy = SortBy,
                SortOrder = action,
                SubType = subType,
                Interior = interior

            };
            DbQueryResult result = MVipProductBLL.GetVipProduct(param);
            List<ProductViewModel> Datas = new List<ProductViewModel>();
            if (result.Data != null)
            {
                foreach (var en in ((List<MVipProduct>)result.Data))
                {
                    Datas.Add(new ProductViewModel()
                    {
                        ProductName = en.ProductName,
                        SkuId = en.SkuId,
                        Id = en.Id,
                        SaleCounts = en.SaleCounts,
                        PriceValue = en.PriceValue,
                        ImageUrl = en.BigImageUrl,
                        IsJoin = en.IsJoin,
                        BuyingPrice = en.BuyingPrice,
                        BuyingEndDate = en.BuyingEndDate.ToString(),
                        BuyingStartDate = en.BuyingStartDate.ToString(),
                        IsDone = en.IsDone,
                        Stock = en.Stock.HasValue ? en.Stock.Value : 0,
                        LeastLevel = en.LeastLevel
                    });
                }
            }
            ProductListResult viewModel = new ProductListResult()
            {
                Status = 1,
                Msg = "获取成功",
                TotalRecords = result.TotalRecords,
                Data = Datas
            };

            PrintJson(viewModel);
        }

        /// <summary>
        /// 获取兑换记录
        /// </summary>
        public void GetSaleRecord()
        {
            Guid productid = Guid.Parse(GetRequestData("productid"));
            int pageIndex = Tool.SafeConvert.ToInt32(GetRequestData("pageIndex"), 1);
            int pageSize = Tool.SafeConvert.ToInt32(GetRequestData("pageSize"), 8);

            //查询兑换记录
            var dbResult = MVipExchangeHistoryBLL.GetVipExchangeHistory(new ExchangeHistoryQuery()
            {
                PageIndex = pageIndex,
                PageSize = pageSize,
                SourceFlag = (int)SourceFlagEnums.FromExChange,
                ProductId = productid
            });

            PrintJson(dbResult);
        }

        //获取表单请求数据
        protected string GetRequestData(string fieldName)
        {
            return WEBRequest.GetString(fieldName);
        }

        /// <summary>
        /// 获取城市列表
        /// </summary>
        public void GetCityList()
        {
            AddressInfoList cityList = new AddressInfoList();
            int proid = Tool.SafeConvert.ToInt32(GetRequestData("proid"), 1);
            string sqlText =
                @"SELECT m_CityID AS ProId,m_CityName AS ProName FROM dbo.t_Mall_City with(nolock) WHERE m_ProId=@m_ProId";
            var para = new Dapper.DynamicParameters();
            para.Add("@m_ProId", proid);
            cityList.addrList = TuanDai.DB.TuanDaiDB.Query<AddressInfo>(TdConfig.DBRead,
                sqlText, ref para);
            if (cityList.addrList.Count > 0)
            {
                cityList.Status = 1;
                cityList.Msg = "获取城市列表成功";
            }
            else
            {
                cityList.Status = 0;
                cityList.Msg = "获取城市列表失败";
            }

            PrintJson(cityList);
        }

        /// <summary>
        /// 获取区域列表
        /// </summary>
        public void GetAreaList()
        {
            AddressInfoList cityList = new AddressInfoList();
            int proid = Tool.SafeConvert.ToInt32(GetRequestData("proid"), 1);
            string sqlText =
                @"SELECT m_Id AS ProId,m_DisName AS ProName FROM dbo.t_Mall_District with(nolock) WHERE m_CityID=@m_CityID";
            var para = new Dapper.DynamicParameters();
            para.Add("@m_CityID", proid);
            cityList.addrList = TuanDai.DB.TuanDaiDB.Query<AddressInfo>(TdConfig.DBRead,
                sqlText, ref para);
            if (cityList.addrList.Count > 0)
            {
                cityList.Status = 1;
                cityList.Msg = "获取区域列表成功";
            }
            else
            {
                cityList.Status = 0;
                cityList.Msg = "获取区域列表失败";
            }

            PrintJson(cityList);
        }

        /// <summary>
        /// 添加地址
        /// </summary>
        public void AddAddr()
        {
            BaseResult resultModel = new BaseResult();
            if (WebUserAuth.UserId == Guid.Empty || WebUserAuth.UserId == null)
            {
                resultModel.Status = -99;
                resultModel.Msg = "未登录";
                PrintJson(resultModel);
                return;
            }
            Guid id = Guid.NewGuid();
            string Receiver = Context.Request["name"].ToString();
            string TelNo = Context.Request["phone"].ToString();
            string Privince = Context.Request["province"].ToString();
            string City = Context.Request["city"].ToString();
            string Area = Context.Request["area"].ToString();
            string Address = Context.Request["address"].ToString();
            string ZipCode = "";
            //var IsDefault = Context.Request["isDefault"].ToString() == "1"?true:false;
            if (string.IsNullOrEmpty(Receiver))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，收件人不能为空";
                PrintJson(resultModel);
                return;
            }
            if (string.IsNullOrEmpty(TelNo))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，收件人电话";
                PrintJson(resultModel);
                return;
            }
            if (string.IsNullOrEmpty(Privince))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，省不能为空";
                PrintJson(resultModel);
                return;
            }
            if (string.IsNullOrEmpty(City))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，市不能为空";
                PrintJson(resultModel);
                return;
            }
            if (string.IsNullOrEmpty(Area))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，区不能为空";
                PrintJson(resultModel);
                return;
            }
            if (string.IsNullOrEmpty(Address))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，收货地址不能为空";
                PrintJson(resultModel);
                return;
            }
            try
            {
                MUserShippingAddressesBLL bll = new MUserShippingAddressesBLL();
                var address = bll.GetMUserShippingAddressesByUserId(Guid.Parse(WebUserAuth.UserId.ToString()));
                if (address != null && address.Count >= 6)
                {
                    resultModel.Status = -2;
                    resultModel.Msg = "一个用户最多6个收货地址";
                    PrintJson(resultModel);
                    return;
                }
                MUserShippingAddresses defAddr = null;
                if (address != null)
                    defAddr = address.Where(o => o.IsDefault == true).FirstOrDefault();

                MUserShippingAddresses model = new MUserShippingAddresses();
                model.Id = id;
                model.Privince = int.Parse(Privince);
                model.City = int.Parse(City);
                model.Area = int.Parse(Area);
                model.CellPhone = TelNo;
                model.Address = Address;
                model.UserId = WebUserAuth.UserId.Value;
                model.ZipCode = ZipCode;
                model.IsDefault = defAddr == null ? true : false;
                model.ShipTo = Receiver;
                int result = bll.AddMUserShippingAddresses(model);
                if (result > 0)
                {
                    resultModel.Status = 1;
                    resultModel.Msg = "";
                    PrintJson(resultModel);
                }
                else
                {
                    resultModel.Status = 0;
                    resultModel.Msg = "添加地址失败，请联系网站客服处理！";
                    PrintJson(resultModel);
                    return;
                }
            }
            catch (Exception ex)
            {
                NetLog.WriteLoginHandler("AddAddress", "ex.message:" + ex.Message + "|ex.StackTrace:" + ex.StackTrace);
                resultModel.Status = -1;
                resultModel.Msg = "添加地址失败，请联系网站客服处理！";
                PrintJson(resultModel);
                return;
            }
        }
        /// <summary>
        /// 更改收货地址
        /// </summary>
        /// <param name="Context"></param>
        public void UpdateAddr()
        {
            BaseResult resultModel = new BaseResult();
            if (WebUserAuth.UserId == Guid.Empty)
            {
                resultModel.Status = -99;
                resultModel.Msg = "未登录";
                PrintJson(resultModel);
                return;
            }
            Guid id = Guid.Parse(Context.Request["id"].ToString());
            string Receiver = Context.Request["name"].ToString();
            string TelNo = Context.Request["phone"].ToString();
            string Privince = Context.Request["province"].ToString();
            string City = Context.Request["city"].ToString();
            string Area = Context.Request["area"].ToString();
            string Address = Context.Request["address"].ToString();
            if (string.IsNullOrEmpty(Receiver))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，收件人不能为空";
                PrintJson(resultModel);
                return;
            }
            if (string.IsNullOrEmpty(TelNo))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，收件人电话";
                PrintJson(resultModel);
                return;
            }
            if (string.IsNullOrEmpty(Privince))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，省不能为空";
                PrintJson(resultModel);
                return;
            }
            if (string.IsNullOrEmpty(City))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，市不能为空";
                PrintJson(resultModel);
                return;
            }
            if (string.IsNullOrEmpty(Area))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，区不能为空";
                PrintJson(resultModel);
                return;
            }
            if (string.IsNullOrEmpty(Address))
            {
                resultModel.Status = -1;
                resultModel.Msg = "信息不全，收货地址不能为空";
                PrintJson(resultModel);
                return;
            }

            try
            {
                MUserShippingAddressesBLL bll = new MUserShippingAddressesBLL();
                MUserShippingAddresses model = bll.GetMUserShippingAddressesById(id);
                model.Privince = int.Parse(Privince);
                model.City = int.Parse(City);
                model.Area = int.Parse(Area);
                model.CellPhone = TelNo;
                model.Address = Address;
                model.ShipTo = Receiver;
                model.Id = id;
                int result = bll.UpdateMUserShippingAddresses(model);
                if (result > 0)
                {
                    resultModel.Status = 1;
                    resultModel.Msg = "";
                    PrintJson(resultModel);
                }
                else
                {
                    resultModel.Status = 0;
                    resultModel.Msg = "修改地址失败，请联系网站客服处理！";
                    PrintJson(resultModel);
                    return;
                }
            }
            catch (Exception ex)
            {
                NetLog.WriteLoginHandler("UpdateAddress", "ex.message:" + ex.Message + "|ex.StackTrace:" + ex.StackTrace);
                resultModel.Status = -1;
                resultModel.Msg = "修改地址失败，请联系网站客服处理！";
                PrintJson(resultModel);
                return;
            }
        }
        /// <summary>
        /// 设置默认地址
        /// </summary>
        public void SetDefault()
        {
            BaseResult br = new BaseResult();
            string id = Context.Request["id"].ToString();
            string userid = WebUserAuth.UserId.Value.ToString();
            if (string.IsNullOrEmpty(id) || string.IsNullOrEmpty(userid))
            {
                br.Status = 0;
                br.Msg = "设置失败，请重试";
                PrintJson(br);
                return;
            }
            MUserShippingAddressesBLL bll = new MUserShippingAddressesBLL();
            br.Status = bll.SetDefualt(id, userid);
            if (br.Status > 0)
            {
                br.Status = 1;
                br.Msg = "设置成功";
                PrintJson(br);
                return;
            }
            else
            {
                br.Status = 0;
                br.Msg = "设置失败，请重试";
                PrintJson(br);
                return;
            }
        }
        /// <summary>
        /// 删除地址
        /// </summary>
        public void DeleteAddr()
        {
            BaseResult br = new BaseResult();
            string id = Context.Request["id"].ToString();
            if (string.IsNullOrEmpty(id))
            {
                br.Status = 0;
                br.Msg = "删除失败，请重试";
                PrintJson(br);
                return;
            }
            var isFlag = MUserShippingAddressesBLL.DeleteUserShippingAddress(Guid.Parse(id));
            if (isFlag)
            {
                br.Status = 1;
                br.Msg = "删除成功";
                PrintJson(br);
                return;
            }
            else
            {
                br.Status = 0;
                br.Msg = "删除失败，请重试";
                PrintJson(br);
                return;
            }
        }
        /// <summary>
        /// 取得地址
        /// </summary>
        public void GetAddress()
        {
            string addrId = Context.Request["addrid"].ToString();
            if (!string.IsNullOrEmpty(addrId))
            {
                MUserShippingAddressesBLL bll = new MUserShippingAddressesBLL();
                var Address = bll.GetMUserShippingAddressesById(Guid.Parse(addrId));
                Address.TelPhone = bll.GetPrivinceById(Convert.ToString(Address.Privince)) +
                                   bll.GetCityById(Convert.ToString(Address.City)) +
                                   bll.GetAreaById(Convert.ToString(Address.Area));//此处暂时用作存省市县
                PrintJson(Address);
            }
            else
            {
                PrintJson("0", "获取地址失败");
            }
        }

        /// <summary>
        ///兑换商品提交
        ///返回:-99未登录
        ///--1保存成功,-1程序异常,-2会员信息不存在,-3团币不足,-4异动团币数据失败,-99未登录，-5商品信息不存在，-6收货地址不能为空，-7商品已经下架无法兑换
        /// </summary>
        /// <param name="context"></param>
        public void ExchangeSubmit()
        {
            ExchangeResult resultModel = new ExchangeResult();
            if (WebUserAuth.UserId == Guid.Empty && WebUserAuth.UserId.Value == Guid.Empty)
            {
                resultModel.Status = -99;
                resultModel.Msg = "未登录";
                PrintJson(resultModel);
                return;
            }
            MUserVipInfo userVipInfo = MUserVipInfoBLL.GetUserVipInfoById(Guid.Parse(WebUserAuth.UserId.ToString()));
            //会员是否存在
            if (userVipInfo == null)
            {
                resultModel.Status = -2;
                resultModel.Msg = "会员信息不存在";
                PrintJson(resultModel);
                return;
            }
            string addressId = GetRequestData("AddressId");
            string address = string.Empty;
            string productId = GetRequestData("ProductId");
            string skuId = GetRequestData("SkuId");
            string userNote = GetRequestData("UserNote");
            string exChangeNum = GetRequestData("Num");
            string telNo = GetRequestData("TelNo");
            //检查商品是否存在
            MVipProduct vipProduct = MVipProductBLL.GetVipProductBySkuId(Guid.Parse(skuId));
            if (vipProduct == null)
            {
                resultModel.Status = -5;
                resultModel.Msg = "商品信息不存在";
                PrintJson(resultModel);
                return;
            }
            if (!vipProduct.Upselling)
            {
                resultModel.Status = -9;
                resultModel.Msg = "商品已经下架";
                PrintJson(resultModel);
                return;
            }
            //增加兑换数量的判断（以前的写法太不严谨了）
            int o;
            if (!int.TryParse(exChangeNum, out o))
            {
                resultModel.Status = -9;
                resultModel.Msg = "兑换数量不正确";
                PrintJson(resultModel);
                return;
            }
            if (Convert.ToInt32(exChangeNum) <= 0 || Convert.ToInt32(exChangeNum) > 300)
            {
                resultModel.Status = -1;
                resultModel.Msg = "兑换失败";
                PrintJson(resultModel);
                return;
            }
            //新增库存检测
            if (!CheckProductStock(skuId, Convert.ToInt32(exChangeNum), vipProduct.Id))
            {
                resultModel.Status = -9;
                resultModel.Msg = "商品库存不足";
                PrintJson(resultModel);
                return;
            }
            //新增每日兑换数量限制
            int limitNum = 0;
            int leftNum = CheckLeftNum(userVipInfo.UserId, vipProduct.Id, out limitNum);
            if (leftNum != -1 && Convert.ToInt32(exChangeNum) > leftNum)  //做了限制，并且兑换数量大于剩下的兑换数量时
            {
                resultModel.Status = -9;
                resultModel.Msg = "亲，今日您的兑换数量已达上限啦，</br>该商品每人每天只能兑换" + limitNum + "件";
                PrintJson(resultModel);
                return;
            }

            //新增最低等级限制
            int leavel = GetLeastLevel(vipProduct.Id);
            if (userVipInfo.Level < leavel)
            {
                resultModel.Status = -9;
                resultModel.Msg = "很抱歉，此商品仅限V" + leavel + "以上用户参与兑换";
                PrintJson(resultModel);
                return;
            }

            if (vipProduct.SubType == 22 || vipProduct.SubType == 25)
            {
                //每天限制为白天08：00-22：00  
                if ((DateTime.Now.Hour < 8 || DateTime.Now.Hour >= 22))
                {
                    resultModel.Status = -9;
                    resultModel.Msg = "请于每天08：00-22：00兑换";
                    PrintJson(resultModel);
                    return;
                }
                if (Convert.ToInt32(exChangeNum) > 1)
                {
                    resultModel.Status = -8;
                    resultModel.Msg = "每次只能兑换一张";
                    PrintJson(resultModel);
                    return;
                }

                if (string.IsNullOrEmpty(userVipInfo.TelNo))
                {
                    resultModel.Status = -9;
                    resultModel.Msg = "请先完善手机号码";
                    PrintJson(resultModel);
                    return;
                }
                try
                {
                    decimal.ToInt32(vipProduct.PrizeValue.Value);
                }
                catch (Exception)
                {
                    resultModel.Status = -11;
                    resultModel.Msg = "商品价值不正确";
                    PrintJson(resultModel);
                    return;
                }

                if (vipProduct.SubType == 22) //话费
                {
                    if (IsExchangeProduct(22))  //如果已经兑换过
                    {
                        resultModel.Status = -9;
                        resultModel.Msg = "每天只能兑换一张";
                        PrintJson(resultModel);
                        return;
                    }
                }
                else if (vipProduct.SubType == 25) //流量包
                {
                    if (IsExchangeProduct(25))  //如果已经兑换过
                    {
                        resultModel.Status = -9;
                        resultModel.Msg = "每天只能兑换一张";
                        PrintJson(resultModel);
                        return;
                    }

                    if (GetFlowBalance() == 0)
                    {
                        resultModel.Status = -9;
                        resultModel.Msg = "团贷网流量包余额不足，请联系工作人员";
                        PrintJson(resultModel);
                        return;
                    }

                    string phoneArea = GetPhoneArea(userVipInfo.TelNo);
                    if (phoneArea == "UNICOM")  //联通号码，每个月最多只能充值5次
                    {
                        int unionCount = GetUnicomCount();
                        if (unionCount >= 5)
                        {
                            resultModel.Status = -9;
                            resultModel.Msg = "联通号码每个月最多只能兑换5次";
                            PrintJson(resultModel);
                            return;
                        }
                    }
                }
            }
            else if (vipProduct.SubType == 28)   //第三方虚拟商品
            {
                if (Convert.ToInt32(exChangeNum) > 1)
                {
                    resultModel.Status = -8;
                    resultModel.Msg = "每次只能兑换一张";
                    PrintJson(resultModel);
                    return;
                }
            }

            MUserShippingAddresses addressModel = new MUserShippingAddresses();
            if (vipProduct.SubType == (int)ProductEnums.Goods || vipProduct.SubType == 29)
            {
                if (addressId.IsEmpty())
                {
                    resultModel.Status = -6;
                    resultModel.Msg = "收货地址不能为空";
                    PrintJson(resultModel);
                    return;
                }
                var addrBll = new MUserShippingAddressesBLL();
                addressModel = addrBll.GetMUserShippingAddressesById(Guid.Parse(addressId));
                if (addressModel == null)
                {
                    resultModel.Status = -6;
                    resultModel.Msg = "收货地址不能为空";
                    PrintJson(resultModel);
                    return;
                }
                address = addrBll.GetPrivinceById(Convert.ToInt32(addressModel.Privince) + "") + addrBll.GetCityById(Convert.ToInt32(addressModel.City) + "") + addrBll.GetAreaById(Convert.ToInt32(addressModel.Area) + "") + addressModel.Address;
            }

            Guid ExchangeId = Guid.NewGuid();

            //如果是
            var priceValue = vipProduct.ProductValues.FirstOrDefault().PriceValue;
            priceValue = GetProductPrice(vipProduct, priceValue);
            resultModel.ValidTuanBi = userVipInfo.ValidTuanBi;
            if (Math.Abs(Int32.Parse(exChangeNum)) * priceValue > userVipInfo.ValidTuanBi
                || Int32.Parse(exChangeNum) * priceValue <= 0)
            {
                resultModel.Status = -3;
                resultModel.Msg = "团币不足";
                PrintJson(resultModel);
                return;
            }
            int[] toUserPrize = { (int)ProductEnums.WithDrawalCoupon, (int)ProductEnums.NormalRedPacket, (int)ProductEnums.CashRedPacket, (int)ProductEnums.CashRedPackage, (int)ProductEnums.InvestATighteningRatesTicket, 6 };
            //判断是否是团宝箱商品
            int status = 1;
            //如果是会员或者团宝箱商品都是已发货
            if (Array.IndexOf(toUserPrize, vipProduct.SubType) != -1 || vipProduct.SubType == (int)ProductEnums.VIP)
            {
                status = 2;
            }

            bool result = true;

            //添加成功则扣减团币值
            if (result)
            {
                int _outStatus = -1;
                string _outMsg = string.Empty;
                if (Int32.Parse(exChangeNum) < 0)
                {
                    resultModel.Status = -3;
                    resultModel.Msg = "团币不足";
                    PrintJson(resultModel);
                    return;
                }
                string sqlText = string.Format(@"P_ExchangeProduct");
                var paras = new Dapper.DynamicParameters();

                paras.Add("@ExchangeId", ExchangeId);
                paras.Add("@UserId", userVipInfo.UserId);
                paras.Add("@UserName", userVipInfo.UserName);
                paras.Add("@Remark", "m.tuandai");
                paras.Add("@SkuId", Guid.Parse(skuId));
                paras.Add("@ProductId", vipProduct.Id);
                paras.Add("@Address", address);
                paras.Add("@TotalNum", Int32.Parse(exChangeNum));
                paras.Add("@TotalTuanBi", Int32.Parse(exChangeNum) * priceValue);
                paras.Add("@ProductName", vipProduct.ProductName);
                paras.Add("@SourceFlag", (int)SourceFlagEnums.FromExChange);
                paras.Add("@Status", status);
                paras.Add("@UserNote", userNote);
                paras.Add("@ReceiveDate", DateTime.Now);
                paras.Add("@TelNo", addressModel.CellPhone);
                paras.Add("@AttributeDesc", vipProduct.ProductValues == null ? "" : string.Join(",", vipProduct.ProductValues.Select(en => en.ValueStr).ToArray()));
                paras.Add("@ShipTo", string.IsNullOrEmpty(addressModel.ShipTo) ? userVipInfo.NickName : addressModel.ShipTo);
                paras.Add("@ProductImageUrl", vipProduct.BigImageUrl);
                paras.Add("@SubTypeId", 52);
                paras.Add("@OutStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
                paras.Add("@OutMsg", 0, System.Data.DbType.String, System.Data.ParameterDirection.Output, 100);

                TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBVipWrite, sqlText, ref paras, System.Data.CommandType.StoredProcedure);
                _outStatus = paras.Get<int>("OutStatus");
                _outMsg = paras.Get<string>("OutMsg");
                if (_outStatus != 1)
                {
                    resultModel.Status = _outStatus;
                    resultModel.Msg = _outMsg;
                    PrintJson(resultModel);
                    return;
                }

                //更新库存
                if (!UpdateProductStock(skuId, Convert.ToInt32(exChangeNum)))
                {
                    resultModel.Status = -9;
                    resultModel.Msg = "商品库存不足";
                    PrintJson(resultModel);
                    return;
                }

                //先扣团币，再充,但是充值卡和流量包不用第三方如玩积分这类，而是直接和充值卡公司（开心果）对接
                if (vipProduct.SubType == 22 || vipProduct.SubType == 25)  //22话费,以后还会有： 25流量包 26 油卡
                {
                    string postResult = string.Empty;
                    string urlString = baseUrlString;
                    if (vipProduct.SubType == 22) //话费
                    {
                        urlString += "/PhoneRecharge/PostVipRechargFare";
                    }
                    else if (vipProduct.SubType == 25)  //流量
                    {
                        urlString += "/MingZhuanWuXian/PostVipRechargeFlow";
                    }
                    string jsonString = string.Empty;
                    string tokenString = string.Empty;
                    try
                    {
                        jsonString = string.Empty;
                        if (vipProduct.SubType == 22)  //话费
                        {
                            jsonString = TuanDai.WXSystem.Core.JsonHelper.ToJson(new { RechargeId = ExchangeId, TelNo = userVipInfo.TelNo, Amount = (int)vipProduct.PrizeValue.Value });
                        }
                        else if (vipProduct.SubType == 25)  //流量
                        {
                            jsonString = TuanDai.WXSystem.Core.JsonHelper.ToJson(new { linkid = ExchangeId, action = "charge", phone = userVipInfo.TelNo, mbytes = "500" });  //这里暂时写死了500，因为电信联通移动只有500M是都有的
                        }
                        tokenString = MD5_Hash(jsonString);
                        postResult = Tool.HttpUtils.HttpPost(urlString + "?jsonString=" + jsonString + "&token=" + tokenString, null, 60);
                        if (vipProduct.SubType == 22)
                        {
                            if (!postResult.Contains("\"ret_code\":\"10000000\",\"ret_msg\":\"交易成功\""))   //调用接口不成功（供应方接口错误等）
                            {
                                NetLog.WriteLoginHandler("PostVipRechargFareError", "调用开心果充值接口错误，供应方接口错误:" + postResult.Replace("\"", "|") + ",接口地址是：" + urlString + "?jsonString=" + jsonString + "&token=" + tokenString, "触屏版");
                            }
                            else
                            {
                                NetLog.WriteLoginHandler("PostVipRechargFareSuccess", "号码：" + userVipInfo.TelNo + "，" + (int)vipProduct.PrizeValue + "元话费充值成功", "触屏版");
                            }
                        }
                        else if (vipProduct.SubType == 25)
                        {
                            FlowResult flowResult = TuanDai.WXSystem.Core.JsonHelper.ToObject<FlowResult>(postResult);
                            if (flowResult.Return == "0")  //充值流量成功
                            {
                                NetLog.WriteLoginHandler("PostVipRechargeFlowSuccess", "号码：" + userVipInfo.TelNo + "，500M流量充值成功", "触屏版");
                            }
                            else //充值流量失败
                            {
                                NetLog.WriteLoginHandler("PostVipRechargeFlowError", "调用明传流量充值接口错误，供应方接口错误:" + postResult.Replace("\"", "|") + ",接口地址是：" + urlString + "?jsonString=" + jsonString + "&token=" + tokenString, "触屏版");
                            }
                        }

                    }
                    catch (Exception ex)    //调用接口错误（地址错误等）
                    {
                        if (vipProduct.SubType == 22)
                        {
                            NetLog.WriteLoginHandler("PostVipRechargFareError", "兑换充值卡内部接口错误，参数不正确,ex.Message:" + ex.Message + ",ex.StackTrace:" + ex.StackTrace + "，接口地址是：" + urlString + "?jsonString=" + jsonString + "&token=" + tokenString, "触屏版");
                        }
                        else if (vipProduct.SubType == 25)
                        {
                            NetLog.WriteLoginHandler("PostVipRechargeFlowError", "兑换流量内部接口错误，参数不正确,ex.Message:" + ex.Message + ",ex.StackTrace:" + ex.StackTrace + "，接口地址是：" + urlString + "?jsonString=" + jsonString + "&token=" + tokenString, "触屏版");
                        }
                    }
                }
                else if (vipProduct.Type == 1 && vipProduct.ProductSource != "0" && !string.IsNullOrEmpty(vipProduct.ProductSource))   //第三方（玩积分等）商品
                {
                    //发起订单请求                              
                    string orderNo = string.Empty;
                    string productECouponNo = string.Empty;  //第三方虚拟商品密码
                    bool orderResult = false;
                    orderResult = CheckWJFStock(vipProduct.ProductCode, Guid.Parse(skuId), vipProduct.ProductName, Convert.ToInt32(exChangeNum));
                    if (orderResult)
                    {
                        if (vipProduct.SubType == 29)   //实物商品
                        {
                            orderResult = StartEntityOrder(address, vipProduct.Score, ExchangeId, addressModel.CellPhone, string.IsNullOrEmpty(addressModel.ShipTo) ? userVipInfo.NickName : addressModel.ShipTo, vipProduct.ProductCode, Convert.ToInt32(exChangeNum), out orderNo, userNote);
                        }
                        else if (vipProduct.SubType == 28) //28第三方虚拟商品
                        {
                            orderResult = StartVirtualOrder(vipProduct.Score, ExchangeId, vipProduct.ProductCode, Convert.ToInt32(exChangeNum), out orderNo, out productECouponNo);
                        }
                    }

                    //更新兑换历史表里面的订单号码和状态     
                    if (orderResult)
                    {
                        MVipExchangeHistory orderHistory = new MVipExchangeHistoryBLL().GetMVipExchangeHistoryById(ExchangeId);
                        orderHistory.OrderNo = orderNo;
                        orderHistory.ECouponNo = productECouponNo;
                        orderHistory.OrderStatus = "1";   //订单状态是1 和2，玩积分的没有0 的
                        if (!string.IsNullOrEmpty(productECouponNo) && vipProduct.SubType == 28)   //如果是虚拟商品，则状态全部为已领取
                        {
                            orderHistory.UsAge = vipProduct.Remark1;    //使用描述    
                            if (vipProduct.EndTime.HasValue)
                            {
                                orderHistory.ValidDateDesc = vipProduct.EndTime.Value.ToString();
                                orderHistory.ExpireDate = vipProduct.EndTime.Value;
                            }

                            orderHistory.Status = 2;
                        }
                        int resCount = new MVipExchangeHistoryBLL().UpdateMVipExchangeHistory(orderHistory);
                        if (resCount <= 0)
                        {
                            NetLog.WriteLoginHandler("UpdateMVipExchangeHistory", "更新兑换的第三方商品的电子密码错误，兑换id：" + ExchangeId, "触屏版");
                        }
                    }
                    else   //订单失败，回滚
                    {
                        RockBackOrder(ExchangeId, userVipInfo.UserId, Int32.Parse(exChangeNum) * priceValue, Int32.Parse(exChangeNum), vipProduct.Id);
                        resultModel.Status = -9;
                        resultModel.Msg = "兑换失败，请联系团贷网客服人员!";
                        PrintJson(resultModel);
                        return;
                    }
                }

                //团宝箱商品
                if (Array.IndexOf(toUserPrize, vipProduct.SubType) != -1
                    && vipProduct.UserPrize_Activity_Id != Guid.Empty
                    && vipProduct.UserPrize_Activity_Id != null)
                {
                    string desc = "团贷会员商品兑换 ";
                    if (vipProduct.SubType == (int)ProductEnums.NormalRedPacket)
                    {
                        desc += "(单笔投资金额满" + vipProduct.PrizeValue * 100 * 2 + "元可使用，限投1个月及以上的非债权转让标)";
                    }
                    else if (vipProduct.SubType == (int)ProductEnums.WithDrawalCoupon)
                    {
                        desc += vipProduct.ProductName + "(每次提现限使用一张，不设找零，使用期限1个月)";
                    }
                    else if (vipProduct.SubType == (int)ProductEnums.VIP)
                    {
                        desc = "团贷会员商品兑换";
                    }
                    else if (vipProduct.SubType == 6 && vipProduct.Type == 1)  //补签卡
                    {
                        desc = "团贷会员商品兑换";
                    }
                    else if (vipProduct.SubType == 18 && vipProduct.Type == 1)
                    {
                        //先读取团宝箱规则，然后拼接
                        string getRuleIdErrMsg = string.Empty;
                        TuanDai.UserPrizeNew.ServiceClient.Models.UserPrizeActivityInfo ruleModel = new TuanDai.UserPrizeNew.Client.UserPrizeActivityClient(TdConfig.ApplicationName).GetUserPrizeActivity(Guid.Parse(vipProduct.UserPrize_Activity_Id.ToString()), "", out getRuleIdErrMsg);
                        desc += GetRuleDescription(ruleModel);
                    }

                    int outStatus = 0;
                    bool sendResult = SendUserPrize(new UserPrizeSendRequest()  //这里需要修改
                    {
                        UserId = userVipInfo.UserId,
                        PrizeName = vipProduct.ProductName,
                        PrizeValue = GetDenomination(vipProduct),
                        TargetProductId = null,
                        RuleId = Guid.Parse(vipProduct.UserPrize_Activity_Id.ToString()),
                        Description = desc
                    }, Int32.Parse(exChangeNum), ref outStatus);
                    if (!sendResult)
                    {
                        //发送团宝箱失败
                        MVipExchangeHistoryBLL.AddRemark("发送团宝箱失败", outStatus + "", ExchangeId);
                    }
                }
                else if (vipProduct.SubType == (int)ProductEnums.VIP)
                {
                    //兑换会员
                    List<MSiteConfig> siteConfigList = new List<MSiteConfig>();
                    siteConfigList = MSiteConfigBLL.GetSiteConfig();
                    int month = 0;
                    var config = siteConfigList.Where(en => en.Value.ToUpper() == vipProduct.Id.ToString().ToUpper()).FirstOrDefault();
                    if (config != null)
                    {
                        if (config.Key == "2001")
                        {
                            month = 1 * Int32.Parse(exChangeNum);
                        }
                        else if (config.Key == "2002")
                        {
                            month = 6 * Int32.Parse(exChangeNum);
                        }
                        else if (config.Key == "2003")
                        {
                            month = 12 * Int32.Parse(exChangeNum);
                        }
                    }
                    int outStatus = 0;
                    bool exchangeResult = ExchangeSuperVip(ExchangeId, userVipInfo.UserId, month, ref outStatus);
                    if (!exchangeResult)
                    {
                        if (!exchangeResult)
                        {
                            //发送超级会员失败
                            MVipExchangeHistoryBLL.AddRemark("兑换超级会员失败", outStatus + "", ExchangeId);
                        }
                    }
                }
            }
            else
            {
                resultModel.Status = -1;
                resultModel.Msg = "兑换失败";
                PrintJson(resultModel);
                return;
            }
            resultModel.Status = 1;
            resultModel.Msg = "兑换成功";
            resultModel.ExchangeId = ExchangeId;
            PrintJson(resultModel);
        }

        #region 兑换超级会员
        protected bool ExchangeSuperVip(Guid ExchangeId, Guid UserId, int Months, ref int outStatus)
        {
            try
            {
                string sqlText = @"p_GiveMember";
                //using (SqlConnection connection = TuanDai.PortalSystem.DAL.PubConstant.CrateConnection())
                //{
                var paras = new Dapper.DynamicParameters();
                paras.Add("@userid", UserId);
                paras.Add("@type", 9);
                paras.Add("@desc", "团币兑换超级会员");
                paras.Add("@months", Months);
                paras.Add("@handlerUserId", ExchangeId);
                paras.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
                //SqlMapper.Execute(connection, sqlText, paras, null, null, System.Data.CommandType.StoredProcedure);
                //connection.Close();
                //connection.Dispose();
                TuanDai.DB.TuanDaiDB.Execute(TdConfig.DBUserWrite, sqlText, ref paras, CommandType.StoredProcedure);
                outStatus = paras.Get<int>("@outStatus");
                //}

                if (outStatus == 1)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        #endregion

        #region 发送团宝箱

        /// <summary>
        /// 发团宝箱，如果返回false，则发团宝箱失败，回滚抽奖操作
        /// </summary>
        /// <returns></returns>
        protected bool SendUserPrize(UserPrizeSendRequest request, int num, ref int outStatus)
        {
            try
            {
                for (int i = 0; i < num; i++)
                {

                    //新的发送团宝箱的方法                   
                    string errorMsg = string.Empty;
                    Guid? successId = new UserPrizeSendClient(TdConfig.ApplicationName).SendUserPrize(request, out errorMsg);
                    if (successId.HasValue)
                    {
                        outStatus = 1;
                    }
                    else
                    {
                        outStatus = 0;
                    }
                }
                if (outStatus == 1)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        #endregion
        /// <summary>
        /// 获取团币明细
        /// </summary>
        public void GetTuanbiHistory()
        {
            Guid UserId = WebUserAuth.UserId.Value;
            int PageIndex = int.Parse(GetRequestData("pageIndex"));
            int PageSize = int.Parse(GetRequestData("pageSize"));
            int TotalRecode = 0;
            int month = int.Parse(GetRequestData("month"));
            DateTime StartDate = DateTime.Now.AddMonths(-month);
            List<MTuanBiHistoryDetail> tuanBiList = new MTuanBiHistoryDetailBLL().GetListMTuanBiHistoryDetail(UserId, PageIndex, PageSize, ref TotalRecode, StartDate);
            if (tuanBiList != null)
            {
                TuanbiHistoryResult result = new TuanbiHistoryResult { recordCout = TotalRecode, list = tuanBiList, sumTuanbiValue = tuanBiList.Count == 0 ? 0 : tuanBiList[0].AfterTuanBiValue };
                PrintJson(result);
            }
        }

        /// <summary>
        /// 奖品抽奖
        /// 返回值
        /// Status:-99未登录， -1程序异常，-2会员信息不存在，-3团币不足-4团币数据异动失败,-5未绑定手机
        /// SubTypeId:0谢谢参与，1团宝箱商品，2实物奖品，3团币值，4，虚拟商品
        ///// </summary>
        /// <param name="context"></param>
        public void MemberCoinLottery()
        {
            PrizeResult resultModel = new PrizeResult();
            if (WebUserAuth.UserId == Guid.Empty || WebUserAuth.UserId == null)
            {
                resultModel.Status = -99;
                resultModel.Msg = "未登录";
                PrintJson(resultModel);
                return;
            }
            MUserVipInfo userVipInfo = MUserVipInfoBLL.GetUserVipInfoById(Guid.Parse(WebUserAuth.UserId.ToString()));
            //会员是否存在
            if (userVipInfo == null)
            {
                resultModel.Status = -2;
                resultModel.Msg = "会员信息不存在";
                PrintJson(resultModel);
                return;
            }
            if (string.IsNullOrEmpty(userVipInfo.TelNo))
            {
                resultModel.Status = -5;
                resultModel.Msg = "未绑定手机";
                PrintJson(resultModel);
                return;
            }

            var lotteryResult = MVipPrizeHistoryBLL.MemberCoinLottery(userVipInfo.UserId, userVipInfo.NickName);

            if (lotteryResult.OutStatus.Equals(-1))
            {
                resultModel.Status = lotteryResult.OutStatus;
                resultModel.Msg = lotteryResult.OutMsg;
                PrintJson(resultModel);
                return;
            }
            else if (lotteryResult.OutStatus.Equals(-3))
            {
                resultModel.Status = -3;
                resultModel.Msg = "团币不足";
                resultModel.ValidTuanBi = userVipInfo.ValidTuanBi;
                PrintJson(resultModel);
                return;
            }
            int[] toUserPrize = { (int)ProductEnums.WithDrawalCoupon, (int)ProductEnums.NormalRedPacket, (int)ProductEnums.CashRedPacket, (int)ProductEnums.CashRedPackage, (int)ProductEnums.InvestATighteningRatesTicket, 6 };

            //如果抽中团币值
            if (lotteryResult.OutSubTypeId == (int)ProductEnums.TuanBi)
            {
                resultModel.SubTypeId = 3;
            }
            else if (lotteryResult.OutSubTypeId == (int)ProductEnums.NotPrized)
            {
                resultModel.Msg = "谢谢参与";
                resultModel.SubTypeId = 0;
            }
            else if (Array.IndexOf(toUserPrize, lotteryResult.OutSubTypeId) != -1
               && lotteryResult.OutUserPrize_Activity_Id != Guid.Empty
               && lotteryResult.OutUserPrize_Activity_Id != null)
            {
                resultModel.SubTypeId = 1;
                string desc = "团贷会员商品抽奖 ";
                if (lotteryResult.OutSubTypeId == (int)ProductEnums.NormalRedPacket)
                {
                    desc += "(单笔投资金额满" + lotteryResult.OutPrizeValue * 100 * 2 + "元可使用，限投1个月及以上的标)";
                }
                else if (lotteryResult.OutSubTypeId == (int)ProductEnums.WithDrawalCoupon)
                {
                    desc += lotteryResult.OutProductName + "(每次提现限使用一张，不设找零，使用期限1个月)";
                }
                else if (lotteryResult.OutSubTypeId == (int)ProductEnums.VIP)
                {
                    desc = "团贷会员商品抽奖";
                }
                int outStatus = 0;
                bool sendResult = SendUserPrize(new UserPrizeSendRequest()
                {
                    UserId = userVipInfo.UserId,
                    PrizeName = lotteryResult.OutProductName,
                    PrizeValue = lotteryResult.OutPrizeValue,
                    TargetProductId = null,
                    RuleId = Guid.Parse(lotteryResult.OutUserPrize_Activity_Id.ToString()),
                    Description = desc
                }, 1, ref outStatus);
                if (!sendResult)
                {
                    //发送团宝箱失败
                    MVipPrizeHistoryBLL.AddRemark("Remark4", outStatus + "", Guid.Parse(lotteryResult.PrizeRecordId.ToString()));
                }
            }
            else if (lotteryResult.OutSubTypeId == (int)ProductEnums.Goods)
            {
                resultModel.SubTypeId = 2;
            }
            else
            {
                resultModel.SubTypeId = 4;
            }

            //抽奖成功
            resultModel.Status = 1;
            resultModel.PrizeIndex = lotteryResult.OutPrizeIndex;
            resultModel.Msg = lotteryResult.OutProductName;
            resultModel.ValidTuanBi = lotteryResult.OutValidTuanBi;
            resultModel.PrizedCount = lotteryResult.OutPrizedCount;
            resultModel.ProductName = lotteryResult.OutProductName;
            resultModel.PrizeValue = lotteryResult.OutPrizeValue;
            resultModel.PriceValue = lotteryResult.OutPriceValue;
            resultModel.ImageUrl = lotteryResult.OutImageUrl;
            resultModel.ValidPrizeNum = (int)(resultModel.ValidTuanBi / lotteryResult.OutCostTuanBi);


            PrintJson(resultModel);
        }
        /// <summary>
        /// 获取我的商品
        /// </summary>
        public void GetMyProduct()
        {
            if (WebUserAuth.UserId == Guid.Empty)
            {
                PrintJson("-99", "未登录");
                return;
            }
            int pageIndex = Tool.SafeConvert.ToInt32(GetRequestData("pageIndex"), 1);
            int pageSize = Tool.SafeConvert.ToInt32(GetRequestData("pageSize"), 10);
            int status = Tool.SafeConvert.ToInt32(GetRequestData("status"), 0);

            string sqlCount = @"SELECT COUNT(1) FROM [dbo].[MVipExchangeHistory] (nolock) WHERE UserId = @UserID AND SubType <> 55 AND SubType<>20 AND status<>-10 #WHERESQL# ";

            string sqlText = @"
                    SELECT * FROM (
                    SELECT ROW_NUMBER() over(order by (select 0)) RowNum,* FROM (
                    select ROW_NUMBER() OVER ( ORDER BY  AddDate DESC   ) r,* from [MVipExchangeHistory]   where Status=0 AND  UserId = @UserID AND  SubType <> 55 AND SubType<>20 and SourceFlag!=3 AND status<>-10 #WHERESQL#
                    union ALL
                    select   ROW_NUMBER() over(order by AddDate DESC)  AS r,* from [MVipExchangeHistory]   where Status<>0  AND  UserId = @UserID AND  SubType <> 55 AND SubType<>20 and SourceFlag!=3 AND status<>-10 #WHERESQL#   
                    ) A)  r   WHERE r.RowNum > ( @PageIndex - 1 ) * @PageSize 
                    AND r.RowNum <= ( @PageIndex ) * @PageSize  ";
            var paras = new DynamicParameters();
            paras.Add("@UserId", WebUserAuth.UserId.Value);
            paras.Add("@PageIndex", pageIndex);
            paras.Add("@PageSize", pageSize);
            if (status == 1)
            {
                sqlCount = sqlCount.Replace("#WHERESQL#", string.Format(" AND status = 0 "));
                sqlText = sqlText.Replace("#WHERESQL#", string.Format(" AND status = 0 "));
            }
            else if (status == 2)
            {
                sqlCount = sqlCount.Replace("#WHERESQL#", string.Format(" AND status in (1,2,-11) "));
                sqlText = sqlText.Replace("#WHERESQL#", string.Format(" AND status in (1,2,-11) "));
            }
            else
            {
                sqlCount = sqlCount.Replace("#WHERESQL#", string.Format(" "));
                sqlText = sqlText.Replace("#WHERESQL#", string.Format(" "));
            }
            var TotalRecode = 0;
            List<MVipExchangeHistory> list = null;

            TotalRecode = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.DBVipWrite, sqlCount, ref paras);
            list = TuanDai.DB.TuanDaiDB.Query<MVipExchangeHistory>(TdConfig.DBVipWrite, sqlText, ref paras);
            //using (SqlConnection connection = TuanDai.PortalSystem.DAL.PubConstant.CreateVIPConnection())
            //{
            //    var result = connection.QueryMultiple(sqlText, paras);
            //    if (result != null)
            //    {
            //        TotalRecode = result.Read<int>().FirstOrDefault();
            //        list =  result.Read<MVipExchangeHistory>().ToList();
            //    }
            //    connection.Close();
            //    connection.Dispose();
            //}

            if (TotalRecode == 0)
            {
                PrintJson("0", "无数据");
                return;
            }
            ExchangeHistoryResult viewModel = new ExchangeHistoryResult()
            {
                Status = 1,
                Msg = "获取成功",
                TotalRecords = TotalRecode,
                History = list
            };
            PrintJson(viewModel);
        }

        /// <summary>
        /// 领取实物
        /// </summary>
        public void ReceivePrize()
        {
            BaseResult resultModel = new BaseResult();
            if (WebUserAuth.UserId == Guid.Empty)
            {
                resultModel.Status = -99;
                resultModel.Msg = "未登录";
                PrintJson(resultModel);
                return;
            }
            string id = GetRequestData("id");
            if (string.IsNullOrEmpty(id))
            {
                resultModel.Status = -1;
                resultModel.Msg = "ID不能为空";
                PrintJson(resultModel);
                return;
            }
            string userName = GetRequestData("userName");
            string telNo = GetRequestData("telNo");
            string Address = GetRequestData("address");
            string message = GetRequestData("Message");
            MVipExchangeHistoryBLL bll = new MVipExchangeHistoryBLL();
            MVipExchangeHistory model = null;
            try
            {
                model = bll.GetMVipExchangeHistoryById(Guid.Parse(id));
            }
            catch (Exception ex)
            {
                NetLog.WriteLoginHandler("ajax_base.ReceivePrize", "ex.Message" + ex.Message + "|ex.StackTrace" + ex.StackTrace);
                resultModel.Status = -1;
                resultModel.Msg = "获取数据失败" + ex.Message;
                PrintJson(resultModel);
                return;
            }
            if (model == null)
            {
                resultModel.Status = -1;
                resultModel.Msg = "获取不到数据";
                PrintJson(resultModel);
                return;
            }

            if (model.ExpireDate.HasValue && model.ExpireDate < DateTime.Now)
            {
                resultModel.Status = -1;
                resultModel.Msg = "商品已过期";
                PrintJson(resultModel);
                return;
            }
            
            model.ShipTo = userName;
            model.TelNo = telNo;
            model.Address = Address;
            model.UserNote = message;
            model.Status = 1;
            try
            {
                int result = bll.UpdateMVipExchangeHistory(model);
                if (result > 0)
                {
                    resultModel.Status = 1;
                    resultModel.Msg = "领取成功";
                    PrintJson(resultModel);
                    return;
                }
                else
                {
                    resultModel.Status = -1;
                    resultModel.Msg = "领取失败，请联系管理员！";
                    PrintJson(resultModel);
                    return;
                }
            }
            catch (Exception ex)
            {
                NetLog.WriteLoginHandler("ajax_base.ReceivePrize", "ex.Message" + ex.Message + "|ex.StackTrace" + ex.StackTrace);
                resultModel.Status = -1;
                resultModel.Msg = "领取异常，请联系管理员！" + ex.Message;
                PrintJson(resultModel);
                return;
            }
        }
        /// <summary>
        /// 获取日均资产
        /// </summary>
        public void GetDailyAsset()
        {
            List<MDayNetAssets> PreDailyAssets; //上月资产列表
            List<MDayNetAssets> CurrDailyAssets; //当月资产列表
            List<MDayNetAssets> dayNetAssets = MVipNetAssetsBLL.GetDayOfNetAssets(WebUserAuth.UserId.Value);
            string flag = GetRequestData("flag");
            if (flag == "cur")//当月
            {
                CurrDailyAssets =
                    dayNetAssets.Where(o => o.ReportDate >= new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1))
                        .OrderByDescending(o => o.ReportDate)
                        .ToList();
                PrintJson(CurrDailyAssets);
            }
            else//上月
            {
                PreDailyAssets =
                 dayNetAssets.Where(o => o.ReportDate < new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)).OrderByDescending(o => o.ReportDate).ToList();
                PrintJson(PreDailyAssets);
            }
        }

        //md5加密
        private static string MD5_Hash(string originalString)
        {
            string APIKey = System.Configuration.ConfigurationManager.AppSettings["APIKey"];
            System.Security.Cryptography.SHA1 sha1 = new System.Security.Cryptography.SHA1CryptoServiceProvider();
            byte[] bytes_sha1_in = System.Text.UTF8Encoding.Default.GetBytes(APIKey + originalString.ToLower());
            byte[] bytes_sha1_out = sha1.ComputeHash(bytes_sha1_in);
            string str_sha1_out = BitConverter.ToString(bytes_sha1_out);

            System.Security.Cryptography.MD5 md5 = new System.Security.Cryptography.MD5CryptoServiceProvider();
            byte[] bytes_md5_in = System.Text.UTF8Encoding.Default.GetBytes(str_sha1_out + APIKey);
            byte[] bytes_md5_out = md5.ComputeHash(bytes_md5_in);
            string str_md5_out = BitConverter.ToString(bytes_md5_out);
            return str_md5_out;
        }

        //检查商品库存
        private bool CheckProductStock(string skuId, int num, Guid productId)
        {
            string sqlText = " select @Count=Stock from dbo.MVipProductsSKU(nolock) where SkuId=@skuId";
            Dapper.DynamicParameters param = new Dapper.DynamicParameters();
            param.Add("@SkuId", skuId);
            param.Add("@Count", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output, 5);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBVipWrite, sqlText, ref param);
            int res = param.Get<int?>("@Count").HasValue ? param.Get<int>("@Count") : 0;
            //预防性写法
            if (res < 0)
            {
                string sqlText2 = " update dbo.MVipProductsSKU set Stock=0 where SkuId=@skuId";
                Dapper.DynamicParameters param2 = new Dapper.DynamicParameters();
                param2.Add("@skuId", skuId);
                TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBVipWrite, sqlText2, ref param);
            }
            //如果特价商品已经过期，则修改状态
            MVipScareBuying buyingModel = new MVipScareBuyingBLL().GetBuyingModel(productId);
            if (buyingModel != null && buyingModel.BuyingEndDate < DateTime.Now)
            {
                if (!buyingModel.IsDone)
                {
                    buyingModel.DoneDate = DateTime.Now;
                    buyingModel.IsDone = true;
                    buyingModel.IsJoin = null;
                    new MVipScareBuyingBLL().UpdateBuyingModel(buyingModel);
                }
            }
            return res >= num;
        }

        //更新商品库存
        private bool UpdateProductStock(string skuId, int num)
        {
            string sqlText = @" update dbo.MVipProductsSKU set Stock=Stock-@num where SkuId=@skuId";
            Dapper.DynamicParameters param = new Dapper.DynamicParameters();
            param.Add("@skuId", skuId);
            param.Add("@num", num);
            int res = TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBVipWrite, sqlText, ref param, IsUseTran: true);
            return res > 0;
        }

        //获得商品价格(包括特价商品)  -- 如果同时请求的人太多(太火爆)，这里可能会有问题：特价已经结束，
        //但是依然以特价的价格购买，不过这算让点利而已，最多也就一两个人会碰到这样的情况
        private static int GetProductPrice(MVipProduct vipProduct, int priceValue)
        {
            int buyingPrice = priceValue;
            MVipScareBuying buyingModel = new MVipScareBuyingBLL().GetBuyingModel(vipProduct.Id);
            if (buyingModel != null && !buyingModel.IsDone && buyingModel.IsJoin.HasValue && buyingModel.IsJoin.Value && buyingModel.BuyingEndDate > DateTime.Now && buyingModel.BuyingStartDate < DateTime.Now)
            {
                buyingPrice = buyingModel.BuyingPrice;
            }
            return buyingPrice;
        }

        //查询用户今天还可以兑换多少件商品
        private int CheckLeftNum(Guid userId, Guid productId, out int productLimitNum)
        {
            string sql1 = " select @Count1=sum(TotalNum) from dbo.MVipExchangeHistory where UserId=@userId and ProductId=@productId and AddDate>=@dateTime and (Status<>-10 and Status<>-11 ) ";
            Dapper.DynamicParameters param1 = new Dapper.DynamicParameters();
            param1.Add("@userId", userId);
            param1.Add("@productId", productId);
            param1.Add("@dateTime", DateTime.Now.Date);
            param1.Add("@Count1", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBVipWrite, sql1, ref param1);
            int count = param1.Get<int?>("@Count1").HasValue ? param1.Get<int?>("@Count1").Value : 0;   //今日兑换该商品数量        

            string sql2 = "  select @LimitNum=LimitNum from dbo.MVipProductConfigure where IsLimitNum=1 and ProductId=@productId ";
            var param2 = new Dapper.DynamicParameters();
            param2.Add("@LimitNum", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            param2.Add("@productId", productId);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBVipWrite, sql2, ref param2);
            int limitNum = param2.Get<int?>("@LimitNum").HasValue ? param2.Get<int>("@LimitNum") : 0;   //限制兑换量
            productLimitNum = limitNum;

            int res = 0;
            if (limitNum == 0) // 不做限制
            {
                res = -1;
            }
            else if (limitNum > 0)
            {
                res = (limitNum - count) > 0 ? (limitNum - count) : 0;
            }
            return res;
        }

        //查询商品的最低兑换等级
        private int GetLeastLevel(Guid productId)
        {
            int leavel = 1;
            string sql = " select @Leavel=LeastLevel from MVipProductConfigure where ProductId=@productId and IsLeastLevel=1 ";
            Dapper.DynamicParameters param = new Dapper.DynamicParameters();
            param.Add("@Leavel", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            param.Add("@productId", productId);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBVipWrite, sql, ref param);
            leavel = param.Get<int?>("@Leavel").HasValue ? param.Get<int>("@Leavel") : 1;
            return leavel;
        }


        //获取电话号码运营商
        private string GetPhoneArea(String phone)
        {
            String head1 = "";
            String head2 = "";

            // 去除前后的空白  
            phone = phone.Trim();

            // 判断输入的电话号码是否合法  
            if (phone == null || phone.Length < 11)
            {
                return "";
            }
            else
            {
                // 处理国内的+86开头  
                if (phone.StartsWith("+"))
                {
                    phone = phone.Substring(1);
                }
                if (phone.StartsWith("86"))
                {
                    phone = phone.Substring(2);
                }
            }
            // 去除+86后电话号码应为11位  
            if (phone.Length != 11)
            {
                return "";
            }
            // 判断去除+86后剩余的是否全为数字  
            if (!IsNum(phone))
            {
                return "";
            }
            // 截取前3或前4位电话号码，判断运营商  
            head1 = phone.Substring(0, 3);
            head2 = phone.Substring(0, 4);

            // 移动前三位  
            bool cmcctemp3 = head1.Equals("134") || head1.Equals("135") || head1.Equals("136")
                || head1.Equals("137") || head1.Equals("138")
                || head1.Equals("139") || head1.Equals("147")
                || head1.Equals("150") || head1.Equals("151")
                || head1.Equals("152") || head1.Equals("157")
                || head1.Equals("158") || head1.Equals("159")
                || head1.Equals("182") || head1.Equals("183")
                || head1.Equals("184") || head1.Equals("178")
                || head1.Equals("187") || head1.Equals("188");
            if (cmcctemp3)
            {
                return "CMCC";
            }
            // || head2.Equals("1705") 是移动的虚拟号段，故排除
            // 移动前4位  
            bool cmcctemp4 = head2.Equals("1340") || head2.Equals("1341")
                             || head2.Equals("1342") || head2.Equals("1343")
                             || head2.Equals("1344") || head2.Equals("1345")
                             || head2.Equals("1346") || head2.Equals("1347")
                             || head2.Equals("1348");
            if (cmcctemp4)
            {
                return "CMCC";
            }
            // 联通前3位  
            bool unicomtemp = head1.Equals("130") || head1.Equals("131")
                              || head1.Equals("132") || head1.Equals("145")
                              || head1.Equals("155") || head1.Equals("156") || head1.Equals("176")
                              || head1.Equals("185") || head1.Equals("186");
            if (unicomtemp)
            {
                return "UNICOM";
            }
            // 1709 为联通虚拟的运营商，不能充值，排除
            //unicom 4  
            //bool unicomtemp4 = head1.Equals("1709");
            //if (unicomtemp4)
            //{
            //    return "UNICOM";
            //}
            // 电信前3位  
            bool telecomtemp = head1.Equals("133") || head1.Equals("153")
                || head1.Equals("181") || head1.Equals("177")
                || head1.Equals("180") || head1.Equals("189");

            if (telecomtemp)
            {
                return "TELECOM";
            }
            // 1700 为电信虚拟运营商，
            //telecom 4  
            //bool telecomtemp4 = head1.Equals("1700");
            //if (telecomtemp4)
            //{
            //    return "TELECOM";
            //}
            return "";
        }

        /// <summary>
        /// 判断是否为数字
        /// </summary>
        /// <param name="str">待确定字符串</param>
        /// <returns>true 是数字，否则不是数字</returns>
        private bool IsNum(string strIn)
        {
            bool bolResult = true;
            if (strIn == "")
            {
                bolResult = false;
            }
            else
            {
                foreach (char Char in strIn)
                {
                    if (char.IsNumber(Char))
                        continue;
                    else
                    {
                        bolResult = false;
                        break;
                    }
                }
            }
            return bolResult;
        }

        //检查是否已经兑换过，针对话费、流量包等每日限量兑换的情况
        private bool IsExchangeProduct(int type)
        {
            //每天只能兑换一张
            string sqlText = " select top 1 *from dbo.MVipExchangeHistory(nolock) where SubType=@type and UserId=@userId order by AddDate desc";
            var param = new Dapper.DynamicParameters();
            param.Add("@type", type);
            param.Add("@userId", WebUserAuth.UserId.Value);
            List<MVipExchangeHistory> list = TuanDai.DB.TuanDaiDB.Query<MVipExchangeHistory>(TdConfig.ApplicationName, TdConfig.DBVipWrite, sqlText, ref param);
            if (list != null && list.Count >= 1)
            {
                DateTime exTime = list[0].AddDate;
                if (exTime.Date == DateTime.Now.Date)  //当天有兑换过
                {
                    return true;
                }
            }
            return false;
        }

        //获取流量的余额
        private decimal GetFlowBalance()
        {
            string urlString = baseUrlString;
            urlString += "/MingZhuanWuXian/PostVipFlowMoneyInfo";
            string jsonString = TuanDai.WXSystem.Core.JsonHelper.ToJson(new { action = "getuserinfo" });
            string tokenString = MD5_Hash(jsonString);
            string postResult = Tool.HttpUtils.HttpPost(urlString + "?jsonString=" + jsonString + "&token=" + tokenString, null, 60);
            FlowBalancsResult result = TuanDai.WXSystem.Core.JsonHelper.ToObject<FlowBalancsResult>(postResult);
            if (result != null && !string.IsNullOrEmpty(result.Riches))
            {
                decimal o;
                if (decimal.TryParse(result.Riches, out o))
                {
                    return o;
                }
            }
            return 0;
        }

        //获取联通号码充值次数
        private int GetUnicomCount()
        {
            string sqlUnicomText = " select @UnicomCount=count(1) from dbo.MVipExchangeHistory where UserId=@uerId and AddDate>=@beginDate and AddDate<=@endDate and SubType=25";
            Dapper.DynamicParameters unicomParam = new Dapper.DynamicParameters();
            unicomParam.Add("@UnicomCount", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            unicomParam.Add("@uerId", WebUserAuth.UserId.Value);
            DateTime beginDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);  //这个月的第一天
            DateTime endDate = beginDate.AddMonths(1).AddDays(-1);  //下一个月的前一天，也就是月尾
            unicomParam.Add("@beginDate", beginDate);
            unicomParam.Add("@endDate", endDate);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBVipWrite, sqlUnicomText, ref unicomParam);
            int unionCount = unicomParam.Get<int>("@UnicomCount");
            return unionCount;
        }


        //第三方实物商品发起订单请求
        private bool StartEntityOrder(string orderAddress, int orderScore, Guid exchangeId, string orderPhone, string orderReceiveName, string orderCommodityCode, int Num, out string orderNo, string orderNote = "")
        {
            string urlString = baseUrlString;
            urlString += "/WanJiFen/PostExchangeCommodity";
            string jsonString = TuanDai.WXSystem.Core.JsonHelper.ToJson(
                new
                {
                    address = orderAddress,
                    amountscore = orderScore,
                    apporder = exchangeId,
                    appuser = "www.tuandai.com",
                    cellphone = orderPhone,
                    commodityCode = orderCommodityCode,
                    linkman = orderReceiveName,
                    remark = orderNote,
                    number = Num,
                    commodityType = 0
                });
            string tokenString = MD5_Hash(jsonString);
            try
            {
                string postResult = Tool.HttpUtils.HttpPost(urlString + "?jsonString=" + jsonString + "&token=" + tokenString, null, 60);
                WJFExchangeCommodityResult res = TuanDai.WXSystem.Core.JsonHelper.ToObject<WJFExchangeCommodityResult>(postResult);
                if (res != null && res.data != null && !string.IsNullOrEmpty(res.data.ordcode))
                {
                    orderNo = res.data.ordcode;
                    NetLog.WriteLoginHandler("StartOrderSuccess", exchangeId + "购买玩积分实物商品成功:" + res.msg, "触屏版");
                    return res.result == "1";
                }
                else
                {
                    orderNo = "";
                    NetLog.WriteLoginHandler("StartOrderError", exchangeId + "购买玩积分实物商品失败:" + res.msg, "触屏版");
                    return false;
                }
            }
            catch (Exception ex)
            {
                NetLog.WriteLoginHandler("StartOrderError", "会员商城兑换第三方商品，请求接口失败,ex.Message:" + ex.Message + ",ex.StackTrace:" + ex.StackTrace + ",接口地址是:" + urlString + "?jsonString=" + jsonString + "&token=" + tokenString, "触屏版");
                orderNo = "";
                return false;
            }
        }

        //第三方虚拟商品发起订单请求
        private bool StartVirtualOrder(int orderAmountscore, Guid exchangeId, string orderCommodityCode, int orderNumber, out string orderNo, out string vipPassword)
        {
            vipPassword = "";
            orderNo = "";
            string urlString = baseUrlString;
            urlString += "/WanJiFen/PostExchangeCouponCommodity";
            string jsonString = TuanDai.WXSystem.Core.JsonHelper.ToJson(
                new
                {
                    amountscore = orderAmountscore,
                    Apporder = exchangeId,
                    CommodityCode = orderCommodityCode,
                    Number = orderNumber
                });
            string tokenString = MD5_Hash(jsonString);
            try
            {
                string postResult = Tool.HttpUtils.HttpPost(urlString + "?jsonString=" + jsonString + "&token=" + tokenString, null, 60);
                WJFExchangeCouponCommodityResult res = TuanDai.WXSystem.Core.JsonHelper.ToObject<WJFExchangeCouponCommodityResult>(postResult);
                if (res != null && res.data != null && !string.IsNullOrEmpty(res.data.ordcode))
                {
                    orderNo = res.data.ordcode;
                    if (res.data.serial != null && res.data.serial.Count > 0) //电子密码
                    {
                        foreach (string item in res.data.serial)
                        {
                            vipPassword += item + "|";
                        }
                        vipPassword = vipPassword.Substring(0, vipPassword.Length - 1);
                    }
                    NetLog.WriteLoginHandler("StartOrderSuccess", exchangeId + "购买玩积分虚拟商品成功:" + res.msg, "触屏版");
                    return res.result == "1";
                }
                else
                {
                    NetLog.WriteLoginHandler("StartOrderError", exchangeId + "购买玩积分虚拟商品失败:" + res.msg, "触屏版");
                    return false;
                }
            }
            catch (Exception ex)
            {
                NetLog.WriteLoginHandler("StartOrderError", "会员商城兑换第三方商品，请求接口失败,ex.Message:" + ex.Message + ",ex.StackTrace:" + ex.StackTrace + ",接口地址是:" + urlString + "?jsonString=" + jsonString + "&token=" + tokenString, "触屏版");
                return false;
            }
        }

        //回滚订单，针对接口失败等情况
        private void RockBackOrder(Guid exchangeId, Guid userId, int totalTuanBi, int totalNum, Guid productId)
        {
            Dapper.DynamicParameters param = new Dapper.DynamicParameters();
            param.Add("@ExchangeHistoryId", exchangeId);
            param.Add("@UserId", userId);
            param.Add("@TotalTuanBi", totalTuanBi);
            param.Add("@TotalNum", totalNum);
            param.Add("@ProductId", productId);
            param.Add("@RockBackReason", "发起第三方订单失败");
            param.Add("@RockBackType", 0);
            param.Add("@OutStatus", 8, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            param.Add("@OutMsg", null, System.Data.DbType.String, System.Data.ParameterDirection.Output, 50);
            string errorMsg = "";
            TuanDai.DB.TuanDaiDB.ExecuteThrowException(TdConfig.DBVipWrite, "P_RollBackExchangeProduct", ref param, ref errorMsg, System.Data.CommandType.StoredProcedure);
            //TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBVipWrite, "P_RollBackExchangeProduct", ref param);
            int status = param.Get<int?>("@OutStatus").HasValue ? param.Get<int>("@OutStatus") : 0;
            string outMsg = param.Get<string>("@OutMsg");
            if (status != 1)
            {
                NetLog.WriteLoginHandler("RockBackOrderError", "会员商城回滚兑换第三方商品失败，原因：" + outMsg + "，exchangeHistoryId：" + exchangeId, "触屏版");
            }
            else
            {
                NetLog.WriteLoginHandler("RockBackOrderSuccess", "会员商城回滚兑换第三方商品失败,成功:" + outMsg + "，exchangeHistoryId：" + exchangeId, "触屏版");
            }

        }

        /// <summary>
        /// 获取玩积分商品库存
        /// </summary>
        /// <param name="productCode">玩积分商品编码</param>
        /// <returns></returns>
        private bool CheckWJFStock(string productCode, Guid skuId, string productName, int num)
        {
            string urlString = baseUrlString;
            urlString = urlString + "/WanJiFen/PostCommodityDetailSimple";
            string jsonString = TuanDai.WXSystem.Core.JsonHelper.ToJson(
              new
              {
                  commodityCode = productCode
              });
            string tokenString = MD5_Hash(jsonString);
            try
            {
                string postResult = Tool.HttpUtils.HttpPost(urlString + "?jsonString=" + jsonString + "&token=" + tokenString, null, 60);
                WJFProductStock wjfStrock = TuanDai.WXSystem.Core.JsonHelper.ToObject<WJFProductStock>(postResult);
                if (wjfStrock.status != "0" || wjfStrock.remainNumber <= 1) // 下架或者库存小于等于1，则下架我们的库存
                {
                    //更新商品库存
                    string sql = "update dbo.MVipProductsSKU set Stock=-" + num + " where SkuId=@skuId";
                    Dapper.DynamicParameters param = new Dapper.DynamicParameters();
                    param.Add("@skuId", skuId);
                    int res = TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBVipWrite, sql, ref param);
                    if (res <= 0)
                    {
                        NetLog.WriteLoginHandler("GetProductStock", "第三方商品：" + productName + "库存为0，更新商城库存为0失败", "触屏版");
                    }
                    else
                    {
                        NetLog.WriteLoginHandler("GetProductStock", "第三方商品：" + productName + "库存为0，更新商城库存为0成功", "触屏版");
                    }
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                NetLog.WriteLoginHandler("StartOrderError", "会员商城兑换第三方商品，请求接口失败,ex.Message:" + ex.Message + ",ex.StackTrace:" + ex.StackTrace + ",接口地址是:" + urlString + "?jsonString=" + jsonString + "&token=" + tokenString, "VIP_PC");
                return false;
            }
        }

        //团币游戏专区
        public void GetTuanBiGameList()
        {
            int pageIndex = int.Parse(Context.Request["pageIndex"] ?? "1");
            int pageSize = int.Parse(Context.Request["pageSize"] ?? "5");

            string sql = @"select v.ImageUrl,v.LocationType,v.ShortDesc from
                         (
                          select row_number() over(order by DisplaySequence asc) num ,* from dbo.MVipBanner where LocationType=2 and IsShow=1 
                        ) v where v.IsShow=1 and v.LocationType=2 and v.num>@pageSize*(@pageIndex-1) and v.num<=@pageSize*@pageIndex";
            Dapper.DynamicParameters param = new DynamicParameters();
            param.Add("@pageIndex", pageIndex);
            param.Add("@pageSize", pageSize);
            List<MVipBanner> list = TuanDai.DB.TuanDaiDB.Query<MVipBanner>(TdConfig.ApplicationName, TdConfig.DBVipWrite, sql, ref param);
            PrintJson(list);
        }

        //获取团宝箱类商品的面额
        private decimal GetDenomination(MVipProduct vipProduct)
        {
            decimal pValue = 0.0M;  //团宝箱相关面额,包括红包、加息券、提现券
            if (vipProduct.SubType == 18 && !string.IsNullOrEmpty(vipProduct.Remark2) && decimal.TryParse(vipProduct.Remark2, out pValue))
            {
                pValue = decimal.Parse(vipProduct.Remark2);
            }
            else
            {
                pValue = vipProduct.PrizeValue == null ? 0 : Convert.ToDecimal(vipProduct.PrizeValue);
            }
            return pValue;
        }

        //加息券使用说明
        private string GetRuleDescription(TuanDai.UserPrizeNew.ServiceClient.Models.UserPrizeActivityInfo activityInfo)
        {
            string res = "（使用条件：单笔投资满" + activityInfo.InvestMoney + "元；";
            if (activityInfo.DeadLineType == 1)  //1月标 
            {
                if (activityInfo.EndDeadLine.HasValue)
                {
                    res += "仅限" + (activityInfo.StartDeadLine ?? 1) + "至" + activityInfo.EndDeadLine.Value + "月";
                }
                else
                {
                    res += "仅限≥" + (activityInfo.StartDeadLine ?? 1) + "月";
                }
            }
            else if (activityInfo.DeadLineType == 2)  //2天标
            {
                if (activityInfo.EndDeadLine.HasValue)
                {
                    res += "仅限" + (activityInfo.StartDeadLine ?? 1) + "至" + activityInfo.EndDeadLine + "天";
                }
                else
                {
                    res += "仅限≥" + (activityInfo.StartDeadLine ?? 1) + "天";
                }
            }
            string[] projectTypeArr = activityInfo.ProjectType.Split(',');
            if (projectTypeArr != null && projectTypeArr.Length > 0)
            {
                foreach (string type in projectTypeArr)
                {
                    switch (type)
                    {
                        case "WeFTB":
                            res += "复投宝、";
                            break;
                        case "We":
                            res += "We计划、";
                            break;
                        case "WeAYB":
                            res += "安盈计划、";
                            break;
                        case "6":
                        case "7":
                            res += "资产标、";
                            break;
                        case "9":
                        case "10":
                        case "11":
                            res += "微团贷、";
                            break;
                        case "1":
                        case "3":
                            res += "小微企业、";
                            break;
                        case "15":
                        case "24":
                        case "25":
                        case "26":
                        case "27":
                        case "28":
                        case "29":
                        case "30":
                        case "31":
                            res += "分期宝" + type + "、";
                            break;
                        case "19":
                        case "20":
                            res += "供应链、";
                            break;
                        case "AYB":
                            res += "安盈宝、";
                            break;
                        case "DQZR":
                            res += "定期转让、";
                            break;
                        case "P2PZR":
                            res += "P2P转让、";
                            break;
                        default:
                            res += "";
                            break;

                    }
                }
                res = res.Substring(0, res.Length - 1);
            }
            res += "使用）";
            return res;
        }
    }

    public class BaseResult
    {
        public int Status { get; set; }
        public string Msg { get; set; }
    }


    public class ExchangeHistoryResult : BaseResult
    {
        public int TotalRecords { get; set; }
        public List<MVipExchangeHistory> History { get; set; }
    }
    public class PrizeResult : BaseResult
    {
        /// <summary>
        /// 用户可用团币
        /// </summary>
        public int ValidTuanBi { get; set; }
        /// <summary>
        /// 每次抽奖花费团币数量
        /// </summary>
        public int OutCostTuanBi { get; set; }
        /// <summary>
        /// 可抽奖次数
        /// </summary>
        public int ValidPrizeNum { get; set; }
        /// <summary>
        /// 用户累计中奖次数
        /// </summary>
        public int PrizedCount { get; set; }
        /// <summary>
        /// 中奖商品类型0谢谢参与1团宝箱商品2实物奖品3团币值
        /// </summary>
        public int SubTypeId { get; set; }
        /// <summary>
        /// 中奖商品价值-团宝箱
        /// </summary>
        public decimal PrizeValue { get; set; }
        /// <summary>
        /// 中奖商品名称
        /// </summary>
        public string ProductName { get; set; }
        public int PrizeIndex { get; set; }
        public int PriceValue { get; set; }
        public string ImageUrl { get; set; }

    }
    public class TuanbiHistoryResult
    {
        public int recordCout { get; set; } //消息数量
        public int sumTuanbiValue { get; set; }
        public List<MTuanBiHistoryDetail> list { get; set; }
    }
    public class ExchangeResult : BaseResult
    {
        public int ValidTuanBi { get; set; }
        public Guid ExchangeId { get; set; }
    }
    public class ProductListResult : BaseResult
    {
        public int TotalRecords { get; set; }
        public List<ProductViewModel> Data { get; set; }
    }
    public class AddressInfo
    {
        /// <summary>
        /// 名称
        /// </summary>
        public string ProName { get; set; }
        /// <summary>
        /// Id
        /// </summary>
        public int ProId { get; set; }
    }

    public class AddressInfoList : BaseResult
    {
        public List<AddressInfo> addrList { get; set; }
    }


    public class FlowResult
    {
        private string @return;

        public string Return
        {
            get { return @return; }
            set { @return = value; }
        }

        private string info;

        public string Info
        {
            get { return info; }
            set { info = value; }
        }
        private string taskid;

        public string Taskid
        {
            get { return taskid; }
            set { taskid = value; }
        }
        private string linkid;

        public string Linkid
        {
            get { return linkid; }
            set { linkid = value; }
        }

    }

    /// <summary>
    /// 流量余额
    /// </summary>
    public class FlowBalancsResult
    {
        private string @return;

        public string Return
        {
            get { return @return; }
            set { @return = value; }
        }
        private string info;

        public string Info
        {
            get { return info; }
            set { info = value; }
        }
        private string id;

        public string Id
        {
            get { return id; }
            set { id = value; }
        }
        private string name;

        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        private string riches;

        public string Riches
        {
            get { return riches; }
            set { riches = value; }
        }
    }

    /// <summary>
    /// 接口3.	兑换商城实物商品 返回实体类
    /// </summary>
    public class WJFExchangeCommodityResult
    {
        /// <summary>
        /// 操作码 -1执行失败,1执行成功,2功能不支持,11参数错误,12签名错误
        /// </summary>
        public string result { get; set; }

        /// <summary>
        /// 具体的数据[各个接口的数据]
        /// </summary>
        public WJFExchangeCommodityResponse data { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string msg { get; set; }
    }

    /// <summary>
    /// 接口3.	兑换商城实物商品 返回兑换详情
    /// </summary>
    public class WJFExchangeCommodityResponse
    {
        /// <summary>
        /// 订单编号
        /// </summary>
        public string ordcode { get; set; }

        /// <summary>
        /// 交易时间
        /// </summary>
        public string time { get; set; }

        /// <summary>
        /// 交易状态0:已受理;1:交易成功;2:交易失败;3:交易取消;4:交易异常
        /// </summary>
        public string status { get; set; }

        /// <summary>
        /// 团贷网兑换的GUID
        /// </summary>
        public string apporder { get; set; }

        /// <summary>
        /// 团贷网的用户ID
        /// </summary>
        public string appuser { get; set; }
    }

    /// <summary>
    /// 接口3.	兑换商城实物商品 返回实体类
    /// </summary>
    public class WJFExchangeCouponCommodityResult
    {
        /// <summary>
        /// 操作码 -1执行失败,1执行成功,2功能不支持,11参数错误,12签名错误
        /// </summary>
        public string result { get; set; }

        /// <summary>
        /// 具体的数据[各个接口的数据]
        /// </summary>
        public WJFExchangeCouponCommodityResponse data { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string msg { get; set; }
    }

    /// <summary>
    /// 接口4.	兑换商城实物商品 返回兑换详情
    /// </summary>
    public class WJFExchangeCouponCommodityResponse
    {
        /// <summary>
        /// 订单编号
        /// </summary>
        public string ordcode { get; set; }

        /// <summary>
        /// 交易时间
        /// </summary>
        public string createTime { get; set; }

        /// <summary>
        /// 广告主
        /// </summary>
        public string advertiser { get; set; }

        /// <summary>
        /// 商品编号
        /// </summary>
        public string commodityCode { get; set; }

        /// <summary>
        /// 团贷网的用户ID
        /// </summary>
        public string appuser { get; set; }

        /// <summary>
        /// 优惠券码
        /// </summary>
        public List<string> serial { get; set; }
    }

    public class WJFProductStock
    {
        public string result { get; set; }
        public string commodityCode { get; set; }
        public string status { get; set; }
        public string msg { get; set; }
        public int remainNumber { get; set; }
    }
}