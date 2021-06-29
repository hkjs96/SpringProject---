<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 1. 29.    박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<security:authentication property="principal" var="principal"/>
<c:set var="authMember" value="${principal.realMember }"/>
<style>
#ListTable{
	width: 75%;
	margin-left: 10%;
}
#ListTable th, td{
	text-align: center;
}
.titleTd{
	text-align: left;
}
#h4{margin-left: 10%;}
#insertTable th{
	background-color: #E9ECEF;
	text-align: center;
}
#insertTable td{
	text-align: left;
}
#insertTable input, textArea{
	border: 1px solid #E9ECEF;
}
#insertTable input{
	width: 100%;
}
#insertBtn{
	margin-left: 80%;
	margin-top: 30px;
	margin-bottom: 10px;
}
#updateBtn{
	margin-left: 80%;
}
#ViewModal{
	margin-top: 10%;
}
</style>
<br>
<h4>일반문서함</h4>
<br>
<div class="container">
	<div class="col-md-12 "
		style="border-style: outset; border-radius: 8px;">
		<div class="row g-0">
			<div class="col-md-2" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png"
					alt="searchIcon"
					style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;<strong>검색
					조건</strong>
			</div>
			<form id="searchForm">
				<input type="hidden" name="currentPage" value="1">
				<input type="hidden" name="searchVO.searchType" >
				<input type="hidden" name="searchVO.searchWord" value="${pagingVO.searchVO.searchWord }">
				<input type="hidden" name="boNo">
			</form>
			<div class="col-md-10">
				<form class="form-inline">
					<div class="card-body " id="inputUI">
						분류선택
						<select class="custom-select col-md-2" name="searchVO.searchType">
							<option value>전체</option>
							<option value="title">제목</option>
							<option value="writer">작성자</option>
						</select> 
						<input type="text" class="form-control col-md-2" name="searchVO.searchWord" value="${pagingVO.searchVO.searchWord }">
						<button class="btn btn-dark" id="searchBtn">검색</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<input type="button" class="btn btn-primary" value="등록" id="insertBtn">
<table class="table table-hover" id="ListTable">
	<colgroup>
		<col width="10%">
		<col width="50%">
		<col width="15%">
		<col width="15%">
		<col width="10%">
	</colgroup>
	<thead class="thead-light">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody id="tbodyList"></tbody>
</table>
<div id="pagingDiv" class="pagination justify-content-center">
	<ui:pagination paginationInfo='${paginationInfo }' jsFunction='pageLinkMove' type='bsOffice'/>
</div>
<c:set var="boardVO" value="${boardVO }"/>
<%------------------------------ 수리 상세조회 모달 ------------------------------------%>
<div class="modal" id="ViewModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<p class="modal-title" style="font-size: 15pt;">- 일반문서 상세조회</p>
				<button type="button" class="close" id="closeBtn" data-dismiss="modal">X</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body"></div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<div id="footerDiv">
				</div>
			</div>
		</div>
	</div>
</div>
<%------------------------------ 등록, 수정 모달 ------------------------------------%>
<div class="modal" id="formModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content"></div>
	</div>
</div>

<script type="text/javascript">
function makeList(){
	$.ajax({
		dataType:"json"
		,success:function(resp){
			let docList = resp;
			let trTags = [];
			if(docList.length>0){
				$(docList).each(function(idx, boardVO){
					trTags.push(
						$("<tr >").append(
							$("<td>").text(boardVO.rnum),		
							$("<td class='titleTd'>").text(boardVO.boTitle)
													.data("bono", boardVO.boNo)		
													.data("bohit", boardVO.boHit),		
							$("<td>").text(boardVO.boWriter),		
							$("<td>").text(boardVO.boDate),		
							$("<td>").text(boardVO.boHit)	
						)		
					)
				}) //for end
			}
			$("#tbodyList").html(trTags);
		}
	})
}

$(document).ready(function(){
	makeList();
});

let ViewModal = $("#ViewModal").on("hidden.bs.modal", function() {
    $(this).find(".modal-body").empty();
 });
 
//============================= 일반문서 상세조회 모달 테이블생성=======================
$("#tbodyList").on("click", ".titleTd", function(){
	let boNo = $(this).data("bono");
	let boHit = $(this).data("bohit");
	ViewModal.find(".modal-body").load("${cPath}/office/document/documentView.do?boNo="+boNo, function(){
		ViewModal.modal();
	})
});	

let searchForm = $("#searchForm");
let formModal = $("#formModal").on("hidden.bs.modal", function() {
    $(this).find(".modal-content").empty();
 });
// ========================== 등록폼으로 이동 ===========================
$("#insertBtn").on("click", function(){
	formModal.find(".modal-content").load("${cPath}/office/document/documentInsert.do", function(){
		formModal.modal();
	});
});

// ========================== 수정폼으로 이동 ===========================
ViewModal.on("click", "#updateBtn", function(){
	let boNo = $(this).data("bono");
	ViewModal.modal("hide");
	formModal.find(".modal-content").load("${cPath}/office/document/documentUpdate.do?boNo="+boNo, function(){
		formModal.modal();
	});
});

// ========================== 게시글 삭제 ===========================
ViewModal.on("click", "#deleteBtn", function(){
	let boNo = $(this).data("bono");
	if(confirm("삭제하시겠습니까?")){
		location.href = "${cPath}/office/document/documentDelete.do?boNo="+boNo;
	}
});

$("#closeBtn").on("click", function(){
	$("#ViewModal").hide();
	makeList();	
});

function pageLinkMove(event){
	event.preventDefault();
	let page = $(event.target).data("page");
	searchForm.find("[name='currentPage']").val(page);
	searchForm.submit();
	return false;
}

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
</script>