var myScroll,
    pullDownEl, pullDownOffset,
    pullUpEl, pullUpOffset,
    generatedCount = 0;
var pageIndex = 1;
var pageCount = 1;

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
    var upHtml = '<div class="centerBox-wp">'+
		                '<div class="pullDownTips">'+                
		                    '<div class="pullLoading">'+
		                    	'<div class="loading-circle"></div>'+
		                    	'<div class="loading-logo"></div>'+
		                    '</div>'+
		                '</div>'+
		            '</div>';        		
            
	$('#pullDown').html('').html(downHtml);
	$('#pullUp').html('').html(upHtml);
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
        pageIndex = 1;
        if (iScroll.onLoadData) iScroll.onLoadData("empty");
        myScroll.refresh();     //数据加载完成后，调用界面更新方法   Remember to refresh when contents are loaded (ie: on ajax completion)
    }, 1000);       // <-- Simulate network congestion, remove setTimeout from production!
}

/**
* 向上滚动翻页 （自定义实现此方法）
* myScroll.refresh();      // 数据加载完成后，调用界面更新方法
*/
function pullUpAction() {
    setTimeout(function () {    // <-- Simulate network congestion, remove setTimeout from production!
        if (pageCount > 1) {
            if (pageIndex < pageCount) {
                pageIndex++;
                if (iScroll.onLoadData) iScroll.onLoadData("append"); //加载数据  
            }
        }
        myScroll.refresh();     // 数据加载完成后，调用界面更新方法 Remember to refresh when contents are loaded (ie: on ajax completion)
    }, 1000);         // <-- Simulate network congestion, remove setTimeout from production!
}

/**
* 初始化iScroll控件
*/
function loaded() {
    pullDownEl = document.getElementById('pullDown');
    pullDownOffset = pullDownEl.offsetHeight;
    pullUpEl = document.getElementById('pullUp');
    pullUpOffset = pullUpEl.offsetHeight;

    myScroll = new iScroll('wrapper', {
        scrollbarClass: 'myScrollbar', /* 重要样式 */
        useTransition: true, 
        topOffset: pullDownOffset,
        onRefresh: function () {
            if (pullDownEl.className.match('loading')) {
                pullDownEl.className = '';
                //pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
            } else if (pullUpEl.className.match('loading')) {
                pullUpEl.className = '';
                //pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
                //有翻页到底时不显示
                if (pageIndex == pageCount) {
                    $("#pullUp").hide();
                }
            }
        },
        onScrollMove: function () {
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
            if (pullDownEl.className.match('pulling')) {
                pullDownEl.className = 'loading';
                pullDownEl.querySelector('.pullDownIcon').style.transform = 'rotateZ(0)';
                pullDownEl.querySelector('.pullDownIcon').style.webkitTransform = 'rotateZ(0)';
                pullDownAction();   // Execute custom function (ajax call?)
            }
            if (this.y == this.maxScrollY ) {
            	pullUpEl.className = 'loading';
            	pullUpAction(); 
            }
        }
    });


    setTimeout(function () { document.getElementById('wrapper').style.left = '0'; }, 800);
}


function banTouchmove(){
	$(document).bind('touchmove',function(e){
    	e.preventDefault();
    })
}

//初始化绑定iScroll控件 
if (document.URL.indexOf("Repayment/return_pay_list.aspx") == -1)//回款还款列表页面不执行
//  document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
	banTouchmove();
    
document.addEventListener('DOMContentLoaded', loaded, false);