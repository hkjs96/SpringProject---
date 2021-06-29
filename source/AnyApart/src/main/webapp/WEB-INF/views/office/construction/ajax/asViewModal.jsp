<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 2. 9.  박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    

<c:set var="vo" value="${afterServiceVO }"/>

<!-- Modal Header -->
<div class="modal-header">
	<p class="modal-title" style="font-size: 15pt;">- 수리신청 상세</p>
	<button type="button" class="close" id="closeBtn" data-dismiss='modal'>&times;</button>
</div>
<!-- Modal body -->
<div class="modal-body ">
	<div id="viewDiv">
		<p> ■ 신청내역</p>
		<table class="table table-bordered">
			<colgroup>
				<col width="15%">
				<col width="30%">
				<col width="20%">
				<col width="30%">
			</colgroup>
			<tbody id="tbodyModal">
				<tr>
					<th>제목</th>
					<td colspan='3'>${vo.asTitle }</td>
				</tr>
				<tr>
					<th>수선분류</th>
					<td>${vo.asCodeName }</td>
					<th>처리상태</th>
					<td><span class="badge badge-secondary">${vo.asStatusName }</span></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${vo.memId }</td>
					<th>작성일</th>
					<td>${vo.asDate }</td>
				</tr>
				<tr>
					<th>동</th>
					<td>${vo.dong }</td>
					<th>호</th>
					<td>${vo.ho }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan='3'>${vo.asContent }</td>
				</tr>
			</tbody>
		</table>
		<div id="pDiv">
			<p> ■ 처리내역</p>
			<table class="table table-bordered">
				<colgroup>
					<col width="30%">
				</colgroup>
				<tbody id="tbodyViewResult">
					<tr>
						<th>처리일자</th>
						<td colspan='3'>
						<c:if test="${vo.asSchedule ne null }">
							${vo.asSchedule }
						</c:if>
						<c:if test="${vo.asSchedule eq null }">
							처리내역이 없습니다.
						</c:if>
						</td>
					</tr>
					<tr>
						<th>담당자</th>
						<td colspan='3'>${vo.asEmployee }</td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan='3'>${vo.asComment }</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan='3'>
						<c:if test="${vo.asSchedule ne null }">
							<input type='button' value='수정' class='btn btn-warning' id='uBtn' data-asno='${vo.asNo }'>
							<input type='button' value='삭제' class='btn btn-danger' id='deleteResult' data-asno='${vo.asNo }'>
						</c:if>
						<c:if test="${vo.asSchedule eq null }">
							<input type='button' value='처리완료' class='btn btn-warning' id='resultBtn' data-asno='${vo.asNo }'>
						</c:if>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>
<!-- Modal footer -->
<div class="modal-footer">
	<div id="statusBtnDiv">
		<c:if test="${vo.asStatus eq 'ASHOLD'}">
			<button type='button' class='btn btn-primary' id='approvalBtn' data-asno='${vo.asNo }'>접수하기</button>
		</c:if>
		<c:if test="${vo.asStatus eq 'ASING'}">
			<button type='button' class='btn btn-danger' id='cancleBtn' data-asno='${vo.asNo }'>승인취소</button>
		</c:if>
	</div>
</div>

<script>
$("#resultBtn").on("click", function(){
	let asNo = $(this).data("asno");
	if('${vo.asStatus }'=='ASHOLD'){
		alert('수리신청을 접수한 후 등록하실 수 있습니다.');		
	}else{
		resultModal.find(".modal-content").load("${cPath}/office/construction/afterServiceResultForm.do?asNo="+asNo, function(){
			resultModal.modal();
		});	
	}
});

$("#deleteResult").on("click", function(){
	let asNo = $(this).data("asno");
	if(confirm("삭제하시겠습니까?")){
		location.href="${cPath}/office/construction/deleteResult.do?asNo="+asNo;
	}
});
</script>