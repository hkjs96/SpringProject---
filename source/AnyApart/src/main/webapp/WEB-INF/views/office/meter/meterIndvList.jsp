<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 23.  박정민      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set var="auth" value="${authMember }"/>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }"/>
<c:set var="apart" value="${apart }"/>
<c:set var="mcVO" value="${thisMonthMCVO }"/>
<style>
#ListTable th, td{
	text-align: center;
}
#ListTable th{
	position: sticky;
	top: 0px;
}
#insertModal td{
	text-align: left;
}
img{
	width : 100%;
}
#ListTable td:nth-child(n+5):nth-child(-n+8){
	text-align: right;
} 
#inputUI input, .col-md-2, .col-md-8{
	display: inline;
} 
#insertModal td{
	text-align: center;
}
#insertModal .form-control{
	width: 100px;
}
#explainDiv span{
	color: blue;
}
#explainDiv{
	margin-bottom: 5px;
}
#totalCnt{
	color: red;
	font-size: 1.2em;
}
</style>
<br>
<h2>
	<strong>세대 검침</strong>
</h2>
<div> 
	<button type="button" class="btn btn-primary" style='margin:5pt;' data-toggle="modal" data-target="#insertModal">세대 검침량 단건 등록</button>
	<button type="button" class="btn btn-success" style='margin:5pt;' data-toggle="modal" data-target="#meterExcelUploadModal">엑셀 일괄 등록</button>
</div>
<!----------------------------- 검색 --------------------------------->
<div class="container">
	<div class="col-md-10" style="border-style: outset; border-radius: 8px;margin-left: 8%;">
		<div class="row g-0">
			<div class="col-md-2" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon" style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;
				<strong>검색 조건</strong>
			</div>
		</div>
		<form:form cammandName="pagingVO" id="searchForm">
			<input type="hidden" name="currentPage" value="1">
			<input type="hidden" name="startYear" value="${pagingVO.searchDetail.startYear }">
			<input type="hidden" name="startMonth" value="${pagingVO.searchDetail.startMonth }">
			<input type="hidden" name="endYear" value="${pagingVO.searchDetail.endYear }">
			<input type="hidden" name="endMonth" value="${pagingVO.searchDetail.endMonth }">
			<input type="hidden" name="startDong" value="${pagingVO.searchDetail.startDong }">
			<input type="hidden" name="startHo" value="${pagingVO.searchDetail.startHo }">
			<input type="hidden" name="endDong" value="${pagingVO.searchDetail.endDong }">
			<input type="hidden" name="endHo" value="${pagingVO.searchDetail.endHo }">
			<input type="hidden" name="meter" value="${pagingVO.searchDetail.meter }">
			<input type="hidden" name="sort" value="${pagingVO.searchDetail.sort }">
			<input type="hidden" name="resName" value="${pagingVO.searchDetail.resName }">
			<input type="hidden" name="screenSize" value="${pagingVO.screenSize }">
		</form:form>
		<form id="inputForm">
		<div id="inputUI">	
		<div class="card-body">
			<div class="row">
				<div class="col-md-2">시작/종료연월</div>
				<div class="col-md-10">
					<input type="text" name="startYear" class="form-control col-md-2" value="${pagingVO.searchDetail.startYear }">
		      		<span>년&nbsp;</span>
					<input type="text" name="startMonth" class="form-control col-md-1" value="${pagingVO.searchDetail.startMonth }">
		      		<span>월&nbsp;</span>&nbsp; ~ &nbsp;
					<input type="text" name="endYear" class="form-control col-md-2" value="${pagingVO.searchDetail.endYear }">
		      		<span>년&nbsp;</span>
					<input type="text" name="endMonth" class="form-control col-md-1" value="${pagingVO.searchDetail.endMonth }">
		      		<span>월&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;
		      		<button type="button" class="btn btn-dark" id="threeMonthBtn">3개월</button>
		      		<button type="button" class="btn btn-dark" id="sixMonthBtn">6개월</button>
			 	</div>
			</div><br>
			<div class="row">
				<div class="col-md-2">동/호 선택</div>
		      	<div class="col-md-10">
		      		<input type="text" name="startDong" class="form-control col-md-2" value="${pagingVO.searchDetail.startDong }">
					 동&nbsp;
		      		<input type="text" name="startHo" id="startHo" class="form-control col-md-2" value="${pagingVO.searchDetail.startHo }">
					 호&nbsp;&nbsp; ~ &nbsp;
		      		<input type="text" name="endDong" class="form-control col-md-2" value="${pagingVO.searchDetail.endDong }">
					 동&nbsp;
		      		<input type="text" name="endHo" id="endHo" class="form-control col-md-2" value="${pagingVO.searchDetail.endHo }">
					 호 
				</div>
			</div><br>
<!-- 			<div class="row"> -->
<!-- 				<div class="col-md-2">검침항목	</div> -->
<!-- 		      	<div class="col-md-9"> -->
<!-- 					<select name="meter" class="custom-select col-md-3 searchSelect"> -->
<!-- 						<option value>항목선택</option> -->
<%-- 						<option value="INDV_HEAT" ${'INDV_HEAT' eq pagingVO.searchDetail.meter?"selected":""}>난방</option> --%>
<%-- 						<option value="INDV_HOTWATER" ${'INDV_HOTWATER' eq pagingVO.searchDetail.meter?"selected":""}>급탕</option> --%>
<%-- 						<option value="INDV_WATER" ${"INDV_WATER" eq pagingVO.searchDetail.meter?"selected":""}>수도</option> --%>
<%-- 						<option value="INDV_ELEC" ${"INDV_ELEC" eq pagingVO.searchDetail.meter?"selected":""}>전기</option> --%>
<!-- 					</select> &nbsp;&nbsp; -->
<!-- 					<select name="sort" class="custom-select col-md-3 searchSelect"> -->
<!-- 						<option value>정렬방식</option> -->
<%-- 						<option value="desc" ${"desc" eq pagingVO.searchDetail.sort?"selected":""}>내림차순</option> --%>
<%-- 						<option value="asc" ${"asc" eq pagingVO.searchDetail.sort?"selected":""}>오름차순</option> --%>
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div><br> -->
			<div class="row">
				<div class="col-md-2">세대주명</div>
		      	<div class="col-md-3">
					<input type="text" name="resName" class="form-control" value="${pagingVO.searchDetail.resName }"> 
				</div>
				<div class="col-md-4">
					<button type="button" class="btn btn-dark" id="searchBtn">조회</button>
					<button type="reset" class="btn btn-dark" id="resetBtn">초기화</button>
				</div>
			</div>
		</div>
	</div>
	</form>
	</div>
</div>
<br>

<select name="show" onchange="showListNumber()" id="showSelect" class="custom-select col-md-1 searchSelect">
	<option value="10" ${10 eq pagingVO.screenSize?"selected":"" }>10</option>
	<option value="25" ${25 eq pagingVO.screenSize?"selected":"" }>25</option>
	<option value="50" ${50 eq pagingVO.screenSize?"selected":"" }>50</option>
	<option value="100" ${100 eq pagingVO.screenSize?"selected":"" }>100</option>
</select>
<span>개 씩 보기</span>&nbsp;&nbsp;&nbsp;
<button type="button" class="btn btn-success" style='margin:5pt;' id="excelDownBtn">엑셀 다운로드</button>
<br>
<div id="explainDiv">
	<span>* 더블 클릭시 해당연월의 공동 검침 정보를 수정할 수 있습니다.</span>
	<br>
	<span>* 관리비 부과일은 매월 5일입니다. 관리비가 이미 부과된 검침량은 수정할 수 없습니다.</span>
	<br>
	<span>* [${apart.aptName }]의 난방방식은 [${apart.codeName }]입니다.</span>
</div>
	전체 검침 수 : <span id="totalCnt">${totalCnt }</span>
<!----------------------------- 검침 목록 --------------------------------->
<div style="width: 100%;height: 550px;overflow: auto;">
	<table class="table table-bordered" id="ListTable">
		<colgroup>
			<col width="9%">
			<col width="9%">
			<col width="9%">
			<col width="9%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="12%">
		</colgroup>
		<thead class="thead-light">
			<tr>
				<th scope="col">동</th>
				<th scope="col">호</th>
				<th scope="col">검침연</th>
				<th scope="col">검침월</th>
				<th scope="col">난방</th>
				<th scope="col">급탕</th>
				<th scope="col">수도(t)</th>
				<th scope="col">전기(kWh)</th>
				<th scope="col">입주민코드</th>
				<th scope="col">변경</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(pagingVO.dataList) == 0 }">
				<tr>
					<td colspan="10">조회 결과가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${fn:length(pagingVO.dataList) != 0}">
				<c:forEach items="${pagingVO.dataList }" var="miVO">
					<tr>
						<td>${miVO.dong }</td>
						<td>${miVO.ho }</td>
						<td>${miVO.indvYear }</td>
						<td>${miVO.indvMonth }</td>
						<td><fmt:formatNumber value="${miVO.indvHeat }" pattern="#,###"/></td>
						<td><fmt:formatNumber value="${miVO.indvHotwater }" pattern="#,###"/></td>
						<td><fmt:formatNumber value="${miVO.indvWater }" pattern="#,###"/></td>
						<td><fmt:formatNumber value="${miVO.indvElec }" pattern="#,###"/></td>
						<td>${miVO.memId }</td>
						<td>
						<c:set var="now" value="<%=new java.util.Date()%>" />
						<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
						<c:set var="sysMonth"><fmt:formatDate value="${now}" pattern="MM" /></c:set>
						<c:set var="sysDay"><fmt:formatDate value="${now}" pattern="dd" /></c:set>
						<c:choose>
							<c:when test="${miVO.indvYear eq mcVO.commYear and miVO.indvMonth > mcVO.commMonth and mcVO.commFlag eq 'N'}">
								<button type="button" id="updateBtn" class="btn btn-warning" data-indvno="${miVO.indvNo }">수정</button>
								<button type="button" id="deleteBtn" class="btn btn-danger" data-indvno="${miVO.indvNo }">삭제</button>
							</c:when>
							<c:otherwise>
								<span style="color: red;">부과됨</span>
							</c:otherwise>
						</c:choose> 
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>

<div id="pagingDiv" class="pagination justify-content-center">
	<ui:pagination paginationInfo='${paginationInfo }' jsFunction='pageLinkMove' type='bsOffice'/>
</div>

<!---------------------------- 검침 등록 모달 ---------------------------->
<div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<div>
					<h3 class="modal-title" id="insertModalLabel">검침 등록</h3>
				</div>
				<div>
					<button class="btn btn-primary" id="insertAddBtn">추가</button>
				</div>
			</div>
			<form id="insertForm" action="${cPath }/office/meter/registMeterIndv.do" method="post">
				<input type="hidden" name="aptCode" value="${auth.aptCode }"/>
				<div class="modal-body">
					<table class="table" id="insertTable">
						<tr>
							<th><span class="reddot">* </span>검침연</th>
							<th><span class="reddot">* </span>검침월</th>
							<th><span class="reddot">* </span>난방검침량</th>
							<th><span class="reddot">* </span>급탕검침량</th>
							<th><span class="reddot">* </span>수도검침량</th>
							<th><span class="reddot">* </span>전기검침량</th>
							<th><span class="reddot">* </span>입주민코드</th>
							<th></th>
						</tr>
						<tr>
							<td><input type="number" name="indvList[0].indvYear" required class="form-control"></td>
							<td><input type="number" name="indvList[0].indvMonth" required class="form-control"></td>
							<td><input type="number" name="indvList[0].indvHeat" required class="form-control"></td>
							<td><input type="number" name="indvList[0].indvHotwater" required class="form-control"></td>
							<td><input type="number" name="indvList[0].indvWater" required class="form-control"></td>
							<td><input type="number" name="indvList[0].indvElec" required class="form-control"></td>
							<td><input type="text" name="indvList[0].memId" required class="form-control"></td>
							<td></td>
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
				<h3 class="modal-title" id="meterModalLabel">세대 검침량 수정</h3>
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
							<form method="POST" enctype="multipart/form-data" id="meterIndvExcelForm">
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

$("#updateBtn").on("click", function(){
	let indvNo = $(this).data("indvno");
	meterUpdateModal.find(".modal-body").load("${cPath}/office/meter/modifyMeterIndv.do?indvNo="+indvNo, function(){
		meterUpdateModal.modal();
	});	
});

//-------------------- 등록 -----------------------
$("#insertForm").validate({
	rules: 
    {
		indvYear: {maxlength: 4}
        ,indvMonth:{maxlength: 2}
        ,indvHeat:{maxlength: 12}
        ,indvHotwater:{maxlength: 12}
        ,indvWater:{maxlength: 12}
        ,indvElec:{maxlength: 12}
    }
});

let insertTable = $("#insertTable");
let index = 0;
$("#insertAddBtn").on("click", function(){
	index = index+1;
	let tr = $("<tr>");
	tr.append(
		$("<td>").append(
			$("<input type='number' name='indvList["+index+"].indvYear' required class='form-control'>")		
		)	
	);
	tr.append(
		$("<td>").append(
			$("<input type='number' name='indvList["+index+"].indvMonth' required class='form-control'>")		
		)	
	);
	tr.append(
		$("<td>").append(
			$("<input type='number' name='indvList["+index+"].indvHeat' required class='form-control'>")		
		)	
	);
	tr.append(
		$("<td>").append(
			$("<input type='number' name='indvList["+index+"].indvHotwater' required class='form-control'>")		
		)	
	);
	tr.append(
		$("<td>").append(
			$("<input type='number' name='indvList["+index+"].indvWater' required class='form-control'>")		
		)	
	);
	tr.append(
		$("<td>").append(
			$("<input type='number' name='indvList["+index+"].indvElec' required class='form-control'>")		
		)	
	);
	tr.append(
		$("<td>").append(
			$("<input type='text' name='indvList["+index+"].memId' required class='form-control'>")		
		)	
	);
	tr.append(
		$("<td>").append(
			$("<button type='button' class='btn btn-danger insertDelBtn'>-</button>")		
		)	
	);
	insertTable.append(tr);	
});

insertTable.on("click", ".insertDelBtn", function(){
	let tbody = $(this).parent().parent().remove();
	index = index-1;
});

//---------------------------------------------------
$("#resetBtn").on("click", function(){
	let inputs = $(this).parents("div#inputUI").find(":input[name]");
	$(inputs).each(function(idx, input){
		let name = $(this).attr("name");
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val("");
	});
	searchForm.attr("action", "${cPath}/office/meter/meterIndvList.do");
	searchForm.find("[name='screenSize']").val(10);
	searchForm.submit();
});

function showListNumber(){
	let screenSize = $("#showSelect").val();
	searchForm.attr("action", "${cPath}/office/meter/meterIndvList.do");
	searchForm.find("[name='screenSize']").val(screenSize);
	
	let inputs = $("div#inputUI").find(":input[name]");
	$(inputs).each(function(index, input){
		let name = $(this).attr("name");
		let value = $(this).val();
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val(value);
	});
	searchForm.submit();
}

$("#meterUpdateModal").on("click", "#insertBtn", function(){
	$("#updateForm").ajaxForm({
		method : "post"
		, dataType : "json"
		, success : function(resp){
			alert(resp.message);
			if(resp.message=="수정되었습니다."){
				$("#meterUpdateModal").modal("hide");
				location.reload();
			}
		}
		, error : function(xhr){
			console.log("에러:"+xhr.status);
		}
	}).submit();
});

$("#deleteBtn").on("click", function(){
	let indvNo = $(this).data("indvno");
	if(confirm("삭제하시겠습니까?")){
		$.ajax({
			url : "${cPath}/office/meter/deleteMeterIndv.do"
			, data : {"indvNo":indvNo}
			, dataType : "text"
			, success : function(message){
				alert(message);
				location.reload();
			}
		})
	}
});

//----------------- 6개월, 1년 검색 ---------------------
var date = new Date();
var year = date.getFullYear();
var month = date.getMonth()+1;
$("#threeMonthBtn").on("click", function(){
	let startDate = new Date(date.setMonth(date.getMonth()-2));
	let startYear = startDate.getFullYear();
	let startMonth = startDate.getMonth()+1;
	searchForm.find("[name='startYear']").val(startYear);
	searchForm.find("[name='startMonth']").val(startMonth);
	searchForm.find("[name='endYear']").val(year);
	searchForm.find("[name='endMonth']").val(month);
	searchForm.submit();
});

$("#sixMonthBtn").on("click", function(){
	let startDate = new Date(date.setMonth(date.getMonth()-5));
	let startYear = startDate.getFullYear();
	let startMonth = startDate.getMonth()+1;
	searchForm.find("[name='startYear']").val(startYear);
	searchForm.find("[name='startMonth']").val(startMonth);
	searchForm.find("[name='endYear']").val(year);
	searchForm.find("[name='endMonth']").val(month);
	searchForm.submit();
});

//---------------검색에서 동 선택시 해당 호 리스트 만들기----------------------
function makeHoOptions1(dong){
	$.ajax({
		url : "${cPath}/office/meter/meterIndvList.do"
		,data : {"dong":dong}
		,dataType:"json"
		,success : function(hoList){
			if(hoList){
				let options = [];
				$(hoList).each(function(idx, house){
					options.push(
						$("<option value='"+house.ho+"'>").text(house.ho)		
					)					
				});
				$("#startHo").append(options);
			}
		}
	});
}
function makeHoOptions2(dong){
	$.ajax({
		url : "${cPath}/office/meter/meterIndvList.do"
		,data : {"dong":dong}
		,dataType:"json"
		,success : function(hoList){
			if(hoList){
				let options = [];
				$(hoList).each(function(idx, house){
					options.push(
						$("<option value='"+house.ho+"'>").text(house.ho)		
					)					
				});
				$("#endHo").append(options);
			}
		}
	});
}

//---------------단건등록 입주민 select선택시 input tag에 값 뿌리기 ----------------------
function residentSelect(memId){
	$("#insertMemId").val(memId);
}

//========================== 엑셀 ==================================
//-----------------------샘플양식 다운로드---------------------------	
$("#sampleDownBtn").on("click", function(){
	location.href = "${cPath}/office/meter/sampleExcelDownIndv.do";
});	

$("#excelDownBtn").on("click", function(){
	searchForm.attr("action", "${cPath}/office/meter/downloadExcelIndv.do");
	console.log("val:"+searchForm.find("[name='screenSize']").val());
	searchForm.submit();
});

$("#uploadExcelBtn").on("click", function(){
	if(confirm("엑셀파일을 등록하시겠습니까?")){
		$("#meterIndvExcelForm").ajaxForm({
			url:"${cPath}/office/meter/uploadExcelIndv.do"
			, data : $("#meterIndvExcelForm").serialize()
			, dataType : "json"
			, success : function(resp){
				alert(resp.message);
				if(resp.message=='등록되었습니다.'){
					$("#meterExcelUploadModal").modal("hide");
					location.reload();
				}
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
	
	let inputs = $("div#inputUI").find(":input[name]");
	$(inputs).each(function(index, input){
		let name = $(this).attr("name");
		let value = $(this).val();
		console.log(value);
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val(value);
	});
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
	return false;  //이벤트에 대한 처리를 끝까지 완료해줘야됨
});
</script>