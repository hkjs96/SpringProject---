<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href='${cPath }/js/fullcalendar-5.5.1/lib/main.css' rel='stylesheet' />
<script src='${cPath }/js/fullcalendar-5.5.1/lib/main.js'></script>
<link href='${cPath }/css/office/wholeCalendar.css' rel="stylesheet">

<style>
#body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
}
#calendar {
    max-width: 1100px;
    margin: 0 auto;
    margin-left: 10%;
}

/* 상세조회 모달 */
#modalView{
	width: 500px;
	margin-left: 800px;
	margin-top: 150px;
}
#viewDiv th{
	text-align: center;
	background-color: #E9EAE8;
}
#viewDiv td{
	background-color: white;
}
#insertBtn{
	margin-left: 70%;
	margin-bottom: 30px;
}
#rmdlViewModal{
	width: 40%;
	margin-left: 28%;
}
#rmdlViewModal th{
	text-align: center;
	background-color: #E9EAE8;
}
p{
	margin-left: 10%;
}
</style>
<br>
<h2><strong>&nbsp;&nbsp;&nbsp;아파트 일정</strong></h2><br>
<input type="button" class="btn btn-outline-primary btn-lg" id="insertBtn" value="일정등록">
<div id='calendar'></div>
<br>
<p>※ 수리일정, 리모델링 일정은 일정 삭제시 접수도 함께 취소되며, 취소된 내역은 공사/수선관리에서 확인하실 수 있습니다. 
<div id="body">
	<div class="modal" id="rmdlViewModal">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
			</div>
		</div>
	</div>
<!-- 	일정등록 모달 -->
	<div class="modal" id="scheduleModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
			</div>
		</div>
	</div>
</div>
<c:set var="asList" value="${asList }"/>
<c:set var="rmdlList" value="${rmdlList }"/>
<c:set var="eventList" value="${eventList }"/>
<script>
var eventsArr = [];
let asList = JSON.parse('${asList}');
let asIndvList = JSON.parse('${asIndvList}');
let rmdlList = JSON.parse('${rmdlList}');
let eventList = JSON.parse('${eventList}');
$(rmdlList).each(function(idx,schedulVO){
// 	console.log(schedulVO.schdEnd+"T10:00:00.0+0100");  이거 추가하면 날짜 하루 안나오는것 고칠 수 있음. 대신 캘린더에 시간도 같이나옴
	eventsArr.push(
        {
          title: schedulVO.schdTitle,
          start: schedulVO.schdStart,
          end : schedulVO.schdEnd,
          color : '#C3D7FF',
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
          color : '#FDEEF2',
          id : schedulVO.schdType+schedulVO.schdNo
        }
    )
});
$(asIndvList).each(function(idx,schedulVO){
	eventsArr.push(
        {
          title: schedulVO.schdTitle,
          start: schedulVO.schdStart,
          end : schedulVO.schdEnd,
          color : '#FDEEF2',
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
          color : '#FAFFC2',
          id : schedulVO.schdType+schedulVO.schdNo
        }
    )
});
var schdNo = null;
var schdType = null;
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
	    eventTextColor: 'black',
	    eventClick: function(info) {
	    	let id = info.event.id;
	    	schdType = id.substring(0,4);
	    	schdNo = id.substring(4, id.length);
	    	makeModal(schdNo);
	    }
	});
	calendar.render();
});

let rmdlViewModal = $("#rmdlViewModal").on("hidden.bs.modal", function() {
	$(this).find(".modal-content").empty();
});

function makeModal(schdNo){
	rmdlViewModal.find(".modal-content").load("${cPath}/office/construction/remodellingCalendarView.do?schdNo="+schdNo, function(){
		rmdlViewModal.modal();
	});	
}

// 스케줄 타입에 따라 일정지워지고 승인취소되게 하기!!
rmdlViewModal.on("click", "#deleteBtn", function(){
	if(confirm("일정을 삭제하시겠습니까?")){
		if(schdType=="S001"){
			location.href = "${cPath}/office/construction/removeApartEvent.do?schdNo="+schdNo;
		}else if(schdType=="S004"){
			location.href = "${cPath}/office/construction/rmdlApprovalCancel.do?schdNo="+schdNo;
		}else{
			location.href = "${cPath}/office/construction/asApprovalCancel.do?schdNo="+schdNo;
		}
	}	
});

let scheduleModal = $("#scheduleModal").on("hidden.bs.modal", function() {
	$(this).find(".modal-content").empty();
});

$("#insertBtn").on("click", function(){
	scheduleModal.find(".modal-content").load("${cPath}/office/construction/registSchedule.do", function(){
		scheduleModal.modal();
	});	
});

$(".modal-content").on("click", "#updateBtn", function(){
	scheduleModal.find(".modal-content").load("${cPath}/office/construction/updateCalendarEvent.do?schdNo="+schdNo, function(){
		scheduleModal.modal();
	});	
});

$("#closeBtn").on("click", function(){
	rmdlViewModal.modal("hide");
});

$(".modal-content").on("click", "#closeBtn", function(){
	scheduleModal.modal("hide");
});

</script>