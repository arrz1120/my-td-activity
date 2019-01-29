//签到后刷新页面
// if(Jsbridge){
//   Jsbridge.appLifeHook(
//     function(){}, 
//     function(){}, 
//     function(){}, 
//     function(){
//         window.location.reload()
//     }
//   )
// }

var doms = {
  noRank: $('#norank'),
  noRankAndLogin: $('#norankAndLogin'),
  rankAndLogin: $('#rankAndLogin'),
  noLogin: $('#nologin'),
  info: $('#info'),
  sliderWrapper: $('.slider-wrapper'),
  rankContainer: $('#rankContainer'),
  rankTab: $('.rank-tab')
}

var objRank = {
  totalPage: 3,
  rank1 : {
    type: 1,
    el: '.slider1',
    slider:null,
    page: 1,
    data: [],
    hasMore:true
  },
  rank2 : {
    type: 2,
    el: '.slider2',
    slider:null,
    page: 1,
    data: [],
    hasMore:true
  }
}

//定义页面状态
var state = {
  isAcitvityEnd: false, //活动是否已结束
  isLogin: true, //是否登录
  activeRankType: false, 
  hb: 0
}

var methods = {
  _setContainerClass: function(className) {
    doms.rankContainer.addClass('rank-container ' + className)
  },
  _showLoginState: function() {
    methods._setContainerClass('login-rank')
    doms.rankContainer.show()
    doms.info.show()
    doms.rankAndLogin.show()
  },
  _showNoLoginState: function() {
    methods._setContainerClass('nologin')
    doms.rankContainer.show()
    doms.noLogin.show()
  },
  _showEndState: function() {
    methods._setContainerClass('login-rank')
    doms.noRank.hide()
    doms.rankContainer.show()
    $('#rankTitle').html('活动获奖名单')
    $('.rank-list-box').css('margin-top',0)
    $('.rank-rule').hide()
    $('#endPrize').show()
    $('#notEndTxt').hide()
    $('#endTxt').show()
    rankTab.hide()
    $('#endPrine').show()
    if (state.hb === 0) {
      $('.prize-off').show()
    }else{
      $('.prize-on').find('b').html(state.hb)
      $('.prize-on').show()
    }
  },
  init: function() {
    if (state.isAcitvityEnd) {
      methods.getEndRankData()
      methods._setContainerClass('activity-end')
      if (state.isLogin) {
        methods._showEndState()
        methods._showLoginState()
        methods.getInfoData()
        methods.getHbState()
        methods.getEndRankData()
      } else {
        methods._showNoLoginState()
      }
    } 
    else {
      methods.getRankType()
    }
  },
  getRankType: function(){
    //获取当前排行榜类型：假设：1 == 冲刺榜；2 == 英壕榜，false == 无排行榜数据
    state.activeRankType = 1

    if (state.activeRankType == false) {
      
      if (state.isLogin) {
        doms.noRank.hide()
        doms.rankContainer.show()
        doms.info.show()
        doms.noRankAndLogin.show()
        methods._setContainerClass('login-norank')
      } else {
        doms.noRank.show()
        doms.rankContainer.hide()
      }
    } 
    else {
      methods.handleLogin()
    }
  },
  handleLogin: function() {
    if (state.isLogin) {
      methods._showLoginState()
      methods.getInfoData()
      methods.getHbState()
    } else {
      methods._showNoLoginState()
    }
    methods.initRankTab()
  },
  getInfoData: function(){
    //设置投资和排行榜信息
    $('#percent').css('width','30%')
    $('#investData').html('99,999.99元')
    $('#myRank').html('18名（冲刺榜）')
  },
  getHbState: function() {
    //定义红包额度，假设：0 == 未获得红包，100 == 100元红包， 280 == 280元红包
    state.hb = 0
    methods.lightHb()
  },
  lightHb: function(){
    var hb = state.hb
    if (hb === 0) {
      return
    }
    else{
      $('.hb').each(function(i,item){
        if(parseInt($(item).attr('data-hb')) === hb){
          $(item).find('.hb-cover').hide()
        }
      })
    }
  },
  initRankTab: function() {
    var item = $('.rank-tab .item')
    if (state.activeRankType == 1) {
        item.eq(0).html('冲刺榜')
        item.eq(1).html('英壕榜')
    }
    else if (state.activeRankType == 2) {
        item.eq(0).html('英壕榜')
        item.eq(1).html('冲刺榜')
    }  
    methods.getRankData(1)
    item.on("click",function(){
      var index = $(this).index()
      if ($(this).hasClass('active')) {
        return
      }
      else {
        $(this).addClass("active")
        $(this).siblings().removeClass("active")
        $('.slider').hide()
        $('.slider' + (index+1)).show()
        if(objRank.rank1.slider){
          objRank.rank1.slider.refresh()
        }
        if(objRank.rank2.slider){
          objRank.rank2.slider.refresh()
        }
        if (index === 0 && objRank.rank1.data.length === 0) {
          methods.getRankData(1)
        }
        else if (index === 1 && objRank.rank2.data.length === 0){
          methods.getRankData(2)
        }
      }
    })
  },

  getTempData:function(){
    var data = []
    var dataLength = 20
    for(var i = 0; i < dataLength; i++){
      data.push({
        'rank': i+1,
        'tel':' 137****1111',
        'sign': 10,
        'money': '11,111.11'
      })
    }
    return data
  },

  getRankData: function(rank){
    rank = 'rank' + rank
    console.log(objRank[rank].page)
    setTimeout(function(){
      var data = methods.getTempData()
      objRank[rank].data = data
      if (data.length < 20) {
        objRank[rank].hasMore = false
      } else {
        objRank[rank].page++
      }
      $(objRank[rank].el).find('.dropload-tips').hide()
      methods.renderRank(rank,data)
      setTimeout(function(){
        if(objRank[rank].slider === null){
            methods.initScroll(rank)
        }else{
          objRank[rank].slider.finishPullUp()
          objRank[rank].slider.refresh()
        }
      },20)
    },1000)      
    
  },

  showNoRank:function (rank){
    $(objRank[rank].el).find('.dropload-tips').html('没有更多排名~').show()
    if (objRank[rank].slider) {
      objRank[rank].slider.refresh()
      objRank[rank].slider.closePullUp()
    }
  },

  renderRank: function(r,data) {
    if (data.length === 0 || data === undefined) {
      if (objRank[r].page === 1) {
        var layout = '<div class="data-none">' + 
          '<div class="pic"></div>'+
         '<p>签到满15天即有机会进入英壕榜</p>'+
          '<p>赢取现金红包!</p>'+
        '</div>'
        $(objRank[r].el).html(layout)
      } else {
        methods.showNoRank(r)
      }
    } else {
      var layout = '';
      var layoutClassName = 'item' //active
      for(var i = 0; i < data.length; i++){
          var rank = (data[i].rank < 4) ? '<span class="rank' + data[i].rank + '"></span>' : data[i].rank;
          layout += '<div class="'+ layoutClassName +'">'+
              '<p>'+ rank +'</p>'+
              '<p>' + data[i].tel + '</p>'+
              '<p>' + data[i].sign + '</p>'+
              '<p>' + data[i].money + '</p>'+
              '</div>'
      }
      $(objRank[r].el).find('.slider-group').append(layout)
      if (data.length < 20) {
        methods.showNoRank(r)
      }
    }
  },

  initScroll: function(rank) {
    objRank[rank].slider = new BScroll(objRank[rank].el,{
        scrollbar: {
            fade: false
        },
        probeType: 3,
        // click: true,
        scrollY: true,
        pullUpLoad: {
          threshold:0,
          // moreTxt:'加载更多',
          // noMoreTxt:'没有更多数据了'
        }
    })
    objRank[rank].slider.on('pullingUp',function(pos) {
        if (objRank[rank].page <= objRank.totalPage && objRank[rank].hasMore) {
            $(objRank[rank].el).find('.dropload-tips').html('加载中...').show()
            objRank[rank].slider.refresh()
            methods.getRankData(objRank[rank].type)
        }else{
          methods.showNoRank(rank)
          return
        }
    })
  },

  goToSignIn: function() {
    Jsbridge.toAppSignIn()
  },
  goToLogin: function() {
    if (Jsbridge.isApp()) {
        Jsbridge.toAppLogin()
    } else {
        location.href = ''
    }
  },
  goToRule: function() {
    location.href = '../../views/rule.html'
  },
  goToQuestion: function() {
    location.href = '../../views/question.html'
  },
  goToInvest: function() {
    if (Jsbridge.isApp()) {
      Jsbridge.toAppP2p()
    } else {
      window.location.href = 'https://www.tuandai.com/app/install.aspx'

    }
  },
  _showEndAlert: function(){
    $('#endAlert').show()
  },
  _showAlertGl: function() {
    $('#alertGL').show()
  },
  _showRule: function(){
    $('#alertRule').show()
  },
  _showInvestAlert: function(){
    $('#alertToInvest').show()
  },
  _showRankAlert: function(){
    $('#alertWatchRank').show()
  }
}

methods.init()