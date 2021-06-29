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
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<security:authentication property="principal" var="principal"/>
<c:set var="authMember" value="${principal.realMember }"/>
<style type="text/css">
#btnDiv{
	margin-left: 84%;
	margin-bottom: 20px;
}
th, td{
	text-align: center;
}
td:nth-child(2){
	text-align: left;
}
tbody img{
	width: 18px;
	height: 15px;
}
.badge-primary{
	background-color: #F6534E;
}
.badge-default{
	background-color: #3ECFDE;
}
</style>
<div id="btnDiv">
	<input type="button" id="myListBtn" value="나의 수리신청" class="btn btn-warning btn-sm mb20">
	<input type="button" id="insertBtn" value="등록" class="btn btn-default btn-sm mb20">
</div>    
<table class="table">
	<thead class="table-light">
		<colgroup>
			<col width="60px">
			<col width="550px" style="text-align: center">
			<col width="100px">
			<col width="130px" style="text-align: center">
			<col width="120px">
			<col width="120px">
		</colgroup>
  		<tr>
  			<th>No.</th>
  			<th style="text-align: center;" scope="row">제목</th>
  			<th style="text-align: center;" scope="row">분류</th>
  			<th style="text-align: center;" scope="row">작성자</th>
  			<th style="text-align: center;" scope="row">작성일</th>
  			<th>처리상태</th>
  		</tr>
	</thead>
	<tbody id="listTbody">
		<c:set var="pagingVO" value="${paginationInfo.pagingVO }"/>
		<c:forEach items="${pagingVO.dataList }" var="asVO">
			<tr class="text-center">
	 			<td>${asVO.rnum }</td>
	 			<td class="text-left">
					<a href="#" data-asno="${asVO.asNo }" data-memid="${asVO.memId }" data-code="${asVO.asCode }">${asVO.asTitle}</a>
					<c:if test="${asVO.memId ne authMember.memId && asVO.asCode == 'ASRES'}">
						<img src="${pageContext.request.contextPath}/images/boardlock.jpg">
					</c:if>
				</td>
	 			<td>${asVO.asCodeName }</td>
	 			<td>${asVO.memNick }</td>
	 			<td>${asVO.asDate }</td>
	 			<td>
		 			<c:if test="${asVO.asStatus eq 'ASHOLD'}">
		 				<span class="badge badge-primary">접수중</span>
		 			</c:if>
		 			<c:if test="${asVO.asStatus eq 'ASING'}">
		 				<span class="badge badge-default">접수완료</span>
		 			</c:if>
		 			<c:if test="${asVO.asStatus eq 'ASDONE'}">
		 				<span class="badge badge-secondary">수리완료</span>
		 			</c:if>
	 			</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="6">
				<br>
				<form id="searchForm">
					<input type="hidden" name="currentPage" value="${paginationInfo.pagingVO.currentPage}"/> 
					<input type="hidden" name="searchVO.searchType" value="${paginationInfo.pagingVO.searchVO.searchType}"/> 
					<input type="hidden" name="searchVO.searchWord" value="${paginationInfo.pagingVO.searchVO.searchWord}"/> 
					<input type="hidden" name="asNo">
				</form>
				<div id="inputUI" class="row">
					<div class="col col-md-2 float-right">
						<select name="searchVO.searchType" class="form-control">
							<option value>전체</option>
							<option value="title">제목</option>
							<option value="memId">작성자</option>
						</select>
					</div>
					<div class="col-sm-4 float-right">	
						<input type="text" name="searchVO.searchWord" value="${paginationInfo.pagingVO.searchVO.searchWord}" class="form-control">
					</div>
					<div class="col-sm-4 float-right">	
						<input type="button" class="btn btn-primary" id="searchBtn" value="검색">
						<input type="button" class="btn btn-secondary" id="goListBtn" value="목록으로">
					</div>
				</div>
				<div id="pagingDiv">
					<ui:pagination paginationInfo='${paginationInfo }' jsFunction='pageLinkMove' type='bsResident'/>
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<div class="modal" id="passChkModal">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<!-- Modal body -->
			<div class="modal-body ">
				<form id="passForm">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<th>비밀번호를 입력하세요</th>
						</tr>
						<tr>
							<td><input type="text" name="memPass"></td>
						</tr>
					</tbody>
				</table>
				</form>	
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<input type="button" value="확인" id="passBtn" class="btn btn-default">
				<input type="button" value="취소" class="btn btn-danger" data-dismiss="modal" id="closeBtn">
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
	let searchForm = $("#searchForm");
//------------------------------- 나의 수리내역 조회----------------------------------------
	$("#myListBtn").on("click", function(){
		searchForm.find("[name='searchVO.searchWord']").val("${authMember.memId}");
		searchForm.find("[name='currentPage']").val(1);
		searchForm.attr("action", "${cPath}/resident/support/afterServiceList.do");
		searchForm.submit();
	});

//------------------------------- 수리 신청 ----------------------------------------
	$("#insertBtn").on("click", function(){
		searchForm.attr("action", "${cPath}/resident/support/insertAfterService.do");
		searchForm.submit();
	});
	
	$("#goListBtn").on("click", function(){
		location.href="${cPath}/resident/support/afterServiceList.do";
	});
//----------------------- 게시글 조회시 다른사람 수리글은 비밀번호 체크모달 띄우기 ------------------------------------
	var asNo = null;
	let passChkModal = $("#passChkModal");
// 	$("#listTbody").on("click", "a", function(event){
// 		event.preventDefault();
// 		let memId = $(this).data("memid");
// 		let asCode = $(this).data("code");
// 		console.log(asCode);
// 		asNo = $(this).data("asno");
// 		if(memId == "${authMember.memId}" || asCode=="ASAPT"){
// 			searchForm.find("[name='asNo']").val(asNo);
// 			searchForm.attr("action", "${cPath }/resident/support/afterServiceView.do");
// 			searchForm.submit();
// 		}else{
// 			passChkModal.show();
// 		}
// 		return false;
// 	});
	$("#listTbody").on("click", "a", function(event){
		event.preventDefault();
		let memId = $(this).data("memid");
		let asCode = $(this).data("code");
		asNo = $(this).data("asno");
		if(memId == "${authMember.memId}" || asCode=="ASAPT"){
			searchForm.find("[name='asNo']").val(asNo);
			searchForm.attr("action", "${cPath }/resident/support/afterServiceView.do");
			searchForm.submit();
		}else{
			alert('비밀글입니다.');
		}
		return false;
	});
	
//----------------------- 비밀번호 체크 ------------------------------------
	$("#passBtn").on("click", function(){
		let memPass = $("#passChkModal").find("[name='memPass']").val();
		$.ajax({
			url:"${cPath}/resident/support/chkPass.do"
			,data: {"memPass":memPass, "asNo":asNo}
			,dataType:"text"
			,success:function(resp){
				if(resp=="true"){
					location.href="${cPath }/resident/support/afterServiceView.do?asNo="+asNo;
				}else{
					alert('비밀번호 틀림.');
					passChkModal.hide();
				}
			}
		})
	});
	
	$("#closeBtn").on("click", function(){
		passChkModal.hide();
	});
	
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='currentPage']").val(page);
		searchForm.submit();
		return false;
	}
	
	$("#searchBtn").on("click", function(){
		searchForm.attr("action", "${cPath}/resident/support/afterServiceList.do");
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
