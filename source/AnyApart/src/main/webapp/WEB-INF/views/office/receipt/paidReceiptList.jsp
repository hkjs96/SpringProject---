<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 1.  이경륜      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
	.wrapper {
		height:565px;
		overflow: auto;
	}

	.fixedHeader {
	   position: sticky;
	   top: 0;
	}
</style>
<security:authentication property="principal" var="principal"/>
<c:set var="authMember" value="${principal.realMember }"/>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }"/>
<br>
<div id="top"> 
	<h2><strong>수납 조회</strong></h2>
</div>
<form:form commandName="pagingVO" id="searchForm" method="get">
<div class="container">
	<div class="col-md-12" style="border-style: outset; border-radius: 8px;">
		<div class="row g-0">
			<div class="col-md-2" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png"
					alt="searchIcon"
					style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;<strong>검색 조건</strong>
			</div>
		</div>
		<div class="card-body">
			<div class="row">
				<form:hidden path="currentPage"/>
				<div class="col-md-2">
					동/호 선택
				</div>
				<div class="col-md-5">
					<form:input path="searchDetail.dongStart" cssClass="form-control col-md-4" cssStyle="display: inline-block;" maxlength="4" onkeypress="return onlyNumber(event)"/>
		      		<label>&nbsp;동&nbsp;</label>
					<form:input path="searchDetail.hoStart" cssClass="form-control col-md-4" cssStyle="display: inline-block;" maxlength="4" onkeypress="return onlyNumber(event)"/>
			 		<label>&nbsp;호 ~&nbsp;</label>
			 	</div>
			 	<div class="col-md-5">
					<form:input path="searchDetail.dongEnd" cssClass="form-control col-md-4" cssStyle="display: inline-block;" maxlength="4" onkeypress="return onlyNumber(event)"/>
		      		<label>&nbsp;동&nbsp;</label>
					<form:input path="searchDetail.hoEnd" cssClass="form-control col-md-4" cssStyle="display: inline-block;" maxlength="4" onkeypress="return onlyNumber(event)"/>
			 		<label>&nbsp;호</label>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-md-2">
					수납일자
				</div>
				<div class="col-md-5">
					<input class="form-control col-md-5" type="date" name="searchDetail.receiptDateStart" style="display: inline-block;" value="${pagingVO.searchDetail.receiptDateStart }" >
					&nbsp;~&nbsp;
					<input class="form-control col-md-5" type="date" name="searchDetail.receiptDateEnd" style="display: inline-block;" value="${pagingVO.searchDetail.receiptDateEnd }" >
				</div>
				<div class="col-md-4">
					<button class="btn btn-dark" id="searchBtn" onclick="goSearch()">검색</button>
					<button class="btn btn-secondary" id="resetBtn">초기화</button>
				</div>
			</div>
		</div>
	</div>
</div>
<form:select path="screenSize" cssClass="custom-select col-md-1 searchSelect" onchange="goSearch()">
	<form:option value="10" label="10"/>
	<form:option value="25" label="25"/>
	<form:option value="50" label="50"/>
	<form:option value="100" label="100"/>
</form:select>
<span>개 씩 보기</span>
</form:form>
<br>
<div class="wrapper">
	<table class="table table-bordered table-hover">
		<thead class="thead-light text-center">
			<tr class="text-center">
				<th class="fixedHeader" scope="col">수납일자</th>
				<th class="fixedHeader" scope="col">고지년월</th>
				<th class="fixedHeader" scope="col">동</th>
				<th class="fixedHeader" scope="col">호</th>
				<th class="fixedHeader" scope="col">세대주명</th>
				<th class="fixedHeader" scope="col">부과액</th>
				<th class="fixedHeader" scope="col">연체료</th>
				<th class="fixedHeader" scope="col">총 수납금액</th>
				<th class="fixedHeader" scope="col">납기구분</th>
				<th class="fixedHeader" scope="col">수납방법</th>
			</tr>
		</thead>
		<tbody>
	    	<c:set var="receiptList" value="${pagingVO.dataList }" />
	    	<c:if test="${not empty receiptList }">
	    		<c:forEach items="${receiptList }" var="receipt" varStatus="vs">
		    		<tr class="text-center">
			            <td>${receipt.receiptDate }</td>
			            <td>${receipt.costYear } / ${receipt.costMonth }</td>
			            <td>${receipt.dong }</td>
			            <td>${receipt.ho }</td>
			            <td>${receipt.resName }</td>
			            <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${receipt.costTotal }" /> 원</td>
			            <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${receipt.lateFee }" /> 원</td>
			            <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${receipt.receiptCost }" /> 원</td>
			            <td style="color: ${receipt.receiptType eq '납기내' ? 'blue' : 'red' };">${receipt.receiptType }</td>
			            <td>${receipt.receiptMethod }</td>
			        </tr>
				</c:forEach>
	    	</c:if>
	    	<c:if test="${empty receiptList }">
	    		<tr class="text-center">
	    			<td colspan="10">조회 결과가 없습니다.</td>
	    		</tr>
	    	</c:if>
		</tbody>
	</table>
</div>
<c:if test="${not empty receiptList }">
	<div id="pagingArea" class="pagination justify-content-center">
		<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice" />
	</div>
</c:if>
<script>
let searchForm = $("#searchForm");

/*
 * 검색조건 바뀌면 페이지1페이지로 셋팅
 */
function resetPage() {
	searchForm.find("[name='currentPage']").val(1);
}
/*
 * 페이지 이동
 */
function pageLinkMove(event){
	event.preventDefault();
	let page = $(event.target).data("page");
	searchForm.find("[name='currentPage']").val(page);
	searchForm.submit();
	return false;
}
/*
 * - '조회' 눌렀을때 작동
 * - 스크린사이즈 변화있을때 searchForm 트리거링 
 */
function goSearch() {
	let hoStart = searchForm.find(":input[name='searchDetail.hoStart']").val();
	let hoEnd = searchForm.find(":input[name='searchDetail.hoEnd']").val();
	if(hoStart.length==3) {
		hoStart='0'+hoStart;
		searchForm.find(":input[name='searchDetail.hoStart']").val(hoStart);
	}
	if(hoEnd.length==3) {
		hoEnd='0'+hoEnd;
		searchForm.find(":input[name='searchDetail.hoEnd']").val(hoEnd);
	}
	searchForm.attr("action", "<c:url value='/office/receipt/paidReceiptList.do'/>");
	searchForm.submit();
}
/*
 * 리셋
 */
$("#resetBtn").on("click", function(event) {
	event.preventDefault();
	
	let inputs = searchForm.find(":input[name]");
	$(inputs).each(function(index, input){
		$(this).val(null);
	});
	resetPage();
	
	return false;
});
/*
 * forEach 사용 후 rowspan 병합
 * 참고: https://brunch.co.kr/@ourlove/85
 */
var mergeItem = "";
var mergeCount = 0;
var mergeRowNum = 0;

var thCnt = $("th","table").length;

$('tr', 'table').each(function(row) {
// 	if(row > 2) { // 헤더 제외
		var thisTr = $(this);
		var item = $(':first-child',thisTr).html();
		var item2 = $(':eq(1)', thisTr).html();

		if(mergeItem != item) {
			mergeCount = 1;
			mergeItem = item;
			mergeRowNum = Number(row); // 숫자 형태로 저장
		} else {
			mergeCount = Number(mergeCount) + 1;
			$("tr:eq("+mergeRowNum+") > td:first-child").attr("rowspan",mergeCount).addClass("align-middle");
			$('td:first-child',thisTr).remove(); // 병합했으므로 해당 행의 첫번째 td element는 삭제한다.
		}
// 	}
});

// $('tr', 'table').each(function(row) {
// 		var thisTr = $(this);
// 		console.log(thisTr);
// 		for(var i = 1 ; i < 4 ; i++) {
// 			var item = $(':eq('+i+')', thisTr).html();
// 			console.log(item);
// 			if(mergeItem != item) {
// 				mergeCount = 1;
// 				mergeItem = item;
// 				mergeRowNum = Number(row); // 숫자 형태로 저장
// 			} else {
// 				mergeCount = Number(mergeCount) + 1;
// 				$("tr:eq("+mergeRowNum+") > td:eq('+i+')").attr("rowspan",mergeCount).addClass("align-middle");
// 				$(':eq('+i+')',thisTr).remove(); // 병합했으므로 해당 행의 첫번째 td element는 삭제한다.
// 			}
// 		}
		
// 		mergeItem = "";
// 		mergeCount = 0;
// 		mergeRowNum = 0;
// });

</script>
