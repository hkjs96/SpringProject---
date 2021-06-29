<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 30.  이미정      최초작성
* 2021. 2. 15.  이미정      기존 코드 수정
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />
<style type="text/css">
#insertBtn{
	margin-left: 95%;
	margin-bottom: 20px;
}
td:first-child, th:first-child{
	text-align: center;
}
.badge{
	width: 80px;
	height:20px;
	font-size: 14px;
}
.bg-warning{
	background-color: #F0AD4E;
	color: black;
}

</style>

<form id="viewForm" method="get" action="${cPath }/resident/officeQna/officeQnaView.do">
	<input type="hidden" name="boNo"  />
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="searchType" value="${param.searchType }" />
	<input type="hidden" name="searchWord" value="${param.searchWord }"/>
</form>

<input type="button" id="insertBtn" value="등록" class="btn btn-default btn-sm mb20">
<table class="table table-sm text-center">
	<thead class="table-light ">
		<colgroup>
			<col style="width: 10%">
			<col style="width: 35%">
			<col style="width: 10%">
			<col style="width: 10%">
			<col style="width: 25%">
			<col style="width: 10%">
		</colgroup>
  		<tr>
  			<th class="text-center">No</th>
  			<th class="text-center">제목</th>
  			<th class="text-center">작성자</th>
  			<th class="text-center">답변여부</th>
  			<th class="text-center">작성일</th>
  			<th class="text-center">조회수</th>
  		</tr>
	</thead>
	<tbody id="listBody">
		<c:set var="boardList" value="${pagingVO.dataList }"/>
			<c:if test="${not empty boardList }">
			  		<c:forEach items="${boardList }" var="board">
			  			<tr data-bo-no='${board.boNo }'>
			  				<td>${board.boNo }</td>
			  				<td class="text-left">${board.boTitle } </td>
			  				<td>${board.boWriter }</td>
			  				<td>
				  				<c:if test="${(not empty board.answerFlag) and (board.boDepth eq '1')}">
				  					<span class="badge bg-warning text-dark">답변완료</span>
				  				</c:if>
				  				<c:if test="${(empty board.answerFlag) and (board.boDepth eq '1') }">
				  					<span class="badge bg-secondary text-light">미답변</span>
				  				</c:if>
			  				</td>
			  				<td>${board.boDate }</td>
			  				<td>${board.boHit }</td>
					    <tr>
			  		</c:forEach>
			</c:if>
			<c:if test="${empty boardList }">
				<tr>
					<td colspan="6">조회 결과가 없습니다.</td>
				</tr>
			</c:if>	
		</tbody>
		<tfoot>
				<tr>
					<td colspan="6">
						<!-- 서버 -->
							<form id="searchForm">
								<input type="hidden" name="page" />
								<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }" />
								<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
							</form>
							<!-- 클라이언트 -->
							<div id="inputUI" class="row">
								<div class="col col-sm-2 float-right">
									<select class="form-control" name="searchType">
										<option value>전체</option>
										<option value="title" ${'title' eq param.searchType?"selected":"" }>제목</option>
										<option value="writer" ${'writer' eq param.searchType?"selected":"" }>작성자명</option>
										<option value="content" ${'content' eq param.searchType?"selected":"" }>내용</option>
									</select>
								</div>
								<div class="col-sm-4 float-right">
									<input type="text" class="form-control col-md-6" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
								</div>
								<div class="col col-sm-2 float-right">
									<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
								</div>
							</div>
						<div id="pagingArea">
							<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsResident"/>
						</div>
					</td>
				</tr>
		</tfoot>
</table>

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