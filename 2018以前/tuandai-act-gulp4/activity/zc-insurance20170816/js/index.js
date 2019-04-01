var isApp = function() {
  var useragent = navigator.userAgent;
  return useragent.indexOf("paisheng_Android") !== -1 || useragent.indexOf("tuandaiapp_android") !== -1 || useragent.indexOf("tuandaiapp_IOS") !== -1;
  // return useragent.indexOf("paisheng_Android") != -1 || useragent.indexOf("tuandaiapp_IOS") != -1;
}

// 页面跳转
var goToView = function(url, title, cb) {
  if(!url) return;  //url 不存在则返回
  
  if (!isApp()) {
    window.location.href = url;
    return;
  }
  
  var params = {
    "title": title,
    "url": url
  };

  var callback = cb || null;
  Jsbridge.exec("ToAppNewPage", callback, params);
}


/*
  判断是否是ios，5.2.2版本
*/
var isCurrentTuandaiIosApp = function() {
  var useragent = navigator.userAgent;
  var arr = useragent.match(/\[([^\[\]]*)\]/);
  var curVersion;
  if (arr && arr[1]) {
      var vst = arr[1].split("_");
       curVersion = vst[vst.length - 1];
  }
  return (useragent.indexOf("tuandaiapp_IOS") !== -1 || useragent.indexOf("tuandaiapp_android") !== -1) && curVersion === "5.2.2";
}

$(function() {
  FastClick.attach(document.body);
  if(isCurrentTuandaiIosApp()) {
    $("#defaultView").show(); //显示缺省页面
    $("#wrapper").remove();  //删除本来页面
    $(".sticky-header").remove(); //删除置顶标题
    return
  }
  $("#wrapper").show();  //显示原来页面
  $("#defaultView").remove(); //删除缺省页面
  var contentEl = $(".content");
  var stickyEl = $(".sticky-header");
  var normalEl = contentEl.find(".normal-position");

  /*// 点击跳转至中驰介绍
  contentEl.on("tap", ".insurance-name", function() {
    var urlInfo = window.location.href.split("/");
    urlInfo[urlInfo.length - 1] = "introduction.html";
    var url = urlInfo.join("/");
    var title = "中驰保险代理(北京)有限公司";
    goToView(url, title);
  });
  
  // 点击跳转至中驰专题页面
  contentEl.on("tap", ".banner", function() {
    var url = "https://hd.zc-insurance.com/201708/20170825/weixin/index.aspx ";
    var title = "团贷网携手中驰保险";
    goToView(url, title);
  });*/

  // 点击进入保险详情
  contentEl.on("tap", ".insurance-healthy", function() {
    var urlInfo = window.location.href.split("/");
    urlInfo[urlInfo.length - 1] = "detail.html";
    var url = urlInfo.join("/");
    var title = "爱健康百万医疗保险";
    goToView(url, title);
  });

  var myScroll = new IScroll("#wrapper", {
    probeType: 2,
    click: false,
    tap: true,
    disableMouse: true,
    disablePointer: true,
    mutationObserver: true,
    eventPassthrough: "horizontal"
  });

  var insuranceNameHeight = contentEl.find(".insurance-name").height();
  var bannerHeight = contentEl.find(".banner").height();


  // 监听窗口位置发生变化，改变置顶条件
  resizeEvt = "orientationchange" in window ? "orientationchange" : "resize";
  window.addEventListener && window.addEventListener(resizeEvt, function() {
    insuranceNameHeight = contentEl.find(".insurance-name").height();
    bannerHeight = contentEl.find(".banner").height();
  }, false);

  myScroll.on("scroll", function() {
    if (this.y < -(insuranceNameHeight + bannerHeight)) { //置顶条件
      normalEl.css("visibility", "hidden");
      stickyEl.show();
    } else {
      stickyEl.hide();
      normalEl.css("visibility", "visible");
    }
  });

  myScroll.on("scrollEnd", function() {
    if (this.y < -(insuranceNameHeight + bannerHeight)) { //置顶条件
      normalEl.css("visibility", "hidden");
      stickyEl.show();
    } else {
      stickyEl.hide();
      normalEl.css("visibility", "visible");
    }
  });
  // 计算滑动的位移量
  var offsetH = stickyEl.height() + contentEl.find(".wrapper-title").height();
  var srollToEl;
  // 点击滑动到相应的险种项
  $("body").on("tap click", ".insurance-type-list .type", function(e) {
    var btnType = +$(this).attr("data-type"); //获取险种类型
    switch (btnType) {
      case 1:
        srollToEl = ".insurance-healthy";
        break;
      case 2:
        srollToEl = ".insurance-accident";
        break;
      case 3:
        srollToEl = ".insurance-tourism";
        break;
      case 4:
        srollToEl = ".insurance-assets";
        break;
    }
    // 动到相应的险种项
    srollToEl && myScroll && myScroll.scrollToElement(srollToEl, 200, 0, -offsetH);
  });
});