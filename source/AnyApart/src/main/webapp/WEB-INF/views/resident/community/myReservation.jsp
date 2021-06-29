<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />

<style type="text/css">
thead th{
	background-color: #FBF9FA;
}

/* 시설선택 */
#selectDiv span{
	padding-left: 10px;
	padding-right: 20px;
}
#retrieveBtn{
	margin-left:500px; 
	margin-bottom: 50px;
}
/* 예약자 정보 */
#memIdfoDiv{
	margin-top: 30px;
}
thead th{
	text-align: center;
	background-color: #e9ecef;
}
</style>

<div id="selectDiv" class="text-center">
	<form id="searchForm" class="form-inline">
		<input type="hidden" name="page" />
		<input type="hidden" name="cmntNo" value="${pagingVO.searchDetail.cmntNo }"/>
		<input type="hidden" name="screenSize" value="${pagingVO.screenSize }"/>
	</form>
	<table id="inputUI" class="table table-bordered" style="margin: auto;">
		<thead>
			<tr>
				<th style="text-align: center;">
<!-- 					<span style="color: green; font-size: 10pt"><strong> * 시설 선택시 예약 된 일정들이 조회됩니다.</strong></span> -->
					<span>시설명</span>
				    <select id="communityView" name="cmntNo" style="width: 180px;">
				    	<option value>시설 조회</option>
				    	<c:set var="communityList" value="${communityList }" />
				    	<c:if test="${not empty communityList }">
				    		<c:forEach var="community" items="${communityList }">
								<option value="${community.cmntNo }"
									data-limit='${community.cmntLimit }' data-close='${community.cmntClose }' data-open='${community.cmntOpen }' data-code='${community.cmntCode }'
									data-name='${community.cmntName }' data-size='${community.cmntSize }' data-capa='${community.cmntCapa }' data-desc='${community.cmntDesc }'
									<c:if test="${community.cmntNo eq pagingVO.searchDetail.cmntNo }">selected</c:if>
								>${community.cmntName }</option>				    		
				    		</c:forEach>
				    	</c:if>
				    </select>
				    <button id="searchBtn" class="btn btn-primary">시설별 예약 조회하기</button>
				    <span id="viewSpan"></span>
					    <select id="screenSize" name="screenSize" >
							<option value="10" ${pagingVO.screenSize eq 10 ? "selected":""}>10</option>
							<option value="25" ${pagingVO.screenSize eq 25 ? "selected":""}>25</option>
							<option value="50" ${pagingVO.screenSize eq 50 ? "selected":""}>50</option>
						</select>
						<span>개 씩 보기</span>
				</th>
			</tr>
		</thead>	
	</table>
	<div id="pagingArea" class="pagination justify-content-center">
		<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsResident" />
	</div>
</div>

<!-- <input type="button" value="조회하기" class="btn btn-default" id="retrieveBtn"> -->
<!-- <div id="pagingArea"> -->
<%-- 	${pagingVO.pagingHTML } --%>
<!-- </div> -->
<div align="right" class="mb-2 mr-5">
<!-- 	<span style="color: green"><strong> * 더블클릭시 상세 보기? </strong></span> -->
	<div align="right">
		
	</div>
	
<!-- 	<input type="button" class="btn btn-dark" role="alert" value="인쇄" style="margin-right: 100px;"> -->
</div>

<div class="table-responsive" id="listDiv">
	<table class="table table-hover">
		<colgroup>
			<col width="100px">
			<col width="120px">
			<col width="80px">
			<col width="80px">
			<col width="10px">
		</colgroup>
		<thead class="thead-light">
			<tr class="text-center">
				<th class="text-center" scope="col">시설 분류</th>
				<th class="text-center" scope="col">시설명</th>
				<th class="text-center" scope="col">예약날짜</th>
				<th class="text-center" scope="col">예약시간</th>
				<th class="text-center" scope="col">예약취소</th>
			</tr>
		</thead>
		<tbody id="listBody">
			<c:set var="reservationList" value="${pagingVO.dataList }" />
			<c:if test="${not empty reservationList }" >
				<c:forEach items="${reservationList }" var="reservation" varStatus="vs">
					<tr data-resvno='${reservation.resvNo }' data-name='${reservation.cmntName }' data-cnt="${reservation.resvCnt }" data-date='${reservation.resvDate }' data-time='${reservation.resvTime }'>
			  			<td class="listTd text-center">${reservation.cmntCode}</td>
	<%-- 		  			<c:url value="/resident/space/boardView.do?boNo=${board.boNo }" var="viewURL" /> --%>
			  			<td class="listTd text-center">${reservation.cmntName }</td>
			  			<td class="listTd text-center">${reservation.resvDate }</td>
			  			<td class="listTd text-center">${reservation.resvTime }</td>
			  			<td class="text-center btnArea">
			  				<c:if test="${reservation.resvLast eq 'N' }">
				  				<button class="btn btn-danger cancelBtn">취소하기</button>
			  				</c:if>
			  			</td>
			  		</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty reservationList }">
				<tr>
					<td class="text-center" colspan="5">예약 내역이 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>


<div class="modal fade" id="viewModal" tabindex="-1" aria-labelledby="viewModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-dialog-scrollable modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="viewModalLabel">예약정보</h3>
				<span style="color: green; font-size: 10pt"><strong> * 예약 취소는 하루전까지 가능합니다.</strong></span>
			</div>
			<div class="modal-body">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th >시설명</th>
							<td id="viewName" colspan="4">
								
							</td>
						</tr>
						<tr>
							<th>예약자명</th>
							<td>
								${resident.resName }
							</td>
						</tr>
						<tr>
							<th>예약일</th>
							<td id="viewDate" colspan="2">
								<span name="resvDateSpan"></span>
							</td>
						</tr>
						<tr>
							<th>핸드폰 번호</th>
							<td id="hp">
<%-- 								${resident.resHp } --%>
							</td>
						</tr>
						<tr>
							<th>예약시간</th>
							<td id="viewTime" colspan="2">
							
							</td>
						</tr>
						<tr>
							<th>예약 인원</th>
							<td id="viewCnt">
								
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


<script type="text/javascript">
	let data;

	let pagingArea = $("#pagingArea");
// 	pagingArea.on("click", "a" ,function(event){
// 		event.preventDefault();
// 		let page = $(this).data("page");
// 		searchForm.find("[name='page']").val(page);
// 		searchForm.submit();
// 		searchForm.find("[name='page']").val("");
// 		return false;
// 	});
	
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='page']").val(page);
		searchForm.submit();
		searchForm.find("[name='page']").val("");
		return false;
	}
	
	let searchForm = $("#searchForm");
	
	$("#searchBtn").on("click", function(event){
		let inputs = $(this).parents("#inputUI").find(":input[name]");
		$(inputs).each(function(index, input){
			let name = $(this).attr("name");
			let value = $(this).val();
			let hidden = searchForm.find("[name='"+name+"']");
			hidden.val(value);
		});
		searchForm.submit();
	});

	/*
	 * 예약 상세보기
	 */
	let hp = $("#hp");
	hp.text('${resident.resHp }');
	hp.text(formatTel(hp.text()));
	
	let viewModal = $("#viewModal");
	let listBody = $("#listBody").on("dblclick", ".listTd", function(){
		let selectTr = $(this).parent('tr');
		let resvNo = selectTr.data('resvno');
		
		if(resvNo != null){
			$("#viewDate").text(selectTr.data('date'));
			$("#viewName").text(selectTr.data('name'));
			$("#viewTime").text(selectTr.data('time'));
			$("#viewCnt").text(selectTr.data('cnt'));
			viewModal.modal('show');
		}
	});
	
	/*
		삭제하기
	*/
	let cancelBtn = $(".cancelBtn").on("click", function(){
		// 버튼 클릭시 삭제할건지 안할 건지 묻는 부분 만들어 주기
		if (confirm("정말 삭제하시겠습니까??") == true){    //확인
			let delResvNo = $(this).parent().parent().data('resvno');
			data = delResvNo;
			$.ajax({
				url : "${cPath }/resident/community/reservationCancel.do"
				, data : { resvNo : delResvNo }
				, dataType : "json"
				, success : function(resp){
					if(resp.message == "OK"){
						let redirectInput = searchForm.find(":input");
						let queryString = "?";
						$(redirectInput).each(function(index, input){
							let name = $(this).attr("name");
							let value = $(this).val();
							queryString = queryString + String(name) + "=" + String(value) + "&" 
						});
						queryString = queryString.slice(0,-1);
						location.href="${cPath }/resident/community/myReservation.do"+queryString;
					}else{
						alert(resp.message);
					}
				}
				, errors : function(xhr){
					console.log(xhr);
				}
			});
		
		}else{   //취소
		    return false;
		}
		
	});

	
	//n개씩 보기
	let screenSize = $("#screenSize").on("change",function(){
		let sizeNum = $(this).val();
		let hidden = searchForm.find("[name='screenSize']");
		hidden.val(sizeNum);
		searchForm.submit();
	});
	
	
</script>    