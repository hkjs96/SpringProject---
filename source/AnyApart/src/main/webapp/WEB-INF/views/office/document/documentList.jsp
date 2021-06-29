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
#updateBtn{
	margin-left: 84%;
}
#ViewModal{
	margin-top: 10%;
}
#insertBtn{
	margin: 5px 12px 5px 5px;
}
</style>
<br>
<h2>
	<strong>일반문서함</strong>
</h2>
<div class="container">
	<div class="col-sm-6"
		style="border-style: outset; border-radius: 8px; margin-left: 15em;">
		<div class="row g-0">
			<div>
				<form id="searchForm">
				<input type="hidden" name="currentPage" value="1">
				<input type="hidden" name="searchVO.searchType" >
				<input type="hidden" name="searchVO.searchWord" value="${pagingVO.searchVO.searchWord }">
				<input type="hidden" name="boNo">
			</form>
				<form class="form-inline">
					<div class="card-body inputUI">
						<div class="ml-3" style="float: left">
							<img
								src="${pageContext.request.contextPath}/images/searchIcon.png"
								alt="searchIcon" style="width: 30px; height: 30px;">&nbsp;&nbsp;
							<select name="searchType" class="custom-select">
								<option value="">전체</option>
								<option value="title" ${'title' eq param.searchType?"selected":"" }>제목</option>
								<option value="writer" ${'content' eq param.searchType?"selected":"" }>작성자</option>
							</select> 
							<input type="text" name="searchVO.searchWord" class="form-control col-sm-8" value="${pagingVO.searchVO.searchWord }">
						</div>
						<div class="ml-3" style="float: left"></div>
						<div class="d-flex justify-content-end">
							<button class="btn btn-dark" id="searchBtn">검색</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div><br><br>
	<div class="d-flex justify-content-end">
		<input type="button" class="btn btn-dark" value="등록" id="insertBtn">
	</div>
</div>

<div class="container">
	<div class="col-sm-12">
		<table class="table table-bordered" id="ListTable">
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
	</div>
</div>		
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
							$("<td>").text(boardVO.boNo),		
							$("<td class='titleTd'>").text(boardVO.boTitle)
													.data("bono", boardVO.boNo)		
													.data("bohit", boardVO.boHit),		
							$("<td>").text(boardVO.boWriter),		
							$("<td>").text(boardVO.boDate),		
							$("<td>").text(boardVO.boHit)	
						)		
					)
				}) //for end
			}else{
				trTags.push(
					$("<tr>").append(
						$("<td colspan='5'>").text('조회 결과가 없습니다.')
					)		
				)
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
	$.ajax({
		url:"${cPath}/office/document/chkUpdateId.do"
		,data:{"boNo":boNo}
		,method:"post"
		,dataType:"json"
		,success:function(resp){
			if(resp.message=="다름"){
				alert("본인이 작성한 글만 수정할 수 있습니다.");
			}else{
				formModal.find(".modal-content").load("${cPath}/office/document/documentUpdate.do?boNo="+boNo, function(){
					formModal.modal();
				});
			}
		}	
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