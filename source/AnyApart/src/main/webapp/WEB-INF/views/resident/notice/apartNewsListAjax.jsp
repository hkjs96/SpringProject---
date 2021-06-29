<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href='${cPath }/js/fullcalendar-5.5.1/lib/main.css' rel='stylesheet' />
<script src='${cPath }/js/fullcalendar-5.5.1/lib/main.js'></script>
<div id='calendar'></div>
<script>
var eventsArr = [];
const date = new Date();
var year = date.getFullYear();
var month = date.getMonth();
console.log(month);
var cDateInit1 = year+"-0"+month+"-01";
var cDateInit2 = year+"-0"+(month+1)+"-01";

function makeSchedule(){
	let cDate1 = cDateInit1;
	let cDate2 = cDateInit2;
	scheduleAjax(cDate1, cDate2);
}

$(document).ready(function(){
	makeSchedule();
});

function scheduleAjax(cDate1, cDate2){
	$.ajax({
		dataType:"json"
		,data : {"cDate1":cDate1, "cDate2":cDate2}
		,success:function(resp){
			let dataList = resp;
			$(dataList).each(function(idx,schedulVO){
				eventsArr.push(
			        {
			          title: schedulVO.schdTitle,
			          start: schedulVO.schdStart
			        }
			    )
			});
			var calendarEl = document.getElementById('calendar');
			var calendar = new FullCalendar.Calendar(calendarEl, {
				initialView : 'dayGridMonth',  //달력화면   timeGridWeek:시간표 화면나옴
				headerToolbar : {
					left : 'prev,next',
					center : 'title',
					right : 'dayGridMonth,dayGridWeek,dayGridDay'
				},
			    dayMaxEvents: true, // allow "more" link when too many events
			    events: eventsArr
			});
			calendar.render();
		}
	})
}

function makeMonth(monthStr){
	let month = 0; 
	switch (monthStr) {
	case "January":
		month = 1;
		break;
	case "February":
		month = 2;
		break;
	case "March":
		month = 3;
		break;
	case "April":
		month = 4;
		break;
	case "May":
		month = 5;
		break;
	case "June":
		month = 6;
		break;
	case "July":
		month = 7;
		break;
	case "August":
		month = 8;
		break;
	case "September":
		month = 9;
		break;
	case "October":
		month = 10;
		break;
	case "November":
		month = 11;
		break;
	default:
		month = 12;
		break;
	}
	return month;
}

$("#rowDiv").on("click", "button", function(event){
	
});
</script>
