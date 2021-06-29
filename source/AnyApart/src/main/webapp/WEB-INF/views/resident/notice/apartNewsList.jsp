<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href='${cPath }/js/fullcalendar-5.5.1/lib/main.css' rel='stylesheet' />
<script src='${cPath }/js/fullcalendar-5.5.1/lib/main.js'></script>

<style>
.fc-day-sun{
	color : red;
}
.fc-day-sat{
	color : blue;
}
#modalTbody th{
	text-align: center;
	background-color: #F0F2F5;
}
#calendar table th, td{
	border: 1px solid #DDDDDD;
}
#rmdlViewModal{
	margin-top: 10%;
	width: 60%;
	margin-left: 20%;
}
#imgDiv img{
	width: 20px;
	height: 22px;
	border: 1px solid black;
	margin-right: 10px;
}
#imgDiv p{
	display: inline;
	margin-right: 22%;
	padding: 0px;
}
#imgDiv{
	margin-bottom: 70px;
}
</style>
<div id="imgDiv">
	<p><img src="${cPath}/images/cPink.png">아파트 행사</p>
	<p><img src="${cPath}/images/cGreen.png">아파트 수선</p>
	<p><img src="${cPath}/images/cPurple.png">리모델링</p>
</div>
<div id='calendar'></div>
<!-- 상세조회 모달 -->
<div class="modal" id="rmdlViewModal">
	<div class="modal-dialog modal-xl">
		<div class="modal-content"></div>
	</div>
</div>

<c:set var="asList" value="${asList }"/>
<c:set var="rmdlList" value="${rmdlList }"/>
<c:set var="eventList" value="${eventList }"/>
<script>
var eventsArr = [];
let asList = JSON.parse('${asList}');
let rmdlList = JSON.parse('${rmdlList}');
let eventList = JSON.parse('${eventList}');
$(rmdlList).each(function(idx,schedulVO){
	eventsArr.push(
        {
          title: schedulVO.schdTitle,
          start: schedulVO.schdStart,
          end : schedulVO.schdEnd,
          color : '#9070F9',
          id : schedulVO.schdType+schedulVO.schdNo
        }
    )
});
$(asList).each(function(idx,schedulVO){
	eventsArr.push(
        {
          title: schedulVO.schdTitle,
          start: schedulVO.schdStart,
          end : schedulVO.schdEnd,
          color : '#09C4D1',
          id : schedulVO.schdType+schedulVO.schdNo
        }
    )
});
$(eventList).each(function(idx,schedulVO){
	eventsArr.push(
        {
          title: schedulVO.schdTitle,
          start: schedulVO.schdStart,
          end : schedulVO.schdEnd,
          color : '#F97095',
          id : schedulVO.schdType+schedulVO.schdNo
        }
    )
});

let modalTbody = $("#modalTbody");
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		locale : 'ko',
		initialView : 'dayGridMonth',  //달력화면   timeGridWeek:시간표 화면나옴
		themeSystem: 'bootstrap',
		headerToolbar : {
			left : 'prevYear,prev,next,nextYear today',
			center : 'title',
			right : 'dayGridMonth,dayGridWeek,dayGridDay'
		},
	    events: eventsArr,
	    eventTextColor: 'white',
	    eventClick: function(info) {
	    	let id = info.event.id;
	    	let schdType = id.substring(0,4);
	    	let schdNo = id.substring(4, id.length);
	    	makeModal(schdNo);
	    }
	});
	calendar.render();
});

let rmdlViewModal = $("#rmdlViewModal").on("hidden.bs.modal", function() {
	$(this).find(".modal-content").empty();
});

function makeModal(schdNo){
	rmdlViewModal.find(".modal-content").load("${cPath}/resident/notice/apartNewsView.do?schdNo="+schdNo, function(){
		rmdlViewModal.modal();
	});	
}

$("#closeBtn").on("click", function(){
	rmdlViewModal.hide();
});

</script>

