<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- <link href="${cPath }/css/office/afterServiceList.css" rel="stylesheet"> --%>
<script type="text/javascript" src="${cPath }/js/ckeditor/ckeditor.js"></script>
<style>
.container{
	max-width: 1500px;
	margin: 0 auto;
}
/* 조회조건 */
#retrieveTopDiv {
	margin-top: 30px;
}
#listDiv {
	width: 95%;
	margin-left: 30px;
	margin-bottom: 30px;
}
#listDiv th, td{
	text-align: center;
}
#listDiv td:nth-child(3){
	text-align: left;
	padding-left: 30px;
}
/* 상세조회 */
#viewDiv img {
	width: 600px;
	height: 500px;
}
#repairView th {
	text-align: center;
	background-color: #343A40;
	color: white;
}
#repairView td{
	text-align: left;
}
#contentDiv {
	height: 200px;
}
#statusBtnDiv {
	margin-right: 30%;
	margin: 10px;
}
#statusBtnDiv button{
	margin-right: 10px;
}
#cancleBtn{
	margin-right: 10px;
}
#tbodyResult input{
	border : 1px solid #DEE2E6;
}
#message{
	width: 300px;
	margin-left: 700px; 
}
#uBtn{
	margin-left: 88%;
	margin-right: 10px;
}
#resultModal th{
	background-color: #E9ECEF;
	text-align: center;
}
#resultModal{
	margin-top: 50px;
}
.resultTh{
	width: 100px;
}
#resultBtn{
	margin-left: 91%;
}
#waitingDiv span:not(#waitingCnt){
	color: blue;
}
#waitingDiv{
	margin-left: 4%;
	margin-top: 20px;
	margin-bottom: 10px;
}
#waitingCnt{
	color: red;
	font-size: 1.2em;
}
.badge-primary{
	background-color: #F6534E;
}
.badge-default{
	background-color: #3ECFDE;
	color: white;
}
#listDiv td:nth-child(3){
	cursor:pointer;
}
</style>
<c:set var="paingVO" value="${paginationInfo.pagingVO }"/>	
<c:set var="asVO" value="${asVO }"/>	
<br>
<h2>
	<strong>수선 관리</strong>
</h2>
<br>
<div class="container">
	<div class="col-md-8"	style="border-style: outset; border-radius: 8px;margin-left: 18%;">
		<div class="row g-0">
			<div class="col-md-2" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png"	alt="searchIcon"
					style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;<strong>검색
					조건</strong>
			</div>
			<form id="searchForm">
				<input type="hidden" name="currentPage" value="1">
				<input type="hidden" name="searchVO.searchType">
				<input type="hidden" name="searchVO.searchWord" value="${pagingVO.searchVO.searchWord }">
				<input type="hidden" name="asNo" >
			</form>
			<div id="inputUI" class="card-body">
				<div class="row">
					<div class="col-md-2">분류선택</div>
			      	<div class="col-md-10">
						<select class="custom-select col-md-2" name="searchVO.searchType">
							<option value>전체</option>
							<option value="title">제목</option>
						</select>  &nbsp;&nbsp; 
						<input type="text" class="form-control col-md-4" name="searchVO.searchWord" value="${pagingVO.searchVO.searchWord }" style="display: inline;">
						<button class="btn btn-dark" id="searchBtn">검색</button>
					</div>
				</div><br>
				<div class="row">
					<div class="col-md-2">시설 선택</div>
			      	<div class="col-md-10">
						<form id="searchDetailForm">
						<select name="asCode" class="custom-select col-md-2">
							<option value>선택</option>
							<option value="ASAPT" ${'ASAPT' eq param.asCode?"selected":"" }>아파트</option>
							<option value="ASRES" ${'ASRES' eq param.asCode?"selected":"" }>세대</option>
						</select> &nbsp;&nbsp;&nbsp;
						접수상태 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="asStatus" class="custom-select col-md-2">
							<option value>선택</option>
							<option value="ASHOLD" ${'ASHOLD' eq param.asStatus?"selected":"" }>접수대기중</option>
							<option value="ASING" ${'ASING' eq param.asStatus?"selected":"" }>수선중</option>
							<option value="ASDONE" ${'ASDONE' eq param.asStatus?"selected":"" }>수선완료</option>
						</select> &nbsp;&nbsp;&nbsp;
						<input type="submit" id="retreiveBtn" class="btn btn-dark" role="alert" value="조회">
						</form>
					</div>
				</div>
			</div>	
		</div>
	</div>
</div>
<br>
<div id="waitingDiv">
	접수 대기 수 : <span id="waitingCnt"> ${asVO.waitingCnt }</span><br>
	<span>* 정렬 조건 접수상태에서 접수대기중을 선택하면 접수대기중인 글을 조회할 수 있습니다.</span><br> 
	<span>* 글 제목을 선택하여 상세조회 및 처리상태를 변경할 수 있습니다.</span><br> 
	<span>* 일정관리에서 등록된 일정 조회 및 수정, 삭제를 할 수 있습니다.</span> 
</div>
<%------------------------------ 목록 테이블 ------------------------------------%>
<div class="col-sm-12" id="listDiv">
	<table class="table table-hover">
		<colgroup>
			<col width="110px;">
			<col width="220px;">
			<col width="45%;">
			<col width="220px;">
			<col width="220px;">
			<col width="220px;">
			<col width="220px;">
		</colgroup>
		<thead  class="thead-light">
			<tr>
				<th scope="col">글번호</th>
				<th scope="col">수선분류</th>
				<th scope="col">제목</th>
				<th scope="col">회원명</th>
				<th scope="col">신청일</th>
				<th scope="col">처리상태</th>
				<th scope="col">일정등록</th>
			</tr>
		</thead>
		<tbody id="tbodyList">
			<c:set var="dataList" value="${paingVO.dataList }"/>
			<c:if test="${fn:length(dataList) eq 0}">
				<tr>
					<td colspan='7'>조회 결과가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${fn:length(dataList) ne 0}">
				<c:forEach items="${dataList }" var="asVO">
					<tr>
						<td>${asVO.asNo }</td>
						<td>${asVO.asCodeName }</td>
						<td data-asno='${asVO.asNo}' class="modalTd">${asVO.asTitle }</td>
						<td>${asVO.memNick }</td>
						<td>${asVO.asDate }</td>
						<td>
							<c:if test="${asVO.asStatusName eq '접수대기중' }">
								<span class="badge badge-primary">${asVO.asStatusName }</span>
							</c:if>
							<c:if test="${asVO.asStatusName eq '수선중' }">
								<span class="badge badge-default">${asVO.asStatusName }</span>
							</c:if>
							<c:if test="${asVO.asStatusName eq '수선완료' }">
								<span class="badge badge-secondary">${asVO.asStatusName }</span>
							</c:if>
						</td>
						<td>
							<c:if test="${asVO.schdNo eq '' }">
								<button type='button' class='btn btn-primary btn-sm' id='insertSchdBtn' data-asno='${asVO.asNo}'>일정등록</button>
							</c:if>
							<c:if test="${asVO.schdNo ne '' }">
								<span class="badge badge">등록됨</span>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
<div id="pagingDiv" class="pagination justify-content-center">
	<ui:pagination paginationInfo='${paginationInfo }' jsFunction='pageLinkMove' type='bsOffice'/>
</div>
<%------------------------------ 수리 상세조회 모달 ------------------------------------%>
<div class="modal" id="repairView" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content"></div>
	</div>
</div>
<%------------------------------- 처리내역 등록, 수정 모달 -------------------------------------%>
<div class="modal" id="resultModal">
	<div class="modal-dialog modal-md">
		<div class="modal-content"></div>
	</div>
</div>

<script type="text/javascript" >
//================================ 리스트 생성 ================================= -동기로 바꿈
// 	function makeList(){
// 		$.ajax({
// 			dataType:"json"
// 			,success : function(resp){
// 				let asList = resp;
// 				let trTags = []
// 				if(asList){
// 					$(asList).each(function(idx, asVO){
// //--------------------------- 수선코드 생성 -----------------------------
// 						let schdBtn = "등록됨";
// 						if(asVO.schdNo==0){
// 							schdBtn = $("<button type='button' class='btn btn-primary btn-xs mb20' id='insertSchdBtn' data-asno='"+asVO.asNo+"'>일정등록</button>");	
// 						}
// 						trTags.push(
// 							$("<tr>").append(
// 								$("<td>").text(asVO.asNo),		
// 								$("<td>").text(asVO.asCodeName),		
// 								$("<td data-asno='"+asVO.asNo+"'>").text(asVO.asTitle).addClass("modalTd"),
// 								$("<td>").text(asVO.memId),		
// 								$("<td>").text(asVO.asDate),		
// 								$("<td>").text(asVO.asStatusName),	
// 								$("<td>").append(
// 									schdBtn
// 								)
// 							)		
// 						)
// 					})
// 				}else{
// 					trTags.push(
// 						$("<tr>").append(
// 							$("<td colspan='7'>").text("내역이 없습니다.")		
// 						)		
// 					)
// 				}
// 				$("#tbodyList").html(trTags);
// 			}
// 		});
// 	}
	
// 	$(document).ready(function(){
// 		makeList();
// 	});
	
//================================ 리스트 상세조회 모달창 생성 =================================
	let repairView = $("#repairView");  //수리상세조회 모달
	let resultModal = $("#resultModal");	
	
	repairView.on("hidden.bs.modal", function() {
		$(this).find(".modal-content").empty();
	});
	
	$("#tbodyList").on("click", ".modalTd", function(event){
		let asNo = $(this).data("asno");
		repairView.find(".modal-content").load("${cPath}/office/construction/afterServiceView.do?asNo="+asNo, function(){
			repairView.modal();
		});
	});
	
	resultModal.on("hidden.bs.modal", function() {
		$(this).find(".modal-content").empty();
	});

	repairView.on("click", "#uBtn", function(){
		let asNo = $(this).data("asno");
		resultModal.find(".modal-content").load("${cPath}/office/construction/afterServiceResultForm.do?asNo="+asNo, function(){
			resultModal.modal();
		});
	});
//================================ 일정등록 ======================================	
	$("#tbodyList").on("click", "#insertSchdBtn", function(){
		let asNo = $(this).data("asno");
		searchForm.find("[name='asNo']").val(asNo);
		searchForm.attr("action", "${cPath}/office/construction/registAsSchedule.do?");
		searchForm.submit();
	});
	
	let tbodyMessage = $("#tbodyMessage");  
	let message = $("#message")   //처리완료후 메시지 모달
	
//================================ 처리버튼 클릭 이벤트 처리 ======================================
	repairView.on("click", "#statusBtnDiv button", function(){
		let buttonId = $(this).attr("id");
		let resultStatus = "";
		if(buttonId=='approvalBtn'){  //접수중 상태에서 승인버튼 - 없어짐
			resultStatus = "ASHOLD";
		}else if(buttonId=='cancleBtn'){  //수리중 상태에서 승인취소버튼
			resultStatus = "ASCANCEL";
		}
		let asNo = $(this).data("asno");
		
		if(confirm("처리상태를 변경하시겠습니까?")){
			$.ajax({
				url : $.getContextPath()+"/office/construction/afterServiceChange.do"
				, data : {
					"asNo":asNo,
					"resultStatus" : resultStatus	
				}
				, dataType : "text"
				, success : function(resp){
					alert(resp);
					repairView.modal('hide');
					location.reload();
				}, error : function(xhr){
					console.log("에러:"+xhr.status);
				}
			});
		}
	});
	
//========================== 모달창 close===============================
	resultModal.on("click", "#saveBtnDiv #cancleCommentBtn", function(){
		resultModal.modal('hide');
	});
	
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='currentPage']").val(page);
		searchForm.submit();
		return false;
	}
	
	let searchForm = $("#searchForm");
	$("#searchBtn").on("click", function(){
		let inputs = $(this).parents("div#inputUI").find(":input[name]");
		$(inputs).each(function(index, input){
			let name = $(this).attr("name");
			let value = $(this).val();
			let hidden = searchForm.find("[name='"+name+"']");
			hidden.val(value);
		});
		searchForm.submit();
	});
	
	$("#resultForm").validate({
		rules : {
			asSchedule : {required:true, minlength:1}
		}
	});
</script>