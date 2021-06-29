<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 08.  박지수      최초작성
* 2021. 3.  8.  이경륜      ui수정
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div id="container">
	<div class="inner">
		<div class="board-list">
			<br>
			<h2><strong>아파트관리사무소 문의글</strong></h2>
				<span style="color: green;">전체  : ${pagingVO.searchDetail.allNum }</span>
				&nbsp;
				<span style="color: red;">답변  : ${pagingVO.searchDetail.ansNum }</span>
				&nbsp;
				<span style="color: blue;">미 답변 : ${pagingVO.searchDetail.unAnsNum }</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span style="color: black;">전체 페이지 : ${pagingVO.totalPage }</span>
			<table>
				<colgroup>
					<col style="width: 10px">
					<col style="width: 200px">
					<col style="width: 50px">
					<col style="width: 90px">
					<col style="width: 30px">
					<col style="width: 20px">
				</colgroup>
				<thead>
					<tr>
						<th>No.</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="listBody">
					<c:set var="boardList" value="${pagingVO.dataList }" />
					<c:if test="${not empty boardList }">
						<c:forEach var="board" items="${boardList }" varStatus="idx">
							<tr>
								<c:url value="/vendor/qna/qnaView.do" var="viewURL">
									<c:param name="boNo" value='${board.boNo }' />
									<c:param name="page" value='${pagingVO.currentPage}' />
									<c:param name="boType" value='${pagingVO.searchDetail.boType}' />
									<c:param name="searchType" value='${pagingVO.searchVO.searchType }' />
									<c:param name="searchWord" value='${pagingVO.searchVO.searchWord }' />
								</c:url>
								<td>${pagingVO.totalRecord - pagingVO.screenSize*(pagingVO.currentPage-1) - idx.count + 1}</td>
								<td class="text-left">
<%-- 									<a href="${cPath }/vendor/qna/qnaView.do?boNo=${board.boNo }"> --%>
									<a href="${viewURL }">
										<c:if test="${not empty board.boParent }">
											└ re:
										</c:if>
											[${board.boType }]${board.boTitle } <span class="badge bg-warning text-dark">${board.boDepth eq '1' and not empty board.answerFlag? '답변' : '' }</span>
									</a>
								</td>
								<td>
									<c:if test="${1 eq board.boDepth }">
										${board.aptName }
									</c:if>
									<c:if test="${2 eq board.boDepth }">
										${board.boWriter }
									</c:if>
								</td>
								<td>${board.boDate }</td>
								<td>${board.boHit }</td>
								<td>
									<c:if test="${1 eq board.boDepth and empty board.answerFlag}">
										<c:url value="/vendor/qna/qnaInsert.do" var="insertURL">
											<c:param name="boNo" value="${board.boNo }" />
										</c:url>
										<input class="btn btn-green" type="button" value="답글" onclick="location.href='${insertURL}'">
									</c:if>
									<c:if test="${2 eq board.boDepth }">
										<c:url value="/vendor/qna/qnaUpdate.do" var="updateURL">
											<c:param name="boNo" value="${board.boNo }" />
										</c:url>
										<input class="btn btn-blue" type="button" value="수정" onclick="location.href='${updateURL}'">
									</c:if>
									<c:url value="/vendor/qna/qnaDelete.do" var="deleteURL">
										<c:param name="boNo" value="${board.boNo }" />
										<c:param name="page" value='${pagingVO.currentPage}' />
										<c:param name="boType" value='${pagingVO.searchDetail.boType}' />
										<c:param name="searchType" value='${pagingVO.searchVO.searchType }' />
										<c:param name="searchWord" value='${pagingVO.searchVO.searchWord }' />
									</c:url>
									</br>
<%-- 									<input id="deleteBtn" class="btn btn-red" type="button" value="삭제하기" onclick="location.href='${deleteURL}'"> --%>
									<input id="deleteBtn" class="btn btn-red" type="button" value="삭제" onclick="deleteBoard('${deleteURL}')">
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty boardList}">
						<tr>
							<td colspan="5">검색 결과 없음.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div>
			<form id="searchForm">
				<input type="hidden" name="page" />
				<input type="hidden" name="boType" value="${paging.searchDetail.boType }"/>
				<input type="hidden" name="unAnswered" value="${paging.searchDetail.unAnswered }"/>
				<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }" />
				<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }" />
			</form>
			<div id="inputUI" class="row justify-content-center mb-3">
				<div class="col-auto">
					<select name="unAnswered" class="form-control">
						<option ${'' eq param.unAnswered?"selected":"" } value >답변/미답변</option>
						<option ${'unAnswered' eq param.unAnswered?"selected":"" } value="unAnswered">미답변</option>
					</select>
				</div>
				<div class="col-auto">
					<select name="boType" class="form-control">
						<option value>문의 분류</option>
					</select>
				</div>
				<div class="col-auto">
					<select name="searchType" class="form-control">
						<option value>전체</option>
						<option value="boTitle"
							${'boTitle' eq param.searchType?"selected":"" }>제목</option>
						<option value="boWriter"
							${'boWriter' eq param.searchType?"selected":"" }>작성자</option>
						<option value="boContent"
							${'boContent' eq param.searchType?"selected":"" }>내용</option>
					</select>
				</div>
				<div class="col-auto">
					<input type="text" name="searchWord" class="form-control mr-3"
						value="${pagingVO.searchVO.searchWord }" />
				</div>
				<div class="col-auto">
					<input type="button" value="검색" id="searchBtn" class="btn btn-dark" />
<!-- 					<input type="btn btn-dark" value="새글쓰기" id="insertBtn" class="btn btn-primary" /> -->
				</div>
			</div>
			<div id="pagingArea">${pagingVO.pagingHTML }</div>
		</div>
	</div>
</div>    

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

//-----------------------------------------------------

function deleteBoard(deleteUrl) {
	var result = confirm("삭제하시겠습니까 ?");
    
    if(result)
    {
        location.href=deleteUrl;
    }
    else
    {
        
    }
}
</script>