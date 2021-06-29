<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.col-md-3{
	display: inline-block;
}
#insertBtn{
	margin: 5px 12px 5px 5px;
}
</style>
<br>
<h2>
	<strong>문의게시판</strong>
</h2>
<br>
<div class="container">
	<div class="col-md-9"
		style="border-style: outset; border-radius: 8px;margin-left: 10%;">
		<div class="row g-0">
			<div class="col-md-1" style="margin-top: 20px;">&nbsp;&nbsp;
				<img
						src="${pageContext.request.contextPath}/images/searchIcon.png"
						alt="searchIcon" style="width: 30px; height: 30px;">
			</div>			
			<form id="searchForm">
				<input type="hidden" name="page" /> <input type="hidden" name="boType"
					value="${paging.searchDetail.boType }" /> <input type="hidden"
					name="searchType" value="${pagingVO.searchVO.searchType }" /> <input
					type="hidden" name="searchWord"
					value="${pagingVO.searchVO.searchWord }" />
			</form>
			<div class="col-md-11">
				<div id="inputUI" class="card-body">
					<div class="row">
						<select name="boType" class="custom-select col-md-3">
							<option value>문의 분류</option>
						</select>&nbsp;&nbsp;
						<select name="searchType" class="custom-select col-md-2">
							<option value>전체</option>
							<option value="boTitle"
								${'boTitle' eq param.searchType?"selected":"" }>제목</option>
							<option value="boWriter"
								${'boWriter' eq param.searchType?"selected":"" }>작성자</option>
							<option value="boContent"
								${'boContent' eq param.searchType?"selected":"" }>내용</option>
						</select>&nbsp;&nbsp;
						<input type="text" name="searchWord" class="form-control col-md-4"
							value="${pagingVO.searchVO.searchWord }" />&nbsp;&nbsp;
						<input type="button" value="검색" id="searchBtn" class="btn btn-dark col-md-1" />
					</div>	
				</div>
			</div>
		</div>
	</div><br>
	<div class="d-flex justify-content-end">
		<input type="button" value="등록" id="insertBtn" class="btn btn-dark" />
	</div>
</div>
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
			<tbody id="listBody">
				<c:set var="boardList" value="${pagingVO.dataList }" />
				<c:if test="${not empty boardList }">
					<c:forEach var="board" items="${boardList }" varStatus="idx">
						<tr class="text-center">
							<c:url value="/office/qna/qnaView.do" var="viewURL">
								<c:param name="boNo" value='${board.boNo }' />
								<c:param name="page" value='${pagingVO.currentPage}' />
								<c:param name="boType" value='${pagingVO.searchDetail.boType}' />
								<c:param name="searchType"
									value='${pagingVO.searchVO.searchType }' />
								<c:param name="searchWord"
									value='${pagingVO.searchVO.searchWord }' />
							</c:url>
							<td>${pagingVO.totalRecord - pagingVO.screenSize*(pagingVO.currentPage-1) - idx.count + 1}</td>
							<td class="text-left">
								<%-- 	  					<a href="${cPath }/office/qna/qnaView.do?boNo=${board.boNo }"> --%>
								<a href="${viewURL }"> <c:if
										test="${not empty board.boParent }">
								└ re : 
							</c:if> [${board.boType }]${board.boTitle } <span
									class="badge bg-warning text-dark">${board.boDepth eq '1' and not empty board.answerFlag? '답변' : '' }</span>
							</a>
							</td>
							<td>${board.boWriter }</td>
							<td>${board.boDate }</td>
							<td>${board.boHit }</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty boardList}">
					<tr>
						<td colspan="5" class="text-center">검색 결과 없음.</td>
					<tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>

<div id="pagingArea" class="pagination justify-content-center">${pagingVO.pagingHTML }</div>

<script>
let pagingArea = $("#pagingArea");
pagingArea.on("click", "a" ,function(event){
	event.preventDefault();
	let page = $(this).data("page");
// 	console.log($('input[name=searchType]').val())
	searchForm.find("[name='page']").val(page);
	searchForm.submit();
	searchForm.find("[name='page']").val("");
	return false;
});

//	searchForm.find("[name='searchType']").val(${pagingVO['searchVO']['searchType'] });
let searchForm = $("#searchForm");

$("#searchBtn").on("click", function(event){
	let inputs = $(this).parents("div#inputUI").find(":input[name]");
	$(inputs).each(function(index, input){
		let name = $(this).attr("name");
		let value = $(this).val();
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val(value);
	});
	searchForm.submit();
});

$("#insertBtn").on("click", function(){
	location.href="<c:url value='/office/qna/qnaBoardInsert.do'/>";
});

//---------------------------------------------------

let optTag = $("[name='boType']");
$.ajax({
	url : "${cPath }/board/getOption.do ",
	method : "get",
	dataType : "json",
	success : function(resp) {
		let opts = [];
		// 옵션을 동적으로 구성
		$(resp.option).each(function(idx, opt){
			opts.push(
				// type을 그대로 유지하기 위해서 prop 를 사용
				$("<option>").text(opt.codeName)
							 .attr("value", opt.codeId)
							 .prop("selected", "${pagingVO.searchDetail.boType}"==opt.codeId)
							 // EL은 javaBean 규약을 기반으로 움직인다.
			);
		});
		optTag.append(opts);
	},
	error : function(xhr) {
		console.log(xhr);
	}
});
</script>