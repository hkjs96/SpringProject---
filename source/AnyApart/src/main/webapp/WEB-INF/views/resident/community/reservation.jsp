<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<link href='${cPath }/js/fullcalendar-5.5.1/lib/main.css' rel='stylesheet' />
<script src='${cPath }/js/fullcalendar-5.5.1/lib/main.js'></script>
<link href='${cPath }/css/office/wholeCalendar.css' rel="stylesheet">


<c:set var="pagingVO" value="${paginationInfo.pagingVO }"/>
<style type="text/css">
thead th{
	background-color: #FBF9FA;
}

/* 시설선택 */
#selectDiv span{
	padding-left: 10px;
	padding-right: 20px;
}

/* 예약정보 확인 */
#confirmDiv{
	margin-top: 100px;
}
thead th{
	text-align: center;
	background-color: #e9ecef;
}
#communityViewBody th{
	background-color: #e9ecef;
}
</style>

<div id="selectDiv">
	<form id="searchForm" class="form-inline">
		<input type="hidden" name="cmntNo"/>
		<input type="hidden" name="currentPage"/>
	</form>
	<table class="table table-bordered">
		<thead>
			<tr>
				<th style="text-align: left;">
					<span style="color: green; font-size: 10pt"><strong> * 시설 선택시 예약 된 일정들이 조회됩니다.</strong></span>
					<span>시설명</span>
				    <select id="communityView" name="cmntNo" style="width: 180px;">
				    	<option>시설 조회</option>
				    	<c:set var="communityList" value="${communityList }" />
				    	<c:if test="${not empty communityList }">
				    		<c:forEach var="community" items="${communityList }">
								<option value="${community.cmntNo }"
									data-limit='${community.cmntLimit }' data-close='${community.cmntClose }' data-open='${community.cmntOpen }' data-code='${community.cmntCode }'
									data-name='${community.cmntName }' data-size='${community.cmntSize }' data-capa='${community.cmntCapa }' data-desc='${community.cmntDesc }'
								>${community.cmntName }</option>				    		
				    		</c:forEach>
				    	</c:if>
				    </select>
				    <button id="viewBtn" class="btn btn-primary">시설 정보 조회하기</button>
				    <span id="viewSpan"></span>
				</th>
			</tr>
		</thead>	
	</table>
</div>
<hr>
<div id='calendar'></div>

<div class="modal fade" id="communityModal" tabindex="-1" aria-labelledby="communityModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-dialog-scrollable ">
<!-- 	<div class="modal-dialog modal-dialog-scrollable modal-lg"> -->
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="communityModalLabel">시설 조회</h3>
			</div>
			<div class="modal-body">
				<table class="table table-bordered">
					<colgroup>
						<col width="160px">
						<col width="160px">
						<col width="160px">
						<col width="160px">
					</colgroup>
					<thead id="communityViewBody">
						<tr>
							<th>시설명</th>
							<td id="viewCmntName" colspan="3">
								
							</td>
						</tr>
						<tr>
							<th>분류</th>
							<td id="viewCmntCode">
								
							</td>
							<th>규모</th>
							<td id="viewCmntSize">
								
							</td>
						</tr>
						<tr>
							<th>수용인원</th>
							<td id="viewCmntCapa">
								
							</td>
							<th>예약제한인원</th>
							<td id="viewCmntLimit">
								
							</td>
						</tr>
						<tr>
							<th>여는 시간</th>
							<td id="viewCmntOpen">
								
							</td>
							<th>닫는 시간</th>
							<td id="viewCmntClose">
								
							</td>
						</tr>
						<tr>
							<th>시설 설명</th>
							<td id="viewCmntDesc" colspan="3">
								
							</td>
						</tr>
					</thead>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="reservationModal" tabindex="-1" aria-labelledby="reservationModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-dialog-scrollable modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="reservationModalLabel">시설예약</h3>
				<span style="color: green; font-size: 10pt"><strong> * 예약은 하루전까지 가능하며, 수용 인원이 초과시 예약이 실패할 수 있습니다.</strong></span>
			</div>
			<div class="modal-body">
				<form:form id="reservationForm" commandName="reservation" action="${cPath }/resident/community/reservationInsert.do">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>시설명</th>
								<form:hidden path="cmntNo" />
							<td colspan="4">
								<span id="resvCmntName"></span>
							</td>
						</tr>
						<tr>
							<th>예약자명</th>
							<td>
								<form:hidden path="memId" value="${resident.memId }"/>${resident.resName }
							</td>
							<th>예약일</th>
							<td colspan="2">
								<input id="resvDate" type="hidden" name="resvDate" value="${reservation.resvDate }"/>
								<span name="resvDateSpan"></span>
							</td>
						</tr>
						<tr>
							<th>핸드폰 번호</th>
							<td>
								${resident.resHp }
							</td>
							<th>예약시간</th>
							<td id="timeBody" colspan="2">
								<form:hidden path="resvStart" />
								<form:hidden path="resvEnd" />
								<span name="resvStartSpan"></span>
								 - 
								<span name="resvEndSpan"></span>
							</td>
						</tr>
						<tr>
							<th>예약 인원</th>
							<td>
								<form:select path="resvCnt" >
									
								</form:select>
							</td>
						</tr>
					</thead>
				</table>
				</form:form>
			</div>
			<div class="modal-footer">
				<button id="submitBtn" class="btn btn-primary">예약 하기</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
let calendar;
var calendarEl = document.getElementById('calendar');
// 시설 선택시 시설에 대한 일정 DB에서 불러서 보여주는 부분

let communityView = $("#communityView").on("change", function(){
	let communityNO = $(this).val();
	let setStart = String(communityView.find("option:selected").data('open'));
	let setEnd = String(communityView.find("option:selected").data('close'));
	setStart = setStart.substr(0,2)+":"+setStart.substr(2,4)+":00";
	setEnd = setEnd.substr(0,2)+":"+setEnd.substr(2,4)+":00";
	
	$.ajax({
		url : "${cPath}/resident/community/reservationList.do"
		, data : { cmntNo : communityNO }
		, dataType : "json"
		, success : function(resp){
			let reservationList = resp.reservationList;
			eventsArr = [];
			$(reservationList).each(function(idx,reservation){
			 	eventsArr.push(
			         {
			           title: reservation.cmntName +" : " +reservation.resvCnt + "명",
			           start: reservation.resvStart,
			           end : reservation.resvEnd,
			           color : '#d6e6f5',
			           id : reservation.cmntNo
			         }
			     )
			});
			calendar = new FullCalendar.Calendar(calendarEl, {
				allDaySlot : false,
				contentHeight: 400,
				scrollTime : '06:00:00',
				locale : 'ko',
				initialView : 'timeGridDay',  //달력화면   timeGridWeek:시간표 화면나옴
				themeSystem: 'bootstrap',
				headerToolbar : {
					left : 'prevYear,prev,next,nextYear today',
					center : 'title',
					right : 'timeGridDay'	// 하루 씩만 보게 만들어준다.
				},
			    events: eventsArr,
			    eventTextColor: 'black',
				 businessHours : businessHours 
				, slotDuration: '00:30' // 보여줄 시간 단위 
// 				, weekends : false // 주말 안보이기 
				, slotMinTime : setStart	// 보여줄 시작 시간
				, slotMaxTime : setEnd	// 보여줄 끝 시간
				, selectable : true
		        , select : function(schedule) {
		        	if(communityView.val() > 0 ){
			        	let startStr = schedule.startStr.substr(11,2) + schedule.startStr.substr(14,2);
			        	let viewStart = schedule.startStr.substr(11,2) + ":" + schedule.startStr.substr(14,2);
			        	let endStr = schedule.endStr.substr(11,2) + schedule.endStr.substr(14,2);
			        	let viewEnd = schedule.endStr.substr(11,2) + ":" + schedule.endStr.substr(14,2);
			        	
			        	$("#resvCmntName").text($("#communityView option:selected").text());
			        	
			        	let dateStr = schedule.startStr.substr(0,10);
			        	timeBody.find("[name=resvStart]").val(startStr);
			        	timeBody.find("[name=resvEnd]").val(endStr);
			        	timeBody.find("[name=resvStartSpan]").text(viewStart);
			        	timeBody.find("[name=resvEndSpan]").text(viewEnd);        	
			        	$("#reservationForm").find(":input[name=resvDate]").val(dateStr);
			        	$("#reservationForm").find("[name=resvDateSpan]").text(dateStr);
			        	reservationModal.modal('show');
		        	}
		         }
			});
			calendar.render();
		}
		, errors : function(xhr){
			console.log(xhr);	
		}
	});
	
	let limitVal = communityView.find("option:selected").data("limit");	
	$("#cmntNo").parent("td").text(communityView.find("option:selected").data("name"));
	$("#cmntNo").val(communityView.val());
	let resvCnt = $("#resvCnt");
	let optTags = [];
	for(var i=1 ; i<=limitVal ; i++){
		optTags.push($("<option>").val(i).text(i));
	}
	resvCnt.html(optTags);
});


//-----------------------------------------------------------------------------------

let communityViewBody = $("#communityViewBody");
let viewBtn = $("#viewBtn").on("click", function(){
	let viewVal = communityView.val();
	$("#viewSpan").text("");
	if(viewVal > 0){
		let communityModal = $("#communityModal");
		
		$("#viewCmntName").text(communityView.find("option:selected").data('name'));
		$("#viewCmntCode").text(communityView.find("option:selected").data('code'));
		$("#viewCmntSize").text(communityView.find("option:selected").data('size')+"㎥");
		$("#viewCmntName").text(communityView.find("option:selected").data('name'));
		$("#viewCmntCapa").text(communityView.find("option:selected").data('capa'));
		$("#viewCmntLimit").text(communityView.find("option:selected").data('limit'));
		let viewOpenTime = String(communityView.find("option:selected").data('open'));
		viewOpenTime = viewOpenTime.substr(0,2)+":"+viewOpenTime.substr(2,4);
		$("#viewCmntOpen").text(viewOpenTime);
		let viewCloseTime = String(communityView.find("option:selected").data('close'));
		viewCloseTime = viewCloseTime.substr(0,2)+":"+viewCloseTime.substr(2,4);
		$("#viewCmntClose").text(viewCloseTime);
		$("#viewCmntDesc").text(communityView.find("option:selected").data('desc'));
		
		communityModal.modal("show");	
	}else{
		$("#viewSpan").text("시설을 선택해주세요");
	}
});

//---------------------------------------------------------------------------------

let reservationForm = $("#reservationForm");
let data;
let submitBtn = $("#submitBtn").on("click", function(){
	event.preventDefault();
	data = reservationForm.serialize();
	$.ajax({
		url : "${cPath }/resident/community/reservationInsert.do" 
		, data : data
		, dataType : "json"
		, method : "post"
		, success : function(resp){
			if(resp.message == "OK"){
				location.href = "${cPath }/resident/community/reservation.do"
			}else{
				alert("예약실패");
			}
		}, errors : function(xhr){
			console.log(xhr);
		}
	});
	return false;
});


//-----------------------------------------------------------------------


// 가능한 시간대를 보여주는 역할을 수행할 수 있다. 만약에 시설 별로 시간을 받아서 셋팅해주면 될듯 ?
let businessHours =  [ // specify an array instead
  {
    daysOfWeek: [ 1, 2, 3, 4 ], // Monday, Tuesday, Wednesday
    startTime: '06:00', // 8am
    endTime: '21:00' // 6pm
  }
] ;
	

let eventsArr = [];

// 예약에 대한 json 객체를 담을 배열
let communitySelect = $("#communitySelect").on("change", function(){
	let limitVal = communitySelect.find("option:selected").data("limit");	
	let resvCnt = $("#resvCnt");
	let optTags = [];
	for(var i=1 ; i<=limitVal ; i++){
		optTags.push($("<option>").val(i).text(i));
	}
	resvCnt.html(optTags);
});


function fillZero(width, str){
    return str.length >= width ? str:new Array(width-str.length+1).join('0')+str;//남는 길이만큼 0으로 채움
}

let reservationModal = $("#reservationModal");
let timeBody = $("#timeBody");

document.addEventListener('DOMContentLoaded', function() {
// 	var calendarEl = document.getElementById('calendar');
	calendar = new FullCalendar.Calendar(calendarEl, {
		allDaySlot : false,
		contentHeight: 400,
		scrollTime : '06:00:00',
		locale : 'ko',
		initialView : 'timeGridDay',  //달력화면   timeGridWeek:시간표 화면나옴
		themeSystem: 'bootstrap',
		headerToolbar : {
			left : 'prevYear,prev,next,nextYear today',
			center : 'title',
			right : 'timeGridDay'	// 하루 씩만 보게 만들어준다.
		},
	    events: eventsArr,
	    eventTextColor: 'black',
		 businessHours : businessHours 
		, slotDuration: '00:30' // 보여줄 시간 단위 
// 		, weekends : false // 주말 안보이기 
		, slotMinTime : '06:00:00'	// 보여줄 시작 시간
		, slotMaxTime : '21:30:00'	// 보여줄 끝 시간
		, selectable : true
        , select : function(schedule) {
        	// 자바스크립트의 시간이 이상하게 나온다. 이틀 더 빠르네
//         	let now = new Date();
//         	let inputDate = schedule.startStr;
//         	let tomorrow = now.setDate(now.getDate()+1);
//         	console.log(schedule.start.getDate());
//         	console.log( now.setDate(now.getDate()+1).getDate() );
        	
        	if(communityView.val() > 0 ){
	        	let startStr = schedule.startStr.substr(11,2) + schedule.startStr.substr(14,2);
	        	let viewStart = schedule.startStr.substr(11,2) + ":" + schedule.startStr.substr(14,2);
	        	let endStr = schedule.endStr.substr(11,2) + schedule.endStr.substr(14,2);
	        	let viewEnd = schedule.endStr.substr(11,2) + ":" + schedule.endStr.substr(14,2);
	        	
	        	let dateStr = schedule.startStr.substr(0,10);
	        	
	        	timeBody.find("[name=resvStart]").val(startStr);
	        	timeBody.find("[name=resvEnd]").val(endStr);
	        	timeBody.find("[name=resvStartSpan]").text(viewStart);
	        	timeBody.find("[name=resvEndSpan]").text(viewEnd);        	
	        	$("#reservationForm").find(":input[name=resvDate]").val(dateStr);
	        	$("#reservationForm").find("[name=resvDateSpan]").text(dateStr);
	        	reservationModal.modal('show');
        	}
         }
	});
	calendar.render();
	
	
});


</script>    
<style>
	.fc-timegrid-event-harness {
		width: 300px;
	}
</style>