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
</style>
<br>
<h4>
	<strong>커뮤니티시설관리</strong>
</h4>
<br>
<div class="container">
	<div class="col-md-12" style="border-style: outset; border-radius: 8px;">
		<form id="searchForm" class="form-inline">
	    	<input type="hidden" name="page" />
			<input type="hidden" name="cmntCode"/>
			<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
			<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
	    </form>
		<div class="row g-0">
			<div class="col-md-3" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png"
					alt="searchIcon"
					style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;<strong>검색
					조건</strong>
			</div>
			<div id="inputUI" class="col-md-9">
				<div class="card-body ">
					&nbsp;&nbsp;분류선택&nbsp;&nbsp;
					<select name="cmntCode" class="custom-select col-md-3">
						<option value>전체</option>
					</select>
<!-- 					<input type="text" name="searchWord" class="form-control col-md-2"> -->
<!-- 					<button id="searchBtn" class="btn btn-dark" style='margin: 0pt;'>검색</button> -->
				</div>
			</div>
		</div>
	</div>
</div>
<br>


<div align="right" class="mb-2 mr-5">
	<input type="button" class="btn btn-dark" role="alert" value="인쇄">
	<!-- Button trigger modal -->
	<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#staticBackdrop">
	  <strong>시설등록</strong>
	</button>
</div>
<div class="card text-center col-auto">
	<div class="card-body row">
		<div class="col-sm-12">
			<table class="table">
				<thead class="thead-dark">
					<tr>
						<th scope="col">#</th>
						<th scope="col">커뮤니티시설명</th>
						<th scope="col">분류</th>
<!-- 						<th scope="col">규모</th> -->
<!-- 						<th scope="col">수용인원</th> -->
<!-- 						<th scope="col">예약제한인원</th> -->
						<th scope="col">여는시간</th>
						<th scope="col">닫는시간</th>
<!-- 						<th scope="col">시설설명</th> -->
					</tr>
				</thead>
				<tbody id="listBody">
					<c:set var="communityList" value="${pagingVO.dataList }"/>
				<!-- 여기 개발 tr에 이벤트 걸어서 상세보기하는 방식으로 차용? 수업때 prod 했던거 참조하면 될듯하다. -->
					<c:if test="${not empty communityList }">
						<c:forEach var="community" items="${communityList }" varStatus="idx">
							<tr class="viewTr">
								<td>${idx.count }</td>
								<td>${community.cmntName }</td>
								<td>${community.cmntCode }</td>
<%-- 								<td><a href="${cPath }/vendor/apartView.do?what=${community.aptCode }">${apart.aptName }</a></td> --%>
								<td>${community.cmntOpen }</td>
								<td>${community.cmntClose }</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty communityList}">
						<tr>
							<td colspan="5">검색 결과 없음.</td>
						</tr>
					</c:if> 
<!-- 					<tr> -->
<!-- 						<th scope="row">1</th> -->
<%-- 						<td><a href="${cPath }/office/community/communityView.do/">단지 헬스장</a></td> --%>
<!-- 						<td>헬스장</td> -->
<!-- 						<td></td> -->
<!-- 						<td></td> -->
<!-- 						<td></td> -->
<!-- 					</tr> -->
				</tbody>
			</table>
			<div id="pagingArea">${pagingVO.pagingHTML }</div>
		</div>
	</div>
</div>



<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">시설 등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
        <div class="card text-center col-auto">
		<div class="card-body row">
			<div class="col-sm-12">
				<table class="table">
					<tbody class="thead-dark">
						<tr>
							<th scope="col"></th>
							<td>시설명</td>
							<td>
								<input type="text" name="cmntName">
							</td>
						</tr>
						<tr>
							<th scope="col"></th>
							<td>분류코드</td>
							<td>
								<input type="text" name="cmntCode">
							</td>
						</tr>
						<tr>
							<th scope="col"></th>
							<td>규모</td>
							<td>
								<input type="text" name="cmntSize">
							</td>
						</tr>
						<tr>
							<th scope="col"></th>
							<td>수용인원</td>
							<td>
								<input type="text" name="cmntCapa">
							</td>
						</tr>
						<tr>
							<th scope="col"></th>
							<td>예약제한인원</td>
							<td>
								<input type="text" name="cmntLimit">
							</td>
						</tr>
						<tr>
							<th scope="col"></th>
							<td>여는시간</td>
							<td>
								<input type="text" name="cmntOpen">
							</td>
						</tr>
						<tr>
							<th scope="col"></th>
							<td>닫는시간</td>
							<td>
								<input type="text" name="cmntClose">
							</td>
						</tr>
						<tr>
							<th scope="col"></th>
							<td>시설설명</td>
							<td colspan="3">
								<input type="text" width="500px;">
								<textarea rows="" cols="" name="cmntDesc"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		</div>
        form:form
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Understood</button>
      </div>
    </div>
  </div>
</div>

<!-- <div id="insertDiv"> -->
<!-- 	<div class="container"> -->
<!-- 		<div class="row"> -->
<!-- 			<div class="col-md-11"> -->
<!-- 				<strong>시설등록</strong> -->
<!-- 			</div> -->
<!-- 			<div class="col-md-1"> -->
<!-- 				<input type="button" class="btn btn-dark" role="alert" value="저장" -->
<!-- 					style="width: 100px;"> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->

<script>
let listbody = $("#listbody");
listbody.on("click", ".viewTr", function(){
	
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

searchForm.on("click", function(event){
	let inputs = $(this).parents("div#inputUI").find(":input[name]");
	$(inputs).each(function(index, input){
		let name = $(this).attr("name");
		let value = $(this).val();
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val(value);
	});
	searchForm.submit();
});

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