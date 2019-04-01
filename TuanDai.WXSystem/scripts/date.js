function getMonIndex(){
	var oDate = new Date();
	var nowMonth = oDate.getMonth()+1;
	var monIndex = [];
	switch (nowMonth){
		case 1: monIndex = [1,2,3,4,5,6];break;
		case 2: monIndex = [2,3,4,5,6,7];break;
		case 3: monIndex = [3,4,5,6,7,8];break;
		case 4: monIndex = [4,5,6,7,8,9];break;
		case 5: monIndex = [5,6,7,8,9,10];break;
		case 6: monIndex = [6,7,8,9,10,11];break;
		case 7: monIndex = [7,8,9,10,11,12];break;
		case 8: monIndex = [8,9,10,11,12,1];break;
		case 9: monIndex = [9,10,11,12,1,2];break;
		case 10: monIndex = [10,11,12,1,2,3];break;
		case 11: monIndex = [11,12,1,2,3,4];break;
		case 12: monIndex = [12,1,2,3,4,5];break;
		default: break;
	}
	return monIndex;
}

function getSixMonth(container,mon,weekday){
	var oDate = new Date();
	var nowYear = oDate.getFullYear();
	var sixMonth = {};
	switch(mon){
		case 1 :
			if(nowYear%4==0){
				 sixMonth = {
				 	prev : [12,31],
				 	now  : [31,29,31,30,31,30]
				 }
			}else{
				sixMonth = {
				 	prev : [12,31],
				 	now  : [31,28,31,30,31,30]
				 }
			}
		break;	
		case 2 : 
			if(nowYear%4==0){
				sixMonth = {
				 	prev : [1,31],
				 	now  : [29,31,30,31,30,31]
				 }
			}else{
				sixMonth = {
				 	prev : [1,31],
				 	now  : [28,31,30,31,30,31]
				 }
			}
		break;
		case 3 : 
			if(nowYear%4==0){
				 sixMonth = {
				 	prev : [2,29],
				 	now  : [31,30,31,30,31,31]
				 }
			}else{
				sixMonth = {
				 	prev : [2,28],
				 	now  : [31,30,31,30,31,31]
				 }
			}
		break;
		case 4 : 
				sixMonth = {
				 	prev : [3,31],
				 	now  : [30,31,30,31,31,30]
				 }
		break;
		case 5 : 
				 sixMonth = {
				 	prev : [4,30],
				 	now  : [31,30,31,31,30,31]
				 }
		break;
		case 6 : 
				 sixMonth = {
				 	prev : [5,31],
				 	now  : [30,31,31,30,31,30]
				 }
		break; 
		case 7 : 
				sixMonth = {
				 	prev : [6,30],
				 	now  : [31,31,30,31,30,31]
				 }
		break;
		case 8 : 
				sixMonth = {
				 	prev : [7,31],
				 	now  : [31,30,31,30,31,31]
				 }
		break;
		case 9 : 
				if(nowYear%4==0){
					sixMonth = {
					 	prev : [8,31],
					 	now  : [30,31,30,31,31,29]
					 }
				}else{
					sixMonth = {
					 	prev : [8,31],
					 	now  : [30,31,30,31,31,28]
					 }
				}
		break;
		case 10 : 
				if(nowYear%4==0){
					sixMonth = {
					 	prev : [9,30],
					 	now  : [31,30,31,31,29,31]
					 }
				}else{
					sixMonth = {
					 	prev : [9,30],
					 	now  : [31,30,31,31,28,31]
					 }
				}
		break;
		case 11 : 
				if(nowYear%4==0){
					sixMonth = {
					 	prev : [10,30],
					 	now  : [30,31,31,29,31,30]
					 }
				}else{
					sixMonth = {
					 	prev : [10,30],
					 	now  : [30,31,31,28,31,30]
					 }
				}
		break;
		case 12 : 
				if(nowYear%4==0){
					sixMonth = {
					 	prev : [11,30],
					 	now  : [31,31,29,31,30,31]
					 }
				}else{
					sixMonth = {
					 	prev : [11,30],
					 	now  : [31,31,28,31,30,31]
					 }
				}
		break;
		default : break;		
		
	}
	buildDate(container,sixMonth,mon,weekday);
}
			
			
function buildDate(container,sixMonth,mon,weekday){
	var strDay = '';
	container.append('<ul class="date_row date_ul clearfix ul'+mon+'"month="'+ mon +'"></ul>');
	if(weekday!=0){
		for(var i=0;i<weekday;i++){
			strDay += '<li></li>';
		}
	}
	for(var i=1;i<=sixMonth.now[0];i++){
		strDay += '<li>'+i+'</li>';
	}
	container.find('.ul'+mon).html(strDay);
}		

function getWeekday(index){
	var weekArr = [];
	for(var i=0;i<index.length;i++){
		var oDate = new Date();
		oDate.setMonth(index[i]-1);
		oDate.setDate(1);
		weekArr.push(oDate.getDay());
	}
	return weekArr;
}

function getYear(){
	var oDate = new Date();
	var nowYear = oDate.getFullYear();
	var date_ul = $('.date_ul');
	for (var i = 0; i <= 5; i++) {
	    if (i > 0) {
	        if (parseInt(date_ul.eq(i).attr('month')) < parseInt(date_ul.eq(i - 1).attr('month'))) {
	            nowYear += 1;
	        }
	    }
		date_ul.eq(i).attr('year',nowYear);
	}
	
}
