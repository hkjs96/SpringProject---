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
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<security:authentication property="principal" var="principal"/>
<c:set var="authMember" value="${principal.realMember }"/>
<style type="text/css">
h4{
	font-size: 1.5em;
}
/* 상세조회 */
#viewDiv table{
	width: 90%;
	margin-top: 50px;
	margin-left: 100px;
}
#viewDiv img{
	width: 600px;
	height: 500px;
}
#viewDiv th{
	text-align: center;
	background-color: #FBF9FA;
}
#contentDiv{
	height: 200px; 
}
#btnDiv{
	margin-top:50px;
	margin-left: 40%;
}
</style>

<div id="viewDiv">
	<h4>수리신청 상세보기</h4>
	<table class="table table-bordered">
	<c:set var="asVO" value="${asVO }"/>
		<tbody>
			<tr>
				<th>제목</th>
				<td colspan="3">
					${asVO.asTitle }
				</td>
			</tr>
			<tr>
				<th>접수분류</th>
				<td>${asVO.asCodeName }</td>
				<th>접수상태</th>
				<td colspan="3">
					<c:if test="${asVO.asStatus eq 'ASHOLD'}">
		 				<span class="badge badge-secondary">접수중</span>
		 			</c:if>
		 			<c:if test="${asVO.asStatus eq 'ASING'}">
		 				<span class="badge badge-secondary">접수완료</span>
		 			</c:if>
		 			<c:if test="${asVO.asStatus eq 'ASDONE'}">
		 				<span class="badge badge-secondary">수리완료</span>
		 			</c:if>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${asVO.resName }</td>
				<th>작성일</th>
				<td>${asVO.asDate }</td>
			</tr>
			<tr>
				<th>동</th>
				<td>${asVO.dong }동</td>
				<th>호</th>
				<td>${asVO.ho }호</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3" id="contentDiv">
						${asVO.asContent }
				</td>
			</tr>
		</tbody>
	</table>	
</div>  
<form id="searchForm">
	<input type="hidden" name="currentPage" value="${pagingVO.currentPage}"/> 
	<input type="hidden" name="searchVO.searchType" value="${pagingVO.searchVO.searchWord}"/> 
	<input type="hidden" name="searchVO.searchWord" value="${pagingVO.searchVO.searchWord}"/> 
	<input type="hidden" name="asNo" value="${asVO.asNo }">
</form>
<div id="btnDiv">
	<c:if test="${asVO.memId eq authMember.memId }">
		<c:if test="${'ASDONE' ne asVO.asStatus}">
		<input type="button" id="updateBtn" class="btn btn-primary" value="수정">
		</c:if>
		<input type="button" id="deleteBtn" class="btn btn-danger" value="삭제">
	</c:if>
	<input type="button" id="backBtn" class="btn btn-secondary" value="목록으로">
</div>
<script>
let searchForm = $("#searchForm");

$("#updateBtn").on("click", function(){
	searchForm.attr("action", "${cPath}/resident/support/updateAfterService.do");
	searchForm.submit();
});
$("#deleteBtn").on("click", function(){
	if(confirm('삭제하시겠습니까?')){
		searchForm.attr("action", "${cPath}/resident/support/deleteAfterService.do");
		searchForm.submit();
	}
});

$("#backBtn").on("click", function(){
	searchForm.attr("action", "${cPath}/resident/support/afterServiceList.do");
	searchForm.submit();
});
</script>