<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<style>
#insertDiv input {
	border: 0.5px solid #DEE2E6;
	width: 200px;
}

#insertDiv {
	width: 90%;
	margin-left: 80px;
	margin-top: 80px;
}

#insertDiv td {
	text-align: center;
}
</style>
<br>
<h2>
	<strong>용역관리</strong>
</h2>
<br>
    <div class="container">
	<div class="col-sm-6" style="border-style:outset;border-radius: 8px;margin-left:15em;">
	  <div class="row g-0">
	    <div>
    	<form id="searchForm">
			<input type="hidden" name="page" />
			<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
			<input type="hidden" name="searchWord"  value="${pagingVO.searchVO.searchWord }"/>
		</form>
	    <form class="form-inline">
	      <div class="card-body inputUI">
	      		<div class="ml-3" style="float:left">
	      			 <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
				    style="width:30px;height:30px;">&nbsp;&nbsp;
		        	<select name="searchType" class="custom-select">
						<option value="svcName" ${'content' eq param.searchType?"selected":"" }>업체명</option>
						<option value="svcCode" ${'content' eq param.searchType?"selected":"" }>업종종류</option>
		        	</select> 
			       	<input type="text" name="searchWord" class="form-control col-sm-8" value="${pagingVO.searchVO.searchWord }">
	      		</div>
	      		<div class="ml-3" style="float:left">
				</div>
				    <div class="d-flex justify-content-end"><button class="btn btn-dark" id="searchBtn">검색</button></div>
				      	</div>
				    	</form>
				    </div>
			    </div>
			  </div>
			  </div>
<br>


<div class="container">
<div align="right" class="mb-2">
<%-- 	<a  class="btn btn-success" id="downExcelJxls" data-page='${pagingVO.currentPage }'>엑셀 다운로드</a> --%>
	<input type="button" class="btn btn-dark" role="alert" value="파일 양식 다운로드" onclick="location.href='${cPath}/office/servicecompany/downloadTmpl.do'">
	<input type="button" class="btn btn-primary" role="alert" value="등록" onclick="location.href='${cPath}/office/servicecompany/serviceForm.do'">
	<button type="button" class="btn btn-success" style='margin:5pt;' data-toggle="modal" data-target="#contractExcelUploadModal">엑셀 일괄 등록</button>
</div>
	<div class="col-sm-12">
		<table class="table table-bordered" id="listBody">
			<thead class="thead-light" >
				<tr class="text-center">
					<th scope="col">No.</th>
					<th scope="col">업종</th>
					<th scope="col">용역업체명</th>
					<th scope="col">계약금</th>
					<th scope="col">계약 시작일</th>
					<th scope="col">계약 만료일</th>
				</tr>
			</thead>
			<tbody>
				<tr id="" class="text-center">
				<c:set var="contractList" value="${pagingVO.dataList }"/>
             	<c:if test="${empty contractList }">
             		<td class="text-center" colspan="6">등록된 용역업체가 없습니다.</td>
             	</c:if>
             	<c:if test="${not empty contractList }">
             		<c:forEach items="${contractList }" var="contract">
             		<tr id="trList" data-contract="${contract.svcId}" data-del="${contract.svcDel }" class="text-center">
	             		<c:choose>
							<c:when test="${contract.svcDel eq 'Y' && contract.svcId ne 'SAMPLE'}">
			             		<td>${contract.svcRum } </td>
			              		<td>${contract.svcCode } </td>
			              		<td class="text-left">${contract.svcName } </td>
			              		<td class="text-right" >${contract.svcDeposit } 원 </td>
			             		<td style="color: red;">계약 만료 </td>
			             		<td style="color: red;">계약 만료 </td>
							</c:when>  
							<c:when test="${contract.svcDel eq 'N' && contract.svcId ne 'SAMPLE' }">
								<td>${contract.svcRum } </td>
			              		<td>${contract.svcCode } </td>
			              		<td class="text-left">${contract.svcName } </td>
			              		<td class="text-right">${contract.svcDeposit } 원 </td>
								<td>${contract.svcStart } </td>
			             			<td>${contract.svcEnd } </td>
							</c:when>            			
	             		</c:choose>
             		</tr>
          			</c:forEach>
             		</c:if>
				</tr>
			</tbody>
		</table>
		       <div id="pagingArea">
              <ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsVendor"/>
           </div>
	</div>
</div>

<div class="modal fade" id="myLargeModalLabel" tabindex="-1" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-fullscreen" data-bs-backdrop="static" >
	  <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title h4" id="myLargeModalLabel">용역업체 정보</h5>
	         <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	      
	      </div>
	      <div class="modal-footer">
	      <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=20f2924230e0e2fb25bc546e44c0b498&libraries=services,clusterer,drawing&autoload=false"></script>
			<input type="button" value="수정" class="btn btn-primary mr-3" id="modifyBtn" />
			<input type="button" value="계약 설정" class="btn btn-primary mr-3" id="delectBtn" />
             <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	</div>
</div>

<div class="modal fade" id="contractExcelUploadModal" tabindex="-1" aria-labelledby="contractExcelUploadModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="contractExcelUploadModalLabel">엑셀 일괄 등록</h3>
			</div>
			<div class="modal-body">
				<table class="table">
					<tr>
						<td>엑셀 업로드</td>
						<td>
							<form method="POST" enctype="multipart/form-data" id="contractExcelForm" name="svcFile">
								<input type="hidden" name="aptCode" value="">
								<input type="file" id="excelFile" name="excelFile">
							</form>
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="uploadExcelBtn">저장</button>
				<button type="reset" class="btn btn-warning" data-bs-dismiss="modal">초기화</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

$("#downExcelJxls").on("click", function(){
	let id = $(this).prop("id");
	let page = $(this).data("page");
	let requestURL = "/AnyApart/office/servicecompany/downloadExcel.do?page="+page; 
	$(this).attr("href", requestURL);
	return true;
});

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


let listBody = $("#listBody");
let serviceViewModal = $("#myLargeModalLabel").on("hidden.bs.modal", function(){
	$(this).find(".modal-body").empty();
});
let svcRemoveId = "";
let svcDelcode= "";
listBody.on("click", "tr", function(){
	let svcId = $(this).data("contract");
	let svcDelCode=$(this).data("del");
	svcDelcode=svcDelCode;
	svcRemoveId = svcId;
	serviceViewModal.find(".modal-body").load($.getContextPath()+"/office/servicecompany/serviceView.do?svcId="+svcId, function(){
		serviceViewModal.modal("show");
	});
});

$("#modifyBtn").on("click",function (){
	 if (confirm("수정하시겠습니까?") == true){    //확인
		location.href=$.getContextPath()+"/office/servicecompany/serviceModify.do?svcId="+svcRemoveId;
	 }else{   //취소

	     return false;

	 }
})
$("#delectBtn").on("click",function(){
	let message = "";
	if (svcDelcode == 'Y'){
		message = "다시 계약 처리 하시 겠습니까?"	
	}else(
		message = "해당 계약을 만료 하시겠습니까?"
	)
	if(confirm(message)== true){
		location.href=$.getContextPath()+"/office/servicecompany/delete.do?svcId="+svcRemoveId+"&svcDel="+svcDelcode;
	}else{
		
		return false;
	}
	
})

const contractExcelUploadModal = $("#contractExcelUploadModal");
const excelFile = $("#excelFile");
excelFile.on("change", function() {
	const uploadFile = this.files[0];
	const ext = uploadFile.name.substr(uploadFile.name.lastIndexOf(".")+1).toLowerCase();
	
	if(ext != "xls" && ext != "xlsx" && ext !="xlsm") {
		getErrorNotyDefault("올바른 파일형식이 아닙니다.");
		this.value=null;
	}
});

const uploadExcelBtn = $("#uploadExcelBtn");

uploadExcelBtn.on("click", function() {
	console.log(excelFile);
	if (isEmpty(excelFile.val())) {
		getErrorNotyDefault("엑셀 파일을 첨부해 주세요.");
		return;
	}
	if(!confirm("등록하시겠습니까?")) return;
	
	const formData = new FormData($("#contractExcelForm")[0]);
	
	let url = $.getContextPath() +"/office/servicecompany/uploadExcel.do";
	fetch(url, {
		method: "POST"
		, body: formData
	})
	.then(function(response) {
		return response.json();
		}
	)
	.then(function(json) {
		if(json.message) {
			
			getNoty(json);
		}else {
			getSuccessNotyDefault("성공적으로 이루어졌습니다.");
			contractExcelUploadModal.modal("hide");
		}
	})
	.catch((error) => {
		  console.error('Error:', error);
	});
	
});

</script>
