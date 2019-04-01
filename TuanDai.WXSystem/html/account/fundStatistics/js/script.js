function chart1() {
	var myChart = echarts.init(document.getElementById('chart1'));
	option = {
		tooltip: {
			show: true,
			trigger: 'axis',
			triggerOn: 'mousemove',
			backgroundColor: 'rgba( 255, 255, 255, 0.8 )',
			position: function(point, params, dom) {
				if(point[0] > 600) {
					point[0] = 600;
				}
				//				console.log(point[0]);
				return [point[0], '-20'];

			},
			extraCssText: 'box-shadow:0px 2px 10px 0px rgba(236, 96, 0, 0.3);',
			axisPointer: {
				lineStyle: {
					color: '#fd6040',
				},
				animation: false
			},
			padding: [20, 20, 20, 20],
			formatter: '{b0}',
			textStyle: {
				fontSize: 20,
				color: '#212121'
			}

		},
		grid: {
			left: '50',
			right: '30',
			top: '0',
			bottom: '0',
			containLabel: true
		},
		calculable: true,
		xAxis: [{
			type: 'category',
			boundaryGap: false,
			axisTick: {
				show: false
			},
			axisLine: {
				show: false
			},
			splitLine: {
				//				show: false,
				lineStyle: {
					color: '#f4f4f4'
				}
			},
			axisLabel: {
				textStyle: {
					color: '#fff',
					fontSize: 10
				},
				margin: 20
			},
			data: ['2016.04.10', '2016.04.11', '2016.04.12', '2016.04.13', '2016.04.14', '2016.04.15', '2016.04.16']
		}],

		yAxis: [{
			type: 'value',
			scale: 1,
			axisTick: {
				show: false
			},
			splitNumber: 3,
			axisLine: {
				show: false,
				lineStyle: {
					width: 1,
					color: '#eee',
				}
			},
			axisLabel: {
				textStyle: {
					color: '#808080',
					fontSize: 20
				},
				margin: 8
			},
			splitLine: {
				lineStyle: {
					color: '#eee'
				}
			},
		}],

		series: [{
			symbol: 'image://images/point.png',
			symbolSize: 25,
			showSymbol: false,
			zlevel: 3,
			z: 3,
			name: '投资收益',
			type: 'line',
			smooth: true,
			areaStyle: {
				normal: {
					color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
						offset: 0,
						color: 'rgba(255,120,28,0.18)'
					}, {
						offset: 1,
						color: 'rgba(255,241,232,0.18)'
					}])
				}
			},
			itemStyle: {
				normal: {
					lineStyle: {
						color: '#ff781c',
						width: '3'
					}
				}
			},
			data: [7000, 500, 1000, 6000, 3000, 5687, 9999]
		}]
	};

	myChart.setOption(option);
}

//支出总计高度计算
//P2P
function chart2(){
	var h1 = $("#h1"),
	    h2 = $("#h2"),
	    h3 = $("#h3"),
	    h4 = $("#h4"),
	    yAxis1 = $("#yAxis1"),
	    yAxis2 = $("#yAxis2"),
	    m1 = parseInt(Number($("#num1").html())),
	    m2 = parseInt(Number($("#num2").html())),
	    m3 = parseInt(Number($("#num3").html())),
	    m4 = parseInt(Number($("#num4").html())),
	    numArr = [m1,m2,m3,m4],
	    numMax = m1,
	    max;
	var sortArr=[m1,m2,m3,m4];
	var sortIndex = [];
	//数值从大到小排序
	for(var i=0;i<sortArr.length;i++){
	    for(var j = i + 1;j<sortArr.length;j++){
	        if(sortArr[i]<sortArr[j]){
	            var tmp = sortArr[i];
	            sortArr[i] = sortArr[j];
	            sortArr[j] = tmp;
	        }
	    }
	}
//	console.log(sortArr)
	//获取最大值
	for(var i=1;i<=numArr.length;i++){
		if(numArr[i]>numMax){
			numMax = numArr[i];
		}
	}
	
	//构造从大到小排序的数组的索引
	var indexArr = [];
	for(var i=0;i<sortArr.length;i++){
		for(var j=0;j<=numArr.length;j++){
			if(sortArr[i] == numArr[j]){
				indexArr.push({
					index:j+1,
					num: numArr[j]
				});
				
			}
		}
	}
//	console.log(JSON.stringify(indexArr))
	
	//处理每一个高度的最小值
	var heightArr = [];
	for(var i=0;i<indexArr.length;i++){
		var tempHeight =  indexArr[i].num/numMax * 198;
		if(tempHeight>0&&tempHeight<15){
			tempHeight = 15
		}
		console.log(tempHeight)
		heightArr.push(tempHeight);
	}
	
	//设置每一个高度以及层级
	for(var i=0;i<heightArr.length;i++){
		$('#h'+indexArr[i].index).css({
			'height' : heightArr[i],
			'z-index':i+1
		})
	}
	//设置坐标轴数值
	yAxis1.html(numMax);
	yAxis2.html(numMax/2);
}

//其他收益进度条计算
function otherIncome() {
	var b1 = parseInt($('#hbIncome').html()),
		b2 = parseInt($('#investIncome').html()),
		b3 = parseInt($('#inviteIncome').html()),
		b123 = b1 + b2 + b3,
		bar1 = $('#bar1'),
		bar2 = $('#bar2'),
		bar3 = $('#bar3'),
		w1 = 0,
		w2 = 0,
		w3 = 0;
	if(b123 == 0) {
		$(".oiBar").addClass('oiBarNone');
	} else {
		if(b3 == 0) {
			w3 = 0;
			if(b2 == 0) {
				w2 = 0;
				if(bar1 != 0) {
					w1 = 100;
				} else {
					w1 = 0;
				}
			} else {
				w2 = 100;
				w1 = b1 / (b1 + b2) * 100;
			}
		} else {
			w3 = 100;
			if(b1 == 0) {
				w1 = 0;
				if(bar2 != 0) {
					w2 = b2 / b123 * 100;
				} else {
					w2 = 0;
				}
			} else {
				w1 = b1 / b123 * 100;
				if(b2 == 0) {
					w2 = 0;
				} else {
					w2 = (b1 + b2) / b123 * 100;
				}
			}
		}
		if(w1 != 0 && w1 < 4) {
			w1 = 4;
		}
		if(w2 != 0 && w2 < 4) {
			w2 = 8;
		}
		bar1.width(w1 + '%');
		bar2.width(w2 + '%');
		bar3.width(w3 + '%');
	}
}

$(function() {
//	chart1();
	chart2();
	var swiper1 = new Swiper('#swiper1', {
		pagination: '#page1'
	});
	otherIncome();
})