<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href='${cPath }/js/fullcalendar-5.5.1/lib/main.css' rel='stylesheet' />
<script src='${cPath }/js/fullcalendar-5.5.1/lib/main.js'></script>
<link href='${cPath }/css/office/wholeCalendar.css' rel="stylesheet">

<style>
	th {
		background-color: #E9EAE8;
	}
</style>

<br>
<h2>
	<strong>커뮤니티시설 예약일정</strong>
</h2>
<br>
<div id='calendar'></div>

<div class="modal fade" id="viewModal" tabindex="-1" aria-labelledby="viewModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-dialog-scrollable modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="viewModalLabel">예약정보</h3>
<!-- 				<span style="color: green; font-size: 10pt"><strong> * 예약 취소는 하루전까지 가능합니다.</strong></span> -->
			</div>
			<div class="modal-body">
				<table class="table table-bordered text-center">
					<tbody>
						<tr>
							<th class="text-center">시설명</th>
							<td id="viewName" colspan="4">
								
							</td>
						</tr>
						<tr>
							<th class="text-center">예약자명</th>
							<td id="viewResName">
								
							</td>
						</tr>
						<tr>
							<th class="text-center">예약일</th>
							<td id="viewDate" colspan="2">
								
							</td>
						</tr>
						<tr>
							<th class="text-center">핸드폰 번호</th>
							<td id="viewResHp">
								
							</td>
						</tr>
						<tr>
							<th class="text-center">예약시간</th>
							<td id="viewTime" colspan="2">
							
							</td>
						</tr>
						<tr>
							<th class="text-center">예약 인원</th>
							<td id="viewCnt">
								
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script>

let businessHours =  [ // specify an array instead
	  {
	    daysOfWeek: [ 1, 2, 3, 4, 5, 6, 7 ], // Monday, Tuesday, Wednesday
	    startTime: '08:00', // 8am
	    endTime: '21:00' // 6pm
	  }
	] ;

let eventsArr = [];
let reservationList = JSON.parse('${reservationList }');
$(reservationList).each(function(idx,reservation){
	eventsArr.push(
		{
           title: reservation.cmntName +" : " +reservation.resvCnt + "명",
           start: reservation.resvStart,
           end : reservation.resvEnd,
           color : '#d6e6f5',
           id : reservation.cmntNo,
           extendedProps : reservation
         }
    )
});

// 보이는 시작 날짜도 정해줘야한다?
let viewModal = $("#viewModal");
		
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	let calendar = new FullCalendar.Calendar(calendarEl, {
		allDaySlot : false,
		scrollTime : '06:00:00',
		locale : 'ko',
// 		initialView : 'timeGridDay',  //달력화면   timeGridWeek:시간표 화면나옴
		initialView : 'dayGridMonth',  //달력화면   timeGridWeek:시간표 화면나옴
		themeSystem: 'bootstrap',
		headerToolbar : {
			left : 'prevYear,prev,next,nextYear today',
			center : 'title',
			right : 'dayGridMonth'	
// 			right : 'dayGridMonth, timeGridDay'	// 하루 씩만 보게 만들어준다.
		},
	    events: eventsArr,
	    eventTextColor: 'black',
	    eventClick: function(info) {
	    	let resvData = info.event._def.extendedProps
	    	let telHp = formatTel(resvData.resHp);
	    	$("#viewDate").text(resvData.resvDate);
			$("#viewName").text(resvData.cmntName);
			$("#viewResName").text(resvData.resName);
			$("#viewResHp").text(telHp);
			$("#viewTime").text(resvData.resvTime);
			$("#viewCnt").text(resvData.resvCnt);
	    	viewModal.modal('show');
	    },
	    dayMaxEventRows: true, // for all non-TimeGrid views
	    views: {
	      timeGrid: {
	        dayMaxEventRows: 3 // adjust to 6 only for timeGridWeek/timeGridDay
	      }
	    }
		, businessHours : businessHours 
		, slotDuration: '00:30' // 보여줄 시간 단위 
// 		, weekends : false // 주말 안보이기 
		, slotMinTime : '08:00:00'	// 보여줄 시작 시간
		, slotMaxTime : '21:30:00'	// 보여줄 끝 시간
		, selectable : true
        , select : function(schedule) {
        	console.log(schedule);
//         	if(communityView.val() > 0 ){
// 	        	let startStr = schedule.startStr.substr(11,2) + schedule.startStr.substr(14,2);
// 	        	let viewStart = schedule.startStr.substr(11,2) + ":" + schedule.startStr.substr(14,2);
// 	        	let endStr = schedule.endStr.substr(11,2) + schedule.endStr.substr(14,2);
// 	        	let viewEnd = schedule.endStr.substr(11,2) + ":" + schedule.endStr.substr(14,2);
	        	
// 	        	let dateStr = schedule.startStr.substr(0,10);
	        	
// 	        	timeBody.find("[name=resvStart]").val(startStr);
// 	        	timeBody.find("[name=resvEnd]").val(endStr);
// 	        	timeBody.find("[name=resvStartSpan]").text(viewStart);
// 	        	timeBody.find("[name=resvEndSpan]").text(viewEnd);        	
// 	        	$("#reservationForm").find(":input[name=resvDate]").val(dateStr);
// 	        	$("#reservationForm").find("[name=resvDateSpan]").text(dateStr);
// 	        	reservationModal.modal('show');
//         	}
         }
	});
	calendar.render();
	
	
});
</script>