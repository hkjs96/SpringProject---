<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 24.      박정민      최초작성
* 2021. 1. 27.		박지수	보여지는 항목 수정
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
#insertDiv input {
	border: 0.5px solid #DEE2E6;
	width: 200px;
}

#insertDiv {
	width: 1300px;
	margin-left: 100px;
	margin-top: 80px;
}

#insertDiv td {
	text-align: left;
}
#listBody tr{
	cursor: pointer;
}
</style>
<br>
<h2>
	<strong>커뮤니티 시설관리</strong>
</h2>
<br>
<div class="container">
	<div class="col-md-6" style="border-style: outset; border-radius: 8px; margin-left: 15em;">
		<form id="searchForm" class="form-inline">
	    	<input type="hidden" name="page" />
			<input type="hidden" name="cmntCode"/>
			<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
			<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
	    </form>
		<div class="row g-0">
			<div class="card-body inputUI">
				<div class="col-md-12" style="float: left">
					<img src="${pageContext.request.contextPath}/images/searchIcon.png"
						alt="searchIcon"
						style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;<strong>검색
						조건</strong>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;분류선택&nbsp;&nbsp;
					<select name="cmntCode" class="custom-select col-md-4">
						<option value>전체</option>
					</select>
					<div class="ml-3" style="float: left"></div>
	<!-- 					<input type="text" name="searchWord" class="form-control col-md-2"> -->
					<button id="searchBtn" class="btn btn-dark" style='margin: 5pt;'>검색</button>
				</div>
			</div>
		</div>
	</div>
</div>	
<br>


<div align="right" class="mb-2" style="max-width: 660px; margin-left: auto; margin-right:auto;">
	<input id="createBtn" type="button" class="btn btn-primary" role="alert" value="등록">
	<input type="button" class="btn btn-dark" role="alert" value="인쇄">
</div>
<div class="col-sm-11 text-center" style="margin-left: 3%;">
	<table class="table table-hover" style="max-width: 700px; margin-left: auto; margin-right:auto;">
		<thead class="thead-light">
			<tr>
				<th colspan="1" scope="col">No.</th>
				<th colspan="1" scope="col">커뮤니티시설명</th>
				<th colspan="1" scope="col">분류</th>
<!-- 						<th scope="col">규모</th> -->
<!-- 						<th scope="col">수용인원</th> -->
<!-- 						<th scope="col">예약제한인원</th> -->
				<th colspan="1" scope="col">여는시간</th>
				<th colspan="1" scope="col">닫는시간</th>
<!-- 						<th scope="col">시설설명</th> -->
			</tr>
		</thead>
		<tbody id="listBody">
			<c:set var="communityList" value="${pagingVO.dataList }"/>
		<!-- 여기 개발 tr에 이벤트 걸어서 상세보기하는 방식으로 차용? 수업때 prod 했던거 참조하면 될듯하다. -->
			<c:if test="${not empty communityList }">
				<c:forEach var="community" items="${communityList }" varStatus="idx">
					<tr class="viewTr" data-cmnt-no="${community.cmntNo }">
						<td>${pagingVO.totalRecord - 5*(pagingVO.currentPage-1) - idx.count + 1}</td>
						<td>${community.cmntName }</td>
						<td>${community.cmntCode }</td>
<%-- 								<td><a href="${cPath }/vendor/apartView.do?what=${community.aptCode }">${apart.aptName }</a></td> --%>
						<td>${community.cmntOpen }</td>
						<td>${community.cmntClose }</td>
						<input type="hidden" value="${community.cmntNo }">
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty communityList}">
				<tr>
					<td class="text-center" colspan="6">검색 결과 없음.</td>
				</tr>
			</c:if> 
		</tbody>
	</table>
	<div id="pagingArea">${pagingVO.pagingHTML }</div>
</div>

<%-- <form id="viewForm" method="post" action="${cPath }/office/community/communityView.do"> --%>
<!-- 	<input type="hidden" name="cmntNo"/> -->
<!-- 	<input type="hidden" name="cmntCode"/> -->
<%-- 	<input type="hidden" name="page" value="${param.page }"/> --%>
<%-- 	<input type="hidden" name="searchType" value="${param.searchType }" /> --%>
<%-- 	<input type="hidden" name="searchWord" value="${param.searchWord }"/> --%>
<!-- </form> -->

<%------------------------------ 상세조회 모달 ------------------------------------%>
<div class="modal" id="communityView" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content text-center"></div>
	</div>
</div>
<%------------------------------ 수정 모달 ------------------------------------%>
<div class="modal" id="communityUpdate" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content text-center" ></div>
	</div>
</div>
<%------------------------------ 등록 모달 ------------------------------------%>
<div class="modal" id="communityInsert" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content text-center"></div>
	</div>
</div>

<script>
let communityView = $("#communityView");  
let communityUpdate = $("#communityUpdate");
let communityInsert = $("#communityInsert");


communityView.on("hidden.bs.modal", function() {
	$(this).find(".modal-content").empty();
});

communityUpdate.on("hidden.bs.modal", function() {
	$(this).find(".modal-content").empty();
});

communityInsert.on("hidden.bs.modal", function() {
	$(this).find(".modal-content").empty();
});

$("#createBtn").on("click", function(){
// 	location.href='${cPath }/office/community/communityForm.do/';
	communityInsert.find(".modal-content").load("${cPath }/office/community/communityForm.do", function(){
		communityInsert.modal();
	});
});

//---------------------------------------------------
let listBody = $("#listBody");
listBody.on("click", "tr", function() {
	let cmntNo = this.dataset.cmntNo;
// 	let viewForm = $("#viewForm");
// 	viewForm.find("[name='cmntNo']").val(cmntNo);
// 	console.log('${param.searchType}');
// 	console.log('${param.searchWord}');
// 	viewForm.submit();
// 	location.href='${cPath }/office/community/communityView.do?cmntNo='+cmntNo;
	
	communityView.find(".modal-content").load("${cPath }/office/community/communityView.do?cmntNo="+cmntNo, function(){
		communityView.modal();
	});
});

let searchForm = $("#searchForm");

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

// searchForm.on("click", function(event){
// 	let inputs = $(this).parents("div#inputUI").find(":input[name]");
// 	$(inputs).each(function(index, input){
// 		let name = $(this).attr("name");
// 		let value = $(this).val();
// 		let hidden = searchForm.find("[name='"+name+"']");
// 		hidden.val(value);
// 	});
// 	searchForm.submit();
// });

// let code = $("#inputUI :input[name=cmntCode]").on("change", function(){
// 	let inputs = $(this).parents("div#inputUI").find(":input[name]");
// 	$(inputs).each(function(index, input){
// 		let name = $(this).attr("name");
// 		let value = $(this).val();
// 		let hidden = searchForm.find("[name='"+name+"']");
// 		hidden.val(value);
// 	});
// 	searchForm.submit();
// });

let searchBtn = $("#searchBtn").on("click", function(){
	let inputs = $(this).parents("div#inputUI").find(":input[name]");
	$(inputs).each(function(index, input){
		let name = $(this).attr("name");
		let value = $(this).val();
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val(value);
	});
	searchForm.submit();
});

//---------------------------------------------------
let optTag3;
let optTag2;

let optTag = $(":input[name=cmntCode]");
$.ajax({
	url : "${cPath }/community/getOption.do",
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
// 							 .prop("selected", "${community.cmntCode}"==opt.codeName)
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