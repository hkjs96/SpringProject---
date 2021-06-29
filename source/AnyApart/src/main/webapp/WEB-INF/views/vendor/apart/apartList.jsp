<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 28.      박지수      최초작성
* 2021. 3.  8.  이경륜  ui수정
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>

<div id="container">
	<div class="inner">
		<!-- 관리사무소 회원 조회 -->
		<div class="board-list">
			<div align="right">
				<input class="btn btn-green" id="insertBtn" type="button" value="아파트 등록">
				<%-- 					<input class="btn" type="button" value="아파트 등록" onclick="location.href='${pageContext.request.contextPath }/vendor/noticeForm.do'"> --%>
			</div>
			<br>
			<table class="apartListTable table-hover">
				<colgroup>
<%-- 					<col style="width: 10px"> --%>
					<col style="width: 60px">
					<col style="width: 60px">
					<col style="width: 50px">
					<col style="width: 50px">
					<col style="width: 40px">
				</colgroup>

				<thead>
					<tr>
					<tr>
<!-- 						<th>번호</th> -->
						<th class="text-center">아파트코드</th>
						<th class="text-center">아파트명</th>
						<th class="text-center">시작일</th>
						<th class="text-center">만료일</th>
						<th class="text-center">활성화여부</th>
					</tr>
				</thead>
				<tbody id="listBody">
					<c:set var="apartList" value="${pagingVO.dataList }"/>
				<!-- 여기 개발 tr에 이벤트 걸어서 상세보기하는 방식으로 차용? 수업때 prod 했던거 참조하면 될듯하다. -->
					<c:if test="${not empty apartList }">
						<c:forEach var="apart" items="${apartList }" varStatus="idx">
							<tr data-aptcode='${apart.aptCode }'>
<%-- 								<td>${idx.count }</td> --%>
								<td class="text-center">${apart.aptCode }</td>
								<td class="text-left" >${apart.aptName }</td>
								<td class="text-center" >${apart.aptStart }</td>
								<td class="text-center" >${apart.aptEnd }</td>
								<td class="text-center">${apart.aptDelete eq 'Y' ? '<span style="color: red;"><strong>활성</strong></span>' : '<span style="color: gray;">비활성<span>' }</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty apartList}">
						<tr>
							<td colspan="4">검색 결과 없음.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			
<%-- 			<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsMore" /> --%>
		</div>
		<div>
			<form id="searchForm">
				<input type="hidden" name="page" />
				<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
				<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
			</form>
				<div id="inputUI" class="row justify-content-center mb-3">
					<div class="col-auto">
						<select name="searchType" class="form-control">
							<option value>전체</option>
							<option value="aptName" ${'aptCode' eq param.searchType?"selected":"" }>아파트 이름</option>
							<option value="aptHead" ${'aptName' eq param.searchType?"selected":"" }>아파트 관리소장</option>
							<option value="aptAdd1" ${'aptAdd1' eq param.searchType?"selected":"" }>주소</option>
						</select>
					</div>						
					<div class="col-auto">
						<input type="text" name="searchWord"  class="form-control mr-3"  value="${pagingVO.searchVO.searchWord }"/>
					</div>
					<div class="col-auto">
						<input type="button" value="검색" id="searchBtn" class="btn btn-dark"/>
					</div>
				</div>
			<div id="pagingArea">${pagingVO.pagingHTML }</div>
		</div>
	</div>
</div>
<script>
let listBody = $("#listBody").on("click", 'tr', function(){
	let trAptCode = $(this).data('aptcode');
	location.href='${cPath }/vendor/apartView.do?aptCode='+trAptCode+"&page=${pagingVO.currentPage }&searchType=${pagingVO.searchVO.searchType }&searchWord=${pagingVO.searchVO.searchWord }";
});

let searchForm = $("#searchForm");

let pagingArea = $("#pagingArea");
pagingArea.on("click", "a" ,function(event){
	event.preventDefault();
	let page = $(this).data("page");
	searchForm.find("[name='page']").val(page);
	searchForm.submit();
	searchForm.find("[name='page']").val("");
	return false;
});

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

let insertBtn = $("#insertBtn");
insertBtn.on("click", function(){
	location.href="<c:url value='/vendor/apartForm.do'/>";
});

</script>


<!-- 모달 달아서 보여줄까? -->
<!-- 아파트 등록 새창 띄우기 해서 보여주자? -->