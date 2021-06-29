<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 27.  이경륜      최초작성 UI
* 2021. 2. 17.  박정민      데이터
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="auth" value="${authMember }"/>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }"/>
<c:set var="apart" value="${apart }"/>
<style>
#ListTable th, td{
	text-align: center;
}
#insertModal td{
	text-align: left;
}
#ListTable td:nth-child(n+4):nth-child(-n+7){
	text-align: right;
} 
#inputUI{
	display: inline;
}
#inputUI input, .col-md-2, .col-md-8{
	display: inline;
}
.card-body{
	width: 70%;
	margin: 0;
	display: inline;
}
#inputForm{
	width: 80%;
}
</style>
<br>
<div id="top"> 
	<h2>공통 검침 관리</h2>
	<button type="button" class="btn btn-primary" style='margin:5pt;' data-toggle="modal" data-target="#insertModal">공통 검침량 단건 등록</button>
	<button type="button" class="btn btn-success" style='margin:5pt;' data-toggle="modal" data-target="#meterExcelUploadModal">엑셀 일괄 등록</button>
</div>
<!----------------------------- 검색 --------------------------------->
<div class="container">
	<div class="col-md-12" style="border-style: outset; border-radius: 8px;">
		<div class="row">
			<div class="col-md-2" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon" style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;
				<strong>검색 조건</strong>
			</div>
		<form id="searchForm">
			<input type="hidden" name="currentPage" value="1">
			<input type="hidden" name="startYear">
			<input type="hidden" name="startMonth">
			<input type="hidden" name="endYear">
			<input type="hidden" name="endMonth">
			<input type="hidden" name="meter">
			<input type="hidden" name="sort">
			<input type="hidden" name="screenSize" value="${pagingVO.screenSize }">
		</form>
		<form id="inputForm" style="display: inline;">
		<div id="inputUI">	
				<div class="col-md-2">시작/종료연월</div>
				<div class="col-md-8">
					<input type="text" name="startYear" class="form-control col-md-1">
		      		<span>년&nbsp;</span>
					<input type="text" name="startMonth" class="form-control col-md-1" >
		      		<span>월&nbsp;</span>&nbsp; ~ &nbsp;
					<input type="text" name="endYear" class="form-control col-md-1" >
		      		<span>년&nbsp;</span>
					<input type="text" name="endMonth" class="form-control col-md-1" >
		      		<span>월&nbsp;</span>
		      		<button type="button" class="btn btn-dark">6개월</button>
		      		<button type="button" class="btn btn-dark">1년</button>
			 	</div>
			</div>
			<br>
			<div class="row">
				<div class="col-md-2">검침항목	</div>
		      	<div class="col-md-4">
					<select name="meter" class="custom-select col-md-4 searchSelect">
						<option value>항목선택</option>
						<option value="INDV_HEAT" ${'INDV_HEAT' eq pagingVO.searchDetail.meter?"selected":""}>난방</option>
						<option value="INDV_HOTWATER" ${'INDV_HOTWATER' eq pagingVO.searchDetail.meter?"selected":""}>급탕</option>
						<option value="INDV_WATER" ${"INDV_WATER" eq pagingVO.searchDetail.meter?"selected":""}>수도</option>
						<option value="INDV_ELEC" ${"INDV_ELEC" eq pagingVO.searchDetail.meter?"selected":""}>전기</option>
					</select> &nbsp;&nbsp;
					<select name="sort" class="custom-select col-md-4 searchSelect">
						<option value>정렬방식</option>
						<option value="desc" ${"desc" eq pagingVO.searchDetail.sort?"selected":""}>내림차순</option>
						<option value="asc" ${"asc" eq pagingVO.searchDetail.sort?"selected":""}>오름차순</option>
					</select>
				</div>
				<div class="col-md-4">
					<button class="btn btn-dark" id="searchBtn">조회</button>
					<button type="reset" class="btn btn-dark" id="resetBtn">초기화</button>
				</div>
			</div>
		</div>
	</div>
	</form>
	</div>
<br>

<select name="show" onchange="showListNumber()" id="showSelect">
	<option value="10" ${10 eq pagingVO.screenSize?"selected":"" }>10</option>
	<option value="25" ${25 eq pagingVO.screenSize?"selected":"" }>25</option>
	<option value="50" ${50 eq pagingVO.screenSize?"selected":"" }>50</option>
	<option value="100" ${100 eq pagingVO.screenSize?"selected":"" }>100</option>
</select>
<span>개 씩 보기</span>
<br>
<span>* 수정버튼 클릭시 해당연월의 공동 검침 정보를 수정할 수 있습니다.</span>
<br>
<span>* 관리비 부과일은 매월 5일입니다. 관리비가 이미 부과된 검침량은 수정할 수 없습니다.</span>
<br>
<span>* [${apart.aptName }]의 난방방식은 [${apart.codeName }]입니다.</span>
<button type="button" class="btn btn-success" style='margin:5pt;' id="excelDownBtn">엑셀 다운로드</button>

<!----------------------------- 검침 목록 --------------------------------->
<table class="table table-bordered" id="ListTable">
	<colgroup>
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<col width="13%">
		<col width="13%">
		<col width="13%">
		<col width="13%">
		<col width="15%">
	</colgroup>
	<thead class="thead-light">
		<tr>
			<th scope="col">검침 번호</th>
			<th scope="col">검침연</th>
			<th scope="col">검침월</th>
			<th scope="col">난방</th>
			<th scope="col">급탕</th>
			<th scope="col">수도(t)</th>
			<th scope="col">전기(kWh)</th>
			<th scope="col">수정</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(pagingVO.dataList) == 0 }">
			<tr>
				<td col>검침 내역이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${fn:length(pagingVO.dataList) != 0}">
			<c:forEach items="${pagingVO.dataList }" var="cmVO">
				<tr>
					<td>${cmVO.commNo }</td>
					<td>${cmVO.commYear }</td>
					<td>${cmVO.commMonth }</td>
					<td><fmt:formatNumber value="${cmVO.commHeat }" pattern="#,###"/></td>
					<td><fmt:formatNumber value="${cmVO.commHotwater }" pattern="#,###"/></td>
					<td><fmt:formatNumber value="${cmVO.commWater }" pattern="#,###"/></td>
					<td><fmt:formatNumber value="${cmVO.commElec }" pattern="#,###"/></td>
					<td>
					<c:set var="now" value="<%=new java.util.Date()%>" />
					<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
					<c:set var="sysMonth"><fmt:formatDate value="${now}" pattern="MM" /></c:set>
					<c:set var="sysDay"><fmt:formatDate value="${now}" pattern="dd" /></c:set>
					<c:choose>
						<c:when test="${sysYear-cmVO.commYear gt 1 or (sysYear eq cmVO.commYear and sysMonth-cmVO.commMonth <= 0) or (sysMonth-cmVO.commMonth eq 1 and sysDay<5) }">
							<button type="button" id="updateBtn" class="btn btn-warning updateBtn" data-commno="${cmVO.commNo }">수정</button>
							<button type="button" id="deleteBtn" class="btn btn-danger deleteBtn" data-commno="${cmVO.commNo }">삭제</button>
						</c:when>
						<c:otherwise>
							부과됨
						</c:otherwise>
					</c:choose> 
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>

<div id="pagingDiv" class="pagination justify-content-center">
	<ui:pagination paginationInfo='${paginationInfo }' jsFunction='pageLinkMove' type='bsOffice'/>
</div>

<!---------------------------- 검침 등록 모달 ---------------------------->
<div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="insertModalLabel">검침 등록</h3>
			</div>
			<form id="insertForm" action="${cPath }/office/meter/registMeterComm.do" method="post">
				<input type="hidden" name="aptCode" value="${auth.aptCode }"/>
				<div class="modal-body">
					<table class="table">
						<tr>
							<td><span class="reddot">* </span>검침연</td>
							<td><input type="number" name="commYear" required></td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>검침월</td>
							<td><input type="number" name="commMonth" required></td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>난방검침량</td>
							<td colspan="2"><input type="number" name="commHeat" required></td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>급탕검침량</td>
							<td colspan="2"><input type="number" name="commHotwater" required></td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>수도검침량</td>
							<td colspan="2"><input type="number" name="commWater" required></td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>전기검침량</td>
							<td colspan="2"><input type="number" name="commElec" required></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">등록</button>
					<button type="reset" class="btn btn-warning" data-bs-dismiss="modal">초기화</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!---------------------------- 검침 수정 모달 ---------------------------->
<div class="modal fade" id="meterUpdateModal" tabindex="-1" aria-labelledby="meterUpdateModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="meterModalLabel">공동 검침량 수정</h3>
			</div>
			<div class="modal-body"></div>
		</div>
	</div>
</div>
 
<!-- 엑셀 일괄 등록 모달 -->
<div class="modal fade" id="meterExcelUploadModal" tabindex="-1" aria-labelledby="meterExcelUploadModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="meterExcelUploadModalLabel">엑셀 일괄 등록</h3>
			</div>
			<div class="modal-body">
				<table class="table">
					<tr>
						<td>샘플 양식 다운로드</td>
						<td><button class="btn btn-dark" id="sampleDownBtn">샘플양식다운로드</button></td>
					</tr>
					<tr>
						<td>엑셀 업로드</td>
						<td>
							<form method="POST" enctype="multipart/form-data" id="meterCommExcelForm">
								<input type="hidden" name="aptCode" value="">
								<input type="file" id="excelFile" name="excelFile">
							</form>
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="uploadExcelBtn">저장</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
let searchForm = $("#searchForm");

let meterUpdateModal = $("#meterUpdateModal").on("hidden.bs.modal", function() {
	$(this).find(".modal-body").empty();
});

$(".updateBtn").on("click", function(){
	let commNo = $(this).data("commno");
	meterUpdateModal.find(".modal-body").load("${cPath}/office/meter/modifyMeterComm.do?commNo="+commNo, function(){
		meterUpdateModal.modal();
	});	
});

$("#insertForm").validate({
	rules: 
    {
		commYear: {maxlength: 4}
        ,commMonth:{maxlength: 2}
        ,commHeat:{maxlength: 12}
        ,commHotwater:{maxlength: 12}
        ,commWater:{maxlength: 12}
        ,commElec:{maxlength: 12}
    }
});

$("#resetBtn").on("click", function(){
	let inputs = $(this).parents("div#inputUI").find(":input[name]");
	$(inputs).each(function(idx, input){
		let name = $(this).attr("name");
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val("");
	});
	searchForm.attr("action", "${cPath}/office/meter/meterCommList.do");
	searchForm.find("[name='screenSize']").val(10);
	searchForm.submit();
});

function showListNumber(){
	let screenSize = $("#showSelect").val();
	searchForm.attr("action", "${cPath}/office/meter/meterCommList.do");
	searchForm.find("[name='screenSize']").val(screenSize);
	searchForm.submit();
}

$(".deleteBtn").on("click", function(){
	let commNo = $(this).data("commno");
	if(confirm("삭제하시겠습니까?")){
		$.ajax({
			url : "${cPath}/office/meter/deleteMeterComm.do"
			, data : {"commNo":commNo}
			, dataType : "text"
			, success : function(message){
				alert(message);
				location.reload();
			}
		})
	}
});

//========================== 엑셀 ==================================
//-----------------------샘플양식 다운로드---------------------------	
$("#sampleDownBtn").on("click", function(){
	location.href = "${cPath}/office/meter/sampleExcelDown.do";
});	

$("#excelDownBtn").on("click", function(){
	searchForm.attr("action", "${cPath}/office/meter/downloadExcel.do");
	console.log("val:"+searchForm.find("[name='screenSize']").val());
	searchForm.submit();
});

$("#uploadExcelBtn").on("click", function(){
	if(confirm("엑셀파일을 등록하시겠습니까?")){
		$("#meterCommExcelForm").ajaxForm({
			url:"${cPath}/office/meter/uploadExcel.do"
			, data : $("#meterCommExcelForm").serialize()
			, dataType : "json"
			, success : function(resp){
				alert(resp.message);
				$("#meterExcelUploadModal").modal("hide");
				location.reload();
			}
			, error : function(xhr){
				console.log(xhr.status);
			}
		}).submit();
	}	
});

function pageLinkMove(event){
	event.preventDefault();
	let page = $(event.target).data("page");
	searchForm.find("[name='currentPage']").val(page);
	searchForm.submit();
	return false;
}

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