var myScroll,
    pullDownEl, pullDownOffset,
    pullUpEl, pullUpOffset,
    generatedCount = 0; 

function resetDom(){
	var downHtml = '<div class="centerBox-wp">'+
                		'<div class="pullDownTips">'+               
	                    	'<span class="pullDownIcon"></span>'+
	                    	'<div class="pullLoading">'+
	                    		'<div class="loading-circle"></div>'+
	                    		'<div class="loading-logo"></div>'+
	                   	 '</div>'+
               			'</div>'+
            		'</div>';
//  var upHtml = '<div class="centerBox-wp">'+
//		                '<div class="pullDownTips">'+                
//		                    '<div class="pullLoading">'+
//		                    	'<div class="loading-circle"></div>'+
//		                    	'<div class="loading-logo"></div>'+
//		                    '</div>'+
//		                '</div>'+
//		            '</div>';        		
            
	$('#pullDown').html('').html(downHtml);
//	$('#pullUp').html('').html(upHtml);
}

$(function(){
	resetDom();
})

/**
* 下拉刷新 （自定义实现此方法）
* myScroll.refresh();      // 数据加载完成后，调用界面更新方法
*/
function pullDownAction() {
    setTimeout(function () {    // <-- Simulate network congestion, remove setTimeout from production!
        //加载数据 
        if (iScroll.onLoadData) iScroll.onLoadData("empty");
        myScroll.refresh();     //数据加载完成后，调用界面更新方法   Remember to refresh when contents are loaded (ie: on ajax completion)
    }, 500);       // <-- Simulate network congestion, remove setTimeout from production!
} 

function refreshPage() {
    window.top.location.href = location.href; 
}

/**
* 初始化iScroll控件
*/
function loaded() {
    pullDownEl = document.getElementById('pullDown');
    pullDownOffset = pullDownEl.offsetHeight;

    myScroll = new iScroll('wrapperdetail', {
        scrollbarClass: 'myScrollbar', /* 重要样式 */
        useTransition: true, 
        topOffset: pullDownOffset,
        onRefresh: function () {
            //            if (pullDownEl.className.match('loading')) {
            //                pullDownEl.className = '';
            //                pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
            //            } 
        },
        onScrollMove: function () {
            $("#pullDown").show();
//          if (this.y > 5 && !pullDownEl.className.match('flip')) {
//              pullDownEl.className = 'flip';
//              pullDownEl.querySelector('.pullDownLabel').innerHTML = '松手开始更新...';
//              this.minScrollY = 0;
//          } else if (this.y < 5 && pullDownEl.className.match('flip')) {
//              pullDownEl.className = '';
//              pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
//              this.minScrollY = -pullDownOffset;
//          }
			if (this.y > 10 && !pullDownEl.className.match('pulling')) {
                pullDownEl.className = 'pulling';
                pullDownEl.querySelector('.pullDownIcon').style.transform = 'rotateZ(-180deg)';
                pullDownEl.querySelector('.pullDownIcon').style.webkitTransform = 'rotateZ(-180deg)';
                this.minScrollY = 0;
            } 
            if (this.y < 10 && pullDownEl.className.match('pulling')) {
                pullDownEl.className = '';
                pullDownEl.querySelector('.pullDownIcon').style.transform = 'rotateZ(0)';
                pullDownEl.querySelector('.pullDownIcon').style.webkitTransform = 'rotateZ(0)';
                this.minScrollY = -pullDownOffset;
            } 
        },
        onScrollEnd: function () {
//          if (pullDownEl.className.match('flip')) {
//              pullDownEl.className = 'loading';
//              pullDownEl.querySelector('.pullDownLabel').innerHTML = '加载中...';
//              pullDownAction();
//          }
			if (pullDownEl.className.match('pulling')) {
                pullDownEl.className = 'loading';
                pullDownEl.querySelector('.pullDownIcon').style.transform = 'rotateZ(0)';
                pullDownEl.querySelector('.pullDownIcon').style.webkitTransform = 'rotateZ(0)';
                pullDownAction();   // Execute custom function (ajax call?)
            }
        }
    });


    setTimeout(function () { document.getElementById('wrapperdetail').style.left = '0'; }, 800);
}

//初始化绑定iScroll控件 
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
document.addEventListener('DOMContentLoaded', loaded, false);