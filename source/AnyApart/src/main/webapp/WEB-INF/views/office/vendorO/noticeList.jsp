<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<br>
<h2>
	<strong>공지사항</strong>
</h2>
<br>
<div class="container">
	<div class="col-sm-6"
		style="border-style: outset; border-radius: 8px; margin-left: 15em;">
		<div class="row g-0">
			<div>
				<form id="searchForm">
					<input type="hidden" name="page" /> <input type="hidden"
						name="searchType" value="${pagingVO.searchVO.searchType }" /> <input
						type="hidden" name="searchWord"
						value="${pagingVO.searchVO.searchWord }" />
				</form>
				<form class="form-inline">
					<div class="card-body inputUI">
						<div class="ml-3" style="float: left">
							<img
								src="${pageContext.request.contextPath}/images/searchIcon.png"
								alt="searchIcon" style="width: 30px; height: 30px;">&nbsp;&nbsp;
							<select name="searchType" class="custom-select">
								<option value="title"
									${'title' eq param.searchType?"selected":"" }>제목</option>
								<%-- 							<option value="writer" ${'writer' eq param.searchType?"selected":"" }>작성자</option> --%>
								<option value="content"
									${'content' eq param.searchType?"selected":"" }>내용</option>
							</select> <input type="text" name="searchWord"
								class="form-control col-sm-8"
								value="${pagingVO.searchVO.searchWord }">
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
	<div class="col-sm-12">
		<table class="table table-bordered">
			<thead class="thead-light">
				<tr class="text-center">
					<th>No.</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="boardList" value="${pagingVO.dataList }" />
				<c:if test="${not empty boardList }">
					<c:forEach items="${boardList }" var="board">
						<tr class="text-center">
							<td>${board.rnum}</td>
							<c:url value="/office/notice/noticeView.do?boNo=${board.boNo }"
								var="viewURL" />
							<td class="subject text-left"><a
								href="${board.boDelete ne 'Y' ? viewURL : '#' }">${board.boTitle }</a></td>
							<c:if test="${board.boWriter eq 'ADMIN'}">
								<c:set target="${board }" property="boWriter" value="애니아파트" />
								<%-- 	                   				<td>[AnyApart]<br>${board.boWriter }</td> --%>
								<td><c:out value="${board.boWriter }" /></td>
							</c:if>
							<td>${board.boDate }</td>
							<td>${board.boHit }</td>
						</tr>
					</c:forEach>
				</c:if>
		</table>
	</div>
</div>

<div id="pagingArea">
	<ui:pagination paginationInfo="${paginationInfo }"
		jsFunction="pageLinkMove" type="bsVendor" />
</div>

<script type="text/javascript">
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