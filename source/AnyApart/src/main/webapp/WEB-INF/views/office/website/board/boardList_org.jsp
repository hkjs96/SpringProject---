<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 3.  이경륜      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />
<div class="container">
	<br>
	<h4>
		<strong>자유게시판</strong>
	</h4>
	<div class="d-flex justify-content-end">
		<div class="d-flex justify-content-end">
			<button
				onclick="location.href = '${pageContext.request.contextPath}/office/website/boardDelete.do'"
				class="btn btn-dark" style='margin: 5pt;'>삭제</button>
		</div>
	</div>
	<div class="text-center col-sm-12">
		<table class="table table-bordered">
			<thead class="thead-dark">
				<tr class="text-center">
					<th><input type="checkbox" /></th>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody id="listBody">
				<c:set var="boardList" value="${pagingVO.dataList }" />
				<c:if test="${not empty boardList }">
					<c:forEach items="${boardList }" var="board" varStatus="vs">
						<tr>
							<td><input type="checkbox" /></td>
							<td>${board.boNo }</td>
							<c:url value="/office/website/boardView.do?boNo=${board.boNo }" var="viewURL" />
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
						<form id="searchForm">
							<input type="hidden" name="page" />
							<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }" />
							<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
						</form>
						<div class="container">
							<div class="col-sm-6" style="border-style: outset; border-radius: 8px; margin-left: 15em;">
								<div class="row g-0">
									<div>
										<form class="form-inline">
											<div id="inputUI" class="card-body">
												<div class="ml-3" style="float: left">
													<img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon" style="width: 30px; height: 30px;">&nbsp;&nbsp;
													<select class="custom-select" name="searchType">
														<option value>전체</option>
														<option value="title" ${'title' eq param.searchType?"selected":"" }>제목</option>
														<option value="writer" ${'writer' eq param.searchType?"selected":"" }>작성자명</option>
														<option value="content" ${'content' eq param.searchType?"selected":"" }>내용</option>
													</select>
													<input type="text" class="form-control col-sm-8" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
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
					</td>
				</tr>
				<tr>
					<td colspan="6">
						<div id="pagingArea">
							<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice" />
						</div>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>


<script>
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
