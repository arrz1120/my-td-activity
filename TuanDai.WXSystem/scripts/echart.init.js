//交易额图标
function chart1() {
	var myChart = echarts.init(document.getElementById('chart1'));
	var option = {
		title: {},
		tooltip: {
			trigger: 'axis'
		},
		legend: {
			data: []
		},
		toolbox: {
			feature: {
				saveAsImage: {}
			}
		},
		grid: {
			left: '3%',
			right: '6%',
			top: '10',
			bottom: '10',
			containLabel: true,
			backgroundColor: '#ffffff'
		},
		xAxis: [{
			type: 'category',
			boundaryGap: false,
			splitLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			axisLabel: {
				textStyle: {
					color: '#808080',
					fontSize: 12
				}
			},
			axisLine: {
				show:false,
//				lineStyle: {
//					color: '#f4f4f4',
//					width: '1'
//				}
			},
			data: dayArr //['03-23', '03-24', '03-25', '03-26', '03-27', '03-28']
		}],
		yAxis: [{
			type: 'value',
			axisLine: {
				show: false
//				lineStyle: {
//					color: '#f4f4f4',
//					width: '1'
//				}
			},
			axisTick: {
				show: false
			},
			splitNumber: 3,
			axisLabel: {
				formatter: function(value, index) {
					if (index == 0) {
						value = '';
						return value;
					} else {
						return value + '万';
					}
				},
				textStyle: {
					color: '#808080',
					fontSize: 12
				},
				margin: 6
			},
			splitLine: {
				show: true,
				lineStyle: {
					'color': '#f4f4f4',
					'width': '1'
				}
			}
		}],
		series: [{
			type: 'line',
			areaStyle: {
				normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgba(255, 179, 163,0.4)'
                    }, {
                        offset: 1,
                        color: 'rgba(255, 244, 242,0.4)'
                    }])
                }	
			},
			itemStyle: {
				normal: {
					color: '#fd6040'
				}
			},
			data: dayAmountArr,//[6000, 8000, 6000, 8000, 6000, 8000],
			lineStyle: {
				normal: {
					color: '#fd6040',
					width: '1'
				}
			},
			symbolSize: 0
		}]
	};
	myChart.setOption(option);
}
//投资人年龄图表1
function chart21() {
	var myChart = echarts.init(document.getElementById('chart2-1'));
	var option = {
		tooltip: {
			trigger: 'axis',
			axisPointer: {
				type: 'shadow'
			}
		},
		legend: {
			data: []
		},
		grid: {
			top: '5px',
			left: '10%',
			right: '4%',
			bottom: '22px'
		},
		xAxis: [{
			type: 'category',
			splitLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			axisLine: {
				show: false,
				lineStyle: {
					width: '1',
					color: '#f4f4f4',
				}
			},
			axisLabel: {
				textStyle: {
					color: '#808080',
					fontSize: 12
				}
			},
			data: ['18-25岁', '26-35岁', '36-45岁', '45岁以上']
		}],
		yAxis: [{
			type: 'value',
			axisTick: {
				show: false
			},
			splitNumber: 4,
			axisLine: {
				show: false,
				lineStyle: {
					width: 1,
					color: '#f4f4f4',
				}
			},
			axisLabel: {
				formatter: function(value, index) {
					if (index == 0) {
						value = '';
						return value;
					} else {
						return value / 10000 + '万';
					}
				},
				min: 'dataMin',
				max: 'dataMax',
				textStyle: {
					color: '#808080',
					fontSize: 12
				},
				margin: 6
			},
			splitLine: {
				lineStyle: {
					color: '#f4f4f4',
					width: 1
				}
			}
		}],
		series: [{
			name: '男',
			type: 'bar',
			//					barWidth : 15,
			barMaxWidth: 20,
			barGap: 0,
			itemStyle: {
				normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgb(255, 207, 31)'
                    }, {
                        offset: 1,
                        color: 'rgb(255, 226, 31)'
                    }])
                }
			},
			data: [27233, 59344, 80709, 105146]
		}, {
			name: '女',
			type: 'bar',
			//					barWidth : 15,
			barMaxWidth: 20,
			barGap: 0,
			itemStyle: {
				normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgb(255, 124, 97)'
                    }, {
                        offset: 1,
                        color: 'rgb(255, 151, 58)'
                    }])
                }
			},
			data: [25111, 61373, 93753, 93378]
		}]
	};
	myChart.setOption(option);
}
//投资人年龄图表2
function chart22() {
	var myChart = echarts.init(document.getElementById('chart2-2'));
	var option = {
		tooltip: {
			trigger: 'axis',
			axisPointer: {
				type: 'shadow'
			}
		},
		legend: {
			data: []
		},
		grid: {
			top: '5px',
			left: '10%',
			right: '4%',
			bottom: '22px'
		},
		xAxis: [{
			type: 'category',
			splitLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			axisLine: {
				lineStyle: {
					width: 1,
					color: '#f4f4f4',
				}
			},
			axisLabel: {
				textStyle: {
					color: '#808080',
					fontSize: 12
				}
			},
			data: ['18-25岁', '26-35岁', '36-45岁', '45岁以上']
		}],
		yAxis: [{
			type: 'value',
			axisTick: {
				show: false
			},
			splitNumber: 4,
			axisLine: {
				show: false,
				lineStyle: {
					width: 1,
					color: '#f4f4f4',
				}
			},
			axisLabel: {
				formatter: function(value, index) {
					if (index == 0) {
						value = '';
						return value;
					} else {
						return value + '%';
					}
				},
				min: 'dataMin',
				max: 'dataMax',
				textStyle: {
					color: '#808080',
					fontSize: 12
				},
				margin: 6
			},
			splitLine: {
				lineStyle: {
					color: '#f4f4f4',
					width: 1
				}
			}
		}],
		series: [{
			name: '男',
			type: 'bar',
			//					barWidth : 15,
			barMaxWidth: 20,
			barGap: 0,
			itemStyle: {
				normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgb(255, 207, 31)'
                    }, {
                        offset: 1,
                        color: 'rgb(255, 226, 31)'
                    }])
                }
			},
			data: [7.51, 28.53, 14.93, 11.07]
		}, {
			name: '女',
			type: 'bar',
			//					barWidth : 15,
			barMaxWidth: 20,
			barGap: 0,
			itemStyle: {
				normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgb(255, 124, 97)'
                    }, {
                        offset: 1,
                        color: 'rgb(255, 151, 58)'
                    }])
                }	
			},
			data: [4.39, 16.24, 8.57, 8.76]
		}]
	};
	myChart.setOption(option);
}
//人均投资金额-按月
function chart31() {
	var myChart = echarts.init(document.getElementById('chart3-1'));
	var option = {
		title: {},
		tooltip: {
			trigger: 'axis'
		},
		legend: {
			data: []
		},
		toolbox: {
			feature: {
				saveAsImage: {}
			}
		},
		grid: {
			left: '3%',
			right: '4%',
			top: '5',
			bottom: '0',
			containLabel: true,
			backgroundColor: '#ffffff'
		},
		xAxis: [{
			type: 'category',
			boundaryGap: false,
			//					splitNumber: 6,
			splitLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			axisLabel: {
				textStyle: {
					color: '#808080',
					fontSize: 12
				}
			},
			axisLine: {
				show:false,
				lineStyle: {
					color: '#f4f4f4',
					width: '1'
				}
			},
			data: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30']
		}],
		yAxis: [{
			type: 'value',
			axisLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			splitNumber: 3,
			axisLabel: {
				formatter: function(value, index) {
					if (index == 0) {
						value = '';
						return value;
					} else {
						return value;
					}
				},
				textStyle: {
					color: '#808080',
					fontSize: 12
				},
				margin: 6
			},
			splitLine: {
				show: true,
				lineStyle: {
					'color': '#f4f4f4',
					'width': '1'
				}
			}
		}],
		series: [{
			name: '最大值',
			type: 'line',
			areaStyle: {
				normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgba(255, 179, 163,0.4)'
                    }, {
                        offset: 1,
                        color: 'rgba(255, 244, 242,0.4)'
                    }])
                }	
			},
			data: [12166, 10087, 10135, 12841, 11816, 11446, 14033, 14324, 12124, 12722, 14776, 11923, 11099, 15269, 13557, 10851, 9820, 12535, 12286, 9745, 13751, 12995, 11930, 11141, 14198, 10646, 10448, 13382, 12722, 9183],
			itemStyle: {
				normal: {
					color: '#fd6040'
				}
			},
			lineStyle: {
				normal: {
					color: '#fd6040',
					width: '1'
				}
			},
			symbolSize: 0,
		}]
	};
	myChart.setOption(option);
}
//投资人数占比-按月
function chart41() {
	var myChart = echarts.init(document.getElementById('chart4-1'));
	var option = {
		title: {},
		tooltip: {
			trigger: 'axis'
		},
		legend: {
			data: []
		},
		toolbox: {
			feature: {
				saveAsImage: {}
			}
		},
		grid: {
			left: '3%',
			right: '4%',
			top: '5',
			bottom: '0',
			containLabel: true,
			backgroundColor: '#ffffff'
		},
		xAxis: [{
			type: 'category',
			boundaryGap: false,
			//					splitNumber: 6,
			splitLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			axisLabel: {
				textStyle: {
					color: '#808080',
					fontSize: 12
				}
			},
			axisLine: {
				show:false,
				lineStyle: {
					color: '#f4f4f4',
					width: '1'
				}
			},
			data: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30']
		}],
		yAxis: [{
			type: 'value',
			axisLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			splitNumber: 3,
			axisLabel: {
				formatter: function(value, index) {
					if (index == 0) {
						value = '';
						return value;
					} else {
						return value + '%';
					}
				},
				textStyle: {
					color: '#808080',
					fontSize: 12
				},
				margin: 4
			},
			splitLine: {
				show: true,
				lineStyle: {
					'color': '#f4f4f4',
					'width': '1'
				}
			}
		}],
		series: [{
			name: '最大值',
			type: 'line',
			areaStyle: {
				normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgba(255, 179, 163,0.4)'
                    }, {
                        offset: 1,
                        color: 'rgba(255, 244, 242,0.4)'
                    }])
                }	
			},
			data: [3.11, 3.16, 2.8, 3.24, 3.9, 3.35, 3.6, 3.65, 3, 3.2, 3.59, 3.11, 2.75, 3.31, 3.31, 2.98, 2.94, 3.35, 3.74, 3.23, 3.73, 3.58, 3.23, 3.35, 3.54, 3.11, 3.14, 3.54, 3.94, 3.52],
			itemStyle: {
				normal: {
					color: '#fd6040'
				}
			},
			lineStyle: {
				normal: {
					color: '#fd6040',
					width: '1'
				}
			},
			symbolSize: 0
		}]
	};
	myChart.setOption(option);
}

//人均投资金额-按日
function chart32() {
	var myChart = echarts.init(document.getElementById('chart3-2'));
	var option = {
		title: {},
		tooltip: {
			trigger: 'axis'
		},
		legend: {
			data: []
		},
		toolbox: {
			feature: {
				saveAsImage: {}
			}
		},
		grid: {
			left: '3%',
			right: '4%',
			top: '5',
			bottom: '0',
			containLabel: true,
			backgroundColor: '#ffffff'
		},
		xAxis: [{
			type: 'category',
			boundaryGap: false,
			//					splitNumber: 6,
			splitLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			axisLabel: {
				textStyle: {
					color: '#808080',
					fontSize: 12
				}
			},
			axisLine: {
				show:false,
				lineStyle: {
					color: '#f4f4f4',
					width: '1'
				}
			},
			data: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00']
		}],
		yAxis: [{
			type: 'value',
			axisLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			splitNumber: 3,
			axisLabel: {
				formatter: function(value, index) {
					if (index == 0) {
						value = '';
						return value;
					} else {
						return value;
					}
				},
				min: 'dataMin',
				max: 'dataMax',
				textStyle: {
					color: '#808080',
					fontSize: 12
				},
				margin: 6
			},
			splitLine: {
				show: true,
				lineStyle: {
					'color': '#f4f4f4',
					'width': '1'
				}
			}
		}],
		series: [{
			name: '最大值',
			type: 'line',
			areaStyle: {
				normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgba(255, 179, 163,0.4)'
                    }, {
                        offset: 1,
                        color: 'rgba(255, 244, 242,0.4)'
                    }])
                }	
			},
			data: [18563, 9639, 7420, 6908, 8407, 10781, 11427, 11271, 9971, 11748, 14957, 18563, 17127, 16398, 18857, 19101, 18430, 17150, 14992, 10966, 10113, 9856, 9044, 10209],
			itemStyle: {
				normal: {
					color: '#fd6040'
				}
			},
			lineStyle: {
				normal: {
					color: '#fd6040',
					width: '1'
				}
			},
			symbol: 'circle',
			symbolSize: 0,
			markPoint: {
				data: [{
					type: 'max',
					name: '最大值'
				}, {
					type: 'min',
					name: '最小值'
				}]
			}
		}]
	};
	myChart.setOption(option);
}
//投资人数占比-按日
function chart42() {
	var myChart = echarts.init(document.getElementById('chart4-2'));
	var option = {
		title: {},
		tooltip: {
			trigger: 'axis'
		},
		legend: {
			data: []
		},
		toolbox: {
			feature: {
				saveAsImage: {}
			}
		},
		grid: {
			left: '3%',
			right: '4%',
			top: '5',
			bottom: '0',
			containLabel: true,
			backgroundColor: '#ffffff'
		},
		xAxis: [{
			type: 'category',
			boundaryGap: false,
			//					splitNumber: 6,
			splitLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			axisLabel: {
				textStyle: {
					color: '#808080',
					fontSize: 12
				}
			},
			axisLine: {
				show:false,
				lineStyle: {
					color: '#f4f4f4',
					width: '1'
				}
			},
			data: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00']
		}],
		yAxis: [{
			type: 'value',
			axisLine: {
				show: false
			},
			axisTick: {
				show: false
			},
			splitNumber: 3,
			axisLabel: {
				formatter: function(value, index) {
					if (index == 0) {
						value = '';
						return value;
					} else {
						return value + '%';
					}
				},
				min: 'dataMin',
				max: 'dataMax',
				textStyle: {
					color: '#808080',
					fontSize: 12
				},
				margin: 6
			},
			splitLine: {
				show: true,
				lineStyle: {
					'color': '#f4f4f4',
					'width': '1'
				}
			}
		}],
		series: [{
			name: '最大值',
			type: 'line',
			areaStyle: {
				normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgba(255, 179, 163,0.4)'
                    }, {
                        offset: 1,
                        color: 'rgba(255, 244, 242,0.4)'
                    }])
                }	
			},
			data: [4.79, 1.84, 0.97, 0.73, 0.76, 1.29, 2.76, 3.93, 5.36, 6.18, 6.98, 6.81, 5.76, 5.92, 6.13, 6.23, 5.94, 5.38, 4.41, 3.8, 3.91, 3.83, 3.39, 2.93],
			itemStyle: {
				normal: {
					color: '#fd6040'
				}
			},
			lineStyle: {
				normal: {
					color: '#fd6040',
					width: '1'
				}
			},
			symbol: 'circle',
			symbolSize: 0,
			markPoint: {
				data: [{
					type: 'max',
					name: '最大值'
				}, {
					type: 'min',
					name: '最小值'
				}]
			}
		}]
	};
	myChart.setOption(option);
}

//图表切换
function tabChart1() {
	var parent = $("#chart2Tab");
	var child1 = parent.find('div:first-child');
	var child2 = parent.find('div:last-child');
	var childBg = parent.find('div.chartTabBg');
	child1.click(function() {
		if (!child1.hasClass('active')) {
			child1.addClass('active');
			child2.removeClass('active');
			childBg.css('-webkit-transform','translateX(0)');
			$('#chart2-1').html('').show();
			$('#chart2-2').hide();
			chart21();
		}
	})
	child2.click(function() {
		if (!child2.hasClass('active')) {
			child2.addClass('active');
			child1.removeClass('active');
			childBg.css('-webkit-transform','translateX(100%)');
			$('#chart2-2').html('').show();
			$('#chart2-1').hide();
			chart22();
		}
	})

}

function tabChart2() {
	var chart3Tab = $("#chart3Tab");
	var chart4Tab = $("#chart4Tab");
	var chart3Bg = chart3Tab.find('.chartTabBg');
	var chart4Bg = chart4Tab.find('.chartTabBg');
	var amo = chart3Tab.find('div:first-child');
	var people = chart3Tab.find('div:last-child');
	var month = chart4Tab.find('div:first-child');
	var day = chart4Tab.find('div:last-child');

	amo.click(function() {
		if (!$(this).hasClass('active')) {
			$(this).addClass('active');
			people.removeClass('active');
			chart3Bg.css('-webkit-transform','translateX(0)');
			if (month.hasClass('active')) {
				$('#chart3-1').html('').show();
				$('#chart3-2,#chart4-1,#chart4-2').hide();
				chart31();
			} else {
				$('#chart3-2').html('').show();
				$('#chart3-1,#chart4-1,#chart4-2').hide();
				chart32();
			}
		}
	})

	people.click(function() {
		if (!$(this).hasClass('active')) {
			$(this).addClass('active');
			amo.removeClass('active');
			chart3Bg.css('-webkit-transform','translateX(100%)');
			if (month.hasClass('active')) {
				$('#chart4-1').html('').show();
				$('#chart3-1,#chart3-2,#chart4-2').hide();
				chart41();
			} else {
				$('#chart4-2').html('').show();
				$('#chart3-1,#chart3-2,#chart4-1').hide();
				chart42();
			}
		}
	})

	month.click(function() {
		if (!$(this).hasClass('active')) {
			$(this).addClass('active');
			day.removeClass('active');
			chart4Bg.css('-webkit-transform','translateX(0)');
			if (amo.hasClass('active')) {
				$('#chart3-1').html('').show();
				$('#chart3-2,#chart4-1,#chart4-2').hide();
				chart31();
			} else {
				$('#chart4-1').html('').show();
				$('#chart3-1,#chart3-2,#chart4-2').hide();
				chart41();
			}
		}
	})

	day.click(function() {
		if (!$(this).hasClass('active')) {
			$(this).addClass('active');
			month.removeClass('active');
			chart4Bg.css('-webkit-transform','translateX(100%)');
			if (amo.hasClass('active')) {
				$('#chart3-2').html('').show();
				$('#chart3-1,#chart4-1,#chart4-2').hide();
				chart32();
			} else {
				$('#chart4-2').html('').show();
				$('#chart3-1,#chart3-2,#chart4-1').hide();
				chart42();
			}
		}
	})
}

//图表初始化调用
chart1();
chart21();
chart31();
tabChart1();
tabChart2();