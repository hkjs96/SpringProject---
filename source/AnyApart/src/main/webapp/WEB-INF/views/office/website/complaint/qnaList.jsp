<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  이미정      최초작성
* 2021. 2. 15.  이미정      기존 코드 수정
* 2021. 3. 03.  박정민      검색, 페이징 ui 수정
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />

<style>
.badge {
	width: 80px;
	height: 30px;
	font-size: 15px;
	line-height: 20px;
}
</style>


<form id="viewForm" method="get"
	action="${cPath }/office/website/officeQna/officeQnaView.do">
	<input type="hidden" name="boNo" /> <input type="hidden" name="page"
		value="${param.page }" /> <input type="hidden" name="searchType"
		value="${param.searchType }" /> <input type="hidden"
		name="searchWord" value="${param.searchWord }" />
</form>

<!-- 서버 -->
<form id="searchForm">
	<input type="hidden" name="page" /> <input type="hidden"
		name="searchType" value="${pagingVO.searchVO.searchType }" /> <input
		type="hidden" name="searchWord"
		value="${pagingVO.searchVO.searchWord }" />
</form>
<!-- 클라이언트 -->
<br>
<h2>
	<strong>문의게시판</strong>
</h2>
<br>
<div class="container">
	<div class="col-sm-6 mt-4"
		style="border-style: outset; border-radius: 8px; margin-left: 17em;">
		<div class="row g-0">
			<div>
				<form class="form-inline">
					<div class="card-body">
						<div class="ml-3" style="float: left">
							<img
								src="${pageContext.request.contextPath}/images/searchIcon.png"
								alt="searchIcon" style="width: 30px; height: 30px;">&nbsp;&nbsp;
							<select class="custom-select" name="searchType">
								<option>전체</option>
								<option value="title"
									${'title' eq param.searchType?"selected":"" }>제목</option>
								<option value="writer"
									${'writer' eq param.searchType?"selected":"" }>작성자명</option>
								<option value="content"
									${'content' eq param.searchType?"selected":"" }>내용</option>
							</select> <input type="text" class="form-control col-sm-8"
								name="searchWord" value="${pagingVO.searchVO.searchWord }">
						</div>
						<div class="ml-3" style="float: left"></div>
						<div class="d-flex justify-content-end">
							<button class="btn btn-dark" id="searchBtn">검색</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<br>
<div class="container">
	<div class="row">
		<div class="col-sm-12">
			<table class="table table-bordered">
				<thead class="thead-light">
					<tr>
						<th style="width: 10%" class="text-center">No</th>
						<th style="width: 35%" class="text-center">제목</th>
						<th style="width: 10%" class="text-center">작성자</th>
						<th style="width: 15%" class="text-center">답변여부</th>
						<th style="width: 20%" class="text-center">작성일</th>
						<th style="width: 10%" class="text-center">조회수</th>
					</tr>
				</thead>
				<tbody id="listBody">
					<c:set var="boardList" value="${pagingVO.dataList }" />
					<c:set var="size" value="${fn:length(boardList)}" />
					<c:if test="${not empty boardList }">
						<c:forEach items="${boardList }" var="board">
							<tr data-bo-no='${board.boNo }'>
								<td class="text-center"><c:if
										test="${pagingVO.currentPage eq pagingVO.totalPage}">
						  				${pagingVO.totalRecord-(board.rnum-1)%pagingVO.totalRecord}
					  				</c:if> <c:if test="${pagingVO.currentPage ne pagingVO.totalPage}">
						  				${pagingVO.screenSize-(board.rnum-1)%pagingVO.screenSize}
					  				</c:if>
					  			</td>
								<td>${board.boTitle }</td>
								<td class="text-center">${board.boWriter }</td>
								<td class="text-center"><c:if
										test="${(not empty board.answerFlag) and (board.boDepth eq '1')}">
										<span class="badge bg-warning text-dark">답변완료</span>
									</c:if> <c:if
										test="${(empty board.answerFlag) and (board.boDepth eq '1') }">
										<span class="badge bg-secondary text-light">미답변</span>
									</c:if></td>
								<td class="text-center">${board.boDate }</td>
								<td class="text-center">${board.boHit }</td>
							<tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty boardList }">
						<tr>
							<td colspan="6" class="text-center">조회 결과가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div id="pagingArea" class="pagination justify-content-center">
	<ui:pagination paginationInfo="${paginationInfo }"
		jsFunction="pageLinkMove" type="bsOffice" />
</div>


<script type="text/javascript">
	let listBody = $("#listBody");
	listBody.on("dblclick", "tr", function() {
		let boNo = this.dataset.boNo;
		let viewForm = $("#viewForm");
		viewForm.find("[name='boNo']").val(boNo);
		console.log('${param.searchType}');
		console.log('${param.searchWord}');
		viewForm.submit();
	});	

	$("#insertBtn").on("click", function(){
		location.href="${pageContext.request.contextPath}/resident/officeQna/officeQnaForm.do";
	});
	
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='page']").val(page);
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
</script>