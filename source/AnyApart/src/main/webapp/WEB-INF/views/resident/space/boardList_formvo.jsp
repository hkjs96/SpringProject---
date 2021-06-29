<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 27.  이경륜      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }"/>
<style type="text/css">
#insertBtn{
	margin-left: 1050px;
	margin-bottom: 20px;
}
thead:first-child{
	text-align: center;
}
</style>

<input type="button" value="새글쓰기" id="insertBtn" class="btn btn-primary"/>
<table class="table table-bordered">
	<thead class="thead-light">
  		<tr class="text-center">
  			<th>글번호</th>
  			<th>제목</th>
  			<th>작성자</th>
  			<th>작성일</th>
  			<th>조회수</th>
  		</tr>
	</thead>
	<tbody>
		<c:set var="boardList" value="${pagingVO.dataList }" />
		<c:if test="${not empty boardList }" >
			<c:forEach items="${boardList }" var="board" varStatus="vs">
				<tr>
		  			<td>${board.boNo }</td>
		  			<c:url value="/resident/space/boardView.do?boNo=${board.boNo }" var="viewURL" />
		  			<td><a href="${board.boDelete ne 'Y' ? viewURL : '#' }">${board.boTitle } [${board.repCnt}]</a></td>
		  			<td>${board.boWriter }</td>
		  			<td>${board.boDate }</td>
		  			<td>${board.boHit }</td>
		  		</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty boardList }">
			<tr>
				<td colspan="6">게시글이 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="6">
				<!-- 서버 -->
				<form:form modelAttribute="boardFormVO" id="searchForm">
					<form:hidden path="searchBoardVO.pageIndex" name="page"/>
					<form:hidden path="searchBoardVO.searchCondition" name="searchCondition"/>
					<form:hidden path="searchBoardVO.searchKeyword" name="searchKeyword"/>
				</form:form>
				<!-- 클라이언트 -->
				<div class="container">
					<div id="inputUI" class="row justify-content-md-center">
						<div class="col col-lg-2">
							<!-- form select로 고쳐볼것 -->
							<select class="form-control" name="searchCondition">
								<option value>전체</option>
								<option value="title" ${'title' eq param.searchType?"selected":"" }>제목</option>
								<option value="writer" ${'writer' eq param.searchType?"selected":"" }>작성자명</option>
								<option value="content" ${'content' eq param.searchType?"selected":"" }>내용</option>
							</select>
						</div>
						<div class="col-md-auto">
							<input type="text" class="form-control col-md-6" name="searchKeyword" value="${pagingVO.searchVO.searchWord }"/>
						</div>
						<div class="col col-lg-2">
							<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
						</div>
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
	$("#insertBtn").on("click", function(){
		location.href="<c:url value='/resident/space/boardInsert.do'/>";
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