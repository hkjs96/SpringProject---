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
<style>
#ListTable th, td{
	text-align: center;
}
#insertModal td{
	text-align: left;
}
img{
	width : 100%;
}
.tablinks.active {
  color: #000;
  background-color: #fff;
}
</style>
<br>
<div id="top"> 
	<h2>세대 검침 관리</h2>
	<button type="button" class="btn btn-primary" style='margin:5pt;' data-toggle="modal" data-target="#insertModal">세대 검침량 단건 등록</button>
	<button type="button" class="btn btn-success" style='margin:5pt;' data-toggle="modal" data-target="#meterExcelUploadModal">엑셀 일괄 등록</button>
</div>
<!----------------------------- 검색 --------------------------------->
<div class="container">
	<div class="col-md-12" style="border-style: outset; border-radius: 8px;">
		<div class="row g-0">
			<div class="col-md-2" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon" style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;
				<strong>검색 조건</strong>
			</div>
		</div>
		<form id="searchForm">
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
		</form>
		<form id="inputForm">
		<div id="inputUI">	
		<div class="card-body">
			<div class="row">
				<div class="col-md-2">시작/종료연월</div>
				<div class="col-md-7">
					<select name="startYear">
						<option value>선택</option>
						<c:forEach begin="2010" end="2050" var="year">
							<option value="${year }" ${year eq pagingVO.searchDetail.startYear?"selected":""}>${year }</option>
						</c:forEach>
					</select>
		      		<span>&nbsp;년&nbsp;</span>
					<select name="startMonth">
						<option value>선택</option>
						<c:forEach begin="1" end="12" var="month">
							<option value="${month }" ${month eq pagingVO.searchDetail.startMonth?"selected":""}>${month }</option>
						</c:forEach>
					</select>
		      		<span>&nbsp;월&nbsp;</span>&nbsp;&nbsp; ~ &nbsp;&nbsp;
					<select name="endYear">
						<option value>선택</option>
						<c:forEach begin="2010" end="2050" var="year">
							<option value="${year }" ${year eq pagingVO.searchDetail.endYear?"selected":""}>${year }</option>
						</c:forEach>
					</select>
		      		<span>&nbsp;년&nbsp;</span>
					<select name="endMonth">
						<option value>선택</option>
						<c:forEach begin="1" end="12" var="month">
							<option value="${month }" ${month eq pagingVO.searchDetail.endMonth?"selected":""}>${month }</option>
						</c:forEach>
					</select>
		      		<span>&nbsp;월&nbsp;</span>
			 	</div>
			</div><br>
			<div class="row">
				<div class="col-md-2">동/호 선택</div>
		      	<div class="col-md-7">
					<form:select path="dongList" name="startDong" onchange="makeHoOptions1(this.value)">
						<form:option value="0000">선택</form:option>
						<form:options items="${dongList }" itemValue="dong" itemLabel="dong" />
					</form:select> 동&nbsp;
					<select name="startHo" id="startHo">
						<option value>선택</option>
					</select> 호&nbsp;&nbsp; ~ &nbsp;&nbsp;
					<form:select path="dongList" name="endDong" onchange="makeHoOptions2(this.value)">
						<form:option value="0000">선택</form:option>
						<form:options items="${dongList }" itemValue="dong" itemLabel="dong"/>
					</form:select> 동&nbsp;
					<select name="endHo" id="endHo">
						<option value=>선택</option>
					</select> 호 
				</div>
			</div><br>
			<div class="row">
				<div class="col-md-2">검침항목	</div>
		      	<div class="col-md-3">
					<select name="meter">
						<option value>항목선택</option>
						<option value="INDV_HEAT" ${'INDV_HEAT' eq pagingVO.searchDetail.meter?"selected":""}>난방</option>
						<option value="INDV_HOTWATER" ${'INDV_HOTWATER' eq pagingVO.searchDetail.meter?"selected":""}>급탕</option>
						<option value="INDV_WATER" ${"INDV_WATER" eq pagingVO.searchDetail.meter?"selected":""}>수도</option>
						<option value="INDV_ELEC" ${"INDV_ELEC" eq pagingVO.searchDetail.meter?"selected":""}>전기</option>
					</select> &nbsp;&nbsp;
					<select name="sort">
						<option value>정렬방식</option>
						<option value="desc" ${"desc" eq pagingVO.searchDetail.sort?"selected":""}>내림차순</option>
						<option value="asc" ${"asc" eq pagingVO.searchDetail.sort?"selected":""}>오름차순</option>
					</select>
				</div>
			</div><br>
			<div class="row">
				<div class="col-md-2">세대주명</div>
		      	<div class="col-md-3">
					<input type="text" name="resName" class="form-control" value="${pagingVO.searchDetail.resName }"> 
				</div>
				<div class="col-md-2">
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

<select name="show" onchange="showListNumber()" id="showSelect">
	<option value="10" ${10 eq pagingVO.screenSize?"selected":"" }>10</option>
	<option value="25" ${25 eq pagingVO.screenSize?"selected":"" }>25</option>
	<option value="50" ${50 eq pagingVO.screenSize?"selected":"" }>50</option>
	<option value="100" ${100 eq pagingVO.screenSize?"selected":"" }>100</option>
</select>
<span>개 씩 보기</span>
<br>
<span>* 더블 클릭시 해당연월의 공동 검침 정보를 수정할 수 있습니다.</span>
<br>
<span>* 관리비 부과일은 매월 5일입니다. 관리비가 이미 부과된 검침량은 수정할 수 없습니다.</span>
<br>
<span>* [${apart.aptName }]의 난방방식은 [${apart.codeName }]입니다.</span>
<button type="button" class="btn btn-success" style='margin:5pt;' id="excelDownBtn">엑셀 다운로드</button>

<!-------------------------------------------------------------------- 검침 목록 ------------------------------------------------------------------------>
<div class="card text-center col-md-12 float-left container">
	<div class="card-header">
		<ul class="nav nav-tabs card-header-tabs tabs">
			<li class="nav-item tab-link " data-tab="tab-1">
				세대별 요금
			</li>
			<li class="nav-item tab-link active" data-tab="tab-2">
				에너지 챠트
			</li>
		</ul>
	</div>
	<div class="card-body row tab-content active" id="tab-1">
		<table class="table" id="ListTable">
			<colgroup>
				<col width="7%">
				<col width="9%">
				<col width="9%">
				<col width="9%">
				<col width="9%">
				<col width="9%">
				<col width="9%">
				<col width="8%">
				<col width="8%">
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
					<th scope="col">동</th>
					<th scope="col">호</th>
					<th scope="col">입주민코드</th>
					<th scope="col">변경</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(pagingVO.dataList) == 0 }">
					<tr>
						<td colspan="8">검침 내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${fn:length(pagingVO.dataList) != 0}">
					<c:forEach items="${pagingVO.dataList }" var="miVO">
						<tr>
							<td>${miVO.indvNo }</td>
							<td>${miVO.indvYear }</td>
							<td>${miVO.indvMonth }</td>
							<td>${miVO.indvHeat } &nbsp;&nbsp;
							<%--
								<c:if test="${miVO.cHotwater<0 }">
									<img src="${cPath}/images/down.png">&nbsp;${-miVO.cHotwater }
								</c:if>
								<c:if test="${miVO.cHotwater>=0 }">
									<img src="${cPath}/images/up.png">&nbsp;${miVO.cHotwater }
								</c:if>
							 --%>
							</td>
							<td>${miVO.indvHotwater }</td>
							<td>${miVO.indvWater }</td>
							<td>${miVO.indvElec }</td>
							<td>${miVO.dong }</td>
							<td>${miVO.ho }</td>
							<td>${miVO.memId }</td>
							<td>
							<c:set var="now" value="<%=new java.util.Date()%>" />
							<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
							<c:set var="sysMonth"><fmt:formatDate value="${now}" pattern="MM" /></c:set>
							<c:set var="sysDay"><fmt:formatDate value="${now}" pattern="dd" /></c:set>
							<c:choose>
								<c:when test="${sysYear-miVO.indvYear gt 1 or (sysYear eq miVO.indvYear and sysMonth-miVO.indvMonth <= 0) or (sysMonth-miVO.indvMonth eq 1 and sysDay<5) }">
									<button type="button" id="updateBtn" class="btn btn-warning" data-indvno="${miVO.indvNo }">수정</button>
									<button type="button" id="deleteBtn" class="btn btn-danger" data-indvno="${miVO.indvNo }">삭제</button>
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
	</div>	
	<div class="tab-content" id="tab-2">
		sdlafj
	</div>
</div>

<div id="pagingDiv">
	<ui:pagination paginationInfo='${paginationInfo }' jsFunction='pageLinkMove' type='bsOffice'/>
</div>

<!---------------------------- 검침 등록 모달 ---------------------------->
<div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="insertModalLabel">검침 등록</h3>
			</div>
			<form id="insertForm" action="${cPath }/office/meter/registMeterIndv.do" method="post">
				<input type="hidden" name="aptCode" value="${auth.aptCode }"/>
				<div class="modal-body">
					<table class="table">
						<tr>
							<td><span class="reddot">* </span>검침연</td>
							<td><input type="number" name="indvYear" required></td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>검침월</td>
							<td><input type="number" name="indvMonth" required></td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>난방검침량</td>
							<td colspan="2"><input type="number" name="indvHeat" required></td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>급탕검침량</td>
							<td colspan="2"><input type="number" name="indvHotwater" required></td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>수도검침량</td>
							<td colspan="2"><input type="number" name="indvWater" required></td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>전기검침량</td>
							<td colspan="2"><input type="number" name="indvElec" required></td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>입주민코드</td>
							<td colspan="2">
								<input type="text" name="memId" required placeholder="직접입력" id="insertMemId">
								<form:select path="residentList" onchange="residentSelect(this.value)">
									<form:option value="0000">입주민 코드</form:option>
									<form:options items="${residentList }" itemValue="memId" itemLabel="memId"/>
								</form:select>
							</td>
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
$(document).ready(function(){
	
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');
		console.log(tab_id);
		$('ul.tabs li').removeClass('active');
		$('.tab-content').removeClass('active');
		console.log($(this));

		$(this).addClass('active');
		$("#"+tab_id).addClass('active');
		console.log($(this));
	})

})


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