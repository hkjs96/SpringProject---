<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 1. 29.    박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
/* 조회조건 */
#retrieveTopDiv{
	margin-top: 30px;
}
#listDiv{
	width: 95%;
	margin-left: 10px;
	margin-top: 20px;
}
#searchBtn{
	margin: 5px;
}
#listTable td:nth-child(2){
	text-align: left;
}
#waitingDiv span:not(#waitingCnt){
	color: blue;
}
#waitingDiv{
	margin-left: 3%;
	margin-top: 20px;
}
#waitingCnt{
	color: red;
	font-size: 1.2em;
}
.card-body{
	margin-left: 20px;
}
</style>	
<br>
<h2>
	<strong>리모델링 관리</strong>
</h2>
<br>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }"/>
<c:set var="rmdlVO" value="${rmdlVO }"/>
<div class="container">
	<div class="col-md-6" style="border-style: outset; border-radius: 8px;margin-left: 20%;">
		<div class="row g-0">
			<div class="col-md-5" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
					style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;<strong>검색
					조건</strong>
			</div>
			<form id="searchForm">
				<input type="hidden" name="currentPage" value="1">
				<input type="hidden" name="searchVO.searchType" >
				<input type="hidden" name="searchVO.searchWord" value="${pagingVO.searchVO.searchWord }">
			</form>
			<div id="inputUI">
			<div class="card-body">
				<div class="row">
					<form class="form-inline">
					<div class="col-md-3">분류선택</div>
					<div class="col-md-9">
						<select class="custom-select col-md-4" name="searchVO.searchType">
							<option value>전체</option>
							<option value="title">내용</option>
						</select> 
						<input type="text" class="form-control col-md-6" name="searchVO.searchWord" value="${pagingVO.searchVO.searchWord }">
						&nbsp;&nbsp;&nbsp;<button class="btn btn-dark" id="searchBtn">검색</button>
					</div>
					</form>
				</div><br>	
				<div class="row">
					<div class="col-md-3">정렬</div>
			      	<div class="col-md-7">
					<form id="ynForm">
					<select name="rmdlYn" onchange="rmdlYnSelect(this.val)" class="custom-select col-md-9">
						<option value>승인여부 선택</option>
						<option value="Y" ${param.rmdlYn eq 'Y'?"selected":"" }>승인</option>
						<option value="N" ${param.rmdlYn eq 'N'?"selected":"" }>미승인</option>
						<option value="D" ${param.rmdlYn eq 'D'?"selected":"" }>신청취소</option>
					</select><br>
					</form>
					</div>
					</div>
				</div>	
			</div>
			</div>
		</div>	
	</div>
<br>
<div id="waitingDiv">
	승인 대기 수 : <span id="waitingCnt"> ${rmdlVO.waitingCnt }</span><br>
	<span>* 정렬 조건에서 미승인을 선택하면 승인 대기중인 글을 조회할 수 있습니다.</span> 
</div>
<div class="text-center col-sm-12" id="listDiv">
	<table class="table table-hover" id="listTable">
		<colgroup>
			<col width="80px;">
			<col width="35%;">
		</colgroup>
		<thead class="thead-light">
			<tr>
				<th scope="col">No.</th>
				<th scope="col">내용</th>
				<th scope="col">동</th>
				<th scope="col">호</th>
				<th scope="col">시작일</th>
				<th scope="col">종료일</th>
				<th scope="col">회원ID</th>
				<th scope="col">신청일</th>
				<th scope="col">승인여부</th>
			</tr>
		</thead>
		<tbody id="tbodyList">
		</tbody>
	</table>
</div>
<div id="pagingDiv" class="pagination justify-content-center">
	<ui:pagination paginationInfo='${paginationInfo }' jsFunction='pageLinkMove' type='bsOffice'/>
</div>

<script type="text/javascript">
	function makeList(){
		$.ajax({
			dataType:"json",
			success:function(resp){
				let rmdlList = resp;
				let trTags = [];
				let rmdlYn = "";
				if(rmdlList.length>0){
					$(rmdlList).each(function(idx, rmdl){
						if('Y'==rmdl.rmdlYn){
							rmdlYn = $("<button id='cancleBtn' data-rmdlno='"+rmdl.rmdlNo+"'>").text("취소")
																.addClass("btn btn-danger");
						}else if('D'==rmdl.rmdlYn){
							rmdlYn = $("<span>").text("취소됨").addClass("badge badge-default");
						}else{
							rmdlYn = $("<button type='button' data-rmdlno='"+rmdl.rmdlNo+"' class='btn btn-primary approvalBtn'>승인</button>");
						}
						trTags.push(
							$("<tr>").append(
								$("<td>").text(rmdl.rmdlNo),
								$("<td>").text(rmdl.rmdlTitle),
								$("<td>").text(rmdl.dong),
								$("<td>").text(rmdl.ho),
								$("<td>").text(rmdl.rmdlStart),
								$("<td>").text(rmdl.rmdlEnd),
								$("<td>").text(rmdl.memNick),
								$("<td>").text(rmdl.rmdlDate),
								$("<td>").append(rmdlYn).attr("id","approvalTd"+rmdl.rmdlNo)
							)		
						) //tr push end
					}); //each end
				}else{
					trTags.push(
						$("<tr>").append(
							$("<td colspan='9'>").text("리모델링 신청 내역이 없습니다.")
						)
					)		
				}
				$("#tbodyList").html(trTags);
			}//success end
		});
	}
	$(document).ready(function(){
		makeList();
	});
	
	function rmdlYnSelect(yn){
		$("#ynForm").submit();
	}
	$("#tbodyList").on("click", ".approvalBtn", function(){
		let rmdlNo = $(this).data("rmdlno");
		if(confirm("승인하시겠습니까?")){
			$.ajax({
				url:"${cPath}/office/construction/approval.do"
				,data : {"rmdlNo":rmdlNo}
				,success : function(resp){
					alert(resp.message);
					location.reload();
				},error:function(xhr){
					console.log(xhr.status);
				}
			});
		}	
	});
	
	$("#listDiv").on("click", "#cancleBtn", function(){
		let rmdlNo = $(this).data("rmdlno");
		if(confirm("승인을 취소하시겠습니까?")){
			$.ajax({
				url:"${cPath}/office/construction/rmdlApprovalCancelAjax.do"
				,data : {"rmdlNo":rmdlNo}
				,success : function(resp){
					alert(resp.message);
					location.reload();
				},error:function(xhr){
					console.log(xhr.status);
				}
			});
		}	
	});
	
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='currentPage']").val(page);
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
