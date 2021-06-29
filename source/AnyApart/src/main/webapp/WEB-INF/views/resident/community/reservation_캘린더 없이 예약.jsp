<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<link href='${cPath }/js/fullcalendar-5.5.1/lib/main.css' rel='stylesheet' />
<script src='${cPath }/js/fullcalendar-5.5.1/lib/main.js'></script>
<link href='${cPath }/css/office/wholeCalendar.css' rel="stylesheet">

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
tbody th{
	text-align: center;
}
</style>

<div id="selectDiv">
	<form id="searchForm" class="form-inline">
		<input type="hidden" name="cmntName"/>
	</form>
	<table class="table table-bordered">
		<thead>
			
		</thead>	
	</table>
</div>

<form:form id="reservationForm" commandName="reservation" action="${cPath }/resident/community/reservation.do">
<div id="confirmDiv">
	<table class="table table-bordered">
		<thead>
			<tr>
				<th colspan="4" >시설 예약</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>시설명</th>
				<td colspan="4">
					<select id="communitySelect" name="cmntNo" style="width: 180px;">
				    	<option>시설선택</option>
				    	<c:set var="communityList" value="${communityList }" />
				    	<c:if test="${not empty communityList }">
				    		<c:forEach var="community" items="${communityList }">
								<option value="${community.cmntNo }" name="${community.cmntNo }" data-limit='${community.cmntLimit }' data-close='${community.cmntClose }' data-open='${community.cmntOpen }'>${community.cmntName }</option>				    		
				    		</c:forEach>
				    	</c:if>
				    </select>
				</td>
			</tr>
			<tr>
				<th>예약자명</th>
				<td><form:hidden path="memId" value="${resident.memId }"/>${resident.resName }</td>
				<th>예약일</th>
				<td colspan="2">
					<input id="resvDate" type="date" name="resvDate" value="${reservation.resvDate }" />
				</td>
			</tr>
			<tr>
				<th>핸드폰 번호</th>
				<td>
					${resident.resHp }
				</td>
				<th>예약시간</th>
				<td id="timeBody" colspan="2">
				
				</td>
			</tr>
			<tr>
				<th>예약 인원</th>
				<td>
					<form:select path="resvCnt" >
						
					</form:select>
				</td>
				<td colspan="1">
					<button type="submit">예약 하기</button>
				</td>
			</tr>
		</tbody>
	</table>
</div>
</form:form>

<script type="text/javascript">
	let data;
	let timeBody = $("#timeBody");

	let reservationForm = $("#reservationForm");
	let communitySelect = $("#communitySelect");
	
	// 커뮤니티 시설을 클릭 했을때 시간 셀렉트 박스를 만들어준다.
	communitySelect.on("change", function(){
		if($(this).val() != null){
			timeBody.html("");
		
			let option = $(this).children("[name="+ $(this).val()+"]");
			console.log(option);
			let openHH = parseInt(option.data("open").substring(0,2));
			let openMM = parseInt(option.data("open").substring(2,4));
			let closeMM = parseInt(String(option.data("close")).substring(2,4));
			let closeHH = parseInt(String(option.data("close")).substring(0,2));
			let timeTags = [];
			let timeTags2 = [];
			for(var i = openHH; i < closeHH ; i++){
				if(i < 10){
					i = "0"+i;
				}
				timeTags.push(
					$("<option>").val(i+"00").text(i+":00")						
				);
				timeTags.push(
					$("<option>").val(i+"30").text(i+":30")						
				);
				timeTags2.push(
					$("<option>").val(i+"00").text(i+":00")						
				);
				timeTags2.push(
					$("<option>").val(i+"30").text(i+":30")						
				);
			}
			let timeEnd = $("<select>").append(timeTags2).attr("name","resvStart");
			let timeStart = $("<select>").append(timeTags).attr("name","resvEnd");
			timeBody.append(timeStart);
			timeBody.append(timeEnd);
			
			let resvCnt = $("#resvCnt");
			let cmntLimit = option.data("limit");
			for(var i = 1; i <= cmntLimit; i++){
				resvCnt.append($("<option>").val(i).text(i+'명'));
			}
		}else{
			
		}
	});
	
			
		
	timeBody.on("change", $(":input"), function(){
		// 시간을 눌렀을때 보이는 값이다.
		let resvDate = $("#resvDate").val();
		console.log(resvDate);
		if(!resvDate){
			alert("예약날짜를 입력하세요.");
		}else{
			data = reservationForm.serialize();
	 		$.ajax({
	 			url : "${cPath }/resident/community/reservationCnt.do"
	 			, method : "post"
	 			, data : data
	 			, dataType : "json"
	 			, success : function(resp){
	 				console.log(resp);		
	 			}
	 			, errors : function(xhr){
	 				console.log(xhr);
	 				alert("예약날짜를 넣어주세요");
	 			}
	 		});
		}
	});
</script>    